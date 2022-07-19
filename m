Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC45795E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbiGSJQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiGSJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:16:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FDA192B9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:16:03 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8t3nU010153;
        Tue, 19 Jul 2022 09:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=bb5EIMLfFWIMK62XXQnbU6dWC4qdzyIjQZ4VlcqlQaU=;
 b=WURkEaUkKt/l7iv2nwl24zw8paEyNJ5wV6D5mXMCgjXBelWHczEGHm0ebNInxxOQuWFa
 HPu8p9PbR6ZUBd1JWNOHbiVjbCHQLOhzxT0NVjOFnu59MsaT+SNEghtqFO5Xa+MsmBqL
 exXB/V7c6/BEt5n754j20j8G3p9oVNb3qdh6UgTDro6Zd1o0tg7Bz6xnOtFpiHF2QSbq
 I6q0aQUIFRWQj1itWJEeI6rdAhwaXSh27q22o9ZxDzSft0UW8k1RCM+f21r1r2yl30RU
 H+QE8LtU4jjfB8qwP0Qc7c6cWXcHsOMe1NsI1fydyVuwM04j76beulecQl4iR7nxFOen TQ== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hdknk0mns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 09:16:01 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 26J9FxcK006088;
        Tue, 19 Jul 2022 09:15:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 3hc6rjbwrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jul 2022 09:15:59 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26J9FwoG006082;
        Tue, 19 Jul 2022 09:15:58 GMT
Received: from jiacangl2-gv.qualcomm.com (jiacangl2-gv.qualcomm.com [10.231.253.177])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 26J9FwLb006081;
        Tue, 19 Jul 2022 09:15:58 +0000
Received: by jiacangl2-gv.qualcomm.com (Postfix, from userid 399080)
        id 6E77F37A69D; Tue, 19 Jul 2022 17:15:57 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Kassey Li <quic_yingangl@quicinc.com>
Subject: [PATCH] mm/cma_debug.c: align the name buffer length as struct cma
Date:   Tue, 19 Jul 2022 17:15:54 +0800
Message-Id: <20220719091554.27864-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ULwnNTs9qNRwFueSUGn7TOlGtQfu8BiK
X-Proofpoint-ORIG-GUID: ULwnNTs9qNRwFueSUGn7TOlGtQfu8BiK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=352 adultscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190039
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 mm/cma_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 2e7704955f4f..c3ffe253e055 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -163,7 +163,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(cma_alloc_fops, NULL, cma_alloc_write, "%llu\n");
 static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
 {
 	struct dentry *tmp;
-	char name[16];
+	char name[CMA_MAX_NAME];
 
 	scnprintf(name, sizeof(name), "cma-%s", cma->name);
 
-- 
2.17.1

