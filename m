Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC59651AE36
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377646AbiEDTrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377664AbiEDTrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:47:33 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926D04E3A2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:43:53 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 244JhL7m001234;
        Thu, 5 May 2022 04:43:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 244JhL7m001234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651693403;
        bh=98mPeoJXI1ySCwQ5M2g+AhZXZflDUK/pAReyjjvyXS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APhVXgF3SPVf2PKJIsbMAnePRT0JFQ2ntS+b1lbf9Y9GPRqtq5tz68oC8TXQm7GCt
         CUkt0QDH6qiCGxvc/2E1aStctEyNr5SLnKV26bYnmHGovbUXR6u8B3pmxnotzcznwP
         GiuE8DkbGw92F1gDUHbTlVoWD5GH2jl+4tX0J9Am9pcxQA89OIQJXVlWAOlMC1gEJq
         HtgCPU0S97XspvLGj9H1OPb2Dp1tD8WrFbBg4n7uxxjwU2QZs5lEIAjgqc83BUEllt
         YnJd5YpvxmVMQcULTIIe66kwNN1syEb0IsbqZFK/ehABvsnv2uKdBb13VwNpcz6mfr
         NlFizDg3/HLTw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] module: do not binary-search in __ksymtab_gpl if fsa->gplok is false
Date:   Thu,  5 May 2022 04:42:44 +0900
Message-Id: <20220504194245.1088063-3-masahiroy@kernel.org>
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

Currently, !fsa->gplok && syms->license == GPL_ONLY) is checked after
bsearch() succeeds.

It is meaningless to do the binary search in the GPL symbol table when
fsa->gplok is false because we know find_exported_symbol_in_section()
will fail anyway.

This check should be done before bsearch().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/module.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index d57beb6b4eee..4380ceb825b9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -448,8 +448,6 @@ static bool check_exported_symbol(const struct symsearch *syms,
 				  struct module *owner, unsigned int symnum,
 				  struct find_symbol_arg *fsa)
 {
-	if (!fsa->gplok && syms->license == GPL_ONLY)
-		return false;
 	fsa->owner = owner;
 	fsa->crc = symversion(syms->crcs, symnum);
 	fsa->sym = &syms->start[symnum];
@@ -497,6 +495,9 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 {
 	struct kernel_symbol *sym;
 
+	if (!fsa->gplok && syms->license == GPL_ONLY)
+		return false;
+
 	sym = bsearch(fsa->name, syms->start, syms->stop - syms->start,
 			sizeof(struct kernel_symbol), cmp_name);
 
-- 
2.32.0

