Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67B25736BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiGMM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiGMM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:56:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668174791;
        Wed, 13 Jul 2022 05:56:53 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DCtuBa025831;
        Wed, 13 Jul 2022 12:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QmRztB5T21trb1d83bgm0QONGneNMIBgqGlnqTAivic=;
 b=TxPHXF3BFaGaXo5Alr2mK73qY1xJU8CQzc0CsnD7bHCgOylUUROsW1+rS82qcWHSSxHA
 wSWXa1z+NGeVRcuPznYX58hu5ihueYiGPG+khAL+qQ+nvEF7lTuSsRob8i7NK7hfcKqq
 NDtx9uOoBR4R4ZSBv4g54DxdFZwWI+fbRZiVCATGHzS229ZC/VR0ZNvoerjgrmYErx2n
 3NdwN9GZ1X7bRa7tkoWM0iTtYLTyXS8g/lY1KHmhig/2OT4JEuD7vEqxYNJQ1Lfz633b
 Pmp2/zpAkZdwZa1BwXrPGioG3TFhJCFLT72BEXI37WuDwYCB13ht1Dlyn3HGery23nWL NQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9wdahnpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 12:56:51 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26DCpwh0030173;
        Wed, 13 Jul 2022 12:56:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3h8ncngv0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 12:56:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26DCuuDY23724344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 12:56:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70750A405B;
        Wed, 13 Jul 2022 12:56:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13738A4054;
        Wed, 13 Jul 2022 12:56:45 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 12:56:45 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
Subject: [PATCH v2 2/3] s390/cpufeature: allow for facility bits
Date:   Wed, 13 Jul 2022 14:56:43 +0200
Message-Id: <20220713125644.16121-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220713125644.16121-1-seiden@linux.ibm.com>
References: <20220713125644.16121-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y2MzvbT8-LccOMQDF4UxSVm8PgGVQhfn
X-Proofpoint-GUID: Y2MzvbT8-LccOMQDF4UxSVm8PgGVQhfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_01,2022-07-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130049
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
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kernel/cpufeature.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/cpufeature.c b/arch/s390/kernel/cpufeature.c
index 9044c75d8b38..170894730fcc 100644
--- a/arch/s390/kernel/cpufeature.c
+++ b/arch/s390/kernel/cpufeature.c
@@ -8,6 +8,7 @@
 
 enum {
 	TYPE_HWCAP,
+	TYPE_FACILITY,
 };
 
 struct s390_cpu_feature {
@@ -34,6 +35,8 @@ int cpu_have_feature(unsigned int num)
 	switch (feature->type) {
 	case TYPE_HWCAP:
 		return !!(elf_hwcap & BIT(feature->num));
+	case TYPE_FACILITY:
+		return test_facility(feature->num);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
-- 
2.35.3

