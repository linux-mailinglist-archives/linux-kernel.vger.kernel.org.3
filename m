Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF22C55B177
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 13:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiFZLPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 07:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiFZLPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 07:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C77BE2E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 04:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F025E611F9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25DAC34114;
        Sun, 26 Jun 2022 11:15:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fny0/IT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656242125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztpCLeJiN8x8NtOpZ42f8MSD1Gm0OAEWaX3b+SAs9kA=;
        b=fny0/IT4ZwXmr6J7YriIEf3MCfCq11FKNasaW4DcI58lhhHAUNvJtLW59OCCqNICTRq13s
        lSUgR6eU7MNTm0Laq+DYAcVxlKaMZ9eWR7VenLKXpbvGhx3/T0D7B32EsYc2wzJGdWOkYm
        fRsH+lUBjLdV9RMyIcusngxCiXZ7++U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c89af2ac (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 26 Jun 2022 11:15:25 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     geert@linux-m68k.org, laurent@vivier.eu,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] m68k: virt: use RNG seed from bootinfo block
Date:   Sun, 26 Jun 2022 13:15:09 +0200
Message-Id: <20220626111509.330159-1-Jason@zx2c4.com>
In-Reply-To: <Yrg6BzpKIJBTAVmO@zx2c4.com>
References: <Yrg6BzpKIJBTAVmO@zx2c4.com>
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/m68k/include/uapi/asm/bootinfo-virt.h | 7 +++++++
 arch/m68k/virt/config.c                    | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/m68k/include/uapi/asm/bootinfo-virt.h b/arch/m68k/include/uapi/asm/bootinfo-virt.h
index e4db7e2213ab..0cb2c2a41610 100644
--- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
+++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
@@ -13,6 +13,13 @@
 #define BI_VIRT_VIRTIO_BASE	0x8004
 #define BI_VIRT_CTRL_BASE	0x8005
 
+/* A random seed used to initialize the RNG. Record format:
+ *
+ *   - length       [ 2 bytes, 16-bit big endian ]
+ *   - seed data    [ `length` bytes ]
+ */
+#define BI_VIRT_RNG_SEED	0x8006
+
 #define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
 
 #endif /* _UAPI_ASM_M68K_BOOTINFO_MAC_H */
diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
index 632ba200ad42..645acc6918b2 100644
--- a/arch/m68k/virt/config.c
+++ b/arch/m68k/virt/config.c
@@ -2,6 +2,7 @@
 
 #include <linux/reboot.h>
 #include <linux/serial_core.h>
+#include <linux/random.h>
 #include <clocksource/timer-goldfish.h>
 
 #include <asm/bootinfo.h>
@@ -92,6 +93,14 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
 		data += 4;
 		virt_bi_data.virtio.irq = be32_to_cpup(data);
 		break;
+	case BI_VIRT_RNG_SEED: {
+		u16 len = be16_to_cpup(data);
+		add_bootloader_randomness(data + 2, len);
+		/* Zero the data to preserve forward secrecy, and zero the
+		 * length to prevent kexec from using it. */
+		memzero_explicit((void *)data, len + 2);
+		break;
+	}
 	default:
 		unknown = 1;
 		break;
-- 
2.35.1

