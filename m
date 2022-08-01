Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ECD5863B5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiHAFHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiHAFHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:07:17 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21775DEA4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659330437; x=1690866437;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=14Ig8KLA7feC588WTqgFQGrGr9rDvdUlqzY+TRRFf4A=;
  b=gdTn630tq6NOXJ+yiZZYEWkfmrvfr7tNZSauYmhQxTU+CSfRhSUFh6bO
   70sG95/Sx357CnoZULI63InFrlcj7LnUeFVburFMMqAF/J41ouHrWWugx
   wx66t7gpyhnvfY9iplbhFRb+gwbwXGD5XvYh+g0cDNyzdpGFjMf5ftEgO
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 31 Jul 2022 22:07:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 22:07:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 31 Jul 2022 22:07:16 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 31 Jul 2022 22:07:13 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>, <mhocko@suse.com>,
        <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] mm/page_ext: remove unused variable in offline_page_ext
Date:   Mon, 1 Aug 2022 10:36:37 +0530
Message-ID: <1659330397-11817-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable 'nid' in offline_page_ext(). This is not used
since the page_ext code inception.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/page_ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 3dc715d..e22a928 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -336,7 +336,7 @@ static int __meminit online_page_ext(unsigned long start_pfn,
 }
 
 static int __meminit offline_page_ext(unsigned long start_pfn,
-				unsigned long nr_pages, int nid)
+				unsigned long nr_pages)
 {
 	unsigned long start, end, pfn;
 
@@ -362,11 +362,11 @@ static int __meminit page_ext_callback(struct notifier_block *self,
 		break;
 	case MEM_OFFLINE:
 		offline_page_ext(mn->start_pfn,
-				mn->nr_pages, mn->status_change_nid);
+				mn->nr_pages);
 		break;
 	case MEM_CANCEL_ONLINE:
 		offline_page_ext(mn->start_pfn,
-				mn->nr_pages, mn->status_change_nid);
+				mn->nr_pages);
 		break;
 	case MEM_GOING_OFFLINE:
 		break;
-- 
2.7.4

