Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D445A1E21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbiHZB0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbiHZBZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:25:52 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D794531374
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:25:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z20so244192ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=+mINjNlXaA4i7a2OMQm5AZHnT3Bc47HDHwyy7Xy8wA4=;
        b=T6JrUHxDKNcEmKm8phKz2emMyDNSyNBqmLJNiTRlCowhzaqCLlPsT88FlT5dKB5Bkl
         oAI4FejmXVBRo31ehqeWj/xsCPjYb2UIfC7dkdlTOqed77eyIePQERa0BjTYsmeKYcSh
         uap0ZtPr8HPHcWpP1eWSpBhEqZfIYQuscWbZwoyDTVSG2c2UYrcx6H4FHFkCrrsbJy9O
         kWCAxmL4sljtAwhsBuPcQ7XwVlgqSDH15+WzQuBYR1Gyy+tG5ZwW+RO+CU2Ax/Sr6o+l
         HglBtRW+txiqkoI7JRNAZoJSD3cCzrVcv2ZaWdPL53/8xnJzRs8qDkO3noH5oPIOcXR1
         dX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+mINjNlXaA4i7a2OMQm5AZHnT3Bc47HDHwyy7Xy8wA4=;
        b=da8FXL6dTmd6ffMCLL3UVJtheZJXuZN7Nh0y6mPmkzhkF5Eoo/W72l4wXBxRBUoGTW
         2H60oVbF4tphRFVzDId3WSJ/8yO+kRZXOQTRG/6pZ7e/4gI8cmAd20vHy1GrDC3k1M5l
         M1VYRIs2M+VRlSaS+Xn9vZg9oPSnjW5DSwP/CMfJ6dD4JRONtojLHU0XO3A/HSAcf43d
         Y1v4UPajtqvFa0dOx7XZUalrSDWIL1GXXktqDMReNM73a9guWQv2fJZkMjIPXsxecCn8
         +e7jpAXLT+n6S6P6vKmZdsld0Hb9V+5R9u4cdGFohkEJFkY/0rPG0mrAxxplG2MLpa8V
         Jxdw==
X-Gm-Message-State: ACgBeo3zO1fC1bNZ3rtOqpt39T2a9NGFmRPDQYObOTHYtCJpi7nYznNQ
        FTI9CbOqRxmDAYk+3qTJrC0=
X-Google-Smtp-Source: AA6agR4H7tbPKSPWLcyg4J3bhA8D5pQi5qEWYZ9BvQSh4qZsTQ80sH0tUOyqJmnB+Mf0JGAThtyZWg==
X-Received: by 2002:a2e:9e0b:0:b0:261:d9ac:b533 with SMTP id e11-20020a2e9e0b000000b00261d9acb533mr1714120ljk.74.1661477149279;
        Thu, 25 Aug 2022 18:25:49 -0700 (PDT)
Received: from localhost.localdomain (37-145-44-29.broadband.corbina.ru. [37.145.44.29])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512200300b004918fff6a93sm125819lfb.296.2022.08.25.18.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 18:25:48 -0700 (PDT)
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Subject: [PATCH] x86/mm: dynamic memory layout declarations
Date:   Fri, 26 Aug 2022 04:24:45 +0300
Message-Id: <20220826012445.32628-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The declarations page_offset_base, vmalloc_base and vmemmap_base makes
sense only if CONFIG_DYNAMIC_MEMORY_LAYOUT is enabled. Hides the
declarations behind a conditional macro checking the option.

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---
 arch/x86/include/asm/page_64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index baa70451b8df..2968b3644912 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -12,9 +12,11 @@
 extern unsigned long max_pfn;
 extern unsigned long phys_base;
 
+#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 extern unsigned long page_offset_base;
 extern unsigned long vmalloc_base;
 extern unsigned long vmemmap_base;
+#endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
-- 
2.17.1

