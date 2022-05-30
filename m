Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBFB537AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiE3Mzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiE3Mz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:55:26 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B1814AE;
        Mon, 30 May 2022 05:55:25 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24UCs1Mo014963;
        Mon, 30 May 2022 21:54:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24UCs1Mo014963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653915242;
        bh=nFbsi2wc8vRk4e83EcKIAfJNJNh7XZcOJOriZZ5YswY=;
        h=From:To:Cc:Subject:Date:From;
        b=WKHqdJC2YlZLG5PQK6TBY7pTdkefEp/44KaN2lxwhgRJVv/h2As7D6lQ9h2lFZDVg
         mekXWbWnQfgxacjwk3hx24M3QkIyqQkJSlHqHuL96QNW/oTcSBGaF9puMk7f35J3FE
         mSfqJ52XOMTrlfpddH+YuU797GBnNeNqpHEVDWt06NucHHTM1WrfFKjGNeSsdAnkVm
         faBZy/r1UX+ICaCJdzSfwKhu+8JxzcLK/BcRaGcWyfwr98rPT/5AhO5UqNktVdWpuO
         TkXVPT9f1KnTlXftcYxPamtk7D3sANxtpaLNYcxW5F2o4KgyTF+JN5C8VgDxesg6x3
         D/8xbBwgk0V+g==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alessio Igor Bogani <abogani@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] modpost: fix section mismatch check for exported init/exit sections
Date:   Mon, 30 May 2022 21:52:58 +0900
Message-Id: <20220530125258.3149370-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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

Since commit f02e8a6596b7 ("module: Sort exported symbols"),
EXPORT_SYMBOL is placed in the individual section ___ksymtab(_gpl)+<sym>
(3 leading underscores, not 2).

Since then, modpost cannot detect the bad combination of EXPORT_SYMBOL
and __init/__exit.

Fix the .fromsec to ___ksymtab*.

Fixes: f02e8a6596b7 ("module: Sort exported symbols")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
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

