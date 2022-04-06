Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781944F670B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiDFR3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiDFR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:29:12 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E658729F58B;
        Wed,  6 Apr 2022 08:31:42 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 236FUcaU017647;
        Thu, 7 Apr 2022 00:30:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 236FUcaU017647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649259043;
        bh=fsZLoYvDYA+z/X7p8S2lQGOuwjtdZEozvoW3LWJLMa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XurjcWa8oxcby53NE+d9FsfU2mqkn76uHPM1ZQWoLCLgg2YMsJ73xIE5L8WCXvaIi
         iDaR5ywgppo6J1ZNmGeA5/9Vvhg1wQt81+cY5OmKHo6MFgPUeCtSALAfQi8Iv0I75I
         FJaYjttplAKtAbX38dTs8RFsz0OaIXOfSxwKde1XeZIVH7fGBNwanMbVDZ+Sjoqnd6
         54DIjfJTnyQW8yMzufLTCzBu5jEGCQhZ88+yzSYHk33LKaQjRmwTEnyzOfSFMvASOP
         7KGHP7oDq0N8KQXdug12K4Rp00ahfQS1/Z0j00N/OK6kIpLZINWzzlUVVNEZKJ3l4D
         0LyBeQ1oXkGnw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 5/7] kbuild: get rid of duplication in *.mod files
Date:   Thu,  7 Apr 2022 00:30:21 +0900
Message-Id: <20220406153023.500847-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220406153023.500847-1-masahiroy@kernel.org>
References: <20220406153023.500847-1-masahiroy@kernel.org>
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

It is allowed to add the same objects multiple times to obj-y / obj-m:

  obj-y += foo.o foo.o foo.o
  obj-m += bar.o bar.o bar.o

It is also allowed to add the same objects multiple times to a composite
module:

  obj-m    += foo.o
  foo-objs := foo1.o foo2.o foo2.o foo1.o

This flexibility is useful because the same object might be selected by
different CONFIG options, like this:

  obj-m               += foo.o
  foo-y               := foo1.o
  foo-$(CONFIG_FOO_X) += foo2.o
  foo-$(CONFIG_FOO_Y) += foo2.o

The duplicated objects are omitted at link time. It works naturally in
Makefiles because GNU Make removes duplication in $^ without changing
the order.

It is working well, almost...

A small flaw I notice is, *.mod contains duplication in such a case.

This is probably not a big deal. As far as I know, the only small
problem is scripts/mod/sumversion.c parses the same file multiple
times.

I am fixing this because I plan to reuse *.mod for other purposes,
where the duplication can be problematic.

The code change is quite simple. We already use awk to drop duplicated
lines in modules.order (see cmd_modules_order in the same file).
I copied the code, but changed RS to use spaces as record separators.

I also changed the file format to list one object per line.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build   | 3 ++-
 scripts/mod/sumversion.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6ae92d119dfa..f7a30f378e20 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -303,7 +303,8 @@ $(obj)/%.prelink.o: $(obj)/%.o FORCE
 	$(call if_changed,cc_prelink_modules)
 endif
 
-cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) > $@
+cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) | \
+	$(AWK) -v RS='( |\n)' '!x[$$0]++' > $@
 
 $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
 	$(call if_changed,mod)
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 0125698f2037..79bb9eaa65ac 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -398,7 +398,7 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
 	buf = read_text_file(filelist);
 
 	md4_init(&md);
-	while ((fname = strsep(&buf, " \n"))) {
+	while ((fname = strsep(&buf, "\n"))) {
 		if (!*fname)
 			continue;
 		if (!(is_static_library(fname)) &&
-- 
2.32.0

