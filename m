Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC04CA67D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbiCBNvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242373AbiCBNvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC187C558A;
        Wed,  2 Mar 2022 05:50:24 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222DEghb009944;
        Wed, 2 Mar 2022 13:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=e5AB4CWXReVykJpnAQ6U+K/jSiPao+uGAmTVYx4V6dU=;
 b=Geoy2C0JG5Ppf0Ns+Pn7cekPoOhCYLqjAsYnOMEuLBXjEukz3/5BbKmeWHudxLPY855D
 fGFWkcnpUQXujMGKWPGyIZ1EhNVogvsEQx4nHgLz/c5p4v3sovhw69nFmeitQOt54YuF
 lL5qB1sk7TTwbbZmgZKGNOfWV4nxPLKKUKDKrN1Sv02k73ViXrPbj0WIAU73C8o/5f9T
 p8Pc3GqUC5HBefoe/gmUw5qTaVJ9hhfUc/V9xRD9SQEeSb3o+Odi03V/cemEAOOgrFq3
 cfv0aQ5SY5Kt7pdoiqxt51lOjtrkvdtAYqRjxaUFKIpXDeTRQeER8vWtuUmA3ifDNic7 oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej779vt81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:03 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222DgCQN013873;
        Wed, 2 Mar 2022 13:50:02 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej779vt7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:02 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222Dn5Bk026736;
        Wed, 2 Mar 2022 13:50:01 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3egfsscpnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:01 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222Dnx1m25493986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:49:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9161112071;
        Wed,  2 Mar 2022 13:49:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DE4811206F;
        Wed,  2 Mar 2022 13:49:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 13:49:59 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v11 19/27] integrity: Add optional callback function to integrity_inode_free()
Date:   Wed,  2 Mar 2022 08:46:54 -0500
Message-Id: <20220302134703.1273041-20-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xYYnM1Dl0JvG5ATA6wyAhQehg89RCHyV
X-Proofpoint-GUID: d0oWRoVz0fNwzsBs3Af82_hbOlzISHXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=916 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 clxscore=1015 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional callback function to integrity_inode_free() that,
if provided, must be called and determines whether the iint can be
freed. Adjust all callers of this function to provide a NULL pointer
since none of the existing callers needs this check.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/integrity.h |  8 ++++++--
 security/integrity/iint.c | 15 +++++++++++++--
 security/security.c       |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 2ea0f2f65ab6..9fe826b9146e 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -19,10 +19,13 @@ enum integrity_status {
 	INTEGRITY_UNKNOWN,
 };
 
+struct integrity_iint_cache;
+typedef bool (*iint_removable_cb)(struct integrity_iint_cache *iint);
+
 /* List of EVM protected security xattrs */
 #ifdef CONFIG_INTEGRITY
 extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
-extern void integrity_inode_free(struct inode *inode);
+extern void integrity_inode_free(struct inode *inode, iint_removable_cb check);
 extern void __init integrity_load_keys(void);
 
 #else
@@ -32,7 +35,8 @@ static inline struct integrity_iint_cache *
 	return NULL;
 }
 
-static inline void integrity_inode_free(struct inode *inode)
+static inline void integrity_inode_free(struct inode *inode,
+					iint_removable_cb check)
 {
 	return;
 }
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 371cbceaf479..4580df0e716e 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -143,21 +143,32 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 /**
  * integrity_inode_free - called on security_inode_free
  * @inode: pointer to the inode
+ * @check: optional callback function to check whether the iint can be freed
  *
  * Free the integrity information(iint) associated with an inode.
  */
-void integrity_inode_free(struct inode *inode)
+void integrity_inode_free(struct inode *inode, iint_removable_cb check)
 {
 	struct integrity_iint_cache *iint;
+	bool freeit = true;
 
 	if (!IS_IMA(inode))
 		return;
 
 	write_lock(&integrity_iint_lock);
+
 	iint = __integrity_iint_find(inode);
-	rb_erase(&iint->rb_node, &integrity_iint_tree);
+
+	if (check)
+		freeit = check(iint);
+	if (freeit)
+		rb_erase(&iint->rb_node, &integrity_iint_tree);
+
 	write_unlock(&integrity_iint_lock);
 
+	if (!freeit)
+		return;
+
 	ima_free_ns_status_list(&iint->ns_list, &iint->ns_list_lock);
 
 	iint_free(iint);
diff --git a/security/security.c b/security/security.c
index 22261d79f333..eede67bf2eb8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1027,7 +1027,7 @@ static void inode_free_by_rcu(struct rcu_head *head)
 
 void security_inode_free(struct inode *inode)
 {
-	integrity_inode_free(inode);
+	integrity_inode_free(inode, NULL);
 	call_void_hook(inode_free_security, inode);
 	/*
 	 * The inode may still be referenced in a path walk and
-- 
2.31.1

