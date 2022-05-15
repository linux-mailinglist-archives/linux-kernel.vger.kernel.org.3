Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B938527791
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbiEOMn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiEOMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:43:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAED2EA17
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p12so11744707pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
        b=pS/jHvHWwnFrMXvw/NKO7jVf7rgAWmrSVIhik0j+dafXTZMkW49m+3oCGrFQqDzbos
         fEEJzmYybyqQFqXj6DKvTAXpZ59cC2trVDVaFT3N2OPV98AUho+qv5H2EI3gdseGYAc9
         dC/I5NtukRdxetaDlvbcln8bqw9kuGMdgQfjUQ50erk4ehtML9NK0f+DvIKGzaceJh08
         whIQDqUpRrBI1AoXyeTdk0QEn6KMdAiUODtkefc4xfMwDrHiwgFBrdxFfDK+hACaNZqM
         z7AC5DtDZr+ue5N5p0LbiL8fEqedqJHRk98LeinCbc0Wsv2OeWheFz/FdlTzn8F6fvrq
         9jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6nKYG584PAtoQ8/jvqpBx36KvgGo8qJoQWKQdOpBKU=;
        b=afZYSkyqAC/ZU0BnK8IfLg9/Z3wlnHO45VgOsfzfsbQLh3z5lYFTGbeh27l34fvZK3
         dNYXx/GPTeSVq0BdBqUcyQr4TImlW1sUb8tgV4odZ/j2RVZIjIMfCk3ie+wWQvIgHm9y
         4aa4UwNDqU+BxFTjvKR+KJSPe4Voyt0F4E8N6lpaElL+zK9pwedCHHjSfYl3awLlL5K5
         +9KaN/YwCuIopsn1ivqbib3eikKzQ+Hrhhl/UHX1niD0jl0aWbSeoMctMaKLUl9togDt
         TsSIO4WOJl8R+sq+E9kVq0ojcgpQmKgJ7e+WIuGAlLhgZiFaBKjdFCw4H38x8gAVoT4J
         L2ng==
X-Gm-Message-State: AOAM530AqAxdhlV6x3t6rLvFjK+CmKNMR1myJphWCzpHhNgHyGfznJXs
        OVZe53CeDoWcVJQXdOB1LKm50Q/bBgzpkQ==
X-Google-Smtp-Source: ABdhPJzK3nMYwucViE+6UcrtAYIhYH8yd+pU+/ungG8bLNSFY/C8q7rakJXXY7nDCSbGIll7b+Lapw==
X-Received: by 2002:a65:6a16:0:b0:39d:4f3:67e6 with SMTP id m22-20020a656a16000000b0039d04f367e6mr11720141pgu.84.1652618568182;
        Sun, 15 May 2022 05:42:48 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b0015e8d4eb1f6sm5209876plh.64.2022.05.15.05.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:42:47 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 12/13] openrisc/fault: Fix symbol scope warnings
Date:   Sun, 15 May 2022 21:41:57 +0900
Message-Id: <20220515124158.3167452-13-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reported the following warning:

    arch/openrisc/mm/fault.c:27:15: warning: symbol 'pte_misses' was not declared. Should it be static?
    arch/openrisc/mm/fault.c:28:15: warning: symbol 'pte_errors' was not declared. Should it be static?
    arch/openrisc/mm/fault.c:33:16: warning: symbol 'current_pgd' was not declared. Should it be static?

This patch fixes these by:
 - Remove unused pte_misses and pte_errors counters which are no longer
   used.
 - Add asm/mmu_context.h include to provide the current_pgd declaration.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/fault.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 80bb66ad42f6..516cba14dec9 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -18,15 +18,13 @@
 #include <linux/perf_event.h>
 
 #include <linux/uaccess.h>
+#include <asm/mmu_context.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 
 #define NUM_TLB_ENTRIES 64
 #define TLB_OFFSET(add) (((add) >> PAGE_SHIFT) & (NUM_TLB_ENTRIES-1))
 
-unsigned long pte_misses;	/* updated by do_page_fault() */
-unsigned long pte_errors;	/* updated by do_page_fault() */
-
 /* __PHX__ :: - check the vmalloc_fault in do_page_fault()
  *            - also look into include/asm/mmu_context.h
  */
-- 
2.31.1

