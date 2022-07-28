Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5F583768
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiG1DRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiG1DRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:17:51 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A439310C5;
        Wed, 27 Jul 2022 20:17:49 -0700 (PDT)
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 26S3GWoJ002867;
        Thu, 28 Jul 2022 12:16:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 26S3GWoJ002867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658978193;
        bh=RYkKgpGc0xvZ84PUQwSu4qoomjBRQz+D5mvuwNjwuJw=;
        h=From:To:Cc:Subject:Date:From;
        b=bAgqnrzwPXzw8tFPySIxsAxax3DySTRS8VglEvwkqGMzPboHHWBbJr5dBbcYwCBZJ
         wDvaxPp4f3c8ALHby1xD6bQYC6rQo7dKBu7cZNHxG4TqmH2zvizDoixvI5NuPgK/ph
         t98ws0B4UGEEV+yyEBNl7Ef4g3su2FqCAxM7U81IiqkdJ3vPotXW7z+kCRrTQH0d8I
         s9IZQ5ebPLXkmscfyjkrf7/vhrTrR6pps5kLXHvHl9dS1N+5YEs8Rvm6UQNAgdDrzR
         HMLtVT2eHVbLnDvU6B9zXOaRC+JLHexQDa3+bn+PERdwRfGidNXVWDzDM8KB5qRjhy
         +clNRQjDKf9YQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     David Laight <David.Laight@aculab.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: set EXIT trap before creating temporary directory
Date:   Thu, 28 Jul 2022 12:14:33 +0900
Message-Id: <20220728031433.1077354-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Swap the order of 'mkdir' and 'trap' just in case the subshell is
interrupted between 'mkdir' and 'trap' although the effect might be
subtle.

Please not this is not a perfect solution to avoid the left-over tmp
directory. There are more cases that miss to remove the tmp directory,
for example:

 - When interrupted, dash does not invoke the EXIT trap (bash does)

 - 'rm' command might be interrupted before removing the directory

I am not addressing all the cases since the tmp directory is harmless
after all.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Kconfig.include   | 2 +-
 scripts/Makefile.compiler | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index c1f4222d223d..a0ccceb22cf8 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -25,7 +25,7 @@ failure = $(if-success,$(1),n,y)
 
 # $(cc-option,<flag>)
 # Return y if the compiler supports <flag>, n otherwise
-cc-option = $(success,mkdir .tmp_$$; trap "rm -rf .tmp_$$" EXIT; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
+cc-option = $(success,trap "rm -rf .tmp_$$" EXIT; mkdir .tmp_$$; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
 
 # $(ld-option,<flag>)
 # Return y if the linker supports <flag>, n otherwise
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 86ecd2ac874c..94d0d40cddb3 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -21,8 +21,8 @@ TMPOUT = $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$
 # automatically cleaned up.
 try-run = $(shell set -e;		\
 	TMP=$(TMPOUT)/tmp;		\
-	mkdir -p $(TMPOUT);		\
 	trap "rm -rf $(TMPOUT)" EXIT;	\
+	mkdir -p $(TMPOUT);		\
 	if ($(1)) >/dev/null 2>&1;	\
 	then echo "$(2)";		\
 	else echo "$(3)";		\
-- 
2.34.1

