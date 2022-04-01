Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984F84EF7DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbiDAQ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiDAQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:27:26 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEEB164D0D;
        Fri,  1 Apr 2022 08:57:03 -0700 (PDT)
Received: from grover.RMN.KIBA.LAB.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 231FuN80009424;
        Sat, 2 Apr 2022 00:56:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 231FuN80009424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648828584;
        bh=PlEZwHX2+oLbHS/OqLyTr6a9Ci0j5vWgM7qqdsKDhzc=;
        h=From:To:Cc:Subject:Date:From;
        b=ow5IqK3pQ4IJMKql6ksgcJN7wkIsnA8Ups89tDhP45d4FRq/wJYky4S59luOnrIgh
         9QaoBMD24OLkzdraqnKEMq+Uyp+A23zYu2Zry4/sWh+suZXE1zQ4UTgbbhfVqgWn8d
         YhuNF/nyk2lOPdyy+bf2vhGasY17nawl83qc3PJAFYIa1g2jNTFHo7RADGf1gdUKBr
         wQat478uKPxbQwzKblmIQQB4ZdPyNE0IO+lQBakoRmxZVEUSImFOQrONZwghU+oy0D
         9r3ycCufKlv82DQUvFc0FQCbBHW+Kw7B+CFfoAe6c+tJEs1G+RWoQ5FXk00/JMnaQh
         UaHlWLnQ71oRQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] modpost: restore the warning message for missing symbol versions
Date:   Sat,  2 Apr 2022 00:56:10 +0900
Message-Id: <20220401155610.1280262-1-masahiroy@kernel.org>
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

This log message was accidentally chopped off.

I was wondering why this happened, but checking the ML log, Mark
precisely followed my suggestion [1].

I just used "..." because I was too lazy to type the sentence fully.
Sorry for the confusion.

[1]: https://lore.kernel.org/all/CAK7LNAR6bXXk9-ZzZYpTqzFqdYbQsZHmiWspu27rtsFxvfRuVA@mail.gmail.com/

Fixes: 4a6795933a89 ("kbuild: modpost: Explicitly warn about unprototyped symbols")
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d10f93aac1c8..ed9d056d2108 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -674,7 +674,7 @@ static void handle_modversion(const struct module *mod,
 	unsigned int crc;
 
 	if (sym->st_shndx == SHN_UNDEF) {
-		warn("EXPORT symbol \"%s\" [%s%s] version ...\n"
+		warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n"
 		     "Is \"%s\" prototyped in <asm/asm-prototypes.h>?\n",
 		     symname, mod->name, mod->is_vmlinux ? "" : ".ko",
 		     symname);
-- 
2.32.0

