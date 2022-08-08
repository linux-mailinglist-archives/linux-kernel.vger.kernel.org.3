Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D893958C7B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242929AbiHHLkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbiHHLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:40:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB26140;
        Mon,  8 Aug 2022 04:40:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.46.64.186])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 201816601C24;
        Mon,  8 Aug 2022 12:40:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659958823;
        bh=vPB21bP63a3cyzTnyqBlMpssVAO3NSTN7hNkLuHypu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoTNVl91VFXUdCtI2GOBG1i5U5F4Odv6afy0ICI4ZpimvFRHIU8MOOyCfk+QxWATd
         60quu7bvRpPir6ji6B7NSeUjYM4fH/Pwd374OqsDOZd8tfglu27WLUvmNVU9x9D9RI
         NrLPV5Buo7crkpryzibFHHNTF1Z1Z2Ej9DPhqyZzlNjJtVdgwC3luA2wCSRmJ2jbNu
         khMB9pY4cQWszlWCEKAxhr89RM26k3yO+mwyXAE5Gthggb7XC3cKhxnciy4FisRkpv
         iA2eLzFONPU3sGUojQnFUyZ/Fv8lVRyIP15DxRf/PZWEOP7WpbpUJ8BElhlwXLrej3
         HO4mwjn4Jmpmw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Cc:     Steven Noonan <steven@uplinklabs.net>, usama.anjum@collabora.com,
        kernel@collabora.com
Subject: [PATCH 2/3] x86: touch clocksource watchdog after syncing TSCs
Date:   Mon,  8 Aug 2022 16:39:53 +0500
Message-Id: <20220808113954.345579-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220808113954.345579-1-usama.anjum@collabora.com>
References: <20220808113954.345579-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Noonan <steven@uplinklabs.net>

Update watchdog after syncing the TSCs of all the CPUs. This is needed
to avoid getting TSC clocksource marked as unstable after syncing them.

Signed-off-by: Steven Noonan <steven@uplinklabs.net>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 arch/x86/kernel/smpboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f24227bc3220..4b3a03004a1f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -56,6 +56,7 @@
 #include <linux/numa.h>
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
+#include <linux/clocksource.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -1444,6 +1445,7 @@ void arch_thaw_secondary_cpus_begin(void)
 
 void arch_thaw_secondary_cpus_end(void)
 {
+	clocksource_touch_watchdog();
 	mtrr_aps_init();
 }
 
@@ -1477,6 +1479,8 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 {
 	pr_debug("Boot done\n");
 
+	clocksource_touch_watchdog();
+
 	calculate_max_logical_packages();
 
 	/* XXX for now assume numa-in-package and hybrid don't overlap */
-- 
2.30.2

