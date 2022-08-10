Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB9258F18F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiHJR2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiHJR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:28:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560CD7C761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:28:52 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AEN9Cf028793;
        Wed, 10 Aug 2022 17:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=pHnYNDIbIxbTXRPWSMIXGubce2vdDoCOAC23ha+lTRU=;
 b=BA4r2+cPOI5TRvWmgxFuCI6FY9EB3mZSrPmCI3nDO3wJFhNPMCbH6B1BieK02/IuuFPC
 Wy+uQpOSR11NEjdCGF/iwg9TM3YhakcLoystNrXq00QfagOLUwBuTPqbusjA+OsKsENJ
 YA4MRqFhoqCzAViq3H+kBv66dBLp0I4AfXODJlJ9Ti3QmdygdOyqWdrESkXkivLVJHzy
 QzKxWfWHPiVXsw/clDoQmrF4NQtceFVsoXqeIyPxzztPM/hKl1pyaDQh2iiK8qUj7baO
 iJwexdUO/j9Gj21ayJmoo/QJ5/bfmvcAcJCpnOBuBRMsbpi8DSxkBsu6caQI0YwuO6oC 3Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwr5k995-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 17:28:46 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27AHQFF8026674;
        Wed, 10 Aug 2022 17:28:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3hshck5yr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 17:28:45 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27AHSiWa030570;
        Wed, 10 Aug 2022 17:28:45 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 27AHSi98030569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 17:28:44 +0000
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 10:28:44 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 10:28:41 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>, <vbabka@suse.cz>,
        <quic_pkondeti@quicinc.com>, <minchan@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] mm/cma_debug: show complete cma name in debugfs directories
Date:   Wed, 10 Aug 2022 22:58:05 +0530
Message-ID: <1660152485-17684-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5nMOJ4Gi2L-no8AreXv6h5wjT_i7xW1J
X-Proofpoint-ORIG-GUID: 5nMOJ4Gi2L-no8AreXv6h5wjT_i7xW1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_11,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 mlxlogscore=611 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100053
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

Also drop 'cma-' prefix for the cma debug directories as they are
clearly evident that they are for cma debug through creating them in
/sys/kernel/debug/cma/ path.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/cma_debug.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

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

