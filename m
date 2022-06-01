Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F98B53A1C3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351775AbiFAKEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351661AbiFAKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:03:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2B65AB;
        Wed,  1 Jun 2022 03:02:52 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2518he0P002219;
        Wed, 1 Jun 2022 10:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9GZat0Xdj5tj2DvKvZwHZ+ugzsSXSipXcdFI7v7mVyg=;
 b=WenUJU65gORG5L9qT1uN0w/mWnCyhp/wgHxKYbyMuO64PXSz7qJUdn7M/AFakokMqrB/
 HWKAqyh9H7B8BpWr4eBLfD81CdEqzI0CfTCKSWwgd1qh8rXhqUE8wdYGCU+bPLBH1zem
 V27qLrQGEYUiA5QI1wMMPdcBYqImcnfoEVk1O3YHCZHRbTzT6LdlxDSBO4ZswrR3qctp
 FZiGAKsS9Ycv+isQfx4PS5j8ZkdTYSoEg+nuG5UghQPXZ9+3m1NRpEpATi92oL9Y6wZJ
 YXD2HqcPT1hnsmvA0gFaa47hqSzYz9bjkmJUt33xNo/7pZ9d/6EJ3gDmApSO9Gtt65wq Hw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ge4uq1eqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 10:02:51 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2519pNwv004726;
        Wed, 1 Jun 2022 10:02:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3gbcakm30e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 10:02:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 251A2kKb55902594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jun 2022 10:02:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EE17A404D;
        Wed,  1 Jun 2022 10:02:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD69CA4040;
        Wed,  1 Jun 2022 10:02:45 +0000 (GMT)
Received: from t46lp73.. (unknown [9.152.108.100])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jun 2022 10:02:45 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     seiden@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        hca@linux.ibm.com, imbrenda@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        nrb@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390: Add attestation query information
Date:   Wed,  1 Jun 2022 10:02:45 +0000
Message-Id: <20220601100245.3189993-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220518135908.1110319-2-seiden@linux.ibm.com>
References: <20220518135908.1110319-2-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oI5ubfcnDbfWrS6ZDmxnb0IPJVvoDFLT
X-Proofpoint-GUID: oI5ubfcnDbfWrS6ZDmxnb0IPJVvoDFLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_03,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By design the uv-device does not check whether an incoming attestation
measurement request only specifies valid plain text flags or has the
right request version, as these values are verified by the Ultravisor
anyway. However, the userspace program that generates these requests
might want to know which flags/versions are supported in order to
create requests without trial and error. Therefore, expose the
supported plain text flags and versions to userspace via sysfs.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/boot/uv.c        |  2 ++
 arch/s390/include/asm/uv.h |  7 ++++++-
 arch/s390/kernel/uv.c      | 20 ++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index 67c737c1e580..a5fa667160b2 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -45,6 +45,8 @@ void uv_query_info(void)
 		uv_info.supp_se_hdr_pcf = uvcb.supp_se_hdr_pcf;
 		uv_info.conf_dump_storage_state_len = uvcb.conf_dump_storage_state_len;
 		uv_info.conf_dump_finalize_len = uvcb.conf_dump_finalize_len;
+		uv_info.supp_att_req_hdr_ver = uvcb.supp_att_req_hdr_ver;
+		uv_info.supp_att_pflags = uvcb.supp_att_pflags;
 	}
 
 #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 3e597bb634bd..18fe04c8547e 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -124,7 +124,10 @@ struct uv_cb_qui {
 	u64 reservedc0;				/* 0x00c0 */
 	u64 conf_dump_storage_state_len;	/* 0x00c8 */
 	u64 conf_dump_finalize_len;		/* 0x00d0 */
-	u8  reservedd8[256 - 216];		/* 0x00d8 */
+	u64 reservedd8;				/* 0x00d8 */
+	u64 supp_att_req_hdr_ver;		/* 0x00e0 */
+	u64 supp_att_pflags;			/* 0x00e8 */
+	u8 reservedf0[256 - 240];		/* 0x00f0 */
 } __packed __aligned(8);
 
 /* Initialize Ultravisor */
@@ -350,6 +353,8 @@ struct uv_info {
 	unsigned long supp_se_hdr_pcf;
 	unsigned long conf_dump_storage_state_len;
 	unsigned long conf_dump_finalize_len;
+	unsigned long supp_att_req_hdr_ver;
+	unsigned long supp_att_pflags;
 };
 
 extern struct uv_info uv_info;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 84fe33b6af4d..c13d5a7b71f0 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -479,6 +479,24 @@ static ssize_t uv_query_max_guest_addr(struct kobject *kobj,
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
@@ -490,6 +508,8 @@ static struct attribute *uv_query_attrs[] = {
 	&uv_query_dump_storage_state_len_attr.attr,
 	&uv_query_dump_finalize_len_attr.attr,
 	&uv_query_dump_cpu_len_attr.attr,
+	&uv_query_supp_att_req_hdr_ver_attr.attr,
+	&uv_query_supp_att_pflags_attr.attr,
 	NULL,
 };
 
-- 
2.30.2

