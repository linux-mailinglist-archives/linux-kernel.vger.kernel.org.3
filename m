Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359524BA2D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbiBQOWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:22:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241834AbiBQOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:22:03 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C2D294133;
        Thu, 17 Feb 2022 06:21:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vz16so7807550ejb.0;
        Thu, 17 Feb 2022 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EuHmUQyH6qnHd858RqknP0s0QcJF0aPYhchgl7zVC2A=;
        b=a/cRpJjYorSNEhv8rgzuuwu8DtqJBBjyo6H/urhBzQeA8gCrmajvBkEHM7if60gNmo
         2UhRRWooKMiMJ9joFoQRdXTMAQZCrFUroZuBnUTi0oYCGwMI792kPeYppaccmY0thftX
         LXMC0uCUt4Xyw5YvGFTzgxlZ/kWlk7UGIiXXLxekUjCJq3XUFmBiDj3yW+zTLDPQ4N5R
         gp6aGQvov4zzK47ZsNnCDl+9ZRn7LURFYAk8JqeVI5jY3tdS5ZZraNv8t3BISmCWvAax
         49qJ5LTGcp9GKqPzdNnrQiJaiwl2Slcuh+0Md+vvG3fCAs/1SFNYVZF5za0LSllI7RjJ
         FYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EuHmUQyH6qnHd858RqknP0s0QcJF0aPYhchgl7zVC2A=;
        b=mniax30NFeTvOdghrrIq6BeNJQVq7wmzggd3PHnwyxvw4n5w5rRkUzDD9pt1ERU42U
         PcFS0mMblOy7bkRnWXWIR7Kg167lj45b3HScKWNi555XGCkTwy5Bb5BKjg9lUbV6TC8E
         I/Y89GozK5RRAkiLz/FOyXpTCOHicr3KxKJEDuytBhRJ5wGUS9VpxRpiUHw/vz9idBZp
         qs1rF8q9+iUsrkTkp1OS6l+clEv90AwtGECw12jNHyc9J8EDIGSdZWFj20RS7ncWKRPQ
         6CXOmrx61wFb+10E1KavkRyO5LWJxV3bBVW5YuiMnqBGEu5byJ6yw4y3EgcSH8pb0hzV
         coDQ==
X-Gm-Message-State: AOAM531QMBoht7wD4sNeydCJq1xM4phWWiTNFyl+XUvJoloO1M2Z++Hy
        VsWaiCwnGv534xul43dbKDFuH+ow9LVY4A==
X-Google-Smtp-Source: ABdhPJxTYJvXI6TOu7Yyy7Lxd7Q0QAwjxFNf0pSk+WK3sVTcBhx4oOQ5Q+ZQQ7967AqOazORGuxVew==
X-Received: by 2002:a17:907:9956:b0:6b9:a6d9:a535 with SMTP id kl22-20020a170907995600b006b9a6d9a535mr2533960ejc.64.1645107706743;
        Thu, 17 Feb 2022 06:21:46 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-066-240.77.1.pool.telefonica.de. [77.1.66.240])
        by smtp.gmail.com with ESMTPSA id a13sm578436edn.25.2022.02.17.06.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 06:21:46 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Austin Kim <austin.kim@lge.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 3/5] selinux: use consistent pointer types for boolean arrays
Date:   Thu, 17 Feb 2022 15:21:26 +0100
Message-Id: <20220217142133.72205-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217142133.72205-1-cgzones@googlemail.com>
References: <20220217142133.72205-1-cgzones@googlemail.com>
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

Use a consistent type of unsigned int* for boolean arrays, instead of
using implicit casts to and from int*.

Reported by sparse:

    security/selinux/selinuxfs.c:1481:30: warning: incorrect type in assignment (different signedness)
    security/selinux/selinuxfs.c:1481:30:    expected unsigned int *
    security/selinux/selinuxfs.c:1481:30:    got int *[addressable] values
    security/selinux/selinuxfs.c:1398:48: warning: incorrect type in argument 3 (different signedness)
    security/selinux/selinuxfs.c:1398:48:    expected int *values
    security/selinux/selinuxfs.c:1398:48:    got unsigned int *bool_pending_values

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
A more invasive change would be to change all boolean arrays to bool*.
---
 security/selinux/include/conditional.h | 4 ++--
 security/selinux/selinuxfs.c           | 2 +-
 security/selinux/ss/services.c         | 9 +++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
index b09343346e3f..9e65aa409318 100644
--- a/security/selinux/include/conditional.h
+++ b/security/selinux/include/conditional.h
@@ -14,9 +14,9 @@
 #include "security.h"
 
 int security_get_bools(struct selinux_policy *policy,
-		       u32 *len, char ***names, int **values);
+		       u32 *len, char ***names, unsigned int **values);
 
-int security_set_bools(struct selinux_state *state, u32 len, int *values);
+int security_set_bools(struct selinux_state *state, u32 len, unsigned int *values);
 
 int security_get_bool_value(struct selinux_state *state, u32 index);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f2f6203e0fff..5216a321bbb0 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1428,7 +1428,7 @@ static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_
 	struct inode_security_struct *isec;
 	char **names = NULL, *page;
 	u32 i, num;
-	int *values = NULL;
+	unsigned int *values = NULL;
 	u32 sid;
 
 	ret = -ENOMEM;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 6901dc07680d..7865926962ab 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3023,7 +3023,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 }
 
 int security_get_bools(struct selinux_policy *policy,
-		       u32 *len, char ***names, int **values)
+		       u32 *len, char ***names, unsigned int **values)
 {
 	struct policydb *policydb;
 	u32 i;
@@ -3045,7 +3045,7 @@ int security_get_bools(struct selinux_policy *policy,
 		goto err;
 
 	rc = -ENOMEM;
-	*values = kcalloc(*len, sizeof(int), GFP_ATOMIC);
+	*values = kcalloc(*len, sizeof(unsigned int), GFP_ATOMIC);
 	if (!*values)
 		goto err;
 
@@ -3075,7 +3075,7 @@ int security_get_bools(struct selinux_policy *policy,
 }
 
 
-int security_set_bools(struct selinux_state *state, u32 len, int *values)
+int security_set_bools(struct selinux_state *state, u32 len, unsigned int *values)
 {
 	struct selinux_policy *newpolicy, *oldpolicy;
 	int rc;
@@ -3175,7 +3175,8 @@ int security_get_bool_value(struct selinux_state *state,
 static int security_preserve_bools(struct selinux_policy *oldpolicy,
 				struct selinux_policy *newpolicy)
 {
-	int rc, *bvalues = NULL;
+	int rc;
+	unsigned int *bvalues = NULL;
 	char **bnames = NULL;
 	struct cond_bool_datum *booldatum;
 	u32 i, nbools = 0;
-- 
2.35.1

