Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF7F5002CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiDMXwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiDMXwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:52:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1BF3DDD7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:49:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so7718897pjn.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIrx5BX8YdB8EIQrcc/E4jEhfb2e+QJVsGsaTmoT1E8=;
        b=ZqB+cLOzPEvlgWlWMKH4T9JNuTSu2LBIw/kFcw48Q5/rlwtanZRPBi7mntQnHchUAh
         OJBFpeGGBVXCkIGWBjlKLWk11KyB+eh9HLbyK7YxZPl33zN1kTcMX8Xa1O7VS5dYL17x
         DMh28D/iIwPSk8r7bQgv8YNqRgLBAqloAyBnz9RmxWQBvApt+z33ELdpCe73A909Vqm/
         L6Q+VKoe0TJoBLwouLn3p/CiC6PJOtNpjwFxxhJ5Q0tx7+Y67fzDZVOZ/pvrs7yMx8D/
         cYmDr16tnj4mbk+637tt2ncpCoRM+Oa8diIw1Vi6p7oN8o0Oub1QkJRt5xHUyGaFOi2E
         tdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yIrx5BX8YdB8EIQrcc/E4jEhfb2e+QJVsGsaTmoT1E8=;
        b=7WlvV28lGOKCXIfCQdjUoEdkiYhoacALy0cHCc0JVAIUaarxQpe4Jv0e3QkZ2heg/i
         cYqFRFRj3lNLqFNnVQXJHjROlhW6MhNDO1a8rDs9wstTq6e7jpPeCeTXekfAB++OpU6f
         HWd0ZxbWeLF/ATAN3QbwxAsPpAEcwem4xi8agaOOr4G2mfGAInWKyPKcdH5Z1EBc5c5O
         xFgJ5rzN/1S3jRfc0z3kHs/sip/ys2WRjSuN/vvKUvMlUpf6XWZIbiNIpTSKzOtZptoW
         +jnIigy6/7vv8/fM9DtLhqj7W9K6cmprrvm7WTexUgisipprjjLmA78WT1mm7n4fqGok
         Ff8A==
X-Gm-Message-State: AOAM533AaS9qmE5gmHfq0xU+yVkcFpCKS79hRZYh0pzPRoisxhCu0/YH
        YQTDSCOdeLr36LULSh2sBFIjxq/51Zo=
X-Google-Smtp-Source: ABdhPJzMM1qzarHQcw9uUUCNHGO1v1hp3hctUsRdC++zgLpbX9wFPoh6dvu8E9sxKG/GRJbBlZldbw==
X-Received: by 2002:a17:90a:1c08:b0:1cd:474a:a4f8 with SMTP id s8-20020a17090a1c0800b001cd474aa4f8mr690612pjs.82.1649893787497;
        Wed, 13 Apr 2022 16:49:47 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:389b:6ba3:7cbd:d8d])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b005060849909esm197075pfl.176.2022.04.13.16.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:49:46 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/3] xtensa: move asid_cache from fault.c to mmu.c
Date:   Wed, 13 Apr 2022 16:49:28 -0700
Message-Id: <20220413234930.1212335-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413234930.1212335-1-jcmvbkbc@gmail.com>
References: <20220413234930.1212335-1-jcmvbkbc@gmail.com>
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

asid_cache is only useful with full MMU, but fault.c is also useful with
MPU. Move asid_cache definition to MMU-specific source file.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/mm/fault.c | 1 -
 arch/xtensa/mm/mmu.c   | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 06d0973a0d74..2a120c024334 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -21,7 +21,6 @@
 #include <asm/cacheflush.h>
 #include <asm/hardirq.h>
 
-DEFINE_PER_CPU(unsigned long, asid_cache) = ASID_USER_FIRST;
 void bad_page_fault(struct pt_regs*, unsigned long, int);
 
 /*
diff --git a/arch/xtensa/mm/mmu.c b/arch/xtensa/mm/mmu.c
index 38acda4f04e8..92e158c69c10 100644
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -18,6 +18,8 @@
 #include <asm/initialize_mmu.h>
 #include <asm/io.h>
 
+DEFINE_PER_CPU(unsigned long, asid_cache) = ASID_USER_FIRST;
+
 #if defined(CONFIG_HIGHMEM)
 static void * __init init_pmd(unsigned long vaddr, unsigned long n_pages)
 {
-- 
2.30.2

