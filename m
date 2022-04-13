Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909D14FF363
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiDMJZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiDMJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:25:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B7B532D1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:22:40 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D9CHLg025180;
        Wed, 13 Apr 2022 09:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xEuKeeb6CPM40df+lXa1GIogUowI06MGWTkkso5bVNY=;
 b=qiOHq1HFw2LjapovMSlv1NJjdGxW71l/pGbBi4XvWg7m8Ty10QO0IKGRwIqYuiBytmsV
 S73DoIpsbdVrkNGyAo7yyl8f8obZfKpYzRWKNUszKt3qJmUjOyWdWCmFUIpryfr42ZqX
 JhkeGu3lMQe+pHvsgwOmAyHGGHuEPwI8dGbn59rF1aO8nfPKlVBBINdxag294IcmTLy1
 vMP21ROi04iWbmRSp4pdVUehgGKsU+svq5b3InwN9KEQjsoDo7EJ6GnEuMnU2MLYVMH8
 aEsccwa57Ix1DWn2ysxNtpXmAG0YyxHdKKmNse9TDJodAFJ+Dw6KGYImm3XKfrk+29iu wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fdup206d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:36 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23D9IA96013448;
        Wed, 13 Apr 2022 09:22:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fdup206cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23D9MBtP021566;
        Wed, 13 Apr 2022 09:22:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3fb1s8xerb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 09:22:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23D9MV9B42926404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 09:22:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E986A4C04E;
        Wed, 13 Apr 2022 09:22:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC72D4C050;
        Wed, 13 Apr 2022 09:22:28 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.51.146])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Apr 2022 09:22:28 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v2 5/5] mm: demotion: Build demotion list based on N_DEMOTION_TARGETS
Date:   Wed, 13 Apr 2022 14:52:06 +0530
Message-Id: <20220413092206.73974-6-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413092206.73974-1-jvgediya@linux.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: otWXF-ZG7BkB_v-O9E6I3nxpLJWzU1zr
X-Proofpoint-ORIG-GUID: FOE330h_nNeZbS-12QtEv6ppLXNnh0bo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_01,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204130051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only nodes which has state N_DEMOTION_TARGETS should be
used as demotion targets.

make nodes which are not in demotion targets as source nodes
while building demotion target list.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 mm/migrate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4d3d80ca0a7f..e517a5ab1fcf 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2394,10 +2394,11 @@ static void __set_migration_target_nodes(void)
 	disable_all_migrate_targets();
 
 	/*
-	 * Allocations go close to CPUs, first.  Assume that
-	 * the migration path starts at the nodes with CPUs.
+	 * Pick demotion targets only from node_states[N_DEMOTION_TARGETS]
+	 * so make nodes which are not in demotion targets as source nodes
 	 */
-	next_pass = node_states[N_CPU];
+	nodes_andnot(next_pass, node_states[N_ONLINE],
+		     node_states[N_DEMOTION_TARGETS]);
 again:
 	this_pass = next_pass;
 	next_pass = NODE_MASK_NONE;
-- 
2.35.1

