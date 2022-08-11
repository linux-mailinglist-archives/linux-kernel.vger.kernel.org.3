Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4035E58FD32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiHKNQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiHKNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:16:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA03C5A3E8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:16:09 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BCJet5012200;
        Thu, 11 Aug 2022 13:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZSJevoEo0/gXYnJN6XjQELpSgkgJvag66N3XNH5+np8=;
 b=eNrvVSmPJjnMAjj6NcoM8JOJP+Gp+Wj+Clh6KsQBZimzXS480vBqwAzEu6YfV4jfsCDz
 HA0HKHnaX4DZmL6OwXKaIkDhQ3nswadjNQi04XIq6L6k4fjgEY45V1paW8psICmBw3IS
 JCcCgoDRiAXtZxZ/Ypfc+8gTHHNhpLW79ju28ldKqPwgItaC2uq6omIQAJTAf2G1pyy7
 qUCG3VTUUHX63RSnbdoRKU3+CHSm7AsS/r25E7flC7qXnjEgggvRKQBvoePhTLBqFTSK
 inrowKTTLgTw7gxj1sEpmAJpBeaT357eP9kFZEFcJ3o6+AxzbhTMXWMoXtj1ZPqYz2a6 PQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwr8x45a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 13:16:01 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27BDG0nt028457;
        Thu, 11 Aug 2022 13:16:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3hshck9bbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 13:16:00 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27BDFDVH028134;
        Thu, 11 Aug 2022 13:16:00 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 27BDG0aV028451
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 13:16:00 +0000
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 11 Aug 2022 06:15:56 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>, <vbabka@suse.cz>,
        <quic_pkondeti@quicinc.com>, <minchan@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V2] mm/cma_debug: show complete cma name in debugfs directories
Date:   Thu, 11 Aug 2022 18:45:29 +0530
Message-ID: <1660223729-22461-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vs4fy44rX8cWr3rocS8MD_j03MkYzMnG
X-Proofpoint-ORIG-GUID: vs4fy44rX8cWr3rocS8MD_j03MkYzMnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=482 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only 12 characters of the cma name is being used as the debug
directories where as the cma name can be of length CMA_MAX_NAME(=64)
characters. One side problem with this is having 2 cma's with first
common 12 characters would end up in trying to create directories with
same name and fails with -EEXIST thus can limit cma debug functionality.

The 'cma-' prefix is used initially where cma areas don't have any names
and are represented by simple integer values. Since now each cma would
be having its own name, drop 'cma-' prefix for the cma debug directories
as they are clearly evident that they are for cma debug through creating
them in /sys/kernel/debug/cma/ path.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
V2:
 o Updated the cma_debugfs.rst documentation.
Vl:
 o https://lore.kernel.org/all/1660152485-17684-1-git-send-email-quic_charante@quicinc.com/

 Documentation/admin-guide/mm/cma_debugfs.rst | 10 +++++-----
 mm/cma_debug.c                               |  5 +----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/mm/cma_debugfs.rst b/Documentation/admin-guide/mm/cma_debugfs.rst
index 4e06ffa..7367e62 100644
--- a/Documentation/admin-guide/mm/cma_debugfs.rst
+++ b/Documentation/admin-guide/mm/cma_debugfs.rst
@@ -5,10 +5,10 @@ CMA Debugfs Interface
 The CMA debugfs interface is useful to retrieve basic information out of the
 different CMA areas and to test allocation/release in each of the areas.
 
-Each CMA zone represents a directory under <debugfs>/cma/, indexed by the
-kernel's CMA index. So the first CMA zone would be:
+Each CMA area represents a directory under <debugfs>/cma/, represented by
+its CMA name like below:
 
-	<debugfs>/cma/cma-0
+	<debugfs>/cma/<cma_name>
 
 The structure of the files created under that directory is as follows:
 
@@ -18,8 +18,8 @@ The structure of the files created under that directory is as follows:
  - [RO] bitmap: The bitmap of page states in the zone.
  - [WO] alloc: Allocate N pages from that CMA area. For example::
 
-	echo 5 > <debugfs>/cma/cma-2/alloc
+	echo 5 > <debugfs>/cma/<cma_name>/alloc
 
-would try to allocate 5 pages from the cma-2 area.
+would try to allocate 5 pages from the 'cma_name' area.
 
  - [WO] free: Free N pages from that CMA area, similar to the above.
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 2e77049..602fff8 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -163,11 +163,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(cma_alloc_fops, NULL, cma_alloc_write, "%llu\n");
 static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
 {
 	struct dentry *tmp;
-	char name[16];
 
-	scnprintf(name, sizeof(name), "cma-%s", cma->name);
-
-	tmp = debugfs_create_dir(name, root_dentry);
+	tmp = debugfs_create_dir(cma->name, root_dentry);
 
 	debugfs_create_file("alloc", 0200, tmp, cma, &cma_alloc_fops);
 	debugfs_create_file("free", 0200, tmp, cma, &cma_free_fops);
-- 
2.7.4

