Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1551AE34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377624AbiEDTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377663AbiEDTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:47:32 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A24DF78
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:43:52 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 244JhL7l001234;
        Thu, 5 May 2022 04:43:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 244JhL7l001234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651693402;
        bh=gyFunNMph3GVNXUoKHHdnuMJ0Tsbpe5rKrwy1jeRjFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOXAoGQ/oFsI1rqvci6zpTr4wE0/NeUOhggVqXp1QpMkb3R7jAY6pO4rcqOG8K2sv
         vT7vmu73p78SRaqUC+bpwIqDqB5PQxUc8o10jGLn18EQiCmJRj0DwNMSkjexKZ2KMs
         we7jYsaxQZYdspcvReR7RtjaYnXQptAPvJNQsV8pdT/S+yJcorywZr7obGJlUvMglx
         Q+I0lr9/sQzXbHxfu5RZhvFzHxXbOkR1wmgjARAvEqV0gHGbmg9UMkevrJfz3oqtFp
         iF5noZdfWjWiFxrt1bdY+G5pIgXAJcl6fXjVKXBYwZAi47A/pLpMTp3xVh0COALycn
         nLc2gYYGFtdlQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] module: do not pass opaque pointer for symbol search
Date:   Thu,  5 May 2022 04:42:43 +0900
Message-Id: <20220504194245.1088063-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504194245.1088063-1-masahiroy@kernel.org>
References: <20220504194245.1088063-1-masahiroy@kernel.org>
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

There is no need to use an opaque pointer for check_exported_symbol()
or find_exported_symbol_in_section.

Pass (struct find_symbol_arg *) explicitly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/module.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index c9e2342da28e..d57beb6b4eee 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -445,11 +445,9 @@ struct find_symbol_arg {
 };
 
 static bool check_exported_symbol(const struct symsearch *syms,
-				  struct module *owner,
-				  unsigned int symnum, void *data)
+				  struct module *owner, unsigned int symnum,
+				  struct find_symbol_arg *fsa)
 {
-	struct find_symbol_arg *fsa = data;
-
 	if (!fsa->gplok && syms->license == GPL_ONLY)
 		return false;
 	fsa->owner = owner;
@@ -495,16 +493,15 @@ static int cmp_name(const void *name, const void *sym)
 
 static bool find_exported_symbol_in_section(const struct symsearch *syms,
 					    struct module *owner,
-					    void *data)
+					    struct find_symbol_arg *fsa)
 {
-	struct find_symbol_arg *fsa = data;
 	struct kernel_symbol *sym;
 
 	sym = bsearch(fsa->name, syms->start, syms->stop - syms->start,
 			sizeof(struct kernel_symbol), cmp_name);
 
 	if (sym != NULL && check_exported_symbol(syms, owner,
-						 sym - syms->start, data))
+						 sym - syms->start, fsa))
 		return true;
 
 	return false;
-- 
2.32.0

