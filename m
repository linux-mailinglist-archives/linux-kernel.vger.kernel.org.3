Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC6054A0BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351649AbiFMU7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344939AbiFMUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:55:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9030012604
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:28:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so5235201pjl.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osZI55S/5dMcmV9pE2V+C0A43bBMSnu9K9IPGFv9W/Q=;
        b=mWUznRIloP2KlmQ1d/y4w2DVizn3o5dRam9GxBJuSDKWWJyNFWl8lbPbBDxPFrlLYF
         bL6KsouwqNO7nn0ZucMLrpAvQeeMlv6Lz+ixXEBs2F9gtF6UMucw2rUHLthFUr17mVkI
         9R2z0NFBWgYL9bSujjUguW3v3dnYtOlRyA60Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osZI55S/5dMcmV9pE2V+C0A43bBMSnu9K9IPGFv9W/Q=;
        b=fDtIUklke4jhhljd4yRuWKT1+Z5Tz8bEGLEcC3yPKs5M3di6ekS74weAfScF24xx9J
         p3ztqxmGyTqqW4tzxBbpRzWXap90LsAl9U2O1YHf0PFt+Z9AYo2rZcAIosEoFisNogZP
         JI8f8rquaSKoBL4nshI48nYa2u1Hs8etkgt/dmU7Sqa1Xv6Xemyk2suJCtFilfuSXMMa
         62LLgi5yi1srK9z+Na9aMeyPfmfbsJPz+9CaXJv+CBhYgNT44CDb1c1A45rxCkbrxSZn
         ntl4LPqQQgznCqhp+XTcrPj4/sY+MdYs3oyAfPNCTKIRSNq21SaFIts8LfmtmEG1ipIv
         MciQ==
X-Gm-Message-State: AJIora88lDSGoxGpU9YxnHrs0vnFa8kLZ589pwvLbdQOJ6UQ4WkOtVOH
        jwRUVTEgqU6NAhE3qNU17hpMNw==
X-Google-Smtp-Source: ABdhPJwWHXAV5GrU0wvTAGyjLfVkRBvo2yWyHFPTojpJxd+BGIwMV6Tfi1FuKAqpnzhRjLbV0+62Vg==
X-Received: by 2002:a17:902:eb90:b0:163:e4c1:b2fc with SMTP id q16-20020a170902eb9000b00163e4c1b2fcmr807340plg.159.1655152092015;
        Mon, 13 Jun 2022 13:28:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:cf79:20b3:87b5:90bc])
        by smtp.gmail.com with UTF8SMTPSA id f13-20020a170902f38d00b0016413dbbf92sm5531140ple.234.2022.06.13.13.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 13:28:10 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 1/2] security: Add LSM hook to setgroups() syscall
Date:   Mon, 13 Jun 2022 13:28:07 -0700
Message-Id: <20220613202807.447694-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give the LSM framework the ability to filter setgroups() syscalls. There
are already analagous hooks for the set*uid() and set*gid() syscalls.
The SafeSetID LSM will use this new hook to ensure setgroups() calls are
allowed by the installed security policy.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---

Developed on 5.18

 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  7 +++++++
 include/linux/security.h      |  7 +++++++
 kernel/groups.c               | 12 ++++++++++++
 security/security.c           |  5 +++++
 5 files changed, 32 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index db924fe379c9..c01063ec4be7 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -201,6 +201,7 @@ LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
 	 int flags)
 LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
 	 int flags)
+LSM_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred * old)
 LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
 LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
 LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 419b5febc3ca..b5143d9a1127 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -701,6 +701,13 @@
  *	@old is the set of credentials that are being replaced.
  *	@flags contains one of the LSM_SETID_* values.
  *	Return 0 on success.
+ * @task_fix_setgroups:
+ *	Update the module's state after setting the supplementary group
+ *	identity attributes of the current process.
+ *	@new is the set of credentials that will be installed.  Modifications
+ *	should be made to this rather than to @current->cred.
+ *	@old is the set of credentials that are being replaced.
+ *	Return 0 on success.
  * @task_setpgid:
  *	Check permission before setting the process group identifier of the
  *	process @p to @pgid.
diff --git a/include/linux/security.h b/include/linux/security.h
index 25b3ef71f495..d111ff830742 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -413,6 +413,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_fix_setgid(struct cred *new, const struct cred *old,
 			     int flags);
+int security_task_fix_setgroups(struct cred *new, const struct cred *old);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
@@ -1096,6 +1097,12 @@ static inline int security_task_fix_setgid(struct cred *new,
 	return 0;
 }
 
+static inline int security_task_fix_setgroups(struct cred *new,
+					   const struct cred *old)
+{
+	return 0;
+}
+
 static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return 0;
diff --git a/kernel/groups.c b/kernel/groups.c
index 787b381c7c00..c085f54d8dbb 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -134,13 +134,25 @@ EXPORT_SYMBOL(set_groups);
 int set_current_groups(struct group_info *group_info)
 {
 	struct cred *new;
+	struct cred *old;
 
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
 
+	old = current_cred();
+
 	set_groups(new, group_info);
+
+	retval = security_task_fix_setgroups(new, old);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
+
+error:
+	abort_creds(new);
+	return retval;
 }
 
 EXPORT_SYMBOL(set_current_groups);
diff --git a/security/security.c b/security/security.c
index b7cf5cbfdc67..eaed8d16d90a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1809,6 +1809,11 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
 	return call_int_hook(task_fix_setgid, 0, new, old, flags);
 }
 
+int security_task_fix_setgroups(struct cred *new, const struct cred *old)
+{
+	return call_int_hook(task_fix_setgroups, 0, new, old);
+}
+
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return call_int_hook(task_setpgid, 0, p, pgid);
-- 
2.36.1.476.g0c4daa206d-goog

