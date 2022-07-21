Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4C757D28D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiGUR3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGUR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:28:40 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7DB8B49A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:28:22 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10cf9f5b500so3318780fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9XmM5ZEm+shFY9USkb0JIud5sKeKc0ztWjPwdUbLtVM=;
        b=VxN5mqJJldqCTmzCQx2+zgcmh2YQ/eQWRZOCH3SSk/wgcplWOs9zda4bzFvX0e/y3I
         w3O6v0xE9QlSb5O7mcwsd7nUKfGQMW+kAGmKMdQ3s/MptadnTYQWw5YHyzVxhn0Qdra7
         /HkKK7hh0AG+o5x79m4ZlAOsEEJPLxCywqt50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9XmM5ZEm+shFY9USkb0JIud5sKeKc0ztWjPwdUbLtVM=;
        b=WwaQnCFyGttyJcwg0S8Z4epHzMwmFgzM7QJGrFociu0lqbASav1/D8j05xbVdy3i91
         tqMp01GE9J3qGYeNPcP3dmdCxjuY8gEdeEpmDlKk254c0cf5X9XNGvrd0CwAGC4GCfda
         ab9s149LqDRfKtVsU9wtrNgu7Y6lkYVDj2cNbLZ44ujxQwcf3n+IOw7/TdpmWWuj+9bh
         4lH21YCkU2dfTRf5PGNgjg6kOwKwnrJEeNifCJBAnuGNdnnMjpfTGtmRTGJW1Cu4MXGq
         +hMkQ7WIxIa4Q9M6vyBsUZ3lvJ/gr6K5KX3vbnMghIQr75VYkYcOC67NfNRdRLoRuKTh
         xS+w==
X-Gm-Message-State: AJIora88NiXHKhcIXrBZfJECJMcWKCnZCHMpHnxoWQ5YIIwxKK3BL88T
        zS8U8BSdbU/DQ6y0WSccUV6ajg==
X-Google-Smtp-Source: AGRyM1szrijCIIxZinJ6E7J+5pSN+ES88nSt3CyPGl/JIMkRcNEV5/3s7Tb0OdikxMeqWkjS76rHQg==
X-Received: by 2002:a05:6870:709e:b0:10d:752a:9ce7 with SMTP id v30-20020a056870709e00b0010d752a9ce7mr5876067oae.233.1658424501678;
        Thu, 21 Jul 2022 10:28:21 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id du24-20020a0568703a1800b00101c83352c6sm1106207oab.34.2022.07.21.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:28:21 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v3 4/4] selinux: Implement userns_create hook
Date:   Thu, 21 Jul 2022 12:28:08 -0500
Message-Id: <20220721172808.585539-5-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721172808.585539-1-fred@cloudflare.com>
References: <20220721172808.585539-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unprivileged user namespace creation is an intended feature to enable
sandboxing, however this feature is often used to as an initial step to
perform a privilege escalation attack.

This patch implements a new user_namespace { create } access control
permission to restrict which domains allow or deny user namespace
creation. This is necessary for system administrators to quickly protect
their systems while waiting for vulnerability patches to be applied.

This permission can be used in the following way:

        allow domA_t domA_t : user_namespace { create };

Signed-off-by: Frederick Lawler <fred@cloudflare.com>

---
Changes since v2:
- Rename create_user_ns hook to userns_create
- Use user_namespace as an object opposed to a generic namespace object
- s/domB_t/domA_t in commit message
Changes since v1:
- Introduce this patch
---
 security/selinux/hooks.c            | 9 +++++++++
 security/selinux/include/classmap.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index beceb89f68d9..afc9da0249e7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4227,6 +4227,14 @@ static void selinux_task_to_inode(struct task_struct *p,
 	spin_unlock(&isec->lock);
 }
 
+static int selinux_userns_create(const struct cred *cred)
+{
+	u32 sid = current_sid();
+
+	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_USER_NAMESPACE,
+						USER_NAMESPACE__CREATE, NULL);
+}
+
 /* Returns error only if unable to parse addresses */
 static int selinux_parse_skb_ipv4(struct sk_buff *skb,
 			struct common_audit_data *ad, u8 *proto)
@@ -7117,6 +7125,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
 	LSM_HOOK_INIT(task_kill, selinux_task_kill),
 	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
+	LSM_HOOK_INIT(userns_create, selinux_userns_create),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
 	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index ff757ae5f253..0bff55bb9cde 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -254,6 +254,8 @@ const struct security_class_mapping secclass_map[] = {
 	  { COMMON_FILE_PERMS, NULL } },
 	{ "io_uring",
 	  { "override_creds", "sqpoll", NULL } },
+	{ "user_namespace",
+	  { "create", NULL } },
 	{ NULL }
   };
 
-- 
2.30.2

