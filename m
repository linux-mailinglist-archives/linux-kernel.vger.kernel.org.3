Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A326E4BA2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbiBQOWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:22:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241834AbiBQOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:22:13 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D562B1663;
        Thu, 17 Feb 2022 06:21:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lw4so7619919ejb.12;
        Thu, 17 Feb 2022 06:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzAjuvuRezKyO/SVp83DwWN6oZxDOTQaXqLmt6YXjzE=;
        b=LHvSh8IaM6IhY+1/xnC7+iup0QTMkQxAnANF1Cg2sZM4XoogiBvEJSzrFxgaqKLHOe
         lRreAZvNDUMFfAo5Pu/7jLYCUV8jlEFa4+eCGqtU+NIOuX/kUExBEd+f4Z+LZGSKe0cN
         pU2P3cyppD2X6JkObg6kl52ZfZ/Ob5zHJnZlJ2z3yY+BJ5NiRcRRs2c2LUJyPmDiJjBv
         C8z0NQqMgsPagkxrAJjMtmCRhmqPHAEYkYKj0FCSRYkxydFwyJNXAOqnP+U7N2hN7cSX
         Vz5btmgnKObw7jMlGvxzRgfjp8kNsBfILB1B51ywokK1KSwWNq2644WzOh+zws/HptwS
         2xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzAjuvuRezKyO/SVp83DwWN6oZxDOTQaXqLmt6YXjzE=;
        b=GEYKwM3apSSlIieKICZfZXKQppjf948EkZ+sqARKNfU78Pts6rb4o5Bz69IDuFeoNz
         1T+sPaGVfWooDa9auQJqpur44tux4GVhQQAkkSjLraImRAgKZMbS7bWTEfWPeCPIe6TD
         5MgpYNWeFlE6U5eTR/VATsRsWQNVZhettBWRFVZ942na7vsQLTpZ2nUupMB91vjySjom
         l6Tyyr7HHH4ft6lpsx/6yfrPe85I6kSxd1y6nn9LS8/77WXKhkVSjgrlp4Ok/Q+hgZ6b
         6/BDCac6m/hOTPg690GWSb5IrwM0FyTYhHsJuRRYaWJT5TfGc/bBOM/afBf31X3F3qhj
         /LQg==
X-Gm-Message-State: AOAM531SP2CnG5GJzvwqL/q9Ag3h1QtMREeoc8cNqZJh1+YeSEL/h/We
        DeCXZ9S2ZWVkJ59Z+MVnypFayfBycm97wA==
X-Google-Smtp-Source: ABdhPJxG9vIvZ6Wb0ffgnDvshkhUw4k6RsPKnE9YL7PdUc/nsZqTnNlQBPe5tektEvwu/gC1POUfPA==
X-Received: by 2002:a17:906:7711:b0:6ce:51b:a5a1 with SMTP id q17-20020a170906771100b006ce051ba5a1mr2464110ejm.610.1645107716221;
        Thu, 17 Feb 2022 06:21:56 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-066-240.77.1.pool.telefonica.de. [77.1.66.240])
        by smtp.gmail.com with ESMTPSA id a13sm578436edn.25.2022.02.17.06.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 06:21:55 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 4/5] selinux: declare data arrays const
Date:   Thu, 17 Feb 2022 15:21:27 +0100
Message-Id: <20220217142133.72205-3-cgzones@googlemail.com>
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

The arrays for the policy capability names, the initial sid identifiers
and the class and permission names are not changed at runtime.  Declare
them const to avoid accidental modification.

The build time script genheaders needs to be exempted, since it converts
the entries to uppercase.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 scripts/selinux/genheaders/genheaders.c          | 2 ++
 scripts/selinux/mdp/mdp.c                        | 4 ++--
 security/selinux/avc.c                           | 2 +-
 security/selinux/include/avc_ss.h                | 2 +-
 security/selinux/include/classmap.h              | 8 +++++++-
 security/selinux/include/initial_sid_to_string.h | 9 ++++++++-
 security/selinux/include/policycap.h             | 2 +-
 security/selinux/include/policycap_names.h       | 2 +-
 security/selinux/ss/services.c                   | 4 ++--
 9 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
index f355b3e0e968..5f7c0b7d9260 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -15,6 +15,8 @@ struct security_class_mapping {
 	const char *perms[sizeof(unsigned) * 8 + 1];
 };
 
+/* Allow to convert entries in mappings to uppercase */
+#define __SELINUX_GENHEADERS__
 #include "classmap.h"
 #include "initial_sid_to_string.h"
 
diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 105c1c31a316..1415604c3d24 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -82,7 +82,7 @@ int main(int argc, char *argv[])
 
 	/* print out the class permissions */
 	for (i = 0; secclass_map[i].name; i++) {
-		struct security_class_mapping *map = &secclass_map[i];
+		const struct security_class_mapping *map = &secclass_map[i];
 		fprintf(fout, "class %s\n", map->name);
 		fprintf(fout, "{\n");
 		for (j = 0; map->perms[j]; j++)
@@ -103,7 +103,7 @@ int main(int argc, char *argv[])
 #define SYSTEMLOW "s0"
 #define SYSTEMHIGH "s1:c0.c1"
 		for (i = 0; secclass_map[i].name; i++) {
-			struct security_class_mapping *map = &secclass_map[i];
+			const struct security_class_mapping *map = &secclass_map[i];
 
 			fprintf(fout, "mlsconstrain %s {\n", map->name);
 			for (j = 0; map->perms[j]; j++)
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index abcd9740d10f..020985a53d8f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -668,7 +668,7 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
 	struct common_audit_data *ad = a;
 	struct selinux_audit_data *sad = ad->selinux_audit_data;
 	u32 av = sad->audited;
-	const char **perms;
+	const char *const *perms;
 	int i, perm;
 
 	audit_log_format(ab, "avc:  %s ", sad->denied ? "denied" : "granted");
diff --git a/security/selinux/include/avc_ss.h b/security/selinux/include/avc_ss.h
index 88c384c5c09e..b38974e22d81 100644
--- a/security/selinux/include/avc_ss.h
+++ b/security/selinux/include/avc_ss.h
@@ -18,7 +18,7 @@ struct security_class_mapping {
 	const char *perms[sizeof(u32) * 8 + 1];
 };
 
-extern struct security_class_mapping secclass_map[];
+extern const struct security_class_mapping secclass_map[];
 
 #endif /* _SELINUX_AVC_SS_H_ */
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 35aac62a662e..07ade4af85ff 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -2,6 +2,12 @@
 #include <linux/capability.h>
 #include <linux/socket.h>
 
+#ifdef __SELINUX_GENHEADERS__
+# define const_qual
+#else
+# define const_qual const
+#endif
+
 #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
     "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", "map"
 
@@ -38,7 +44,7 @@
  * Note: The name for any socket class should be suffixed by "socket",
  *	 and doesn't contain more than one substr of "socket".
  */
-struct security_class_mapping secclass_map[] = {
+const_qual struct security_class_mapping secclass_map[] = {
 	{ "security",
 	  { "compute_av", "compute_create", "compute_member",
 	    "check_context", "load_policy", "compute_relabel",
diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
index 5d332aeb8b6c..915283cd89bd 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -1,5 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-static const char *initial_sid_to_string[] =
+
+#ifdef __SELINUX_GENHEADERS__
+# define const_qual
+#else
+# define const_qual const
+#endif
+
+static const char *const_qual initial_sid_to_string[] =
 {
 	NULL,
 	"kernel",
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index 2ec038efbb03..3207a4e8c899 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -15,6 +15,6 @@ enum {
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
 
-extern const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
+extern const char *const selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
 
 #endif /* _SELINUX_POLICYCAP_H_ */
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index b89289f092c9..51da36e37d21 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -5,7 +5,7 @@
 #include "policycap.h"
 
 /* Policy capability names */
-const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
+const char *const selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"network_peer_controls",
 	"open_perms",
 	"extended_socket_class",
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7865926962ab..25c287324059 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -99,7 +99,7 @@ static void context_struct_compute_av(struct policydb *policydb,
 				      struct extended_perms *xperms);
 
 static int selinux_set_mapping(struct policydb *pol,
-			       struct security_class_mapping *map,
+			       const struct security_class_mapping *map,
 			       struct selinux_map *out_map)
 {
 	u16 i, j;
@@ -121,7 +121,7 @@ static int selinux_set_mapping(struct policydb *pol,
 	/* Store the raw class and permission values */
 	j = 0;
 	while (map[j].name) {
-		struct security_class_mapping *p_in = map + (j++);
+		const struct security_class_mapping *p_in = map + (j++);
 		struct selinux_mapping *p_out = out_map->mapping + j;
 
 		/* An empty class string skips ahead */
-- 
2.35.1

