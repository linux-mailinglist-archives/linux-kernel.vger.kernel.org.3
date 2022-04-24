Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D9150D49C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbiDXTOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbiDXTNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:41 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB42729;
        Sun, 24 Apr 2022 12:10:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o5w019069;
        Mon, 25 Apr 2022 04:08:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o5w019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827334;
        bh=KYwyQDgYoSAR9k9phrqg3aahjxUmZXZsbqJH2MfzCS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uyp4MwGoBJDjkP/2Tx7a5ufNv1hfIXfxfFWpD24RG3shKp4PNMNuyn0gUxJ04cXCt
         w7JrKbwyIoiVgWcaPQcw0wXRdubB5tVi7W+WA1WjJQS3TI0WaaAKPhq8u+Tj1QsG1M
         c5MsjSXLVZCmHkkdh8Y4RJdAZ+aMJAD/QEXar1vxomOh8uxAT08Kq7ZCsGSw30I3tc
         zR5ICwRzK8H6V206x1HPjODOalphXgSBpRQ79WfNPzZ7+kwmRqRzKYf5ibTtFNqAE0
         rRRqKCkmlIl87l49XmQH/ocUDhVms/OZzB/zDh3PQK3voUPzLKu9z7Lmtae6+6ovNU
         tbOm6HGdcnO3Q==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 04/27] modpost: add a separate error for exported symbols without definition
Date:   Mon, 25 Apr 2022 04:07:48 +0900
Message-Id: <20220424190811.1678416-5-masahiroy@kernel.org>
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

It took me a while to understand the intent of "exp->module == mod".

This code goes back to 2003 (pre-git era).

The commit is not in this git repository, and might be worth a little
explanation.

You can add EXPORT_SYMBOL() with no definition in the same file (but you
need to put a declaration).

  int foo(void);
  EXPORT_SYMBOL(foo);

This is typical when EXPORT_SYMBOL() is defined in a C file, but the
actual implementation is in a separate assembly file. In old days,
EXPORT_SYMBOL() were only available in C files (but this limitation
does not exist any more).

Add a separate, clearer message if an exported symbol has no definition.
It should be an error even if KBUILD_MODPOST_WARN is given.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=2763b6bcb96e6a38a2fe31108fe5759ec5bcc80a

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c7cfeeb088f7..969a081dba62 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2147,13 +2147,18 @@ static void check_exports(struct module *mod)
 	for (s = mod->unres; s; s = s->next) {
 		const char *basename;
 		exp = find_symbol(s->name);
-		if (!exp || exp->module == mod) {
+		if (!exp) {
 			if (!s->weak && nr_unresolved++ < MAX_UNRESOLVED_REPORTS)
 				modpost_log(warn_unresolved ? LOG_WARN : LOG_ERROR,
 					    "\"%s\" [%s.ko] undefined!\n",
 					    s->name, mod->name);
 			continue;
 		}
+		if (exp->module == mod) {
+			error("\"%s\" [%s.ko] was exported without definition\n",
+			      s->name, mod->name);
+			continue;
+		}
 		basename = strrchr(mod->name, '/');
 		if (basename)
 			basename++;
-- 
2.32.0

