Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18E2503366
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiDPE27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiDPE2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:28:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1239FFDE31
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so13123895pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLOYNCP7bM0FoGD+XOolwlv66QCUuV6ytlu1gwN0Oh4=;
        b=NHsvKhHTUbORcEoJwhAnGbbF8gmfK9OYprcI7r9vlmjXQxus3ssM3YTtoAyFfzU8/W
         1BKp+cei12Kk+w6n9V/mDRHYdX9H4ZRO1QTAjxsXxVHhtqdSwTCJ9wd1PwoX7iUhOeTm
         hxsy1dcYTh6zEKGZ+cyo9sUr/xAe9+DELAYDCfz8xqni1PskI/7yj19tlAL5SsL2wBIX
         XkuGRQCPuk4cUq6/LgtHNwrO5hF8ucM+g0QI1vEUn7O8jEf00tXU8azyfGRoQgpwTi86
         5hLnXANVgexD6TYfCVEYiOUDf/Z3MDXrQSn/38gC34AYU90x0iIu76sZI9MzDL3DHPiB
         ppGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLOYNCP7bM0FoGD+XOolwlv66QCUuV6ytlu1gwN0Oh4=;
        b=gayRVBu3AORB+N3qiVNDmOhY/2qXN7/iidyl0DaTNeYuCmwOyacMj2w0BsLADMhlw1
         oSAuptTAvn6PYdQg+YK37UPSK75RMC3duWumfLJsH6ibSseonIrBDCPiXcXyP8jnMFww
         fjFQd9d+49LF9UWplj4fWxwrZNLnuI3PNeQLPeIEhO7V7CXx99iHj+b+AD15zq7iCtq6
         nxqyMCimFDR601f17brU8nMLl9tHcm5RvjmCf+tk2slAHH2o53PofQEsqGALBIhBYCug
         TCHNNv/KBMvycH3OyzdFGQgiXGttefs46kCQNxMgcFs4mMCIGFoXmxZt+BA4qiLcv3dm
         Fm2g==
X-Gm-Message-State: AOAM530YMaUmRGmpKzkCp9umSSKBnXIB/KpnT+ZoabrkW9m/BI0g/Mxz
        xYySeNmnVICxZ6MlvLoeNWQ=
X-Google-Smtp-Source: ABdhPJwOguSHns23VNXqf0tYW5LRtEWg9kZeeEAlGWqRbhDqrFqLHzispLN0tQF6/xHgA9X6S/SEXA==
X-Received: by 2002:a17:903:31d5:b0:158:27f4:fc9f with SMTP id v21-20020a17090331d500b0015827f4fc9fmr1916983ple.60.1650083181445;
        Fri, 15 Apr 2022 21:26:21 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:9b6:6aad:72f6:6e16])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b00505793566f7sm4258513pfo.211.2022.04.15.21.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 21:26:20 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/6] xtensa: clean up excsave1 initialization
Date:   Fri, 15 Apr 2022 21:25:56 -0700
Message-Id: <20220416042559.2035015-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
References: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use xtensa_set_sr instead of inline assembly.
Rename local variable exc_table in early_trap_init to avoid conflict
with per-CPU variable of the same name.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/traps.h | 4 ++--
 arch/xtensa/kernel/traps.c      | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/include/asm/traps.h b/arch/xtensa/include/asm/traps.h
index 6fa47cd8e02d..c9c5f59db420 100644
--- a/arch/xtensa/include/asm/traps.h
+++ b/arch/xtensa/include/asm/traps.h
@@ -45,11 +45,11 @@ void fast_second_level_miss(void);
 /* Initialize minimal exc_table structure sufficient for basic paging */
 static inline void __init early_trap_init(void)
 {
-	static struct exc_table exc_table __initdata = {
+	static struct exc_table init_exc_table __initdata = {
 		.fast_kernel_handler[EXCCAUSE_DTLB_MISS] =
 			fast_second_level_miss,
 	};
-	__asm__ __volatile__("wsr  %0, excsave1\n" : : "a" (&exc_table));
+	xtensa_set_sr(&init_exc_table, excsave1);
 }
 
 void secondary_trap_init(void);
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index a85992d60c11..f6855eb92614 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -386,8 +386,7 @@ void * __init trap_set_handler(int cause, void *handler)
 
 static void trap_init_excsave(void)
 {
-	unsigned long excsave1 = (unsigned long)this_cpu_ptr(&exc_table);
-	__asm__ __volatile__("wsr  %0, excsave1\n" : : "a" (excsave1));
+	xtensa_set_sr(this_cpu_ptr(&exc_table), excsave1);
 }
 
 static void trap_init_debug(void)
-- 
2.30.2

