Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CC3573A73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiGMPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiGMPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:48:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D20D4E865;
        Wed, 13 Jul 2022 08:48:08 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DFiPJo029438;
        Wed, 13 Jul 2022 15:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0DhHvsxCxRfs8ONe0EUj23JBu5ERuQgHbLPOK7uZoz4=;
 b=qpu8PC9gHTuvYEIiUyzpz7qAFnPoKg2L35yihUdzkR5mm0NMtD2b2gNFddithWI7LiK2
 E1s4WvIJCL+KiFhKf7WqIQcg/MXnt4LnVD40uOdBTBN+RDv5BQC4FCNpPpOgVHattNP0
 XGm6c+zD9f6a7kmI+GWrcbJulplPFjyXtpVGXFGfkaPRYR1vDN5qn4VICNb4Tkg9zdgh
 67WbPKPkk41FWq1gm1aPrpSVoKpIY1NmqG9KGutm+OjnbSRkMkpnIGlNiObQhrS1pOJJ
 IcBeEkvAWKkvspHdKMfFUUvdM66NQE5nYDBNFhJMVHxMakB2zHhF/hhbPQbSrYxPAblu Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ha0xxr2ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 15:47:37 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26DFkE9r001922;
        Wed, 13 Jul 2022 15:47:36 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ha0xxr2dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 15:47:36 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26DFOCM0002503;
        Wed, 13 Jul 2022 15:47:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xhww1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 15:47:34 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26DFlVxp12583168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 15:47:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69CFBAE051;
        Wed, 13 Jul 2022 15:47:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA320AE045;
        Wed, 13 Jul 2022 15:47:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.2.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 15:47:30 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        wim@linux-watchdog.org, linux@roeck-us.net, nathanl@linux.ibm.com,
        rdunlap@infradead.org
Cc:     haren@linux.vnet.ibm.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v5 1/4] powerpc/mobility: wait for memory transfer to complete
Date:   Wed, 13 Jul 2022 17:47:26 +0200
Message-Id: <20220713154729.80789-2-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713154729.80789-1-ldufour@linux.ibm.com>
References: <20220713154729.80789-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ytPHl0Qilk7Pj133hrPfxl3DPos0mySt
X-Proofpoint-GUID: XHW1NtzqDq6FFbOrEt6KHMItT1LwnIc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_05,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130063
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

If reading the VASI state is done after the hypervisor has completed the
migration, the HCALL is returning H_PARAMETER. We can safely assume that
the memory transfer is achieved if this happens.

This will also allow to manage the NMI watchdog state in the next commits.

Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 48 ++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 78f3f74c7056..6297467072e6 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -427,6 +427,43 @@ static int wait_for_vasi_session_suspending(u64 handle)
 	return ret;
 }
 
+static void wait_for_vasi_session_completed(u64 handle)
+{
+	unsigned long state = 0;
+	int ret;
+
+	pr_info("waiting for memory transfer to complete...\n");
+
+	/*
+	 * Wait for transition from H_VASI_RESUMED to H_VASI_COMPLETED.
+	 */
+	while (true) {
+		ret = poll_vasi_state(handle, &state);
+
+		/*
+		 * If the memory transfer is already complete and the migration
+		 * has been cleaned up by the hypervisor, H_PARAMETER is return,
+		 * which is translate in EINVAL by poll_vasi_state().
+		 */
+		if (ret == -EINVAL || (!ret && state == H_VASI_COMPLETED)) {
+			pr_info("memory transfer completed.\n");
+			break;
+		}
+
+		if (ret) {
+			pr_err("H_VASI_STATE return error (%d)\n", ret);
+			break;
+		}
+
+		if (state != H_VASI_RESUMED) {
+			pr_err("unexpected H_VASI_STATE result %lu\n", state);
+			break;
+		}
+
+		msleep(500);
+	}
+}
+
 static void prod_single(unsigned int target_cpu)
 {
 	long hvrc;
@@ -673,9 +710,16 @@ static int pseries_migrate_partition(u64 handle)
 	vas_migration_handler(VAS_SUSPEND);
 
 	ret = pseries_suspend(handle);
-	if (ret == 0)
+	if (ret == 0) {
 		post_mobility_fixup();
-	else
+		/*
+		 * Wait until the memory transfer is complete, so that the user
+		 * space process returns from the syscall after the transfer is
+		 * complete. This allows the user hooks to be executed at the
+		 * right time.
+		 */
+		wait_for_vasi_session_completed(handle);
+	} else
 		pseries_cancel_migration(handle, ret);
 
 	vas_migration_handler(VAS_RESUME);
-- 
2.37.0

