Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B376C53F41E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiFGCx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiFGCxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:53:24 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 19:53:21 PDT
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296569CF0;
        Mon,  6 Jun 2022 19:53:20 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (unknown [69.145.56.143])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 372882EE491B;
        Tue,  7 Jun 2022 02:43:19 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id 14DEB1300202; Mon,  6 Jun 2022 20:43:07 -0600 (MDT)
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: avoid regex RS for POSIX awk
Date:   Mon,  6 Jun 2022 20:42:54 -0600
Message-Id: <368129160298161a9eb40ad4f489458be6be3b6f.1654569774.git.kevin@kevinlocke.name>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 22f26f21774f8 awk was added to deduplicate *.mod files.  The awk
invocation passes -v RS='( |\n)' to match a space or newline character
as the record separator.  Unfortunately, POSIX states[1]

> If RS contains more than one character, the results are unspecified.

Some implementations (such as the One True Awk[2] used by the BSDs) do
not treat RS as a regular expression.  When awk does not support regex
RS, build failures such as the following are produced (first error using
allmodconfig):

      CC [M]  arch/x86/events/intel/uncore.o
      CC [M]  arch/x86/events/intel/uncore_nhmex.o
      CC [M]  arch/x86/events/intel/uncore_snb.o
      CC [M]  arch/x86/events/intel/uncore_snbep.o
      CC [M]  arch/x86/events/intel/uncore_discovery.o
      LD [M]  arch/x86/events/intel/intel-uncore.o
    ld: cannot find uncore_nhmex.o: No such file or directory
    ld: cannot find uncore_snb.o: No such file or directory
    ld: cannot find uncore_snbep.o: No such file or directory
    ld: cannot find uncore_discovery.o: No such file or directory
    make[3]: *** [scripts/Makefile.build:422: arch/x86/events/intel/intel-uncore.o] Error 1
    make[2]: *** [scripts/Makefile.build:487: arch/x86/events/intel] Error 2
    make[1]: *** [scripts/Makefile.build:487: arch/x86/events] Error 2
    make: *** [Makefile:1839: arch/x86] Error 2

To avoid this, use printf(1) to produce a newline between each object
path, instead of the space produced by echo(1), so that the default RS
can be used by awk.

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html
[2]: https://github.com/onetrueawk/awk

Fixes: 22f26f21774f ("kbuild: get rid of duplication in *.mod files")
Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
---
 scripts/Makefile.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 1f01ac65c0cd..cac070aee791 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -251,8 +251,8 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
 
 # To make this rule robust against "Argument list too long" error,
 # ensure to add $(obj)/ prefix by a shell command.
-cmd_mod = echo $(call real-search, $*.o, .o, -objs -y -m) | \
-	$(AWK) -v RS='( |\n)' '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
+cmd_mod = printf '%s\n' $(call real-search, $*.o, .o, -objs -y -m) | \
+	$(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
 
 $(obj)/%.mod: FORCE
 	$(call if_changed,mod)
-- 
2.35.1

