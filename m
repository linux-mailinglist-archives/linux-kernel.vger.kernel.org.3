Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562D651B6C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbiEED5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiEED5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:57:07 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEDFB7C0;
        Wed,  4 May 2022 20:53:27 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2453qiRG021346;
        Thu, 5 May 2022 12:52:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2453qiRG021346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651722766;
        bh=Ucyg107RFa+06vZD++CcuYxSjjefwnfQNS/0NyIzQIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDIoxuNtXpepdbpzi5Z7MHUW865iucz9GQYpLQS2CZ1upBYd/EGLOdXL+IZFspXZY
         5kJSySkgstLpH/LcspuJwA6nx6LmAZp8yTg6HOpnEAiC1s0UYZGXQNrAQN26PvGXwc
         iu/jwS2BoJfA4NDck0geugmn5V9QOxjCFQsaagT4pVtoSd3RuiI27IlmOE8HjR6VYP
         fY8+742PWFg2VXeDiy12jFfYXUjmpnSfv9+5vwwBDV7nFvD56e6ZU5SK4PEDTvBvyL
         AvInFzB82DrGPAj03o99b1g7vssaV4jObEkFIpxnwi1CUf2QwbJm/NNKX47w5qvl8q
         gsoT9TBwurGog==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/3] module: do not binary-search in __ksymtab_gpl if fsa->gplok is false
Date:   Thu,  5 May 2022 12:52:11 +0900
Message-Id: <20220505035212.1130858-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505035212.1130858-1-masahiroy@kernel.org>
References: <20220505035212.1130858-1-masahiroy@kernel.org>
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

Currently, !fsa->gplok && syms->license == GPL_ONLY) is checked after
bsearch() succeeds.

It is meaningless to do the binary search in the GPL symbol table when
fsa->gplok is false because we know find_exported_symbol_in_section()
will fail anyway.

This check should be done before bsearch().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/module/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 28ece86d99dc..22a860d42c16 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -247,8 +247,6 @@ static bool check_exported_symbol(const struct symsearch *syms,
 				  struct module *owner, unsigned int symnum,
 				  struct find_symbol_arg *fsa)
 {
-	if (!fsa->gplok && syms->license == GPL_ONLY)
-		return false;
 	fsa->owner = owner;
 	fsa->crc = symversion(syms->crcs, symnum);
 	fsa->sym = &syms->start[symnum];
@@ -287,6 +285,9 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 {
 	struct kernel_symbol *sym;
 
+	if (!fsa->gplok && syms->license == GPL_ONLY)
+		return false;
+
 	sym = bsearch(fsa->name, syms->start, syms->stop - syms->start,
 			sizeof(struct kernel_symbol), cmp_name);
 
-- 
2.32.0

