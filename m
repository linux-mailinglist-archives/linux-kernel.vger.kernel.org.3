Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497DE51AE39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377672AbiEDTrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377615AbiEDTrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:47:33 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFC64E3A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:43:55 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 244JhL7n001234;
        Thu, 5 May 2022 04:43:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 244JhL7n001234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651693403;
        bh=w4C7GITZYrtU5qB494mOB6XmSgN1m8R6tiEfRuraIfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwM5SnP/wA1ExO6evdZcg+Z1du3s/S9auQ+Mz+ZwzhVymGUmVapkiar6soeOiJacK
         7U6XPBZXw4RoYb8Ynp0P5Zo+gzrBTWekW2FtwY80c7C0qPAHMuTy8sB3Bl/AlGL0G1
         W8xuNtAJVxZqDHuVbQBQZ/0rPf3nIVyfnG8Wl2EAcmNCuVsTYKVRBfHOd03vKdoVly
         NUfDPV37sERTpFgz+3yFem5fdQoAvnH21VajAVsh0bYY/+HTguZ7BCiEVkTtvZOpME
         J+Ht/z49DsTsdFaLDAUhNe82xe5v4mLyHxPJGB32KzSttu3vxkvieovoL/P8mL1ssp
         WCsJe5/Diutvw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] module: merge check_exported_symbol() into find_exported_symbol_in_section()
Date:   Thu,  5 May 2022 04:42:45 +0900
Message-Id: <20220504194245.1088063-4-masahiroy@kernel.org>
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

Now check_exported_symbol() always succeeds.

Merge it into find_exported_symbol_in_search() to make the code concise.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/module.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 4380ceb825b9..6b2afce80c32 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -444,17 +444,6 @@ struct find_symbol_arg {
 	enum mod_license license;
 };
 
-static bool check_exported_symbol(const struct symsearch *syms,
-				  struct module *owner, unsigned int symnum,
-				  struct find_symbol_arg *fsa)
-{
-	fsa->owner = owner;
-	fsa->crc = symversion(syms->crcs, symnum);
-	fsa->sym = &syms->start[symnum];
-	fsa->license = syms->license;
-	return true;
-}
-
 static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
 {
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
@@ -500,12 +489,15 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 
 	sym = bsearch(fsa->name, syms->start, syms->stop - syms->start,
 			sizeof(struct kernel_symbol), cmp_name);
+	if (!sym)
+		return false;
 
-	if (sym != NULL && check_exported_symbol(syms, owner,
-						 sym - syms->start, fsa))
-		return true;
+	fsa->owner = owner;
+	fsa->crc = symversion(syms->crcs, sym - syms->start);
+	fsa->sym = sym;
+	fsa->license = syms->license;
 
-	return false;
+	return true;
 }
 
 /*
-- 
2.32.0

