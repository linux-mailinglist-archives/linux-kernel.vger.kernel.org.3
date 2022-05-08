Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC6351F04D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiEHTWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiEHTPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:15:54 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C7312AC7;
        Sun,  8 May 2022 12:11:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 248J8qSN030019;
        Mon, 9 May 2022 04:08:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 248J8qSN030019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652036933;
        bh=+vYUwETkJzeHMTCZ91mKcqrVUk+DZUgc4qJxVJGLB84=;
        h=From:To:Cc:Subject:Date:From;
        b=F4LJf0izMBoQwKKxFHapf/UWVkpce+bBOiPQDjYdwhGn4tjnhTYWvzVVqkcyPq804
         wDV3dj2VXzZ3nUn50spW30wo44yeinntn/zLBECDNy+HKuo4c5WjW594yBUMLi9HJT
         wh0d+02rTX2YFYjP5EQT1idNsaC0NZxLKCzsyElUxjIq91/u5NWViltNUAbCDr/fI1
         c4RsAMtN7VODeWSApmkeeIwtBppqcGR83Ocb9ZjcSCDL6dvRZ/T1gTzeJUi+3NL62D
         i3XLkjzJPLGGjjGT9pziJq2TeZyq+C4VDoadGLSYb3U3a6/WRGfI2AjWqpDZg7phzF
         89WOSAQW+ZG/A==
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
Subject: [PATCH v4 00/14] kbuild: yet another series of cleanups (modpost, LTO, MODULE_REL_CRCS, export.h)
Date:   Mon,  9 May 2022 04:06:17 +0900
Message-Id: <20220508190631.2386038-1-masahiroy@kernel.org>
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

This is the third batch of cleanups in this development cycle.

Major changes in v4:
 - Move static EXPORT_SYMBOL check to a script
 - Some refactoring

Major changes in v3:

 - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.

Major changes in v2:

 - V1 did not work with CONFIG_MODULE_REL_CRCS.
   I fixed this for v2.

 - Reflect some review comments in v1

 - Refactor the code more

 - Avoid too long argument error



Masahiro Yamada (14):
  modpost: remove left-over cross_compile declaration
  modpost: change the license of EXPORT_SYMBOL to bool type
  modpost: split the section mismatch checks into section-check.c
  modpost: add sym_find_with_module() helper
  modpost: extract symbol versions from *.cmd files
  kbuild: link symbol CRCs at final link, removing
    CONFIG_MODULE_REL_CRCS
  kbuild: stop merging *.symversions
  genksyms: adjust the output format to modpost
  kbuild: do not create *.prelink.o for Clang LTO or IBT
  kbuild: check static EXPORT_SYMBOL* by script instead of modpost
  kbuild: make built-in.a rule robust against too long argument error
  kbuild: make *.mod rule robust against too long argument error
  kbuild: add cmd_and_savecmd macro
  kbuild: rebuild multi-object modules when objtool is updated

 arch/powerpc/Kconfig            |    1 -
 arch/s390/Kconfig               |    1 -
 arch/um/Kconfig                 |    1 -
 include/asm-generic/export.h    |   22 +-
 include/linux/export-internal.h |   16 +
 include/linux/export.h          |   30 +-
 init/Kconfig                    |    4 -
 kernel/module.c                 |   10 +-
 scripts/Kbuild.include          |   10 +-
 scripts/Makefile.build          |  134 +--
 scripts/Makefile.lib            |    7 -
 scripts/Makefile.modfinal       |    5 +-
 scripts/Makefile.modpost        |    9 +-
 scripts/check-local-export      |   48 +
 scripts/genksyms/genksyms.c     |   18 +-
 scripts/link-vmlinux.sh         |   33 +-
 scripts/mod/Makefile            |    2 +-
 scripts/mod/modpost.c           | 1499 ++++---------------------------
 scripts/mod/modpost.h           |   35 +-
 scripts/mod/section-check.c     | 1222 +++++++++++++++++++++++++
 20 files changed, 1551 insertions(+), 1556 deletions(-)
 create mode 100644 include/linux/export-internal.h
 create mode 100755 scripts/check-local-export
 create mode 100644 scripts/mod/section-check.c

-- 
2.32.0

