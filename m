Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7A6561948
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiF3LdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiF3LdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:33:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A6E12087
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8505DB82A30
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F06C34115;
        Thu, 30 Jun 2022 11:33:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YhIALwNu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656588784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v+Re/J7CDomnNGKEEalv3NlzbBAIQfyC1PELROLBY8Y=;
        b=YhIALwNur1qkYjJu/VWPDuUmqWt0LFVP+/bvH7k0RymOhM3VmKGTdJd1tTUb2ybw+4shEI
        UChvYc0MAD8xeHVXYBqGiiQMMZoiDcFxniK7ECbdE9N8whZsx2N4rKlXx84GjgoFW1bK12
        Iqoct9TuCnR8yngeNstWfnbmtU5sOYw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e0c30d7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Jun 2022 11:33:04 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] x86/setup: Allow passing RNG seeds via e820 setup table
Date:   Thu, 30 Jun 2022 13:33:00 +0200
Message-Id: <20220630113300.1892799-1-Jason@zx2c4.com>
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

Currently the only way x86 can get an early boot RNG seed is via EFI,
which is generally always used now for physical machines, but is very
rarely used in VMs, especially VMs that are optimized for starting
"instantaneously", such as Firecracker's MicroVM. Here, we really want
the ability for the firmware to pass a random seed, similar to what OF
platforms do with the "rng-seed" property. It also would be nice for
bootloaders to be able to append seeds to the kernel before launching.

This patch accomplishes that by adding SETUP_RNG_SEED, similar to the
other 7 SETUP_* entries that are parsed from the e820 setup table. I've
verified that this works well with QEMU.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/include/uapi/asm/bootparam.h | 1 +
 arch/x86/kernel/setup.c               | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index bea5cdcdf532..a60676b8d1d4 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -11,6 +11,7 @@
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
 #define SETUP_CC_BLOB			7
+#define SETUP_RNG_SEED			8
 
 #define SETUP_INDIRECT			(1<<31)
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bd6c6fd373ae..4135fa17a90e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -23,6 +23,7 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
+#include <linux/random.h>
 
 #include <uapi/linux/mount.h>
 
@@ -343,7 +344,8 @@ static void __init parse_setup_data(void)
 		data_len = data->len + sizeof(struct setup_data);
 		data_type = data->type;
 		pa_next = data->next;
-		early_memunmap(data, sizeof(*data));
+		if (data_type != SETUP_RNG_SEED)
+			early_memunmap(data, sizeof(*data));
 
 		switch (data_type) {
 		case SETUP_E820_EXT:
@@ -355,6 +357,10 @@ static void __init parse_setup_data(void)
 		case SETUP_EFI:
 			parse_efi_setup(pa_data, data_len);
 			break;
+		case SETUP_RNG_SEED:
+			add_bootloader_randomness(data + 1, data_len);
+			early_memunmap(data, sizeof(*data));
+			break;
 		default:
 			break;
 		}
-- 
2.35.1

