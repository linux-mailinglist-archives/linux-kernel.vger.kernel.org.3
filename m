Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42BE53AA83
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344973AbiFAPxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355864AbiFAPxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:53:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8D483B8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:53:42 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251Fm4Ai020740;
        Wed, 1 Jun 2022 15:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nfVh87Az55i8k1gppBZujWqK4+28GKuAIhgQbFoYIrE=;
 b=DNei/iN5ZUMb/fhoeF8N3+AMX1yBGoLSbB8rCQgfvhUfUBHOMokYAG3RAQDFcO2VTqwS
 fwoqfA1u4WkUW8tlb/Bi0Gw9dGdwDuQzxydkJ5E2GPnyFbsw751cqeHO/DPKaonds+ML
 Ybad3MWotaN7tDUhYtV1e04gAyZWIBBdQJaGXVWEHjoeub4TFf79cvDFx1mTMX6J1yjs
 bOQL11rZl9wGXk941P1rZQiuRiJKy2kfoah05TbggN92EqGc4OVKYN5928taXDeeIPjL
 S75StaCtjbWs0e2NcrvSaoqjHVFtkQQV8iKXcIFgnJ6VZ2sVjT6K/01s8CDi6/rezYaz AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geb2tr3af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 15:53:23 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 251FrNCG010550;
        Wed, 1 Jun 2022 15:53:23 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geb2tr39s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 15:53:23 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 251FdUB9028296;
        Wed, 1 Jun 2022 15:53:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3gbcae5u4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 15:53:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 251FrHNv49283486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jun 2022 15:53:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCB3042045;
        Wed,  1 Jun 2022 15:53:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5661E42041;
        Wed,  1 Jun 2022 15:53:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.172.57])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jun 2022 15:53:17 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/mobility: Wait for memory transfer to complete
Date:   Wed,  1 Jun 2022 17:53:14 +0200
Message-Id: <20220601155315.35109-2-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601155315.35109-1-ldufour@linux.ibm.com>
References: <20220601155315.35109-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BAdduxIEm0NJZQRh1N5EeucS_G_8QcFG
X-Proofpoint-ORIG-GUID: aDgUH9Xd3vz5W0lwqiztIfsC-Gq23559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_05,2022-06-01_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=937 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pseries_migration_partition(), loop until the memory transfer is
complete. This way the calling drmgr process will not exit earlier,
allowing callbacks to be run only once the migration is fully completed.

This will also allow to manage the NMI watchdog state in the next commits.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 34 +++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 78f3f74c7056..55612a1b07d6 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -427,6 +427,35 @@ static int wait_for_vasi_session_suspending(u64 handle)
 	return ret;
 }
 
+static void wait_for_vasi_session_completed(u64 handle)
+{
+	unsigned long state = 0;
+	int ret;
+
+	pr_info("waiting for memory transfert to complete...\n");
+	/*
+	 * Wait for transition from H_VASI_RESUMED to
+	 * H_VASI_COMPLETED. Treat anything else as an error.
+	 */
+	while (true) {
+		ret = poll_vasi_state(handle, &state);
+
+		if (ret || state == H_VASI_COMPLETED)
+			break;
+
+		if (state != H_VASI_RESUMED) {
+			pr_err("unexpected H_VASI_STATE result %lu\n", state);
+			ret = -EIO;
+			break;
+		}
+
+		msleep(500);
+	}
+
+	pr_info("memory transfert completed (ret:%d state:%ld).\n",
+		ret, state);
+}
+
 static void prod_single(unsigned int target_cpu)
 {
 	long hvrc;
@@ -673,9 +702,10 @@ static int pseries_migrate_partition(u64 handle)
 	vas_migration_handler(VAS_SUSPEND);
 
 	ret = pseries_suspend(handle);
-	if (ret == 0)
+	if (ret == 0) {
 		post_mobility_fixup();
-	else
+		wait_for_vasi_session_completed(handle);
+	} else
 		pseries_cancel_migration(handle, ret);
 
 	vas_migration_handler(VAS_RESUME);
-- 
2.36.1

