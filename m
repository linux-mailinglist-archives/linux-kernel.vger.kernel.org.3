Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0605171D3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384116AbiEBOrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiEBOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:47:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8073163CC;
        Mon,  2 May 2022 07:43:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z19so16831917edx.9;
        Mon, 02 May 2022 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ojaZcUMA3uNiUQBUqlNc/3txHgFBsX6PviXmi4pmaRI=;
        b=fbiSNEPgRbq9QjXl2QpApZF0x4HYiaY0Ky1cC/Q6NkkBgmBptigPGiU8njgzr4qTRj
         X/4ynLdd8lijqez/h3PsfHCAST8mOns0kBR21++c6PuOpfJ0T2NrZCXKw4+zVoOv1jPy
         eM1zuk/9vMt7pF76cjdskWtJ4GzH0jYaRYs3VlIqlMzu0TTvXx1Yvafy0tD/X5YXJu7o
         dnCPJCPVTfnc4jLG4RXHvdYOsGTVfDR3qk8YeLkxAHV4SlykrelEqSar2dMkjT3MzU6v
         TKtVx7uerKnOkXT80QGeh0l19Me78VMJf1foSoZhcS1f6JYwmBJ2IWBai0YX132x90OM
         IbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ojaZcUMA3uNiUQBUqlNc/3txHgFBsX6PviXmi4pmaRI=;
        b=JHzbNNqxEp4LnN879vBHOM0jWg+tYZd1hx5VODfir92NwJzIxpxaxWHimtbJg/CUrI
         ZXwu/jA+BcaBMNkjd/UAngv/9QuKZhO8PvdvIkuFRi6tOPBu5hepkn0ybWqAFq/dTuUb
         nsFB9k0yDt6alfk7RedeE9ebI/Cmz2lkLTfgT/Y+FJRJvpCTUnaio0s8wm+iiRyY0bq2
         I1yUooxzpuDhl6SlMrie/NeGtbGxRD6rCOvkpQYROecPfTAtpTNDo4GeqsAaNe9fZf9y
         zWeTq7dVsKY3gd0V56mLP+nRLLj7ZCflSFwyuGxmBcw0O0paW8//NURCQscdg87Zemuz
         pC/w==
X-Gm-Message-State: AOAM531jF4Mru43a7D6uzJDfbJ5tFq9kCn7iBo/dNQLDWPjz5sW02PTB
        7EpwW7GDaIfyH16w5Hb1g6YsMdplxBsdOA==
X-Google-Smtp-Source: ABdhPJwNiudITsBGActu63YwqQHIF/Mtgo9T5nVPCJT6mq1ceFHXHDfgTrTFT/+LY7UaSIZcTwb6nQ==
X-Received: by 2002:a05:6402:1694:b0:425:ae5e:4843 with SMTP id a20-20020a056402169400b00425ae5e4843mr14041435edv.415.1651502627965;
        Mon, 02 May 2022 07:43:47 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id t19-20020aa7d4d3000000b0042617ba63c2sm6780355edr.76.2022.05.02.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 07:43:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] selinux: declare data arrays const
Date:   Mon,  2 May 2022 16:43:38 +0200
Message-Id: <20220502144345.81949-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220308165527.45456-1-cgzones@googlemail.com>
References: <20220308165527.45456-1-cgzones@googlemail.com>
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

Do not override the classmap and the initial sid list in the build time
script genheaders.

Check flose(3) is successful in genheaders.c, otherwise the written data
might be corrupted or incomplete.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  Drop const exemption for genheaders script by rewriting stoupperx().
v3:
  - Declare some additional data array const
  - Do not use static buffer in genheaders.c::stoupperx()
  - Check fclose(3) in genheaders.c
---
 scripts/selinux/genheaders/genheaders.c       | 75 +++++++++++--------
 scripts/selinux/mdp/mdp.c                     |  4 +-
 security/selinux/avc.c                        |  2 +-
 security/selinux/include/avc_ss.h             |  2 +-
 security/selinux/include/classmap.h           |  2 +-
 .../selinux/include/initial_sid_to_string.h   |  4 +-
 security/selinux/include/policycap.h          |  2 +-
 security/selinux/include/policycap_names.h    |  2 +-
 security/selinux/ss/avtab.c                   |  2 +-
 security/selinux/ss/policydb.c                | 36 ++++-----
 security/selinux/ss/services.c                |  4 +-
 11 files changed, 72 insertions(+), 63 deletions(-)

diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
index f355b3e0e968..15520806889e 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -59,35 +59,27 @@ int main(int argc, char *argv[])
 		exit(2);
 	}
 
-	for (i = 0; secclass_map[i].name; i++) {
-		struct security_class_mapping *map = &secclass_map[i];
-		map->name = stoupperx(map->name);
-		for (j = 0; map->perms[j]; j++)
-			map->perms[j] = stoupperx(map->perms[j]);
-	}
-
-	isids_len = sizeof(initial_sid_to_string) / sizeof (char *);
-	for (i = 1; i < isids_len; i++) {
-		const char *s = initial_sid_to_string[i];
-
-		if (s)
-			initial_sid_to_string[i] = stoupperx(s);
-	}
-
 	fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
 	fprintf(fout, "#ifndef _SELINUX_FLASK_H_\n#define _SELINUX_FLASK_H_\n\n");
 
 	for (i = 0; secclass_map[i].name; i++) {
-		struct security_class_mapping *map = &secclass_map[i];
-		fprintf(fout, "#define SECCLASS_%-39s %2d\n", map->name, i+1);
+		char *name = stoupperx(secclass_map[i].name);
+
+		fprintf(fout, "#define SECCLASS_%-39s %2d\n", name, i+1);
+		free(name);
 	}
 
 	fprintf(fout, "\n");
 
+	isids_len = sizeof(initial_sid_to_string) / sizeof(char *);
 	for (i = 1; i < isids_len; i++) {
 		const char *s = initial_sid_to_string[i];
-		if (s)
-			fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
+		if (s) {
+			char *sidname = stoupperx(s);
+
+			fprintf(fout, "#define SECINITSID_%-39s %2d\n", sidname, i);
+			free(sidname);
+		}
 	}
 	fprintf(fout, "\n#define SECINITSID_NUM %d\n", i-1);
 	fprintf(fout, "\nstatic inline bool security_is_socket_class(u16 kern_tclass)\n");
@@ -96,10 +88,14 @@ int main(int argc, char *argv[])
 	fprintf(fout, "\tswitch (kern_tclass) {\n");
 	for (i = 0; secclass_map[i].name; i++) {
 		static char s[] = "SOCKET";
-		struct security_class_mapping *map = &secclass_map[i];
-		int len = strlen(map->name), l = sizeof(s) - 1;
-		if (len >= l && memcmp(map->name + len - l, s, l) == 0)
-			fprintf(fout, "\tcase SECCLASS_%s:\n", map->name);
+		int len, l;
+		char *name = stoupperx(secclass_map[i].name);
+
+		len = strlen(name);
+		l = sizeof(s) - 1;
+		if (len >= l && memcmp(name + len - l, s, l) == 0)
+			fprintf(fout, "\tcase SECCLASS_%s:\n", name);
+		free(name);
 	}
 	fprintf(fout, "\t\tsock = true;\n");
 	fprintf(fout, "\t\tbreak;\n");
@@ -110,33 +106,52 @@ int main(int argc, char *argv[])
 	fprintf(fout, "}\n");
 
 	fprintf(fout, "\n#endif\n");
-	fclose(fout);
+
+	if (fclose(fout) != 0) {
+		fprintf(stderr, "Could not successfully close %s:  %s\n",
+			argv[1], strerror(errno));
+		exit(4);
+	}
 
 	fout = fopen(argv[2], "w");
 	if (!fout) {
 		fprintf(stderr, "Could not open %s for writing:  %s\n",
 			argv[2], strerror(errno));
-		exit(4);
+		exit(5);
 	}
 
 	fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
 	fprintf(fout, "#ifndef _SELINUX_AV_PERMISSIONS_H_\n#define _SELINUX_AV_PERMISSIONS_H_\n\n");
 
 	for (i = 0; secclass_map[i].name; i++) {
-		struct security_class_mapping *map = &secclass_map[i];
-		int len = strlen(map->name);
+		const struct security_class_mapping *map = &secclass_map[i];
+		int len;
+		char *name = stoupperx(map->name);
+
+		len = strlen(name);
 		for (j = 0; map->perms[j]; j++) {
+			char *permname;
+
 			if (j >= 32) {
 				fprintf(stderr, "Too many permissions to fit into an access vector at (%s, %s).\n",
 					map->name, map->perms[j]);
 				exit(5);
 			}
-			fprintf(fout, "#define %s__%-*s 0x%08xU\n", map->name,
-				39-len, map->perms[j], 1U<<j);
+			permname = stoupperx(map->perms[j]);
+			fprintf(fout, "#define %s__%-*s 0x%08xU\n", name,
+				39-len, permname, 1U<<j);
+			free(permname);
 		}
+		free(name);
 	}
 
 	fprintf(fout, "\n#endif\n");
-	fclose(fout);
+
+	if (fclose(fout) != 0) {
+		fprintf(stderr, "Could not successfully close %s:  %s\n",
+			argv[2], strerror(errno));
+		exit(6);
+	}
+
 	exit(0);
 }
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
index 874c1c6fe10b..9a43af0ebd7d 100644
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
index 35aac62a662e..ff757ae5f253 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -38,7 +38,7 @@
  * Note: The name for any socket class should be suffixed by "socket",
  *	 and doesn't contain more than one substr of "socket".
  */
-struct security_class_mapping secclass_map[] = {
+const struct security_class_mapping secclass_map[] = {
 	{ "security",
 	  { "compute_av", "compute_create", "compute_member",
 	    "check_context", "load_policy", "compute_relabel",
diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
index 5d332aeb8b6c..7942bd5db78c 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-static const char *initial_sid_to_string[] =
-{
+
+static const char *const initial_sid_to_string[] = {
 	NULL,
 	"kernel",
 	"security",
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index 2680aa21205c..f35d3458e71d 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -16,6 +16,6 @@ enum {
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
 
-extern const char *selinux_policycap_names[__POLICYDB_CAP_MAX];
+extern const char *const selinux_policycap_names[__POLICYDB_CAP_MAX];
 
 #endif /* _SELINUX_POLICYCAP_H_ */
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index 100da7d043db..2a87fc3702b8 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -5,7 +5,7 @@
 #include "policycap.h"
 
 /* Policy capability names */
-const char *selinux_policycap_names[__POLICYDB_CAP_MAX] = {
+const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"network_peer_controls",
 	"open_perms",
 	"extended_socket_class",
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index cfdae20792e1..88eef0128773 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -385,7 +385,7 @@ void avtab_hash_eval(struct avtab *h, char *tag)
 	       chain2_len_sum);
 }
 
-static uint16_t spec_order[] = {
+static const uint16_t spec_order[] = {
 	AVTAB_ALLOWED,
 	AVTAB_AUDITDENY,
 	AVTAB_AUDITALLOW,
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index d036e1238e77..db795ca433a7 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -61,7 +61,7 @@ struct policydb_compat_info {
 };
 
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
-static struct policydb_compat_info policydb_compat[] = {
+static const struct policydb_compat_info policydb_compat[] = {
 	{
 		.version	= POLICYDB_VERSION_BASE,
 		.sym_num	= SYM_NUM - 3,
@@ -159,18 +159,16 @@ static struct policydb_compat_info policydb_compat[] = {
 	},
 };
 
-static struct policydb_compat_info *policydb_lookup_compat(int version)
+static const struct policydb_compat_info *policydb_lookup_compat(int version)
 {
 	int i;
-	struct policydb_compat_info *info = NULL;
 
 	for (i = 0; i < ARRAY_SIZE(policydb_compat); i++) {
-		if (policydb_compat[i].version == version) {
-			info = &policydb_compat[i];
-			break;
-		}
+		if (policydb_compat[i].version == version)
+			return &policydb_compat[i];
 	}
-	return info;
+
+	return NULL;
 }
 
 /*
@@ -314,8 +312,7 @@ static int cat_destroy(void *key, void *datum, void *p)
 	return 0;
 }
 
-static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
-{
+static int (*const destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 	common_destroy,
 	cls_destroy,
 	role_destroy,
@@ -670,8 +667,7 @@ static int cat_index(void *key, void *datum, void *datap)
 	return 0;
 }
 
-static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
-{
+static int (*const index_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 	common_index,
 	class_index,
 	role_index,
@@ -1639,8 +1635,7 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 	return rc;
 }
 
-static int (*read_f[SYM_NUM]) (struct policydb *p, struct symtab *s, void *fp) =
-{
+static int (*const read_f[SYM_NUM]) (struct policydb *p, struct symtab *s, void *fp) = {
 	common_read,
 	class_read,
 	role_read,
@@ -2211,7 +2206,7 @@ static int genfs_read(struct policydb *p, void *fp)
 	return rc;
 }
 
-static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
+static int ocontext_read(struct policydb *p, const struct policydb_compat_info *info,
 			 void *fp)
 {
 	int i, j, rc;
@@ -2407,7 +2402,7 @@ int policydb_read(struct policydb *p, void *fp)
 	u32 len, nprim, nel, perm;
 
 	char *policydb_str;
-	struct policydb_compat_info *info;
+	const struct policydb_compat_info *info;
 
 	policydb_init(p);
 
@@ -3241,9 +3236,8 @@ static int user_write(void *vkey, void *datum, void *ptr)
 	return 0;
 }
 
-static int (*write_f[SYM_NUM]) (void *key, void *datum,
-				void *datap) =
-{
+static int (*const write_f[SYM_NUM]) (void *key, void *datum,
+				void *datap) = {
 	common_write,
 	class_write,
 	role_write,
@@ -3254,7 +3248,7 @@ static int (*write_f[SYM_NUM]) (void *key, void *datum,
 	cat_write,
 };
 
-static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
+static int ocontext_write(struct policydb *p, const struct policydb_compat_info *info,
 			  void *fp)
 {
 	unsigned int i, j, rc;
@@ -3611,7 +3605,7 @@ int policydb_write(struct policydb *p, void *fp)
 	__le32 buf[4];
 	u32 config;
 	size_t len;
-	struct policydb_compat_info *info;
+	const struct policydb_compat_info *info;
 
 	/*
 	 * refuse to write policy older than compressed avtab
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 802a80648c6c..d59230258f6f 100644
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
2.36.0

