Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1757179D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiGLKwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiGLKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:52:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E584BAE399;
        Tue, 12 Jul 2022 03:52:29 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CAaicr004812;
        Tue, 12 Jul 2022 10:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tbEtvTuONivSH6v4s9WcSlpj9XpZ76UBawUFaX2glTA=;
 b=HDFflvmWOdHaO4ZNwwLSX86F4hjWxdQtinz9dBNtDRzUyXQ1JavEqvssewfj9UFDDOr1
 0bAd0daXyWyqAbY+tDVMIyLhGjZFUOrYxYBIgI3xYQXjfozHIypGjp9o149pfCNO7o6e
 Fk8v4lO+CwDZNgKkBDjrKw6C3CzSnww+tN4HtqE2QRSu6OA241K42tftHaLxmxJgowdR
 cGF6sTKj5unP1eaBpMkidZQbhTZJOO6B9pIAbIeEXEI9hQahupBMQI7hqhR9iakOvsWz
 xUVRixMJ1D5KSbEoOIYKnqkuqOR1lCW97/oj/pa/vlTfmDnGlMnJEUaJ79yDa9NpIiuj Gw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9642t24r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 10:52:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CApopX004875;
        Tue, 12 Jul 2022 10:52:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3h8rrn0yfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 10:52:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CAqMXP22479112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 10:52:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17DEB11C04A;
        Tue, 12 Jul 2022 10:52:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8DC511C050;
        Tue, 12 Jul 2022 10:52:21 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 10:52:21 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [PATCH 2/3] s390/cpufeature: allow for facility bits
Date:   Tue, 12 Jul 2022 12:52:19 +0200
Message-Id: <20220712105220.325010-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712105220.325010-1-seiden@linux.ibm.com>
References: <20220712105220.325010-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KSoozs_Ed5xUsOXtc0lmE_6jTBjyHNpD
X-Proofpoint-GUID: KSoozs_Ed5xUsOXtc0lmE_6jTBjyHNpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_05,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=960 spamscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207120039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

Allow for facility bits to be used in cpu features.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cpufeature.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/cpufeature.c b/arch/s390/kernel/cpufeature.c
index ea4bbfd855db..e70b29804db4 100644
--- a/arch/s390/kernel/cpufeature.c
+++ b/arch/s390/kernel/cpufeature.c
@@ -10,6 +10,7 @@
 
 enum {
 	TYPE_HWCAP,
+	TYPE_FACILITY,
 };
 
 struct s390_cpu_feature {
@@ -54,6 +55,8 @@ int cpu_have_feature(unsigned int num)
 	switch (feature->type) {
 	case TYPE_HWCAP:
 		return !!(elf_hwcap & (1UL << feature->num));
+	case TYPE_FACILITY:
+		return test_facility(feature->num);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
-- 
2.35.3

