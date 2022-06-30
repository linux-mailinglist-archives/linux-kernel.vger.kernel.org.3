Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B479D561B65
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiF3Nb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbiF3NbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:31:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B66E340F0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C6861EA4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E1BC3411E;
        Thu, 30 Jun 2022 13:31:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gwi9lqIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656595880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJrHW1zfskt5mub94imQU6kO3Is9Gr7LgOI7ppnURQQ=;
        b=Gwi9lqIULHdxm268t463sx0i6CICCytkUmkvGgdPMucd0hpFhw98C9Z0OkhiEcr555stsc
        CQJUbVtBBrCQLtVtC8EsRoMW8ZUENKhMQp7EiMdpVRTbM6LIAOnp6LyHkDohyJBRTA7Ovv
        g+nxzXC3vPWoY4C057F7yO2ezUxNWpw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c370565c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Jun 2022 13:31:20 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4] x86/setup: Allow passing RNG seeds via e820 setup table
Date:   Thu, 30 Jun 2022 15:31:06 +0200
Message-Id: <20220630133106.35970-1-Jason@zx2c4.com>
In-Reply-To: <20220630120955.1937664-1-Jason@zx2c4.com>
References: <20220630120955.1937664-1-Jason@zx2c4.com>
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
Sorry for all the churn. I keep forgetting things. I'll slow down a bit
after this one.

Changes v3->v4:
- Zero out data after using, for forward secrecy and so that kexec
  doesn't reuse the data.
Changes v2->v3:
- Actually memmap the right area with the random bytes in it. This
  worked before because of page sizes, but the code wasn't right. Now
  it's right.
Changes v1->v2:
- Fix small typo of data_len -> data->len.

 arch/x86/include/uapi/asm/bootparam.h | 1 +
 arch/x86/kernel/setup.c               | 8 ++++++++
 2 files changed, 9 insertions(+)

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
index bd6c6fd373ae..6c807a4ae141 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -23,6 +23,7 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
+#include <linux/random.h>
 
 #include <uapi/linux/mount.h>
 
@@ -355,6 +356,13 @@ static void __init parse_setup_data(void)
 		case SETUP_EFI:
 			parse_efi_setup(pa_data, data_len);
 			break;
+		case SETUP_RNG_SEED:
+			data = early_memremap(pa_data, data_len);
+			add_bootloader_randomness(data->data, data->len);
+			memzero_explicit(data->data, data->len);
+			memzero_explicit(&data->len, sizeof(data->len));
+			early_memunmap(data, data_len);
+			break;
 		default:
 			break;
 		}
-- 
2.35.1

