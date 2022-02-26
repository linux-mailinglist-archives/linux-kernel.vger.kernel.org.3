Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376C24C56C2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 17:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiBZQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 11:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiBZQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 11:01:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56F85179265
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645891267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qCqINOQynquBVH+X40kSOhFUiEBHFu+5I+8mTF3ybnI=;
        b=LCVA4Os2Ja2VC7vwXgVF9+It/eh16cP3PnlxyUCTLM1lQkcYMXFHwKs6Tr8GYrNF4hAXrK
        D7U26m/sl7AEU7c3v6VxerpK2uxHn/wW+2tNggIg8y+MEvlicDYOZ3z0ADsdninoZPP+IJ
        /aNLtgW9gL1w7I9SiVn8t/WfduuOWN4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-epcjezo6OsulvytytK3P5A-1; Sat, 26 Feb 2022 11:01:06 -0500
X-MC-Unique: epcjezo6OsulvytytK3P5A-1
Received: by mail-qt1-f197.google.com with SMTP id a6-20020a05622a02c600b002dd2d38f153so4367578qtx.17
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 08:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCqINOQynquBVH+X40kSOhFUiEBHFu+5I+8mTF3ybnI=;
        b=ATDhhpO4ArWeBdIqL5rl53V6n8dlR+89+MIi4hobZQ8nn1DA5r1g8xAVWl25i0v+1T
         1PWVCzFSa+IVsxoa6FzeadK04iUymKxFrjSeACH0/X9ZSCblGKtSQ3QbV/AheKtpBn4S
         3V2sK8/71C+0nzW4gpxmWtzJlgZS08Prz+R8p8ROqpudo4XmZk1etP5kRwjSm3t9ywvy
         aDF9PAB372FLL6W4ufVizIbS88R4xdXk+QnjoM+kNxHknxCq6VaEEkc1zMHSSQ889/Ou
         UJk/afBv0bYtMMuzlwZfym3axeNzLu8ttm6N1mtoaLgUk62NFqbUQ7emkF0vlkegmy4l
         mclw==
X-Gm-Message-State: AOAM5339i/YaM3aoB1n0geOq4MBFmA9skfAAaprSGpEDSafB2Algu7Nl
        vJdQyqpW28nC6GLEUyDaey+OSsh/hx+DGtI3fBPnFLk2zR5mKCshltjcv8DDgghUyf3cbnqBSpj
        vP6WO0yVLs/yJGidR71fudVIE
X-Received: by 2002:a05:6214:20a1:b0:42d:6f51:46e2 with SMTP id 1-20020a05621420a100b0042d6f5146e2mr9319672qvd.67.1645891265778;
        Sat, 26 Feb 2022 08:01:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrZuGlgdj4kgPM9qty3y9swpN5H03h3zppYgwnC6NM/6p/yilQ2qHIOt9Qulnvxtp1Jow/uw==
X-Received: by 2002:a05:6214:20a1:b0:42d:6f51:46e2 with SMTP id 1-20020a05621420a100b0042d6f5146e2mr9319649qvd.67.1645891265477;
        Sat, 26 Feb 2022 08:01:05 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a245300b0047c5aec8cabsm2964991qkn.123.2022.02.26.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 08:01:05 -0800 (PST)
From:   trix@redhat.com
To:     ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org,
        rmk+kernel@armlinux.org.uk, peterz@infradead.org,
        keescook@chromium.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] sh: cleanup comments
Date:   Sat, 26 Feb 2022 08:00:54 -0800
Message-Id: <20220226160054.4176509-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

spdx, remove the extra '-'

Replacements
Defitions to Definitions
highger to higher
mechanizm to mechanism
useable to usable
presision to precision

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/sh/include/asm/addrspace.h      | 2 +-
 arch/sh/include/asm/fixmap.h         | 6 +++---
 arch/sh/include/asm/platform_early.h | 2 +-
 arch/sh/include/asm/processor_32.h   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index 468fba333e896..1fba671326890 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -2,7 +2,7 @@
  *
  * Copyright (C) 1999 by Kaz Kojima
  *
- * Defitions for the address spaces of the SH CPUs.
+ * Definitions for the address spaces of the SH CPUs.
  */
 #ifndef __ASM_SH_ADDRSPACE_H
 #define __ASM_SH_ADDRSPACE_H
diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index b07fbc7f7bc6a..5bb7e60ccc7b0 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -26,7 +26,7 @@
  *
  * these 'compile-time allocated' memory buffers are
  * fixed-size 4k pages. (or larger if used with an increment
- * highger than 1) use fixmap_set(idx,phys) to associate
+ * higher than 1) use fixmap_set(idx,phys) to associate
  * physical memory with fixmap indices.
  *
  * TLB entries of such buffers will not be flushed across
@@ -34,7 +34,7 @@
  */
 
 /*
- * on UP currently we will have no trace of the fixmap mechanizm,
+ * on UP currently we will have no trace of the fixmap mechanism,
  * no page table allocations, etc. This might change in the
  * future, say framebuffers for the console driver(s) could be
  * fix-mapped?
@@ -53,7 +53,7 @@ enum fixed_addresses {
 #ifdef CONFIG_IOREMAP_FIXED
 	/*
 	 * FIX_IOREMAP entries are useful for mapping physical address
-	 * space before ioremap() is useable, e.g. really early in boot
+	 * space before ioremap() is usable, e.g. really early in boot
 	 * before kmalloc() is working.
 	 */
 #define FIX_N_IOREMAPS	32
diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/platform_early.h
index fc802137c37d4..00b6e6dc4ac4a 100644
--- a/arch/sh/include/asm/platform_early.h
+++ b/arch/sh/include/asm/platform_early.h
@@ -1,4 +1,4 @@
-/* SPDX--License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef __PLATFORM_EARLY__
 #define __PLATFORM_EARLY__
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index 45240ec6b85a4..0ca85637c3b99 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -158,7 +158,7 @@ static __inline__ void enable_fpu(void)
 			     : "r" (~SR_FD));
 }
 
-/* Double presision, NANS as NANS, rounding to nearest, no exceptions */
+/* Double precision, NANS as NANS, rounding to nearest, no exceptions */
 #define FPSCR_INIT  0x00080000
 
 #define	FPSCR_CAUSE_MASK	0x0001f000	/* Cause bits */
-- 
2.26.3

