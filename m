Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091144D4D39
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiCJPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbiCJPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:22:35 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DD71301BE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646925680; x=1678461680;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=OCkyn1d0jZJeCuLqpTCUe7k/tQ6fLAJyMA1OoSi4o6c=;
  b=PTQimPZBBzMnrwpeAAd7g2F7hYV0LF/GRB7y3qTJcPeFPYDToZ/4Ut7A
   1zbqxqS6b/QeCkuItP6JUd5mxdtGzmYLTkZHfVULnaVd2sXWgAP7VKgl9
   OlG1wsOKGGzJrbkSThvpAJySc6HDZGVLBqejgwGAC3TFB/bMFe0ZnK4Ik
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 10 Mar 2022 07:21:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 07:21:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 10 Mar 2022 07:21:19 -0800
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 10 Mar 2022 07:21:16 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <iamjoonsoo.kim@lge.com>,
        <mhocko@suse.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <trivial@kernel.org>, Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] mm: vmscan: fix documentation for page_check_references()
Date:   Thu, 10 Mar 2022 20:50:40 +0530
Message-ID: <1646925640-21324-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit b518154e59aa ("mm/vmscan: protect the workingset on anonymous
LRU") requires to look twice for both mapped anon/file pages are used
more than once to take the decission of reclaim or activation. Correct
the documentation accordingly.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 59b14e0..aab6f6e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1398,7 +1398,7 @@ static enum page_references page_check_references(struct page *page,
 		/*
 		 * All mapped pages start out with page table
 		 * references from the instantiating fault, so we need
-		 * to look twice if a mapped file page is used more
+		 * to look twice if a mapped file/anon page is used more
 		 * than once.
 		 *
 		 * Mark it and spare it for another trip around the
-- 
2.7.4

