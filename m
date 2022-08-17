Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09035596B81
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiHQIlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiHQIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:41:05 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707566C77D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:41:04 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4M71gw3XSRz9sW1;
        Wed, 17 Aug 2022 10:41:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1660725660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4RmA0QPvoAENdzGDjPmlk83VfJWjZczdQecqUQL2ATs=;
        b=bdnaUnUKSYUdSuK9kSOToDCtRCkd1yCDjfMYd/9op+kPh6cNcxo5AJE4cu9bZEpSg4vsJd
        JECts5WEnVEkDiQKuTrPVW/6Am+4OOhAXztPKh5hWppffldKj+CO371UdtXFieUefvXiyq
        2RMJIehumI0KS+rBVEnkJ1LzFfAX7Fw2M6rZKzs8euZe6gJVVrCwDDz489lQZqPQ7FT15f
        KeesuAyBNskBARPijcWHKSM/PhoAm8nvFcseEqJRuc6AoiHULrInBTMCBZ16tUAB3+qRTQ
        dWUhG99WgKhUwOdzuwpkX5yJpAwoUdN2DvJRRwAHB8OXRd5C6H/XDCYgAPZsrA==
Date:   Wed, 17 Aug 2022 10:40:59 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Message-ID: <300453780.239457.1660725659957@office.mailbox.org>
Subject: [PATCH] arch/x86: Makefile: Move CPU-specific tuning for x86_64 to
 Makefile.cpu
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: kew4jcmtj5fztie1tqxie6a7qctheurz
X-MBO-RS-ID: e24b3ff3ea788c4a54c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Makefile has a 'FIXME', according to which the CPU-specific tuning
options for 64-bit CPUs should be integrated into a separate file.

Move these cflags to a new file named Makefile.cpu in the same way as for
the 32-bit cflags.

There should be no functional change.

Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
 arch/x86/Makefile     | 8 ++------
 arch/x86/Makefile.cpu | 8 ++++++++
 2 files changed, 10 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/Makefile.cpu

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7854685c5f25..c0b4db692544 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -147,12 +147,8 @@ else
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
 
-        # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
-        cflags-$(CONFIG_MK8)		+= -march=k8
-        cflags-$(CONFIG_MPSC)		+= -march=nocona
-        cflags-$(CONFIG_MCORE2)		+= -march=core2
-        cflags-$(CONFIG_MATOM)		+= -march=atom
-        cflags-$(CONFIG_GENERIC_CPU)	+= -mtune=generic
+        # CPU-specific tuning for x86_64
+        include $(srctree)/arch/x86/Makefile.cpu
         KBUILD_CFLAGS += $(cflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone
diff --git a/arch/x86/Makefile.cpu b/arch/x86/Makefile.cpu
new file mode 100644
index 000000000000..6995353f87e8
--- /dev/null
+++ b/arch/x86/Makefile.cpu
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# CPU tuning section for x86_64
+
+cflags-$(CONFIG_MK8)		+= -march=k8
+cflags-$(CONFIG_MPSC)		+= -march=nocona
+cflags-$(CONFIG_MCORE2)		+= -march=core2
+cflags-$(CONFIG_MATOM)		+= -march=atom
+cflags-$(CONFIG_GENERIC_CPU)	+= -mtune=generic
-- 
2.37.2
