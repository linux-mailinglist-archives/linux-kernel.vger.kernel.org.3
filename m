Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752444758CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbhLOMYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:24:20 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:15447 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbhLOMYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639571060; x=1671107060;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0T9EXSTFudFillhaxA4SCedNXGE4nE1HUul8/TIhE10=;
  b=H4ROkm3JYBJXC5c2xqKlmL5JhNSBWtDwkwji2tDEfg2K+Y4qjIeHevR2
   kvmR6KFtDSLnnvSvFzID4dSOaBuLlPJGIcknH1PisJPDv+j3p1YZnRO/t
   BjOkCgToNoHa7X8zVunMZ1RDsb+c6pOMaPqOIhS4ue8l+T5HoF+1pPktu
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Dec 2021 04:24:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 04:24:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 04:24:19 -0800
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 04:24:16 -0800
From:   Charan Teja Reddy <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <surenb@google.com>, <vbabka@suse.cz>, <rientjes@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Reddy <quic_charante@quicinc.com>
Subject: [PATCH] mm/madvise: elevate page refcount while isolating in process_madvise()
Date:   Wed, 15 Dec 2021 17:53:39 +0530
Message-ID: <1639571019-30043-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of isolate_lru_page() says that, "it must be called
with an elevated refcount on the page", which is not followed while
isolating pages in process_madvise() system call with advise
MADV_PAGEOUT. Fix it.

Signed-off-by: Charan Teja Reddy <quic_charante@quicinc.com>
---
 mm/madvise.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8..4c4a8e9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -317,6 +317,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	pte_t *orig_pte, *pte, ptent;
 	spinlock_t *ptl;
 	struct page *page = NULL;
+	int ret;
 	LIST_HEAD(page_list);
 
 	if (fatal_signal_pending(current))
@@ -373,12 +374,15 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		ClearPageReferenced(page);
 		test_and_clear_page_young(page);
 		if (pageout) {
-			if (!isolate_lru_page(page)) {
+			get_page(page);
+			ret = isolate_lru_page(page);
+			if (!ret) {
 				if (PageUnevictable(page))
 					putback_lru_page(page);
 				else
 					list_add(&page->lru, &page_list);
 			}
+			put_page(page);
 		} else
 			deactivate_page(page);
 huge_unlock:
@@ -459,12 +463,15 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		ClearPageReferenced(page);
 		test_and_clear_page_young(page);
 		if (pageout) {
-			if (!isolate_lru_page(page)) {
+			get_page(page);
+			ret = isolate_lru_page(page);
+			if (!ret) {
 				if (PageUnevictable(page))
 					putback_lru_page(page);
 				else
 					list_add(&page->lru, &page_list);
 			}
+			put_page(page);
 		} else
 			deactivate_page(page);
 	}
-- 
2.7.4

