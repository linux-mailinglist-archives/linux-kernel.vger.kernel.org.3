Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A0449B723
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359089AbiAYPCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581286AbiAYO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:59:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C863EC06173D;
        Tue, 25 Jan 2022 06:59:39 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z22so63480901edd.12;
        Tue, 25 Jan 2022 06:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YETYCy0ly68b/XEmUGegxcn7ozTQ3dOyXFpUqhFaE/o=;
        b=eOfYABgpp2vlbSwD8rMiUsqjuK+1mENAl/iPVK21tO0pg5SFJRf+yq24rJ7ktHiKlP
         GjhLJGtovdJYEF2dtok+vKsidzk6hbYHGbL4geD3+wm1jcABqPF/lK+ExDC4ZPWVYdNk
         y0ucRNVblGZr5Jh+SNkJeqBcKqDqUj3aJusIkm/wGV8B6b0IHyRHk9CE6Y209KMdS+FT
         zKinWISBPxPHFapAvsjzBYUgntc0EVrYmlrpUitAzZETcaNnSxBXWZJf1WRcB8IM5ax5
         b/6ZQv4KmqUUk7UOX8g0cgLTP6ArOgbvKRhIzLap+Hg/9Zq5tz1i49qGDpLY9T3qxBTz
         YDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YETYCy0ly68b/XEmUGegxcn7ozTQ3dOyXFpUqhFaE/o=;
        b=1+VyyKesYoN+Fi8A/GuzTqvXWL8Mnh0y+Ufn1h5S/1pbu91yApendcyS1vGrJZ4A1i
         S3rseBQBahlK8sQW/iRyy1gECURrExxMNJmNr0kPn/Bm0Mg6qb6s2g/VzWcFxgmY/jYZ
         cl9l0Uutqx1yZLJOKVZfQcsaJdGepYKLR11ae9tBhQxYLTnTLQ/HuhAXzi18xlUb7jno
         qwJMWeKFcT+7rD1mOlvSqP5456xOfmqWzhhLNxAYbNgU72ZiFmoHgtPuAUuTWKUGt8AS
         Mn4c9Tfj3Qb0iKm7FXceag/cPZJ0khb+vvdas6q+1CaNVN6TSiXNGJzrS9vr1RcInkuK
         9AsQ==
X-Gm-Message-State: AOAM531MeQTXsxFK7StYcPEyt9WGVeWvZaZa4MDfOjfLCQB5fZ9Lcw09
        hkGXvlpWnAz6auF1M6U1DaxspgzzdKY5DA==
X-Google-Smtp-Source: ABdhPJw3gBH/Bh+gWmE64TAb93sq3Brc8Qh1KZ45RqheOmVv73F3Ud7kpx3NdkymvO+Glb6ISsZLdA==
X-Received: by 2002:a17:907:7287:: with SMTP id dt7mr17000513ejc.56.1643122778318;
        Tue, 25 Jan 2022 06:59:38 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id y17sm6353141ejw.172.2022.01.25.06.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:59:37 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selinux: split no transition execve check
Date:   Tue, 25 Jan 2022 15:59:27 +0100
Message-Id: <20220125145931.56831-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case a setuid or setgid binary is mislabeled with a generic context,
either via a policy mistake or a move by the distribution package,
executing it will be checked by the file permission execute_no_trans on
the generic file context (e.g. bin_t).  The setuid(2)/setgid(2) syscall
within will then be checked against the unchanged caller process
context, which might have been granted the capability permission setuid/
setgid to initially drop privileges.  To avoid that scenario split the
execute_no_trans permission in case of a setuid/setgid binary into a new
permission execute_sxid_no_trans.

For backward compatibility this behavior is contained in a new policy
capability.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c                   | 9 ++++++++-
 security/selinux/include/classmap.h        | 2 +-
 security/selinux/include/policycap.h       | 1 +
 security/selinux/include/policycap_names.h | 3 ++-
 security/selinux/include/security.h        | 8 ++++++++
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5b6895e4fc29..b825fee39a70 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2348,9 +2348,16 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	ad.u.file = bprm->file;
 
 	if (new_tsec->sid == old_tsec->sid) {
+		u32 perm;
+
+		if (selinux_policycap_execute_sxid_no_trans() && is_sxid(inode->i_mode))
+			perm = FILE__EXECUTE_SXID_NO_TRANS;
+		else
+			perm = FILE__EXECUTE_NO_TRANS;
+
 		rc = avc_has_perm(&selinux_state,
 				  old_tsec->sid, isec->sid,
-				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
+				  SECCLASS_FILE, perm, &ad);
 		if (rc)
 			return rc;
 	} else {
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 35aac62a662e..53a1eeeb86fb 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -65,7 +65,7 @@ struct security_class_mapping secclass_map[] = {
 	    "quotaget", "watch", NULL } },
 	{ "file",
 	  { COMMON_FILE_PERMS,
-	    "execute_no_trans", "entrypoint", NULL } },
+	    "execute_no_trans", "entrypoint", "execute_sxid_no_trans", NULL } },
 	{ "dir",
 	  { COMMON_FILE_PERMS, "add_name", "remove_name",
 	    "reparent", "search", "rmdir", NULL } },
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index 2ec038efbb03..23929dc3e1db 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -11,6 +11,7 @@ enum {
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
 	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAPABILITY_EXECUTE_SXID_NO_TRANS,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index b89289f092c9..4c014c2cf352 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -12,7 +12,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"always_check_network",
 	"cgroup_seclabel",
 	"nnp_nosuid_transition",
-	"genfs_seclabel_symlinks"
+	"genfs_seclabel_symlinks",
+	"execute_sxid_no_trans",
 };
 
 #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ac0ece01305a..ab95241b6b7b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -219,6 +219,14 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
 	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS]);
 }
 
+static inline bool selinux_policycap_execute_sxid_no_trans(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_EXECUTE_SXID_NO_TRANS]);
+}
+
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
-- 
2.34.1

