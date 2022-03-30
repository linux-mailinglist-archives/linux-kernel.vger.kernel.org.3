Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA514EBCDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244409AbiC3IqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiC3Ipy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:45:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A311082D2E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:44:08 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U6sxkq007737;
        Wed, 30 Mar 2022 08:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=5/FXDwzUbkNVXsjXEmKAp8QeBUiaNFrnJ6vzHszkTzw=;
 b=JEqU6WKJYhkMDvEAQzZJlpb93k4a1s5Uj6WeWzxQ+9hMeCKMC0ARfTVZjRVy9x0bERO4
 G6l+POmlJ3C0RVvJ30oWkjhKR0Mrfw2xjiRBn5TrkAnJtIaOgcS2utckzRf4f0ic37S0
 5q3VM1V6ElKWbLtIlrh8wfSg7+px6h6NiTB+ZtqOzFvESrUrEqZgnI/Jozw+f4jieusm
 1thDxJmbpqj4bESA+rotAJBu52H1f5HQfhpwGP4jDKFHeSkGwfKbBr8RxHeXMjIR7Rxx
 EnivpeZQtaQgm6EmSx6cn+DNwKbruQCbL4ZcmIVHbHRBc1b33pBaw2Ys4RjbwIfjSFuN MA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f3yy51dkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 08:43:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22U8dSAO014124;
        Wed, 30 Mar 2022 08:43:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3f1tf9g1e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 08:43:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22U8hfHm20906240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 08:43:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEF684C050;
        Wed, 30 Mar 2022 08:43:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE64D4C04A;
        Wed, 30 Mar 2022 08:43:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Mar 2022 08:43:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 8FC3AE027A; Wed, 30 Mar 2022 10:43:41 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] entry: fix compile error in dynamic_irqentry_exit_cond_resched()
Date:   Wed, 30 Mar 2022 10:43:28 +0200
Message-Id: <20220330084328.1805665-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OqTPwGfhcINv_K36GiFN04fgoB_efV4L
X-Proofpoint-ORIG-GUID: OqTPwGfhcINv_K36GiFN04fgoB_efV4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_03,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203300042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/entry/common.c: In function ‘dynamic_irqentry_exit_cond_resched’:
kernel/entry/common.c:409:14: error: implicit declaration of function ‘static_key_unlikely’; did you mean ‘static_key_enable’? [-Werror=implicit-function-declaration]
  409 |         if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
      |              ^~~~~~~~~~~~~~~~~~~
      |              static_key_enable

static_key_unlikely() should be static_branch_unlikely().

Fixes: 99cf983cc8bca ("sched/preempt: Add PREEMPT_DYNAMIC using static keys")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index ef8d94a98b7e..371ee8914af1 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -406,7 +406,7 @@ DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 void dynamic_irqentry_exit_cond_resched(void)
 {
-	if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
 		return;
 	raw_irqentry_exit_cond_resched();
 }
-- 
2.32.0

