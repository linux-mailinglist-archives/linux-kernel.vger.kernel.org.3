Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E1050D4A3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiDXTOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiDXTNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:45 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18D52BFF;
        Sun, 24 Apr 2022 12:10:11 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o65019069;
        Mon, 25 Apr 2022 04:08:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o65019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827338;
        bh=/nbXjb/Czq1uEAA6RFwh8w4kvV4PZw95/VO0fgvQkv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IbeFnOqKEkGJuATuFubsF4GIacp0Rt5p1Bqls1YAKeRyu8nBpdcPTUDF+8HKZ7TXE
         OGR85yXfNMTmVzbOdF4+IRd1E9rdN0LM+9bbmI1SyhhtqVqmrZe2f7k7JZYqkIFYEd
         Jk50DaHMYVKBio5e5+wXT6BjKAOhpkJVKuprUWApyB5aEOJIiOwtMkqTcRNFA2LOub
         PeztkKwX4opZoIjYX7BFG98OKm8tjh9NESZkqvdXWFxEtoe00ft+7mzv7LdY3sH2OC
         ke8Wi47vKsF2vms7l3kVNM8rT+u45BVdsqS1oiXD7ttfLzMImqDG2Uf5yQ6LM9yzKY
         zgUOgKfU3geAQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 11/27] modpost: use doubly linked list for dump_lists
Date:   Mon, 25 Apr 2022 04:07:55 +0900
Message-Id: <20220424190811.1678416-12-masahiroy@kernel.org>
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

This looks easier to understand (just because this is a pattern in
the kernel code). No functional change is intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index e1eb188d6282..4c074d6c1721 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2496,7 +2496,7 @@ static void write_namespace_deps_files(const char *fname)
 }
 
 struct dump_list {
-	struct dump_list *next;
+	struct list_head list;
 	const char *file;
 };
 
@@ -2508,8 +2508,8 @@ int main(int argc, char **argv)
 	char *dump_write = NULL, *files_source = NULL;
 	int opt;
 	int n;
-	struct dump_list *dump_read_start = NULL;
-	struct dump_list **dump_read_iter = &dump_read_start;
+	LIST_HEAD(dump_lists);
+	struct dump_list *dl, *dl2;
 
 	while ((opt = getopt(argc, argv, "ei:mnT:o:awENd:")) != -1) {
 		switch (opt) {
@@ -2517,10 +2517,9 @@ int main(int argc, char **argv)
 			external_module = true;
 			break;
 		case 'i':
-			*dump_read_iter =
-				NOFAIL(calloc(1, sizeof(**dump_read_iter)));
-			(*dump_read_iter)->file = optarg;
-			dump_read_iter = &(*dump_read_iter)->next;
+			dl = NOFAIL(malloc(sizeof(*dl)));
+			dl->file = optarg;
+			list_add_tail(&dl->list, &dump_lists);
 			break;
 		case 'm':
 			modversions = true;
@@ -2554,13 +2553,10 @@ int main(int argc, char **argv)
 		}
 	}
 
-	while (dump_read_start) {
-		struct dump_list *tmp;
-
-		read_dump(dump_read_start->file);
-		tmp = dump_read_start->next;
-		free(dump_read_start);
-		dump_read_start = tmp;
+	list_for_each_entry_safe(dl, dl2, &dump_lists, list) {
+		read_dump(dl->file);
+		list_del(&dl->list);
+		free(dl);
 	}
 
 	while (optind < argc)
-- 
2.32.0

