Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2715054E88B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378252AbiFPRSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378273AbiFPRSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:18:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A348443C6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:18:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2384448pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PKGwV//MEXrwgZOiJp/qoVKZr49qK2b+iqbkchU5bh8=;
        b=gmF4Klitv5CulrXt7xBxijxRxfZ9Jp5eXLMoJMnjoyOKCJwue2joP1FSwImvel8a54
         JOl/Nx661Nf4vsrg1D4Kx2aEW5NaWQUZDN68KqMeLeMzEcmiwoLKP0Z0GuwW9h7xJD0Q
         b+uJ/rfyyqA8FcFAK67f2kWy1joYYUUhL0hZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PKGwV//MEXrwgZOiJp/qoVKZr49qK2b+iqbkchU5bh8=;
        b=MfNJwBYq0F7IWgcYLpKit2xbAl0+d3nMgbAEIW3xFcviqU7mndiy/h246Oq3adKp2V
         fBtLUN5QnOMrkPHN1WTvGLKoSB6LCvYBeHBPVJ3I3onVklzxPdhHRcTCLMkklcVnteeO
         3xv95jqt0cQdb1H6Zo6BGqLVNG3oqgKCCf+L0Cl2HDbnxbY9Ph+ImwiFQjAkyWQIX2We
         fBqtPP49u+5bTZIN+yfgM+Xkq9L86tcgA/rt2HxE7oIkU7sYIqwJAsMseuUtYd3y2Zcd
         wXP914YEGtq8yAyDnkdcH1H8WDNmCFaV1Eu1MqJZFY/lvMK2nS+G0TBaegb3jpom0xly
         vlgg==
X-Gm-Message-State: AJIora98zzaLoMTnF2mKoJbBTgDi8w3awbpWt1JILuhDymq23PCu1bhu
        8AulVqRA2aWqJLFRtB97u5BVUprsBfhNQQ==
X-Google-Smtp-Source: AGRyM1tOcp7klVw0+BqUz5jJnXKHokgfqb9ph9LucWEdnmE9rya65hCQQup8atZHLsV67aJhNHAohA==
X-Received: by 2002:a17:90b:1e44:b0:1e2:e772:5f08 with SMTP id pi4-20020a17090b1e4400b001e2e7725f08mr17314937pjb.129.1655399920846;
        Thu, 16 Jun 2022 10:18:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:46bc:126f:64c1:579a])
        by smtp.gmail.com with UTF8SMTPSA id fs20-20020a17090af29400b001ea75a02805sm4077300pjb.52.2022.06.16.10.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 10:18:38 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 2/3] LSM: SafeSetID: Add setgroups() security policy handling
Date:   Thu, 16 Jun 2022 10:18:35 -0700
Message-Id: <20220616171835.783310-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 security/safesetid/lsm.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 963f4ad9cb66..e806739f7868 100644
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
+		if (!id_permitted_for_cred(old, (kid_t){.gid = new->group_info->gid[i]}, GID)) {
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

