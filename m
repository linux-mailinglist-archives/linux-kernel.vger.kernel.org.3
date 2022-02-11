Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E954B2FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353854AbiBKVn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:43:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353828AbiBKVnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:43:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8044C64;
        Fri, 11 Feb 2022 13:43:40 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BJRcpP021073;
        Fri, 11 Feb 2022 21:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=j+efZ15nRBUAya80sMKzpfEAzQWt2RkXqPh02tlgZYk=;
 b=e9da2KX8uLE5Q6dnZSEQTXspoKUSnAeyP7aTxTJuuqOJBzCZFtYDjapfRwb+RY0FoR2T
 gZlQ53A0gs1vCh1VbWU1B7ln5TKR68cMfya1sC+f+jZQAGDIhdr16EsqyGToUVFRl9mN
 ShUQ/VLLO8eqLSgFcX2lK6T52GGzBY0VLl57t4cBPf/+ikNgzfVo6d0FcOcSIHn8NH3d
 Iac8UNAqic+oP04r2g+QmPiFvuGk8sxDKeZYhDu40lZy5Z1U08EOhkh0cYFi8TKdBOwj
 kvFc8EJDfTdLtPn0Dg5veZevTPwMug3Jcf9UtJpXQxBJQiEARUKTQb566Q1PCIZiRvfg VA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e5wyrt4xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 21:43:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21BLYaQ8006307;
        Fri, 11 Feb 2022 21:43:36 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggkw71y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 21:43:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21BLhT6g43450658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 21:43:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D370B52051;
        Fri, 11 Feb 2022 21:43:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.69.128])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D8B255204F;
        Fri, 11 Feb 2022 21:43:28 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] ima: define signature version 3
Date:   Fri, 11 Feb 2022 16:43:08 -0500
Message-Id: <20220211214310.119257-7-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220211214310.119257-1-zohar@linux.ibm.com>
References: <20220211214310.119257-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nZby8eNCeK5eZp_6p9Yn7EJapPJDTVnx
X-Proofpoint-ORIG-GUID: nZby8eNCeK5eZp_6p9Yn7EJapPJDTVnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To disambiguate the signed data stored in the 'security.ima' xattr,
define signature version 3 as the hash of the ima_file_id structure.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/digsig.c           |  3 ++-
 security/integrity/ima/ima_appraise.c | 35 +++++++++++++++++++++++++++
 security/integrity/integrity.h        | 20 +++++++++++++--
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 3b06a01bd0fd..fd8f77d92a62 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -74,7 +74,8 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 		/* v1 API expect signature without xattr type */
 		return digsig_verify(keyring, sig + 1, siglen - 1, digest,
 				     digestlen);
-	case 2:
+	case 2: /* regular file data hash based sginature */
+	case 3: /* struct ima_file_id data base signature */
 		return asymmetric_verify(keyring, sig, siglen, digest,
 					 digestlen);
 	}
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 17232bbfb9f9..c2b429c141a7 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -225,6 +225,33 @@ int ima_read_xattr(struct dentry *dentry,
 	return ret;
 }
 
+/*
+ * calc_file_id_hash - calculate the hash of the ima_file_id struct data
+ * @type: xattr type [enum evm_ima_xattr_type]
+ * @algo: hash algorithm [enum hash_algo]
+ * @digest: pointer to the digest to be hashed
+ * @hash: (out) pointer to the hash
+ *
+ * IMA signature version 3 disambiguates the data that is signed by
+ * indirectly signing the hash of the ima_file_id structure data.
+ *
+ * Return 0 on success, error code otherwise.
+ */
+static int calc_file_id_hash(enum evm_ima_xattr_type type,
+			     enum hash_algo algo, const u8 *digest,
+			     struct ima_digest_data *hash)
+{
+	struct ima_file_id file_id = {.hash_algorithm = algo};
+	uint unused = HASH_MAX_DIGESTSIZE - hash_digest_size[algo];
+
+	memcpy(file_id.hash, digest, hash_digest_size[algo]);
+
+	hash->algo = algo;
+	hash->length = hash_digest_size[algo];
+
+	return ima_calc_buffer_hash(&file_id, sizeof(file_id) - unused, hash);
+}
+
 /*
  * xattr_verify - verify xattr digest or signature
  *
@@ -236,6 +263,7 @@ static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
 			struct evm_ima_xattr_data *xattr_value, int xattr_len,
 			enum integrity_status *status, const char **cause)
 {
+	struct signature_v2_hdr *sig;
 	int rc = -EINVAL, hash_start = 0;
 
 	switch (xattr_value->type) {
@@ -274,6 +302,13 @@ static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
 		break;
 	case EVM_IMA_XATTR_DIGSIG:
 		set_bit(IMA_DIGSIG, &iint->atomic_flags);
+
+		sig = (typeof(sig))xattr_value;
+		if (sig->version != 2) {
+			*cause = "invalid-signature-version";
+			*status = INTEGRITY_FAIL;
+			break;
+		}
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
 					     (const char *)xattr_value,
 					     xattr_len,
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 39a999877013..bd38bd451b19 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -94,7 +94,7 @@ struct evm_xattr {
 	u8 digest[SHA1_DIGEST_SIZE];
 } __packed;
 
-#define IMA_MAX_DIGEST_SIZE	64
+#define IMA_MAX_DIGEST_SIZE	HASH_MAX_DIGESTSIZE
 
 struct ima_digest_data {
 	u8 algo;
@@ -123,7 +123,11 @@ struct ima_max_digest_data {
 } __packed;
 
 /*
- * signature format v2 - for using with asymmetric keys
+ * signature header format v2 - for using with asymmetric keys
+ *
+ * signature format:
+ * version 2: regular file data hash based signature
+ * version 3: struct ima_file_id data based signature
  */
 struct signature_v2_hdr {
 	uint8_t type;		/* xattr type */
@@ -134,6 +138,18 @@ struct signature_v2_hdr {
 	uint8_t sig[];		/* signature payload */
 } __packed;
 
+/*
+ * IMA signature version 3 disambiguates the data that is signed, by
+ * indirectly signing the hash of the ima_file_id structure data.
+ *
+ * (The hash of the ima_file_id structure is only of the portion used.)
+ */
+struct ima_file_id {
+	__u8 hash_type;		/* xattr type [enum evm_ima_xattr_type] */
+	__u8 hash_algorithm;	/* Digest algorithm [enum hash_algo] */
+	__u8 hash[HASH_MAX_DIGESTSIZE];
+} __packed;
+
 /* integrity data associated with an inode */
 struct integrity_iint_cache {
 	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
-- 
2.27.0

