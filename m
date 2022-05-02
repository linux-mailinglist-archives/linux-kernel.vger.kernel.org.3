Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95C1517116
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381018AbiEBOCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiEBOCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:02:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8FFD97;
        Mon,  2 May 2022 06:59:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so10510619ejk.5;
        Mon, 02 May 2022 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Os0MOBateTIZNqGjk/IqRphgpNZOrSipT31T6veAyYk=;
        b=SIRqaRBqFV0HHZ+/Vu7/WSPskHyhS93OTkvi6AITANAX2lHITs/J/43bE+uWWBF722
         Qe+lr2AC0cEcRUXwfF6QyXXZJQklA9vSri2LbxioWYErtirEUBPDRX4AvANVC5LviLoB
         a/1VPZxO/MiHyXBkwIf+EOVlJYjZJnE3Fe5b/dSLP3axPiY6K6/m2bv8oPJo79SlYXnW
         pro26581vF0c3CSB9NaLG26cZ06Buw4g1XlBIzPR010+iBrAxB+KqEVkf3Y66w666dNl
         hDeTZF3IJGrC9dDEQvjF04eM2mDmSQ3QHj8hBZ0yNvvQAUOd/XIdd7gGxlGTXU6C7dbP
         yU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Os0MOBateTIZNqGjk/IqRphgpNZOrSipT31T6veAyYk=;
        b=Dth+K2tGeaXMenn26h9YRJ/Scycdr7n1ZzMJZAzxj+HLUp0bdCbRns1seFhMNmEjj5
         qDurjA0cBpK8hHiVho18vJUKbVVN3yHHBIJFo1BLrDOM7c7vXaEqEG20/OSbdm+uFRo4
         HQcLEDdiYG1SiaXp89+w4BGkenWzGKtRGhVizMdicyirO86x1oT6PBS4kYPD/fV7pW1g
         XKA5HxzKtoN74dPFKoDriP1f0LIqu48PjamPJ6l92dG8iXtKYRp94ThzkQC4mYQ/lnmC
         stoghAjgFieZmVd2iN0fs8BR5tH5ZfivTIs+rm0fjjcUr665lAQE8EhX9jWxMw/ljJnw
         tAyA==
X-Gm-Message-State: AOAM5304379G3LY7fZRoLGMz0I2Tx93Cy9Kcqb0VuZPpWxNaD8VeqUT0
        ysaHp4R2nharkYBT/+KmLBYoLCexSI8=
X-Google-Smtp-Source: ABdhPJwZ74FxBXyKA241QxksU85nE3PXih88C+jd2HSekSna/oxLcshq7GYaNT5HSSAVW5JStN+b8A==
X-Received: by 2002:a17:906:c0d6:b0:6ca:457e:f1b7 with SMTP id bn22-20020a170906c0d600b006ca457ef1b7mr11362817ejb.399.1651499952950;
        Mon, 02 May 2022 06:59:12 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id jl13-20020a17090775cd00b006f3ef214e0csm3649494ejc.114.2022.05.02.06.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:59:12 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Austin Kim <austin.kim@lge.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: use unsigned char for boolean values
Date:   Mon,  2 May 2022 15:59:04 +0200
Message-Id: <20220502135907.31035-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by sparse:

    security/selinux/selinuxfs.c:1483:30: warning: incorrect type in assignment (different signedness)
    security/selinux/selinuxfs.c:1483:30:    expected unsigned int *
    security/selinux/selinuxfs.c:1483:30:    got int *[addressable] values
    security/selinux/selinuxfs.c:1400:48: warning: incorrect type in argument 3 (different signedness)
    security/selinux/selinuxfs.c:1400:48:    expected int *values
    security/selinux/selinuxfs.c:1400:48:    got unsigned int *bool_pending_values

Also mark the read-only boolean array parameter of security_set_bools()
const.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/conditional.h |  4 ++--
 security/selinux/selinuxfs.c           | 12 ++++++------
 security/selinux/ss/policydb.h         |  2 +-
 security/selinux/ss/services.c         | 13 +++++++------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
index b09343346e3f..f1b52115e0a3 100644
--- a/security/selinux/include/conditional.h
+++ b/security/selinux/include/conditional.h
@@ -14,9 +14,9 @@
 #include "security.h"
 
 int security_get_bools(struct selinux_policy *policy,
-		       u32 *len, char ***names, int **values);
+		       u32 *len, char ***names, unsigned char **values);
 
-int security_set_bools(struct selinux_state *state, u32 len, int *values);
+int security_set_bools(struct selinux_state *state, u32 len, const unsigned char *values);
 
 int security_get_bool_value(struct selinux_state *state, u32 index);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8fcdd494af27..404b4561f8b0 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -71,7 +71,7 @@ struct selinux_fs_info {
 	struct dentry *bool_dir;
 	unsigned int bool_num;
 	char **bool_pending_names;
-	unsigned int *bool_pending_values;
+	unsigned char *bool_pending_values;
 	struct dentry *class_dir;
 	unsigned long last_class_ino;
 	bool policy_opened;
@@ -356,7 +356,7 @@ static const struct file_operations sel_policyvers_ops = {
 /* declaration for sel_write_load */
 static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
 			  unsigned int *bool_num, char ***bool_pending_names,
-			  unsigned int **bool_pending_values);
+			  unsigned char **bool_pending_values);
 static int sel_make_classes(struct selinux_policy *newpolicy,
 			    struct dentry *class_dir,
 			    unsigned long *last_class_ino);
@@ -527,7 +527,7 @@ static const struct file_operations sel_policy_ops = {
 };
 
 static void sel_remove_old_bool_data(unsigned int bool_num, char **bool_names,
-				unsigned int *bool_values)
+				unsigned char *bool_values)
 {
 	u32 i;
 
@@ -545,7 +545,7 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir, *old_dentry;
 	unsigned int tmp_bool_num, old_bool_num;
 	char **tmp_bool_names, **old_bool_names;
-	unsigned int *tmp_bool_values, *old_bool_values;
+	unsigned char *tmp_bool_values, *old_bool_values;
 	unsigned long tmp_ino = fsi->last_ino; /* Don't increment last_ino in this function */
 
 	tmp_parent = sel_make_disconnected_dir(fsi->sb, &tmp_ino);
@@ -1423,7 +1423,7 @@ static void sel_remove_entries(struct dentry *de)
 
 static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
 			  unsigned int *bool_num, char ***bool_pending_names,
-			  unsigned int **bool_pending_values)
+			  unsigned char **bool_pending_values)
 {
 	int ret;
 	ssize_t len;
@@ -1432,7 +1432,7 @@ static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_
 	struct inode_security_struct *isec;
 	char **names = NULL, *page;
 	u32 i, num;
-	int *values = NULL;
+	unsigned char *values = NULL;
 	u32 sid;
 
 	ret = -ENOMEM;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index c24d4e1063ea..f85e875a7799 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -148,7 +148,7 @@ struct range_trans {
 /* Boolean data type */
 struct cond_bool_datum {
 	__u32 value;		/* internal type value */
-	int state;
+	unsigned char state;
 };
 
 struct cond_node;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 802a80648c6c..7349ed4a4d0d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3022,7 +3022,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 }
 
 int security_get_bools(struct selinux_policy *policy,
-		       u32 *len, char ***names, int **values)
+		       u32 *len, char ***names, unsigned char **values)
 {
 	struct policydb *policydb;
 	u32 i;
@@ -3044,7 +3044,7 @@ int security_get_bools(struct selinux_policy *policy,
 		goto err;
 
 	rc = -ENOMEM;
-	*values = kcalloc(*len, sizeof(int), GFP_ATOMIC);
+	*values = kcalloc(*len, sizeof(unsigned char), GFP_ATOMIC);
 	if (!*values)
 		goto err;
 
@@ -3074,7 +3074,7 @@ int security_get_bools(struct selinux_policy *policy,
 }
 
 
-int security_set_bools(struct selinux_state *state, u32 len, int *values)
+int security_set_bools(struct selinux_state *state, u32 len, const unsigned char *values)
 {
 	struct selinux_policy *newpolicy, *oldpolicy;
 	int rc;
@@ -3106,8 +3106,8 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 
 	/* Update the boolean states in the copy */
 	for (i = 0; i < len; i++) {
-		int new_state = !!values[i];
-		int old_state = newpolicy->policydb.bool_val_to_struct[i]->state;
+		unsigned char new_state = !!values[i];
+		unsigned char old_state = newpolicy->policydb.bool_val_to_struct[i]->state;
 
 		if (new_state != old_state) {
 			audit_log(audit_context(), GFP_ATOMIC,
@@ -3174,7 +3174,8 @@ int security_get_bool_value(struct selinux_state *state,
 static int security_preserve_bools(struct selinux_policy *oldpolicy,
 				struct selinux_policy *newpolicy)
 {
-	int rc, *bvalues = NULL;
+	int rc;
+	unsigned char *bvalues = NULL;
 	char **bnames = NULL;
 	struct cond_bool_datum *booldatum;
 	u32 i, nbools = 0;
-- 
2.36.0

