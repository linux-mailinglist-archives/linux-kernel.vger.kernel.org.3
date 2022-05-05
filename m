Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9B51B6C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241966AbiEED5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiEED5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:57:06 -0400
X-Greylist: delayed 29375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 20:53:27 PDT
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657F863A2;
        Wed,  4 May 2022 20:53:27 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2453qiRF021346;
        Thu, 5 May 2022 12:52:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2453qiRF021346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651722765;
        bh=Xp/Il9izgFFUGGxMDiJyqVoFfLzqSe5l32yd/T521y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VY6oS+YVRhjSqtwoy042ugda75ysUAUIojehflDfnYTlp0JXZa0/elFOosRxjN67y
         JB6wRXlIL+0hEDv6YYMKMHwOFokVvVyV1HCmyvZG2wfz88aw6fNnFR6bHU1cgndSjK
         FOX57Bxocv6ly6biNS23x+aHpiucHsoBUqjqzKb37LTSf97G4CpZ7nJ+qTF7G4diCO
         uBEy1qIfBSutBrP70b58TsC5abSyO8ZEM1ZyCLx687ET9MztvtdnA7lDENDmAcQWxV
         uTJW+1HnxjlmM3hY53g0j96oH3R0NV5dL+q3Btg4qnTiqd7GlYyAr06XqJoG4xGkan
         QPzClrr4Kkqdg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 1/3] module: do not pass opaque pointer for symbol search
Date:   Thu,  5 May 2022 12:52:10 +0900
Message-Id: <20220505035212.1130858-2-masahiroy@kernel.org>
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

There is no need to use an opaque pointer for check_exported_symbol()
or find_exported_symbol_in_section.

Pass (struct find_symbol_arg *) explicitly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/module/main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index fe44d46c378b..28ece86d99dc 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -244,11 +244,9 @@ static __maybe_unused void *any_section_objs(const struct load_info *info,
 #endif
 
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
@@ -285,16 +283,15 @@ int cmp_name(const void *name, const void *sym)
 
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

