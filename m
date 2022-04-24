Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B81950D4BF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiDXTQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbiDXTOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:14:17 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB492250D;
        Sun, 24 Apr 2022 12:10:46 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o6I019069;
        Mon, 25 Apr 2022 04:09:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o6I019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827346;
        bh=AVil68YSPHWLVjofCEmlZoN0iHmkVQVJstSM/4p9ZwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHG1Fzn3TddqpqSLS4uV5XckGv9ZWTUqzYPcPdD4cHXVGJxeiu/vqUZXEp8/yt+QB
         995I2DJot2zT3vvzNIy+jIw2KR06UNTRzK+N7sLKkBusy5nZWxknRMN1XRaFaCCGCC
         lXLH1lYD+QijkLoWmNv49/s+wlflDONn77teD1qAo7pvny7F2imtxtkDh88SVSaxtq
         2iOO8iH5VayaD8hTit4MOZqOH2dGnSkIFW4ejjY8Z7zWEqFQ+QGd2DxUQ2L1s0SCrl
         iR38yKCrbgHi+I590inv667MWSsvJJW1slHZ/vwCnZf6h8jrgLkoNRznVBrAOCD7DB
         TfnhGzYaaJ4zw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 24/27] modpost: generate linker script to collect symbol versions
Date:   Mon, 25 Apr 2022 04:08:08 +0900
Message-Id: <20220424190811.1678416-25-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220424190811.1678416-1-masahiroy@kernel.org>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge version CRCs per vmlinux or per module.

These linker scripts will be fed to the final link stage.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .gitignore            |  1 +
 Makefile              |  1 +
 scripts/mod/modpost.c | 27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/.gitignore b/.gitignore
index 265959544978..f9dad6b917e6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -42,6 +42,7 @@
 *.so.dbg
 *.su
 *.symtypes
+*.symver.lds
 *.symversions
 *.tab.[ch]
 *.tar
diff --git a/Makefile b/Makefile
index 235d68fa1470..0779db3d1c0c 100644
--- a/Makefile
+++ b/Makefile
@@ -1859,6 +1859,7 @@ clean: $(clean-dirs)
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
+		-o -name '*.symver.lds' \
 		-o -name '*.*.symversions' \) -type f -print | xargs rm -f
 
 # Generate tags for editors
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 43ab4f000ae3..ef779ada04c6 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2577,6 +2577,30 @@ static void write_dump(const char *fname)
 	free(buf.p);
 }
 
+static void write_symversions_lds(struct module *mod)
+{
+	struct buffer buf = { };
+	struct symbol *sym;
+	char lds_file[PATH_MAX];
+	int ret;
+
+	ret = snprintf(lds_file, sizeof(lds_file), "%s.symver.lds", mod->name);
+	if (ret >= sizeof(lds_file)) {
+		error("%s: too long path was truncated\n", lds_file);
+		return;
+	}
+
+	list_for_each_entry(sym, &mod->exported_symbols, list) {
+		if (!sym->crc_valid)
+			continue;
+
+		buf_printf(&buf, "__crc_%s = 0x%08x;\n", sym->name, sym->crc);
+	}
+
+	write_if_changed(&buf, lds_file);
+	free(buf.p);
+}
+
 static void write_namespace_deps_files(const char *fname)
 {
 	struct module *mod;
@@ -2673,6 +2697,9 @@ int main(int argc, char **argv)
 		char fname[PATH_MAX];
 		int ret;
 
+		if (modversions && !mod->from_dump)
+			write_symversions_lds(mod);
+
 		if (mod->is_vmlinux || mod->from_dump)
 			continue;
 
-- 
2.32.0

