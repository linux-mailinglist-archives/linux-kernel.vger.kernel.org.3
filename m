Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B8F54A0BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351113AbiFMU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349402AbiFMUz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:55:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1126DE3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:28:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso7120130pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXW0hDI4afPMPvVTdglP4wtV3BgdMHsZNl3ku0E2d7M=;
        b=OawfSmTcCHFQ+VMNMVuxoKNkFhep1bnEVtCZ1J2QfgX+MTvk2bzzpQNeHMWMTTlhYK
         Olbfbee+IiJPt8BwM/E1GJV0xdxY9vfAlw8Sb1FEvAzYy1sC1ZCJnFcCKVm1zAEmx9gP
         zw0wVqKu5t87uQ+Bsf9htI21QWnhkZNpRoVXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXW0hDI4afPMPvVTdglP4wtV3BgdMHsZNl3ku0E2d7M=;
        b=kWNA9y7BSB5oIWsNPyxOBS381xmBwSDU3/7Ab3Ai2CWkCqECOh6LbFxAs2hAEsgbwC
         VbrpfcMcCrEEwwn4MuyqKhIDnBAGfw6R4hmAIKRKFrD6ywSr7j4HTf6fUJQIlCxRC+un
         V+kZATQVYw8JlGQSUwquj3hZt7doNA+3vYvMvUr39GeRQE+cVARHCW3KYx2hbDUbkMWm
         uSWkw8/Va+Y/p1zkYV4KyJ4AI9nYRvhrX4KlMQcE1Vs53tmggitRqPFqm8bjK4E9hKcz
         Nxk5K28s+bUYFTJQ6zj8hzTGoeLXpjD8zNnKXgPkSskv6jWEqsqDXORzsbVmfzEs/Fn2
         mITQ==
X-Gm-Message-State: AJIora//yZD7XD0AGuqwl7X/oqSNnnPP0NRcR8bD1LmcYmwupZPNb2h8
        hxnJ40EuSJilhMU5Au3Kr3z3yg==
X-Google-Smtp-Source: AGRyM1vnEGLlJlczhAZiy7kRNxRubYrVq/jIWjq4UXCvl+In+pXSmLG0g4W+fL8FqnLzm574WSP4uA==
X-Received: by 2002:a17:903:3296:b0:164:13db:509 with SMTP id jh22-20020a170903329600b0016413db0509mr788890plb.128.1655152136197;
        Mon, 13 Jun 2022 13:28:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:cf79:20b3:87b5:90bc])
        by smtp.gmail.com with UTF8SMTPSA id w2-20020a62c702000000b0051c03229a2bsm5814447pfg.21.2022.06.13.13.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 13:28:55 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 2/2] LSM: SafeSetID: Add setgroups() security policy handling
Date:   Mon, 13 Jun 2022 13:28:52 -0700
Message-Id: <20220613202852.447738-1-mortonm@chromium.org>
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

The SafeSetID LSM has functionality for restricting setuid()/setgid()
syscalls based on its configured security policies. This patch adds the
analogous functionality for the setgroups() syscall. Security policy
for the setgroups() syscall follows the same policies that are
installed on the system for setgid() syscalls.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
NOTE: this code does nothing to prevent a SafeSetID-restricted process
with CAP_SETGID from dropping supplementary groups. I don't anticipate
supplementary groups ever being used to restrict a process' privileges
(rather than grant privileges), so I think this is fine for the
purposes of SafeSetID.

Developed on 5.18

 security/safesetid/lsm.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 963f4ad9cb66..01c355e740aa 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -97,15 +97,9 @@ static int safesetid_security_capable(const struct cred *cred,
 		return 0;
 
 	/*
-	 * If CAP_SET{U/G}ID is currently used for a setid() syscall, we want to
-	 * let it go through here; the real security check happens later, in the
-	 * task_fix_set{u/g}id hook.
-         *
-         * NOTE:
-         * Until we add support for restricting setgroups() calls, GID security
-         * policies offer no meaningful security since we always return 0 here
-         * when called from within the setgroups() syscall and there is no
-         * additional hook later on to enforce security policies for setgroups().
+	 * If CAP_SET{U/G}ID is currently used for a setid or setgroups syscall, we
+	 * want to let it go through here; the real security check happens later, in
+	 * the task_fix_set{u/g}id or task_fix_setgroups hooks.
 	 */
 	if ((opts & CAP_OPT_INSETID) != 0)
 		return 0;
@@ -241,9 +235,36 @@ static int safesetid_task_fix_setgid(struct cred *new,
 	return -EACCES;
 }
 
+static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old)
+{
+	int i;
+
+	/* Do nothing if there are no setgid restrictions for our old RGID. */
+	if (setid_policy_lookup((kid_t){.gid = old->gid}, INVALID_ID, GID) == SIDPOL_DEFAULT)
+		return 0;
+
+	get_group_info(new->group_info);
+	for (i = 0; i < new->group_info->ngroups; i++) {
+		if (!id_permitted_for_cred(old, (kid_t){.gid = group_info->gid[i]}, GID)) {
+			put_group_info(new->group_info);
+			/*
+			 * Kill this process to avoid potential security vulnerabilities
+			 * that could arise from a missing allowlist entry preventing a
+			 * privileged process from dropping to a lesser-privileged one.
+			 */
+			force_sig(SIGKILL);
+			return -EACCES;
+		}
+	}
+
+	put_group_info(new->group_info);
+	return 0;
+}
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
+	LSM_HOOK_INIT(task_fix_setgroups, safesetid_task_fix_setgroups),
 	LSM_HOOK_INIT(capable, safesetid_security_capable)
 };
 
-- 
2.36.1.476.g0c4daa206d-goog

