Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885D256A5F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiGGOuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiGGOso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6970326FB;
        Thu,  7 Jul 2022 07:48:38 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EgpWg034909;
        Thu, 7 Jul 2022 14:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gY2Fss/1ExUkc3jipfr4Xskf27Y62MZZ5JlhuHX2cjo=;
 b=tE+UfaTzZJ1ugR9+aiewG03i34OFR9ju1/UV4rVXnX9s3Iq21x0JXlNd6YlcOLT53Fou
 lfrdiFjgikrIsW5CisSHZ9K/O+YlggA8M4633/cTLxCAdEu+GcyWwlSBP+ZvGQrBkKVK
 FTZqQs21Oqs7dustmz0GEDaGxIm4o51zRVcbsBiCAEPhatAKMbXsbpQsmuHmKj4fM3i7
 pQoZbBHRxSr1O0L1s2g9ArXFg+t42ZDCRHKZ4tZp1mT0XsShwL4F3JDMHwBW2tMAVTza
 VzTRj6A7aHaCo+xMvGukH+v6sReAW9NbGMoLVaR/Gf3AwDXeeaz+f5t66l0aog2EG09x Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h61g0r6y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:10 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267Eh6X9035477;
        Thu, 7 Jul 2022 14:48:09 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h61g0r6x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:09 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EZmC0029976;
        Thu, 7 Jul 2022 14:48:08 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3h4ud53ybs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em7JE21168534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:07 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57596112063;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39678112069;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:48:07 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v13 22/26] ima: Introduce securityfs file to activate an IMA namespace
Date:   Thu,  7 Jul 2022 10:47:56 -0400
Message-Id: <20220707144800.828288-23-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G8HNeTjjl7vJZ5wH20FMCb-F82ag-ybF
X-Proofpoint-ORIG-GUID: TYkBqwk2kJOPoJWMUwv-mNL6nCnfj3YW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=868 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the IMA securityfs file 'active' that users now need to
write a "1" into (precisely a '1\0' or '1\n') to activate an IMA namespace.
When reading from the file, it shows either '0' or '1'.

The rationale for introducing a file to activate an IMA namespace is that
subsequent support for IMA-measurement and IMA-appraisal will add
configuration files for selecting for example the template that an IMA
namespace is supposed to use for logging measurements, which will add
an IMA namespace configuration stage (using securityfs files) before its
activation. Besides that it allows to create a user namespace with
securityfs mounted and an inactive IMA namespace.

Also, introduce ns_is_active() to be used in those places where the
ima_namespace pointer may either be NULL or where the active flag may not
have been set, yet. An inactive IMA namespace should never be accessed
since it has not been initialized, yet.

Set the init_ima_ns's active flag since it is considered active right from
the beginning.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v12:
 - Fixed uninitialized ret if IS_ERR(active) was true

v11:
 - Move code from ima_fs_add_ns_files() into ima_fs_ns_init()
 - Use ima_ns_flags and IMA_NS_ACTIVE instead of 'atomic_t active'

v10:
 - use memdup_user_nul to copy input from user
 - propagating error returned from ima_fs_add_ns_files()
---
 security/integrity/ima/ima.h             |  6 +++
 security/integrity/ima/ima_fs.c          | 64 ++++++++++++++++++++++++
 security/integrity/ima/ima_init_ima_ns.c |  1 +
 security/integrity/ima/ima_main.c        |  2 +-
 4 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6592ae2a4300..fa9f99ad7e69 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -126,6 +126,7 @@ struct ima_namespace {
 	unsigned long ima_ns_flags;
 /* Bit numbers for above flags; use BIT() to get flag */
 #define IMA_NS_LSM_UPDATE_RULES		0
+#define IMA_NS_ACTIVE			1
 
 	struct rb_root ns_status_tree;
 	rwlock_t ns_tree_lock;
@@ -158,6 +159,11 @@ struct ima_namespace {
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
+static inline bool ns_is_active(struct ima_namespace *ns)
+{
+	return (ns && test_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags));
+}
+
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 84cd02a9e19b..301c717e029f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -451,6 +451,57 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
+static ssize_t ima_show_active(struct file *filp,
+			       char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	struct ima_namespace *ns = &init_ima_ns;
+	char tmpbuf[2];
+	ssize_t len;
+
+	len = scnprintf(tmpbuf, sizeof(tmpbuf),
+			"%d\n", !!test_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags));
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
+}
+
+static ssize_t ima_write_active(struct file *filp,
+				const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct ima_namespace *ns = &init_ima_ns;
+	unsigned int active;
+	char *kbuf;
+	int err;
+
+	if (ns_is_active(ns))
+		return -EBUSY;
+
+	/* accepting '1\n' and '1\0' and no partial writes */
+	if (count >= 3 || *ppos != 0)
+		return -EINVAL;
+
+	kbuf = memdup_user_nul(buf, count);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	err = kstrtouint(kbuf, 10, &active);
+	kfree(kbuf);
+	if (err)
+		return err;
+
+	if (active != 1)
+		return -EINVAL;
+
+	set_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
+
+	return count;
+}
+
+static const struct file_operations ima_active_ops = {
+	.read = ima_show_active,
+	.write = ima_write_active,
+};
+
 int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 {
 	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
@@ -461,6 +512,7 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	struct dentry *ascii_runtime_measurements = NULL;
 	struct dentry *runtime_measurements_count = NULL;
 	struct dentry *violations = NULL;
+	struct dentry *active = NULL;
 	int ret;
 
 	/* FIXME: update when evm and integrity are namespaced */
@@ -531,8 +583,20 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 		}
 	}
 
+	if (ns != &init_ima_ns) {
+		active =
+		    securityfs_create_file("active",
+					   S_IRUSR | S_IWUSR | S_IRGRP, ima_dir,
+					   NULL, &ima_active_ops);
+		if (IS_ERR(active)) {
+			ret = PTR_ERR(active);
+			goto out;
+		}
+	}
+
 	return 0;
 out:
+	securityfs_remove(active);
 	securityfs_remove(ns->ima_policy);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 41e7db0c9749..5c57abfc70ea 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -58,5 +58,6 @@ struct ima_namespace init_ima_ns = {
 	.ima_lsm_policy_notifier = {
 		.notifier_call = ima_lsm_policy_change,
 	},
+	.ima_ns_flags = BIT(IMA_NS_ACTIVE),
 };
 EXPORT_SYMBOL(init_ima_ns);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4550958d0f06..c397d24267b7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -441,7 +441,7 @@ static int process_measurement(struct user_namespace *user_ns,
 
 	while (user_ns) {
 		ns = ima_ns_from_user_ns(user_ns);
-		if (ns) {
+		if (ns_is_active(ns)) {
 			int rc;
 
 			rc = __process_measurement(ns, file, cred, secid, buf,
-- 
2.36.1

