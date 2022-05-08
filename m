Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6387E51F085
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiEHTXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiEHTPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:15:50 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E8112ACE;
        Sun,  8 May 2022 12:11:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 248J8qSV030019;
        Mon, 9 May 2022 04:09:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 248J8qSV030019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652036942;
        bh=/sRpYst46mRgR25HUnoY09SDWVnwLpOXCqbbaE612Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgFPAVSKpYsuoxbPBWHKsYM4QCQlc7cMQi7+Veh2NrVu+CEJx53scUtGfz8suHjay
         Sd+xk24KQzFBWXDaOCvr9/EZ1zfKS9YXeaMdiGqXBq9aPRfXPBMrx3F0h1ZjKuR74k
         x0x2pJf7gTiDWVRGSXGue4aw+NJBZrhN8EKONQXUNxKT7RbSh74w36vrsxflOzK/0F
         i+7nbTbLiXofc+Dw92B5WMAxi8w40n/xid56DOYmWXIW+D/dOH07rThUbMAAh2HjWm
         yjvs2KLCp021RyVXvkreBz+VP1NBfURCPeJbtxYCWw3scy+rh4hZSkwYUTSNnzbkNe
         gbNjn24SIiZgg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 08/14] genksyms: adjust the output format to modpost
Date:   Mon,  9 May 2022 04:06:25 +0900
Message-Id: <20220508190631.2386038-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220508190631.2386038-1-masahiroy@kernel.org>
References: <20220508190631.2386038-1-masahiroy@kernel.org>
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

Make genksyms output symbol versions in the format modpost expects,
so the 'sed' is unneeded.

This commit makes *.symversions completely unneeded.

I will keep *.symversions in .gitignore and 'make clean' for a while.
Otherwise, 'git status' might be surprising.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v2)

Changes in v2:
  - New patch

 scripts/Makefile.build      | 6 ------
 scripts/genksyms/genksyms.c | 3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index dff9220135c4..461998a2ad2b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -165,16 +165,10 @@ ifdef CONFIG_MODVERSIONS
 # o modpost will extract versions from that file and create *.c files that will
 #   be compiled and linked to the kernel and/or modules.
 
-genksyms_format := __crc_\(.*\) = \(.*\);
-
 gen_symversions =								\
 	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
 		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
-		    > $@.symversions;						\
-		sed -n 's/$(genksyms_format)/$(pound)SYMVER \1 \2/p' $@.symversions \
 			>> $(dot-target).cmd;					\
-	else									\
-		rm -f $@.symversions;						\
 	fi
 
 cmd_gen_symversions_c =	$(call gen_symversions,c)
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 6e6933ae7911..f5dfdb9d80e9 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -680,8 +680,7 @@ void export_symbol(const char *name)
 		if (flag_dump_defs)
 			fputs(">\n", debugfile);
 
-		/* Used as a linker script. */
-		printf("__crc_%s = 0x%08lx;\n", name, crc);
+		printf("#SYMVER %s 0x%08lx\n", name, crc);
 	}
 }
 
-- 
2.32.0

