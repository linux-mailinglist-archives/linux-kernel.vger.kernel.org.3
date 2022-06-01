Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574EB53AA82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355872AbiFAPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353707AbiFAPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:53:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEDA46B1F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:53:41 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251FIpl4014497;
        Wed, 1 Jun 2022 15:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jsLDmPDsk+qdaGoUTUSLT3GvdwIT5bYRmXivIPthmfA=;
 b=S+X8s+PVYXe5WE+Ub6RPD/h9q2NQwpdBephA4PX3cZ9OQji4You8BNRDxdId7G8lAInr
 HFguuzonLTxvq7ydIHBpmtl0e1y/1ONFc5wrrg+3oSDucKcpdJXTO6xpZDQOzUljI/Pq
 kcjZuLp9UntgLL0hfYMvs0NV4keR83zo64yZQG9nK2D7SW/ikz9qY4Z5oaJWp0TYg8Pc
 pYBUgSGUu7B2brEuCWueDFBfo/JO9clXOQere1XPw5N4K6xNNhQlrsCbU0OBYFIy2V8I
 9kA4dXN9LuzevfokMjIuUsPsNTMtopj1iNhdbFHzW3manyjvXIEq8Fs6X4taDq5lxrXg qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gean2rq35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 15:53:24 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 251FKaEU022434;
        Wed, 1 Jun 2022 15:53:24 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gean2rq2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 15:53:24 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 251Fdi2n025567;
        Wed, 1 Jun 2022 15:53:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3gbc97ve7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 15:53:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 251FrIto14877074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jun 2022 15:53:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CE9A4203F;
        Wed,  1 Jun 2022 15:53:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB80542041;
        Wed,  1 Jun 2022 15:53:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.172.57])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jun 2022 15:53:17 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/mobility: disabling hard lockup watchdog during LPM
Date:   Wed,  1 Jun 2022 17:53:15 +0200
Message-Id: <20220601155315.35109-3-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601155315.35109-1-ldufour@linux.ibm.com>
References: <20220601155315.35109-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xep8JDT63SigspQwgRFfKLLYdkYHtMg3
X-Proofpoint-GUID: QO-v4BNXcXW_gatijIjXKflVaEcBSWWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_05,2022-06-01_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=764
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling the Hard Lockup Watchdog until the memory transfer is complete.

This avoids hard lockup seen while the memory is still in progress when the
system is heavily loaded and a lot of pages are still not transferred on
the arrival side.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 55612a1b07d6..061d4faefefb 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -701,6 +701,9 @@ static int pseries_migrate_partition(u64 handle)
 
 	vas_migration_handler(VAS_SUSPEND);
 
+	pr_debug("Disabling the NMI watchdog\n");
+	watchdog_nmi_stop();
+
 	ret = pseries_suspend(handle);
 	if (ret == 0) {
 		post_mobility_fixup();
@@ -708,6 +711,9 @@ static int pseries_migrate_partition(u64 handle)
 	} else
 		pseries_cancel_migration(handle, ret);
 
+	pr_debug("Enabling the NMI watchdog again\n");
+	watchdog_nmi_start();
+
 	vas_migration_handler(VAS_RESUME);
 
 	return ret;
-- 
2.36.1

