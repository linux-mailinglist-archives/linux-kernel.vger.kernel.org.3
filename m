Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6EB4F975F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiDHNzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiDHNzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:55:44 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2165D541BD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:53:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649426018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYRCEMKWYu0UDhikG8Ly0BDPYPTrRS4FaVxa2Scm9pU=;
        b=D98jGQZJ/Q96aheRWk0f6JMhEQHX+yvMXktw/S+8PypGelMork+OaylW7lF5Rr6nNTDEmh
        92u10xKgkamt9Ep6joVsygAllJQQpN/LNRihRUL5Rp/SYTbe0aZZ1LT/53CCUoPLaPtATN
        5Rw90DCQuXRP1CXYkvnr1EBIa8yGhMU=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/3] Revert "mm/memory-failure.c: fix race with changing page compound again"
Date:   Fri,  8 Apr 2022 22:53:23 +0900
Message-Id: <20220408135323.1559401-4-naoya.horiguchi@linux.dev>
In-Reply-To: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Reverts commit 888af2701db7 ("mm/memory-failure.c: fix race with
changing page compound again") because now we fetch the page refcount
under hugetlb_lock in try_memory_failure_hugetlb() so that the race
check is no longer necessary.

Suggested-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h      |  1 -
 include/ras/ras_event.h |  1 -
 mm/memory-failure.c     | 11 -----------
 3 files changed, 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f44254af8ce..d446e834a3e5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3251,7 +3251,6 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_DAX,
 	MF_MSG_UNSPLIT_THP,
-	MF_MSG_DIFFERENT_PAGE_SIZE,
 	MF_MSG_UNKNOWN,
 };
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 1e694fd239b9..d0337a41141c 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -374,7 +374,6 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_DAX, "dax page" )					\
 	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
-	EM ( MF_MSG_DIFFERENT_PAGE_SIZE, "different page size" )	\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b2e32cdc3823..e2674532678b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -733,7 +733,6 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
-	[MF_MSG_DIFFERENT_PAGE_SIZE]	= "different page size",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1605,16 +1604,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		return res == MF_RECOVERED ? 0 : -EBUSY;
 	}
 
-	/*
-	 * The page could have changed compound pages due to race window.
-	 * If this happens just bail out.
-	 */
-	if (!PageHuge(p) || compound_head(p) != head) {
-		action_result(pfn, MF_MSG_DIFFERENT_PAGE_SIZE, MF_IGNORED);
-		res = -EBUSY;
-		goto out;
-	}
-
 	page_flags = head->flags;
 
 	/*
-- 
2.25.1

