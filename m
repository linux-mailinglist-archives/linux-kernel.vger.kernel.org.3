Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D8655AB58
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiFYPiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiFYPix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:38:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7213515A2C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 08:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F670614CE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 15:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C0FC341C0;
        Sat, 25 Jun 2022 15:38:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HboEAv4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656171529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W2HeGFQgLk1e9Km3S9SfOn5rxYkH34TUlnLdSzu3vHk=;
        b=HboEAv4t1+dldljw8zw4CRuDJan78kdT6RlYYm3yLsRG8wrC5hq+7eEhaV1vZyNckoqiLy
        974QqWVyyC0fp/wtP3RfYuzSM01ITLpT62ECXLDnprxwsx8Oy4ZiWvZlgRokbzUsk65A6H
        2zcmdShZGeBqmXeWMKwd3FAJAmzP8No=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c2029b86 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 25 Jun 2022 15:38:49 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     geert@linux-m68k.org, laurent@vivier.eu,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] m68k: virt: pass RNG seed via bootinfo block
Date:   Sat, 25 Jun 2022 17:38:41 +0200
Message-Id: <20220625153841.143928-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other virt VMs can pass RNG seeds via the "rng-seed" device tree
property or via UEFI, but m68k doesn't have either. Instead it has its
own bootinfo protocol. So this commit adds support for receiving a RNG
seed from it, which will be used at the earliest possible time in boot,
just like device tree.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/m68k/include/uapi/asm/bootinfo-virt.h | 1 +
 arch/m68k/virt/config.c                    | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/m68k/include/uapi/asm/bootinfo-virt.h b/arch/m68k/include/uapi/asm/bootinfo-virt.h
index e4db7e2213ab..7c3044acdf4a 100644
--- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
+++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
@@ -12,6 +12,7 @@
 #define BI_VIRT_GF_TTY_BASE	0x8003
 #define BI_VIRT_VIRTIO_BASE	0x8004
 #define BI_VIRT_CTRL_BASE	0x8005
+#define BI_VIRT_RNG_SEED	0x8006
 
 #define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
 
diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
index 632ba200ad42..ad71af8273ec 100644
--- a/arch/m68k/virt/config.c
+++ b/arch/m68k/virt/config.c
@@ -2,6 +2,7 @@
 
 #include <linux/reboot.h>
 #include <linux/serial_core.h>
+#include <linux/random.h>
 #include <clocksource/timer-goldfish.h>
 
 #include <asm/bootinfo.h>
@@ -92,6 +93,9 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
 		data += 4;
 		virt_bi_data.virtio.irq = be32_to_cpup(data);
 		break;
+	case BI_VIRT_RNG_SEED:
+		add_bootloader_randomness(data + 4, be32_to_cpup(data));
+		break;
 	default:
 		unknown = 1;
 		break;
-- 
2.35.1

