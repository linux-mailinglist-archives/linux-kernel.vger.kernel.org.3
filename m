Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26805558BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiFWXxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiFWXw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:52:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E0B7F5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so4344301pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xlh5+JHPCpuQ09KawzKkUOlMCn4aWXR34ra2vrdN9hI=;
        b=MEmORMw9CoAhwNYfHfOlrZjmyaV1kxLa2ly8Bz617AoWw6gyQfA+eYRxSScDsayqSE
         vEeb04MRVgwYo6YZU8ahEfefgc7Zo/NiMU+DYL4YDwHrcNbicueEUnbIqQFX5doIy1jm
         /kCAQATYrsmfNaVqrDVcb6DJfAGw87zSOMdMLh1lLF7YOPPH/73bvPg34HTyM7tpRGUQ
         nOjgsZK4t5kglXK6qoK3JAYx7AQQTcRuk8Mj17qhHxTNgnF+Y7GasXDcNgFynTQE9W9L
         95RsE1CJ9sfNpVvHVI83dPlXVdq3OhKVdl2cpSil4MWjqDhLx+Kv/eTTwb9LdbB6ZrXn
         bNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xlh5+JHPCpuQ09KawzKkUOlMCn4aWXR34ra2vrdN9hI=;
        b=FCIZvM3+6XuLd+PI7KgWRki0IDSCYKWTWuzMqTyEtSOJNXGdWGKQIy0Uhi1SCfwIGg
         W3eFBA+/dIqpzWavrrMQJ8lIyMePQvW34jNeoBO1f31q+THB/iPDb6HdeSaOB/AvDKsZ
         4O5fj0fFTY6rVzXk18VvzdnjWZU24xcH/JzIrpdckz7y24oR6hUFK3PeOBmcVCHLeZI3
         HQHIuzkmniQY2fcGC57Z8gL65Mt3lPXlg4cZRaP37t2M+OXnUjEC8Xvcy0TUMPTU8Zri
         DsNChRiCIWH8We2qvkzfFAu3G057yBfXQepChSAg3XEa6/ZyVAARX970kStT51wVHxAA
         lJBQ==
X-Gm-Message-State: AJIora8NYzJzy3kN657tFJ30tJEVLyyJZKgFSYj7cqaFxQN5UHQBgVZ/
        LWbcuV6ibaURNCd7dEIbWEyYPVoZUQ==
X-Google-Smtp-Source: AGRyM1soNngnpVcfxmXaErJFMeKvhtVFxNIlwB4ItZCs2wn5DW3s5YIJ6hdZc7kgW4lJHxcSAIlZDg==
X-Received: by 2002:a17:90b:1808:b0:1ec:9559:3060 with SMTP id lw8-20020a17090b180800b001ec95593060mr542906pjb.163.1656028375788;
        Thu, 23 Jun 2022 16:52:55 -0700 (PDT)
Received: from ik1-406-35019.vs.sakura.ne.jp (ik1-406-35019.vs.sakura.ne.jp. [153.127.16.23])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b00168eab11f67sm362571plh.94.2022.06.23.16.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:52:55 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
X-Google-Original-From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] mm, hwpoison: enable memory error handling on 1GB hugepage
Date:   Fri, 24 Jun 2022 08:51:53 +0900
Message-Id: <20220623235153.2623702-10-naoya.horiguchi@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
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

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Now error handling code is prepared, so remove the blocking code and
enable memory error handling on 1GB hugepage.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h      |  1 -
 include/ras/ras_event.h |  1 -
 mm/memory-failure.c     | 16 ----------------
 3 files changed, 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 044dc5a2e361..9d7e9b5a4d1d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3284,7 +3284,6 @@ enum mf_action_page_type {
 	MF_MSG_DIFFERENT_COMPOUND,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
-	MF_MSG_NON_PMD_HUGE,
 	MF_MSG_UNMAP_FAILED,
 	MF_MSG_DIRTY_SWAPCACHE,
 	MF_MSG_CLEAN_SWAPCACHE,
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index d0337a41141c..cbd3ddd7c33d 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -360,7 +360,6 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
-	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
 	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
 	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
 	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc7b83cb6468..33521e059f7f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -728,7 +728,6 @@ static const char * const action_page_types[] = {
 	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
-	[MF_MSG_NON_PMD_HUGE]		= "non-pmd-sized huge page",
 	[MF_MSG_UNMAP_FAILED]		= "unmapping failed page",
 	[MF_MSG_DIRTY_SWAPCACHE]	= "dirty swapcache page",
 	[MF_MSG_CLEAN_SWAPCACHE]	= "clean swapcache page",
@@ -1717,21 +1716,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 
 	page_flags = head->flags;
 
-	/*
-	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
-	 * simply disable it. In order to make it work properly, we need
-	 * make sure that:
-	 *  - conversion of a pud that maps an error hugetlb into hwpoison
-	 *    entry properly works, and
-	 *  - other mm code walking over page table is aware of pud-aligned
-	 *    hwpoison entries.
-	 */
-	if (huge_page_size(page_hstate(head)) > PMD_SIZE) {
-		action_result(pfn, MF_MSG_NON_PMD_HUGE, MF_IGNORED);
-		res = -EBUSY;
-		goto out;
-	}
-
 	if (!hwpoison_user_mappings(p, pfn, flags, head)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
-- 
2.25.1

