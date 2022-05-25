Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC60533DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiEYNcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiEYNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:32:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318C3617D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:32:10 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 84F923F21C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653485529;
        bh=i0RFprlZ3Fo6m7naiO4awQduRTjU0yke/zLoaLjegbM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=q85ujQTAyDocWeFGNr8FcDq6MwLQMKyvqhVhCDOj7h0WNpJv/lMweAQXKKw+YmItx
         Rs6U6UiDdNTmPyTC1fNwXS/eukjXFTnN2HWHwKFpXtrDz4k6X318b2qu8WlCuRwHD8
         TWMrDlqFjlRGkhg81uI7iiDqi9yWwWuUzl3zZ1uJEksqS3bG80aYJas+98uL2nVJhK
         cdj4ZMIMn2jqonpBjaOh1GRt1+q7dZ8yxfRHS9QtC5xvFdqC4YK9zKiq/vRRPINdll
         xlSZNPkvIaUSfygwiOUY6WYzf8Rna7Lj5j+06jDiaKjm/XRiUL134HTmlPH7GGwvKd
         6SpK9oPR53PAA==
Received: by mail-ed1-f69.google.com with SMTP id y10-20020aa7ce8a000000b0042bc52fb825so1844030edv.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0RFprlZ3Fo6m7naiO4awQduRTjU0yke/zLoaLjegbM=;
        b=G9NBcKTlLWlPNIba1LMCJS2LqiCPC3sg6jLmYr3z0Iv8yPE4il7W1YV2a9Een1x2Xa
         /QCRuXyjDcGg9+WDLgP/wqwJwzAl3SPh5oyOy7lm0eP0wpQ0wyg1BzbKrLaM8mqDhxAD
         Ky7ONkhTK38aa8WZ0jlMCrsxfL0ekrCWZ3F1fVlZOr68Xnjmwa9sea6+6ksxiEr70HXU
         F2O+ZJfTDr7aJkIJYAFpJaw1d2E7uFjy6N4DR3cb+qaiASaNMe03sh/KVzTDuFT26e/4
         9Bn4MudetmKyONGZ4EHO7q71yquYcZuD3ru3E7zqw0Gxq1SvwstqlysFRYeKlaiA9oW3
         S8LQ==
X-Gm-Message-State: AOAM530EIC4GMfzexjDvKkQ45pyJ7jVRUlfJhCFOVldYDHhBCbsbgqfb
        TjpXf3HBW4pqiH1Q/NQz5HepiogIpS3n5qm8wmS9W4xMI5HGJa+jo7S8b4xfUTwIUu6xs/I+/Nr
        zUJ5XgXSafJCKNxdSPNil+EM3ETowjTXwwUEx34DcvA==
X-Received: by 2002:a17:906:264d:b0:6fe:a134:59ae with SMTP id i13-20020a170906264d00b006fea13459aemr25993831ejc.56.1653485529249;
        Wed, 25 May 2022 06:32:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8x03FV6N2+ui4WnSukERN88yTSrtZWjeRTUi+pWnHPjJuyBdDJIg0FoG1l9Zb4HddLtnEqQ==
X-Received: by 2002:a17:906:264d:b0:6fe:a134:59ae with SMTP id i13-20020a170906264d00b006fea13459aemr25993811ejc.56.1653485529026;
        Wed, 25 May 2022 06:32:09 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090694c800b006fe9209a9edsm3723388ejy.128.2022.05.25.06.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:32:08 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/2] x86: Kconfig.debug: Fix indentation
Date:   Wed, 25 May 2022 15:32:03 +0200
Message-Id: <20220525133203.52463-3-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525133203.52463-1-juerg.haefliger@canonical.com>
References: <20220525133203.52463-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/x86/Kconfig.debug | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d3a6f74a94bd..7fec55aab367 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -73,20 +73,19 @@ config DEBUG_TLBFLUSH
 	bool "Set upper limit of TLB entries to flush one-by-one"
 	depends on DEBUG_KERNEL
 	help
+	  X86-only for now.
 
-	X86-only for now.
+	  This option allows the user to tune the amount of TLB entries the
+	  kernel flushes one-by-one instead of doing a full TLB flush. In
+	  certain situations, the former is cheaper. This is controlled by the
+	  tlb_flushall_shift knob under /sys/kernel/debug/x86. If you set it
+	  to -1, the code flushes the whole TLB unconditionally. Otherwise,
+	  for positive values of it, the kernel will use single TLB entry
+	  invalidating instructions according to the following formula:
 
-	This option allows the user to tune the amount of TLB entries the
-	kernel flushes one-by-one instead of doing a full TLB flush. In
-	certain situations, the former is cheaper. This is controlled by the
-	tlb_flushall_shift knob under /sys/kernel/debug/x86. If you set it
-	to -1, the code flushes the whole TLB unconditionally. Otherwise,
-	for positive values of it, the kernel will use single TLB entry
-	invalidating instructions according to the following formula:
+	  flush_entries <= active_tlb_entries / 2^tlb_flushall_shift
 
-	flush_entries <= active_tlb_entries / 2^tlb_flushall_shift
-
-	If in doubt, say "N".
+	  If in doubt, say "N".
 
 config IOMMU_DEBUG
 	bool "Enable IOMMU debugging"
@@ -119,10 +118,10 @@ config X86_DECODER_SELFTEST
 	depends on DEBUG_KERNEL && INSTRUCTION_DECODER
 	depends on !COMPILE_TEST
 	help
-	 Perform x86 instruction decoder selftests at build time.
-	 This option is useful for checking the sanity of x86 instruction
-	 decoder code.
-	 If unsure, say "N".
+	  Perform x86 instruction decoder selftests at build time.
+	  This option is useful for checking the sanity of x86 instruction
+	  decoder code.
+	  If unsure, say "N".
 
 choice
 	prompt "IO delay type"
-- 
2.32.0

