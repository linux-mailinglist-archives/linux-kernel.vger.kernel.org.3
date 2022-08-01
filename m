Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9055E5866F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiHAJmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiHAJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:41:58 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF1637190;
        Mon,  1 Aug 2022 02:41:57 -0700 (PDT)
Received: from grover.sesame ([133.106.54.139]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 2719ejxw028043;
        Mon, 1 Aug 2022 18:40:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 2719ejxw028043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659346848;
        bh=sokvB66jq6RlLMRXgxzMH4QnY0MotEdE/iLkg2kNMeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hn+g+asXygjYkm9rmiczoNmzPNMu0vdT94Re/FMw5TNsTeJDHhRBJSfs7TX6QbLKE
         PIaqdZOo5R0rTRK3rGO64MslrBxXACsEI1WWAlTZc6SzymIYWaz1gbcZSkJHHIT7Wb
         B8VkUBPF9YuKRKv2a+AffY5HVFtrtuRw5Au9N2XP+6LrUddVVK6CnnPGp47owpZQuG
         lv5Tvm21D6vzgLBBFe0cm7fBq+byG3SV8TtRtNgHbcbEfpSnjSENPsKfl5RV8VyWhM
         kg7S7VxPW/ODLKB34yOThycf2V14R6E8+DXpo7Ngb85daC7390i+WW3XEnTI/7RK+J
         qLe2+LdWFapvQ==
X-Nifty-SrcIP: [133.106.54.139]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] modpost: remove unneeded .symbol_white_list initializers
Date:   Mon,  1 Aug 2022 18:39:01 +0900
Message-Id: <20220801093902.1506297-3-masahiroy@kernel.org>
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

The ->symbol_white_list field is referenced in secref_whitelist(),
only when 'fromsec' is data_sections.

        /* Check for pattern 2 */
        if (match(tosec, init_exit_sections) &&
            match(fromsec, data_sections) &&
            match(fromsym, mismatch->symbol_white_list))
                return 0;

If .fromsec is not data sections, the .symbol_white_list member is
not used by anyone.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c2949a1a0d5e..bcd1319f3097 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -930,7 +930,6 @@ static const struct sectioncheck sectioncheck[] = {
 	.fromsec = { TEXT_SECTIONS, NULL },
 	.bad_tosec = { ALL_INIT_SECTIONS, NULL },
 	.mismatch = TEXT_TO_ANY_INIT,
-	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
 },
 {
 	.fromsec = { DATA_SECTIONS, NULL },
@@ -951,7 +950,6 @@ static const struct sectioncheck sectioncheck[] = {
 	.fromsec = { TEXT_SECTIONS, NULL },
 	.bad_tosec = { ALL_EXIT_SECTIONS, NULL },
 	.mismatch = TEXT_TO_ANY_EXIT,
-	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
 },
 {
 	.fromsec = { DATA_SECTIONS, NULL },
@@ -964,41 +962,35 @@ static const struct sectioncheck sectioncheck[] = {
 	.fromsec = { ALL_XXXINIT_SECTIONS, NULL },
 	.bad_tosec = { INIT_SECTIONS, NULL },
 	.mismatch = XXXINIT_TO_SOME_INIT,
-	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
 },
 /* Do not reference exit code/data from memexit code/data */
 {
 	.fromsec = { ALL_XXXEXIT_SECTIONS, NULL },
 	.bad_tosec = { EXIT_SECTIONS, NULL },
 	.mismatch = XXXEXIT_TO_SOME_EXIT,
-	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
 },
 /* Do not use exit code/data from init code */
 {
 	.fromsec = { ALL_INIT_SECTIONS, NULL },
 	.bad_tosec = { ALL_EXIT_SECTIONS, NULL },
 	.mismatch = ANY_INIT_TO_ANY_EXIT,
-	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
 },
 /* Do not use init code/data from exit code */
 {
 	.fromsec = { ALL_EXIT_SECTIONS, NULL },
 	.bad_tosec = { ALL_INIT_SECTIONS, NULL },
 	.mismatch = ANY_EXIT_TO_ANY_INIT,
-	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
 },
 {
 	.fromsec = { ALL_PCI_INIT_SECTIONS, NULL },
 	.bad_tosec = { INIT_SECTIONS, NULL },
 	.mismatch = ANY_INIT_TO_ANY_EXIT,
-	.symbol_white_list = { NULL },
 },
 /* Do not export init/exit functions or data */
 {
 	.fromsec = { "___ksymtab*", NULL },
 	.bad_tosec = { INIT_SECTIONS, EXIT_SECTIONS, NULL },
 	.mismatch = EXPORT_TO_INIT_EXIT,
-	.symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
 },
 {
 	.fromsec = { "__ex_table", NULL },
-- 
2.34.1

