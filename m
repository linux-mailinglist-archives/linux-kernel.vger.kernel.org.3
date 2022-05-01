Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3CC516318
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbiEAIpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245728AbiEAIpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:49 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6A4C436;
        Sun,  1 May 2022 01:42:23 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rs008518;
        Sun, 1 May 2022 17:41:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rs008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394467;
        bh=FFW9sKvnu4NAWgWIhO9D6G572ZjYeQXXbdgfp5F87U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwOCqMhd6ZzOkYx3XgP/GkJ4LQM+Z7+/qlDxP1UHQgPO0mHTq5tXAd7DKkp1Jv9Hi
         RZqv4oyI1eEGeQFGXgp6aH0+EEgv6ln5kR76pK3rwNhJwo+Ehd0DITVmyp6wtOUpoK
         +5oNtd4r3Xp893hpwEAL7M+iJrfQgXSbdUeFKhsu0vsR+zePmMBLr4ZFpdXMTQs7cG
         RD7G58IyjPozQUBclG2k/tM87m/f1RtWmDe0rxsOdoahyeXvnHSRkmjzSy111XF0K7
         zXGpHFNJB0LkmsdkLRLS8GL75dYYcRZOfUQxE/1znaWamuW2PhAXAD2cfKcPHRCkwq
         4YdY8h9K0V4EQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 07/26] modpost: use doubly linked list for dump_lists
Date:   Sun,  1 May 2022 17:40:13 +0900
Message-Id: <20220501084032.1025918-8-masahiroy@kernel.org>
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

This looks easier to understand (just because this is a pattern in
the kernel code). No functional change is intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v1)

 scripts/mod/modpost.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c7dda4cfa497..5e99493b0a82 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2505,7 +2505,7 @@ static void write_namespace_deps_files(const char *fname)
 }
 
 struct dump_list {
-	struct dump_list *next;
+	struct list_head list;
 	const char *file;
 };
 
@@ -2517,8 +2517,8 @@ int main(int argc, char **argv)
 	char *dump_write = NULL, *files_source = NULL;
 	int opt;
 	int n;
-	struct dump_list *dump_read_start = NULL;
-	struct dump_list **dump_read_iter = &dump_read_start;
+	LIST_HEAD(dump_lists);
+	struct dump_list *dl, *dl2;
 
 	while ((opt = getopt(argc, argv, "ei:mnT:o:awENd:")) != -1) {
 		switch (opt) {
@@ -2526,10 +2526,9 @@ int main(int argc, char **argv)
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
@@ -2563,13 +2562,10 @@ int main(int argc, char **argv)
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

