Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B350C2E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiDVWMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiDVWKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:10:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866772F7E2A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:56:36 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MGrT4o020112;
        Fri, 22 Apr 2022 19:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=E4yEUAxbjgnTO7FClAV39+AdHCwnl7sbYhKHBs2Qa6I=;
 b=STYKulM4uATqR8xEa7FsAJ9+MkRbTWukIzLiyIIw3ZHkn68fFwm05WD8EKX7R4ENAMOf
 KI7YZ49n4FRz3GXKEz+UsMpPxtlz4PrpTU3neIS59EU646tMibeEyQKb94WLPOdM2vin
 mJ4dVx5yvhfjxtRhLprnluNk4SGlEcMeCt1FEObRIKa7E3kru2PhzhyAt8WhoFs60wFV
 z61Tmng+WkwCNIXaEG3RsazFBMpeG/a1uN3v13aYgqeVjg88MpHUxnEXCSNkkv3KaC8z
 oBmLu13zyvIArPdyFUvY88De8TYVYSOtokm76/GJWCM+jWJfGs1r93PXF6njuCGjVCNA Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fk1yf8e5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:53 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23MJLZKj031559;
        Fri, 22 Apr 2022 19:55:53 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fk1yf8e55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:52 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23MJiTjf011197;
        Fri, 22 Apr 2022 19:55:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3ffne8ytcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 19:55:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23MJtlLj40894884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 19:55:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B36011C04C;
        Fri, 22 Apr 2022 19:55:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 502D911C04A;
        Fri, 22 Apr 2022 19:55:44 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com.com (unknown [9.43.112.230])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Apr 2022 19:55:44 +0000 (GMT)
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v3 5/7] mm: demotion: Build demotion list based on N_DEMOTION_TARGETS
Date:   Sat, 23 Apr 2022 01:25:14 +0530
Message-Id: <20220422195516.10769-6-jvgediya@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422195516.10769-1-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cJPTmN8FTowY5h6ZkAMojGkVXguilEO6
X-Proofpoint-GUID: 8WNQ91jXL9acN28yVe-5EOs3eWzq185K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 mlxlogscore=867 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only nodes which has state N_DEMOTION_TARGETS should be
used as demotion targets, make nodes which are not in demotion
targets as source nodes while building demotion target list
so that demotion targets are only chosen from N_DEMOTION_TARGETS.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
---
 mm/migrate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8bbe1e478122..5b92a09fbe4a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2366,10 +2366,10 @@ static void __set_migration_target_nodes(void)
 	disable_all_migrate_targets();
 
 	/*
-	 * Allocations go close to CPUs, first.  Assume that
-	 * the migration path starts at the nodes with CPUs.
+	 * Some systems can have DRAM(fast memory) only NUMA nodes, demotion targets
+	 * need to be found for them as well.
 	 */
-	next_pass = node_states[N_CPU];
+	nodes_andnot(next_pass, node_states[N_ONLINE], node_states[N_DEMOTION_TARGETS]);
 again:
 	this_pass = next_pass;
 	next_pass = NODE_MASK_NONE;
-- 
2.35.1

