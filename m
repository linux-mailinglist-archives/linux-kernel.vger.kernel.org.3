Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F7C546C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347842AbiFJSew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349791AbiFJSeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:34:37 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3FF3A1A3;
        Fri, 10 Jun 2022 11:34:35 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25AIX5TM020882;
        Sat, 11 Jun 2022 03:33:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25AIX5TM020882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654885987;
        bh=dWrkbZ/zCsAQbt1ylsfirph76FCDu7eUxy+/dh5/pjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKhRJEaK3gX99ziov/rjxAhmo76ZnId9lzn3GpSIVc9AK8OtHMiqQlPqRY40Pll4s
         wPGEtZv/GV70FNdJiqwh3lmynNvSm0E9xw0JWIqYuZ5G/Nitx5ImpaWkpMy/SNwCuu
         fgIptFOsTMpS7zg0mm5qo19VSDSOLLICqmTAz6eJ/TKufDm1ReBHEh4Ks4qMtgfRKb
         +lVoSCyxyjesKMHD760+vQ7DQ8tz4LkG5iQsoUaCcPn4vSIfndOU3RN9u/kLRy9R/3
         NsCKJl97GxHzhgDQF7Sv3Oj9zAW8OtcQVEieSvGoP32j2EOJs9sFsE8tYvwF4zgWDY
         N7ouJ1/AOlGFg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alessio Igor Bogani <abogani@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] modpost: fix section mismatch check for exported init/exit sections
Date:   Sat, 11 Jun 2022 03:32:30 +0900
Message-Id: <20220610183236.1272216-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220610183236.1272216-1-masahiroy@kernel.org>
References: <20220610183236.1272216-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f02e8a6596b7 ("module: Sort exported symbols"),
EXPORT_SYMBOL* is placed in the individual section ___ksymtab(_gpl)+<sym>
(3 leading underscores instead of 2).

Since then, modpost cannot detect the bad combination of EXPORT_SYMBOL
and __init/__exit.

Fix the .fromsec field.

Fixes: f02e8a6596b7 ("module: Sort exported symbols")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29d5a841e215..620dc8c4c814 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -980,7 +980,7 @@ static const struct sectioncheck sectioncheck[] = {
 },
 /* Do not export init/exit functions or data */
 {
-	.fromsec = { "__ksymtab*", NULL },
+	.fromsec = { "___ksymtab*", NULL },
 	.bad_tosec = { INIT_SECTIONS, EXIT_SECTIONS, NULL },
 	.mismatch = EXPORT_TO_INIT_EXIT,
 	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
-- 
2.32.0

