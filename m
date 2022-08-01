Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D85866F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiHAJmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiHAJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:41:58 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29293718F;
        Mon,  1 Aug 2022 02:41:56 -0700 (PDT)
Received: from grover.sesame ([133.106.54.139]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 2719ejxx028043;
        Mon, 1 Aug 2022 18:40:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 2719ejxx028043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659346849;
        bh=7q7KNGP7/8ph5xksTlmgfiesAmDvv/CKZe58ESb/eDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbZgrAreaPkPlb/wEO3dsqk7JBzysZDCYlWDQ8kEDeyUNSM1rGjzAGNCdHzTZq5xE
         +JyzdCSgNupwcX3f4Tm1q+VRpXu2eXsFF8KQW0nfZuUfSl4dgeMr/OMXCE8ghQo3cv
         QqXKB7wsJB6qDe8zFUg5zrIznAiz/t6c4XjUo2Odu6MEArfEMmEFCaRVg0QKNEjcZ3
         OJ6qecXK4uNfQd3IMNGhgvrq8UKVuiTxQliNBkbsZKPe7t5DAjHXSnGHSEhGvMuZEJ
         DB9AQ5O1NtEFzWPcsmZCQWQi9ysA4FcsaQJKjGU67KMH058PkVRJArhuz1cHgt5gDs
         up2WdLwf8Wgvw==
X-Nifty-SrcIP: [133.106.54.139]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] modpost: remove .symbol_white_list field entirely
Date:   Mon,  1 Aug 2022 18:39:02 +0900
Message-Id: <20220801093902.1506297-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220801093902.1506297-1-masahiroy@kernel.org>
References: <20220801093902.1506297-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not so useful to have symbol whitelists in arrays. With this
over-engineering, the code is difficult to follow.

Let's do it more directly, and collect the relevant code to one place.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 55 +++++++++++++------------------------------
 1 file changed, 16 insertions(+), 39 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index bcd1319f3097..8484c0798f28 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -845,28 +845,12 @@ static const char *const init_data_sections[] =
 /* all init sections */
 static const char *const init_sections[] = { ALL_INIT_SECTIONS, NULL };
 
-/* All init and exit sections (code + data) */
-static const char *const init_exit_sections[] =
-	{ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS, NULL };
-
 /* all text sections */
 static const char *const text_sections[] = { ALL_TEXT_SECTIONS, NULL };
 
 /* data section */
 static const char *const data_sections[] = { DATA_SECTIONS, NULL };
 
-
-/* symbols in .data that may refer to init/exit sections */
-#define DEFAULT_SYMBOL_WHITE_LIST					\
-	"*driver",							\
-	"*_template", /* scsi uses *_template a lot */			\
-	"*_timer",    /* arm uses ops structures named _timer a lot */	\
-	"*_sht",      /* scsi also used *_sht to some extent */		\
-	"*_ops",							\
-	"*_probe",							\
-	"*_probe_one",							\
-	"*_console"
-
 static const char *const head_sections[] = { ".head.text*", NULL };
 static const char *const linker_symbols[] =
 	{ "__init_begin", "_sinittext", "_einittext", NULL };
@@ -898,9 +882,6 @@ enum mismatch {
  *
  * @mismatch: Type of mismatch.
  *
- * @symbol_white_list: Do not match a relocation to a symbol in this list
- * even if it is targeting a section in @bad_to_sec.
- *
  * @handler: Specific handler to call when a match is found.  If NULL,
  * default_mismatch_handler() will be called.
  *
@@ -910,7 +891,6 @@ struct sectioncheck {
 	const char *bad_tosec[20];
 	const char *good_tosec[20];
 	enum mismatch mismatch;
-	const char *symbol_white_list[20];
 	void (*handler)(const char *modname, struct elf_info *elf,
 			const struct sectioncheck* const mismatch,
 			Elf_Rela *r, Elf_Sym *sym, const char *fromsec);
@@ -935,16 +915,11 @@ static const struct sectioncheck sectioncheck[] = {
 	.fromsec = { DATA_SECTIONS, NULL },
 	.bad_tosec = { ALL_XXXINIT_SECTIONS, NULL },
 	.mismatch = DATA_TO_ANY_INIT,
-	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
 },
 {
 	.fromsec = { DATA_SECTIONS, NULL },
 	.bad_tosec = { INIT_SECTIONS, NULL },
 	.mismatch = DATA_TO_ANY_INIT,
-	.symbol_white_list = {
-		"*_template", "*_timer", "*_sht", "*_ops",
-		"*_probe", "*_probe_one", "*_console", NULL
-	},
 },
 {
 	.fromsec = { TEXT_SECTIONS, NULL },
@@ -955,7 +930,6 @@ static const struct sectioncheck sectioncheck[] = {
 	.fromsec = { DATA_SECTIONS, NULL },
 	.bad_tosec = { ALL_EXIT_SECTIONS, NULL },
 	.mismatch = DATA_TO_ANY_EXIT,
-	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
 },
 /* Do not reference init code/data from meminit code/data */
 {
@@ -1051,15 +1025,6 @@ static const struct sectioncheck *section_mismatch(
  *   fromsec = .data*
  *   atsym   = __param_ops_*
  *
- * Pattern 2:
- *   Many drivers utilise a *driver container with references to
- *   add, remove, probe functions etc.
- *   the pattern is identified by:
- *   tosec   = init or exit section
- *   fromsec = data section
- *   atsym = *driver, *_template, *_sht, *_ops, *_probe,
- *           *probe_one, *_console, *_timer
- *
  * Pattern 3:
  *   Whitelist all references from .head.text to any init section
  *
@@ -1108,10 +1073,22 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 	    strstarts(fromsym, "__param_ops_"))
 		return 0;
 
-	/* Check for pattern 2 */
-	if (match(tosec, init_exit_sections) &&
-	    match(fromsec, data_sections) &&
-	    match(fromsym, mismatch->symbol_white_list))
+	/* symbols in data sections that may refer to any init/exit sections */
+	if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
+	    match(tosec, PATTERNS(ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS)) &&
+	    match(fromsym, PATTERNS("*_template", // scsi uses *_template a lot
+				    "*_timer", // arm uses ops structures named _timer a lot
+				    "*_sht", // scsi also used *_sht to some extent
+				    "*_ops",
+				    "*_probe",
+				    "*_probe_one",
+				    "*_console")))
+		return 0;
+
+	/* symbols in data sections that may refer to meminit/exit sections */
+	if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
+	    match(tosec, PATTERNS(ALL_XXXINIT_SECTIONS, ALL_EXIT_SECTIONS)) &&
+	    match(fromsym, PATTERNS("*driver")))
 		return 0;
 
 	/* Check for pattern 3 */
-- 
2.34.1

