Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2B4D1DFD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346569AbiCHQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348593AbiCHQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:56:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F07527C3;
        Tue,  8 Mar 2022 08:55:36 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qx21so40589429ejb.13;
        Tue, 08 Mar 2022 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjXtWGkEwW/SA+fpD3I4QTjghA+IdwhNUEQXDi/C+5Y=;
        b=cLdjqFH3iDBtEJmD21w52mEQKCAtdfR81ATAihLi9o+pqr6bFSaVW3Dlj7DMlguqb+
         3I7lgjCAzmL0hKRMxEQo2LXkbeA8ONGNdiqQA7S6pFybEx6htXUiMJnckLNsqPHduuFw
         xnGNw4hZNdm8QBmQE3eUnAlAJsem4HfV4zbnKIT2Ns56xLLFJuFNwTcBtsqIS3L5I5TG
         aXdyiDGD1ZUGnUtClwJdNBGj/c9arnsZSU6+VyiDIcDxPDeNxjbcyEc9Tot4pBRGbpp8
         JWHwBeEkOeQqNjVFNnx7vDxvY1OXMDheib4gn3jGEDY8CPpkYPnalStmWtfAMpsRbg9O
         IyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjXtWGkEwW/SA+fpD3I4QTjghA+IdwhNUEQXDi/C+5Y=;
        b=TZPaREJi5LRqt3HlEl2mysTifbDWZz/HD9R0TsZDyeuVV2XNeTfsCouApMcMCaOqtg
         K4EoRxte7kNIZbl9+0yIzOS9LcGly3ppUVHTVTX9+tHTcbj5vXDUmvPWT9poHvmF5iE7
         FTpe2zu8mD2zvVOXPpWLh7+q8SyaL76/8CkXEbzyHptKVeAjY+nooGFlEzx7M4B/Y0Sx
         KESk5eEM1X2bWm38rhrpPiunde5BIRVTYqjSjGblgrTqFvbDAbLu6k8psNB5st+1yQju
         taAIpMP2s3nIBn+iIPk6a9Kv8n3zcerBmSaFs8DC0CKnWfFirdkS27CIRRhVZM4aiL9+
         JELg==
X-Gm-Message-State: AOAM531Wh6JQyea0i08VF5E0Anot17H2HcGfUlPGtyO2ayjV4kNBAYC4
        P1CI01rHPIhrNGqvlobHiv8q0sgUTnqEtQ==
X-Google-Smtp-Source: ABdhPJw4MkzF+Jz/qxflgC4MAYWs6mVguTD++C1zX6ix9IwfFpWiHIFCpcQ8ovXH+1eDPp4Z5GpGuw==
X-Received: by 2002:a17:907:6d97:b0:6d7:49e:275e with SMTP id sb23-20020a1709076d9700b006d7049e275emr13811450ejc.410.1646758534620;
        Tue, 08 Mar 2022 08:55:34 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-252-105.77.6.pool.telefonica.de. [77.6.252.105])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906395600b006cec40b9cf0sm6104795eje.92.2022.03.08.08.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:55:33 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Austin Kim <austin.kim@lge.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] selinux: declare data arrays const
Date:   Tue,  8 Mar 2022 17:55:20 +0100
Message-Id: <20220308165527.45456-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217142133.72205-3-cgzones@googlemail.com>
References: <20220217142133.72205-3-cgzones@googlemail.com>
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
script genheaders, by using a static buffer in the conversion function
stoupperx().  In cases we need to compare or print more than one
identifier allocate a temporary copy.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   Drop const exemption for genheaders script by rewriting stoupperx().
---
 scripts/selinux/genheaders/genheaders.c       | 76 ++++++++++---------
 scripts/selinux/mdp/mdp.c                     |  4 +-
 security/selinux/avc.c                        |  2 +-
 security/selinux/include/avc_ss.h             |  2 +-
 security/selinux/include/classmap.h           |  2 +-
 .../selinux/include/initial_sid_to_string.h   |  3 +-
 security/selinux/include/policycap.h          |  2 +-
 security/selinux/include/policycap_names.h    |  2 +-
 security/selinux/ss/services.c                |  4 +-
 9 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
index f355b3e0e968..a2caff3c997f 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -26,19 +26,23 @@ static void usage(void)
 	exit(1);
 }
 
-static char *stoupperx(const char *s)
+static const char *stoupperx(const char *s)
 {
-	char *s2 = strdup(s);
-	char *p;
+	static char buffer[256];
+	unsigned int i;
+	char *p = buffer;
 
-	if (!s2) {
-		fprintf(stderr, "%s:  out of memory\n", progname);
+	for (i = 0; i < (sizeof(buffer) - 1) && *s; i++)
+		*p++ = toupper(*s++);
+
+	if (*s) {
+		fprintf(stderr, "%s:  buffer too small\n", progname);
 		exit(3);
 	}
 
-	for (p = s2; *p; p++)
-		*p = toupper(*p);
-	return s2;
+	*p = '\0';
+
+	return buffer;
 }
 
 int main(int argc, char *argv[])
@@ -59,35 +63,19 @@ int main(int argc, char *argv[])
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
 
-	for (i = 0; secclass_map[i].name; i++) {
-		struct security_class_mapping *map = &secclass_map[i];
-		fprintf(fout, "#define SECCLASS_%-39s %2d\n", map->name, i+1);
-	}
+	for (i = 0; secclass_map[i].name; i++)
+		fprintf(fout, "#define SECCLASS_%-39s %2d\n", stoupperx(secclass_map[i].name), i+1);
 
 	fprintf(fout, "\n");
 
+	isids_len = sizeof(initial_sid_to_string) / sizeof(char *);
 	for (i = 1; i < isids_len; i++) {
 		const char *s = initial_sid_to_string[i];
 		if (s)
-			fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
+			fprintf(fout, "#define SECINITSID_%-39s %2d\n", stoupperx(s), i);
 	}
 	fprintf(fout, "\n#define SECINITSID_NUM %d\n", i-1);
 	fprintf(fout, "\nstatic inline bool security_is_socket_class(u16 kern_tclass)\n");
@@ -96,10 +84,18 @@ int main(int argc, char *argv[])
 	fprintf(fout, "\tswitch (kern_tclass) {\n");
 	for (i = 0; secclass_map[i].name; i++) {
 		static char s[] = "SOCKET";
-		struct security_class_mapping *map = &secclass_map[i];
-		int len = strlen(map->name), l = sizeof(s) - 1;
-		if (len >= l && memcmp(map->name + len - l, s, l) == 0)
-			fprintf(fout, "\tcase SECCLASS_%s:\n", map->name);
+		int len, l;
+		char *name = strdup(stoupperx(secclass_map[i].name));
+
+		if (!name) {
+			fprintf(stderr, "%s:  out of memory\n", progname);
+			exit(3);
+		}
+		len = strlen(name);
+		l = sizeof(s) - 1;
+		if (len >= l && memcmp(name + len - l, s, l) == 0)
+			fprintf(fout, "\tcase SECCLASS_%s:\n", name);
+		free(name);
 	}
 	fprintf(fout, "\t\tsock = true;\n");
 	fprintf(fout, "\t\tbreak;\n");
@@ -123,17 +119,25 @@ int main(int argc, char *argv[])
 	fprintf(fout, "#ifndef _SELINUX_AV_PERMISSIONS_H_\n#define _SELINUX_AV_PERMISSIONS_H_\n\n");
 
 	for (i = 0; secclass_map[i].name; i++) {
-		struct security_class_mapping *map = &secclass_map[i];
-		int len = strlen(map->name);
+		const struct security_class_mapping *map = &secclass_map[i];
+		int len;
+		char *name = strdup(stoupperx(map->name));
+
+		if (!name) {
+			fprintf(stderr, "%s:  out of memory\n", progname);
+			exit(3);
+		}
+		len = strlen(name);
 		for (j = 0; map->perms[j]; j++) {
 			if (j >= 32) {
 				fprintf(stderr, "Too many permissions to fit into an access vector at (%s, %s).\n",
 					map->name, map->perms[j]);
 				exit(5);
 			}
-			fprintf(fout, "#define %s__%-*s 0x%08xU\n", map->name,
-				39-len, map->perms[j], 1U<<j);
+			fprintf(fout, "#define %s__%-*s 0x%08xU\n", name,
+				39-len, stoupperx(map->perms[j]), 1U<<j);
 		}
+		free(name);
 	}
 
 	fprintf(fout, "\n#endif\n");
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
index 5d332aeb8b6c..05cc51085437 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-static const char *initial_sid_to_string[] =
+
+static const char *const initial_sid_to_string[] =
 {
 	NULL,
 	"kernel",
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

