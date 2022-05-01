Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C257051630C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbiEAIqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiEAIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:53 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4BF4C7BD;
        Sun,  1 May 2022 01:42:26 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2S8008518;
        Sun, 1 May 2022 17:41:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2S8008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394476;
        bh=sptS0LmRlNiGcR68bLoyoAyfJyNegh6hJaBxFNIll3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDPFyPCZfsdss2FtLiLT5YxIh9XZAGC9UsWVtwrV1QS+lv5YJrsRK1ddLGmLrUcYI
         We3JUN2MZxVXVWPds6TkQzdbewxVsedPXfNiEWDAXzCG4P2WG/06e827+8zgnPixJV
         ukpuxBGdoCb3D8aWkSOibXZPPTS805h9tMuCNH89biib5OluTZKQ7E5F4zKMdsIgk7
         N2iCeWbWSjQKTJ6XNIC2VlCyCTMvaHkttHZHHRbJ7ZvjIlRbYqW6nf4kR2tJgDPMdu
         khrNWG5vedVu9gCP2GTq/cllt30Qg3Exxx7R242BAcuSnjVzVp+ly8T2m22Xd5r24Q
         c3Q4NhPUIff2w==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 21/26] genksyms: adjust the output format for .cmd files
Date:   Sun,  1 May 2022 17:40:27 +0900
Message-Id: <20220501084032.1025918-22-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220501084032.1025918-1-masahiroy@kernel.org>
References: <20220501084032.1025918-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

genksyms output symbol versions in the linker script format.
The output format depends on CONFIG_MODULE_REL_CRCS.

Now, symbol versions are passed to modpost as plain text data,
we can simplify the genksyms code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 scripts/Makefile.build      |  9 ---------
 scripts/genksyms/genksyms.c | 17 ++++-------------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 10092efb61ac..1f480e4ff70a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -128,7 +128,6 @@ $(obj)/%.i: $(src)/%.c FORCE
 
 genksyms = scripts/genksyms/genksyms		\
 	$(if $(1), -T $(2))			\
-	$(if $(CONFIG_MODULE_REL_CRCS), -R)	\
 	$(if $(KBUILD_PRESERVE), -p)		\
 	-r $(or $(wildcard $(2:.symtypes=.symref)), /dev/null)
 
@@ -166,18 +165,10 @@ ifdef CONFIG_MODVERSIONS
 # o modpost will extract versions from the .cmd file and create linker
 #   scripts used to link the kernel and/or modules.
 
-genksyms_format_rel_crc := [^_]*__crc_\([^ ]*\) = \.; LONG(\([^)]*\)).*
-genksyms_format_normal := __crc_\(.*\) = \(.*\);
-genksyms_format := $(if $(CONFIG_MODULE_REL_CRCS),$(genksyms_format_rel_crc),$(genksyms_format_normal))
-
 gen_symversions =								\
 	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
 		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
-		    > $@.symversions;						\
-		sed -n 's/$(genksyms_format)/$(pound)SYMVER \1 \2/p' $@.symversions \
 			>> $(dot-target).cmd;					\
-	else									\
-		rm -f $@.symversions;						\
 	fi
 
 cmd_gen_symversions_c =	$(call gen_symversions,c)
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 4827c5abe5b7..ec5ad4405483 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -33,7 +33,7 @@ char *cur_filename;
 int in_source_file;
 
 static int flag_debug, flag_dump_defs, flag_reference, flag_dump_types,
-	   flag_preserve, flag_warnings, flag_rel_crcs;
+	   flag_preserve, flag_warnings;
 
 static int errors;
 static int nsyms;
@@ -680,11 +680,7 @@ void export_symbol(const char *name)
 		if (flag_dump_defs)
 			fputs(">\n", debugfile);
 
-		/* Used as a linker script. */
-		printf(!flag_rel_crcs ? "__crc_%s = 0x%08lx;\n" :
-		       "SECTIONS { .rodata : ALIGN(4) { "
-		       "__crc_%s = .; LONG(0x%08lx); } }\n",
-		       name, crc);
+		printf("#SYMVER %s 0x%08lx\n", name, crc);
 	}
 }
 
@@ -745,7 +741,6 @@ static void genksyms_usage(void)
 	      "  -q                    Disable warnings (default)\n"
 	      "  -h                    Print this message\n"
 	      "  -V                    Print the release version\n"
-	      "  -R                    Emit section relative symbol CRCs\n"
 #endif				/* __GNU_LIBRARY__ */
 	      , stderr);
 }
@@ -766,14 +761,13 @@ int main(int argc, char **argv)
 		{"preserve", 0, 0, 'p'},
 		{"version", 0, 0, 'V'},
 		{"help", 0, 0, 'h'},
-		{"relative-crc", 0, 0, 'R'},
 		{0, 0, 0, 0}
 	};
 
-	while ((o = getopt_long(argc, argv, "s:dwqVDr:T:phR",
+	while ((o = getopt_long(argc, argv, "s:dwqVDr:T:ph",
 				&long_opts[0], NULL)) != EOF)
 #else				/* __GNU_LIBRARY__ */
-	while ((o = getopt(argc, argv, "s:dwqVDr:T:phR")) != EOF)
+	while ((o = getopt(argc, argv, "s:dwqVDr:T:ph")) != EOF)
 #endif				/* __GNU_LIBRARY__ */
 		switch (o) {
 		case 'd':
@@ -813,9 +807,6 @@ int main(int argc, char **argv)
 		case 'h':
 			genksyms_usage();
 			return 0;
-		case 'R':
-			flag_rel_crcs = 1;
-			break;
 		default:
 			genksyms_usage();
 			return 1;
-- 
2.32.0

