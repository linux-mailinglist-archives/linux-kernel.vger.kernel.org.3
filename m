Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864FA5B28F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIHWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIHWCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:02:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205B3B15;
        Thu,  8 Sep 2022 15:02:35 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288Lhjvq002046;
        Thu, 8 Sep 2022 22:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PY33xXugMpJrxaOfLtDoKIpmmKkUXM1FA6wgweiD9z8=;
 b=rn4kWPRg+UTz8Kl47uLenQ34cqMnrIoCLtr9K9QNF+Y5lohghgSf5Ky3E6DKrtLXO5l6
 L2lR38/OvjTfnNyNF5d3miJfp8fjj1TnhOnkoEabFMJUsA+kEeFrFPqg48e8ILMcCIgK
 TciToMV+1Ukrit45EIXj8hmYiBIn1rIgeykfsN+oA99gpaRUvPxbkm28SWDDrJk5adTl
 D6xxni0+h52UzcYksmd9Rgx3bZSDSy5behv94taei+DzrKdNh70HXGVOXeAMokXKKnxS
 IH9e9qgcmpcZaQ6TkHEd37YjGMmneZ6sEUYQdEp9CBNYPb4wZZPUUXoRCmfcqSmIF4oQ MQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfrjb8dbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 22:02:25 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 288Locc6032133;
        Thu, 8 Sep 2022 22:02:24 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3jbxjakmvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 22:02:24 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 288M2NIv30343552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Sep 2022 22:02:23 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DAC628059;
        Thu,  8 Sep 2022 22:02:23 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38E5928058;
        Thu,  8 Sep 2022 22:02:23 +0000 (GMT)
Received: from localhost (unknown [9.41.178.242])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Sep 2022 22:02:23 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Subject: [PATCH] lockdown: ratelimit denial messages
Date:   Thu,  8 Sep 2022 17:02:22 -0500
Message-Id: <20220908220222.267255-1-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q3v9Rph-wyIMIc2GsPuy45gHr07uejIA
X-Proofpoint-ORIG-GUID: Q3v9Rph-wyIMIc2GsPuy45gHr07uejIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=811
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space can flood the log with lockdown denial messages:

[  662.555584] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
[  662.563237] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
[  662.571134] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
[  662.578668] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
[  662.586021] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
[  662.593398] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7

Ratelimiting these shouldn't meaningfully degrade the quality of the
information logged.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 87cbdc64d272..a79b985e917e 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -63,7 +63,7 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
 
 	if (kernel_locked_down >= what) {
 		if (lockdown_reasons[what])
-			pr_notice("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
+			pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
 				  current->comm, lockdown_reasons[what]);
 		return -EPERM;
 	}
-- 
2.37.1

