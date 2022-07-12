Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58038571CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiGLOci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiGLOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:32:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56F2240AC;
        Tue, 12 Jul 2022 07:32:35 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CDBugK007915;
        Tue, 12 Jul 2022 14:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0DhHvsxCxRfs8ONe0EUj23JBu5ERuQgHbLPOK7uZoz4=;
 b=Kcql+c5vfVTWypeyQaPJEwNBwFhWg8xSeKuDQiQ0zOyv5VCLVhj2WPmnO9WjMFmsAi3E
 vpZceXF81G0cm9k3pQy3KNPYRR3cpygpycF7MEOXeWg1OpS7g0B7SDHNBX6UkJmun0nI
 Wv3jfak+WMfl9bCjASAoaBHZszV8/PpG8N6hC63xk/Z3RFPVrhw70+jHQqTIiQGJRAxy
 z6Te9FR5jLXp/uWOdlg0nkVgShC7eLRJ93lIuEDvBK89Cr7iEsJSlttG1SAMrQ6zwrzJ
 NbG7qvL2z1T3GcuBxcM+SEZf6wgyI9TUErFRKZlnH1wgeJcbtZgz03iZDeIJI2f1+xLf kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h98jvm1fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 14:32:08 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26CEUH2B029687;
        Tue, 12 Jul 2022 14:32:08 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h98jvm1e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 14:32:08 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CEKX4u024863;
        Tue, 12 Jul 2022 14:32:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xhvaut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 14:32:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CEW3tK16253304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 14:32:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5417A405F;
        Tue, 12 Jul 2022 14:32:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C07FA405B;
        Tue, 12 Jul 2022 14:32:03 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 14:32:03 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        wim@linux-watchdog.org, linux@roeck-us.net, nathanl@linux.ibm.com
Cc:     haren@linux.vnet.ibm.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v4 1/4] powerpc/mobility: wait for memory transfer to complete
Date:   Tue, 12 Jul 2022 16:31:59 +0200
Message-Id: <20220712143202.23144-2-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712143202.23144-1-ldufour@linux.ibm.com>
References: <20220712143202.23144-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tfBTM2f9QAUpjECIqqJp_2ByD9f3wySB
X-Proofpoint-ORIG-GUID: a9YD_9VNreQoh8r922KXmEml-utvB6L6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_08,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120055
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

