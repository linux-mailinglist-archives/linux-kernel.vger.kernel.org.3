Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969E052B6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiERJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiERJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:51:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E62BD1;
        Wed, 18 May 2022 02:51:19 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I9flYT034958;
        Wed, 18 May 2022 09:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HzQMo0hobq/5CrTCFKz4sgsZfL+TYcrVd9eJf5WrwqQ=;
 b=D0hDyQBZ3B1yk1wVbBD8XUOmGi4CdEVF3eDbyauOq5NO1cc2cIeYRrrXjGkzV8Nnx0MV
 vUdq4lA4MncsGRDHs2NQ/rFX4rtUjAArhoo6XBKAfZYtrgzOuglBa3w4+gJNwt4sgjR8
 CINLS8C6D13aFP+euq1Q9urA81LLMwhpcT6MYSBIv/gsO6gX8XZvuV/Bsn2MtWHu0yF6
 6TNHFYxSNkvcWsiFrq3GI8dQtw62FdnZ8NloduTauQFCAudvw2L6HNcQLDzFjeHjADwo
 +66fQ2VgdoJ7GMZIRyZ+y2XhBz6pGZaDpqolw/YZrYvQBjRv2cnzp6NRAD9KQhTM78Ap Sw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4xd3069s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 09:51:19 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24I9gu5o027444;
        Wed, 18 May 2022 09:51:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3g2428ve5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 09:51:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24I9pD6w19464670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 09:51:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90446A4051;
        Wed, 18 May 2022 09:51:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5209CA404D;
        Wed, 18 May 2022 09:51:13 +0000 (GMT)
Received: from t46lp73.. (unknown [9.152.108.100])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 09:51:13 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390: Add attestation query information
Date:   Wed, 18 May 2022 09:51:13 +0000
Message-Id: <20220518095113.982955-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JJrfQO2OueKxAL_q7mIJKG5-1TzF9r_2
X-Proofpoint-ORIG-GUID: JJrfQO2OueKxAL_q7mIJKG5-1TzF9r_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_03,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have information about the supported attestation header version
and paf (=  plaintext attestation flag) bits.
Let's expose it via the sysfs files.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/boot/uv.c        |  2 ++
 arch/s390/include/asm/uv.h |  7 ++++++-
 arch/s390/kernel/uv.c      | 20 ++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index e6be155ab2e5..5e17c657e3d6 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -41,6 +41,8 @@ void uv_query_info(void)
 		uv_info.max_num_sec_conf = uvcb.max_num_sec_conf;
 		uv_info.max_guest_cpu_id = uvcb.max_guest_cpu_id;
 		uv_info.uv_feature_indications = uvcb.uv_feature_indications;
+		uv_info.supp_att_req_hdr_ver = uvcb.supp_att_req_hdr_ver;
+		uv_info.supp_att_pflags = uvcb.supp_att_pflags;
 	}
 
 #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index cfea7b77a5b8..99f459c0eacc 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -110,7 +110,10 @@ struct uv_cb_qui {
 	u8  reserved88[158 - 136];		/* 0x0088 */
 	u16 max_guest_cpu_id;			/* 0x009e */
 	u64 uv_feature_indications;		/* 0x00a0 */
-	u8  reserveda8[200 - 168];		/* 0x00a8 */
+	u8  reserveda8[224 - 168];		/* 0x00a8 */
+	u64 supp_att_req_hdr_ver;		/* 0x00e0 */
+	u64 supp_att_pflags;			/* 0x00e8 */
+	u8 reservedf0[256 - 240];		/* 0x00f0 */
 } __packed __aligned(8);
 
 /* Initialize Ultravisor */
@@ -307,6 +310,8 @@ struct uv_info {
 	unsigned int max_num_sec_conf;
 	unsigned short max_guest_cpu_id;
 	unsigned long uv_feature_indications;
+	unsigned long supp_att_req_hdr_ver;
+	unsigned long supp_att_pflags;
 };
 
 extern struct uv_info uv_info;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index a5425075dd25..095afd375ad1 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -431,12 +431,32 @@ static ssize_t uv_query_max_guest_addr(struct kobject *kobj,
 static struct kobj_attribute uv_query_max_guest_addr_attr =
 	__ATTR(max_address, 0444, uv_query_max_guest_addr, NULL);
 
+static ssize_t uv_query_supp_att_req_hdr_ver(struct kobject *kobj,
+					     struct kobj_attribute *attr, char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "%lx\n", uv_info.supp_att_req_hdr_ver);
+}
+
+static struct kobj_attribute uv_query_supp_att_req_hdr_ver_attr =
+	__ATTR(supp_att_req_hdr_ver, 0444, uv_query_supp_att_req_hdr_ver, NULL);
+
+static ssize_t uv_query_supp_att_pflags(struct kobject *kobj,
+					struct kobj_attribute *attr, char *page)
+{
+	return scnprintf(page, PAGE_SIZE, "%lx\n", uv_info.supp_att_pflags);
+}
+
+static struct kobj_attribute uv_query_supp_att_pflags_attr =
+	__ATTR(supp_att_pflags, 0444, uv_query_supp_att_pflags, NULL);
+
 static struct attribute *uv_query_attrs[] = {
 	&uv_query_facilities_attr.attr,
 	&uv_query_feature_indications_attr.attr,
 	&uv_query_max_guest_cpus_attr.attr,
 	&uv_query_max_guest_vms_attr.attr,
 	&uv_query_max_guest_addr_attr.attr,
+	&uv_query_supp_att_req_hdr_ver_attr.attr,
+	&uv_query_supp_att_pflags_attr.attr,
 	NULL,
 };
 
-- 
2.30.2

