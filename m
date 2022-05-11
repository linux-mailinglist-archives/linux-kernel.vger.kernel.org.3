Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8904523AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbiEKQty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345023AbiEKQtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:49:45 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F6993982;
        Wed, 11 May 2022 09:49:41 -0700 (PDT)
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 24BGlWbt031975;
        Thu, 12 May 2022 01:47:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 24BGlWbt031975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652287653;
        bh=lrObdII52qYaJ8/FrDvrISgaVLdCtE8oZBm6XPqiaSk=;
        h=From:To:Cc:Subject:Date:From;
        b=HvtaKjwQOeSVYjh0ysolTKw0r7pYVYcERlcwdZpQLSOyb2htJarI4X6oEKYJW2JkY
         tUbRVR91L2AF0dD1Rm2Vk0RX7YF7XqkSYZ3t1F7qvDTKnUgrepZMO5x7s6v92Y8eZ8
         mD9InCNq+6Jxrb8ndZ0bQw05WvtYTPDYOT1UkYxyjwSGbXXDAj5fTVBUD+Xqcx4S7y
         KKqMgXogOY3dTzJKqvR5i2XOEelm82Cnagl86UAClKILMUQ4PFtcdOa/yuLTeUv18Z
         MfUEG6YvFOLsG9Wq1OxvL3Wia1Nn2LvlUkFG2cpMeRwfzP8jd0LY0ZWJHKQO1RCJOd
         Bz2xXMR/ivgfw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 00/12] kbuild: yet another series of cleanups (modpost, LTO, MODULE_REL_CRCS, export.h)
Date:   Thu, 12 May 2022 01:45:02 +0900
Message-Id: <20220511164514.2741934-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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


This is the third batch of cleanups in this development cycle.

Major changes in v5:
 - Fix build errors
 - More cleanups

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



Masahiro Yamada (12):
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

 arch/m68k/include/asm/Kbuild    |    1 +
 arch/m68k/include/asm/export.h  |    2 -
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
 scripts/check-local-export      |   64 ++
 scripts/genksyms/genksyms.c     |   18 +-
 scripts/link-vmlinux.sh         |   33 +-
 scripts/mod/Makefile            |    4 +-
 scripts/mod/modpost.c           | 1395 +++----------------------------
 scripts/mod/modpost.h           |   34 +-
 scripts/mod/section-check.c     | 1222 +++++++++++++++++++++++++++
 22 files changed, 1541 insertions(+), 1482 deletions(-)
 delete mode 100644 arch/m68k/include/asm/export.h
 create mode 100644 include/linux/export-internal.h
 create mode 100755 scripts/check-local-export
 create mode 100644 scripts/mod/section-check.c

-- 
2.32.0

