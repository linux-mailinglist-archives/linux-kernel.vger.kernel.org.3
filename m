Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677D7526136
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379993AbiEMLmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379950AbiEMLmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:42:15 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FF55B898;
        Fri, 13 May 2022 04:42:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24DBeEwZ008349;
        Fri, 13 May 2022 20:40:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24DBeEwZ008349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652442015;
        bh=mZnH7vlFKLT7FEGBr7iAv5DRO4vduuM0Ets3Kz9Jvhc=;
        h=From:To:Cc:Subject:Date:From;
        b=eBlvAJYSjmMcKgi8G34ggTIB8DLZKAWpu/qnpZRI9LrpD8IX0NZI161d4KPni9kip
         OsHIZuCJOOVkQWDzMRvNkbB02FC6qYwzQqzkHtwY8+2/H/vtAKbVNrfwUCt398DSXD
         qsT23bRXyCVHrEb4FnHcy6MjSeby4IuMH8xU6YpmAG/WigzvQywqFqPhfRZzXh+XJS
         VFoZ15+mw896qyOvCUSSBlZskUqUdkplXJo9aCB/nKwjvKdFSI3ig7fJgB3Jve0en/
         yVS8gRw+ybImV4ughl4umgqzuVfKD8Lu64oR42w8dnAw2foPz+rbVY+nwp2bOQeScn
         uWsgfe2fYCSow==
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
Subject: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost, LTO, MODULE_REL_CRCS, export.h)
Date:   Fri, 13 May 2022 20:39:20 +0900
Message-Id: <20220513113930.10488-1-masahiroy@kernel.org>
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



Changes in v6:
  - Fix false-positive warnings when CONFIG_TRIM_UNUSED_KSYMS=y

Changes in v5:
  - Fix the build error when CONFIG_DEBUG_INFO_BTF=y (reported by Nathan)
  - Clean up arch/m68k/include/asm/export.h (Nick)
  - Keep gen_symversions (and will be removed by a later patch)
  - Add more comments in the script

Changes in v4:
  - Rename .vmlinux-symver.c to .vmlinux.export.c
    because I notice this approach is useful for further cleanups,
    not only for modversioning but also for overall EXPORT_SYMBOL.
  - New patch
  - New.
    Resent of my previous submission.
    https://lore.kernel.org/all/20210831074004.3195284-10-masahiroy@kernel.org/
  - New
    Resent of my previous submission
    https://lore.kernel.org/linux-kbuild/20210831074004.3195284-11-masahiroy@kernel.org/

Changes in v3:
  - New patch

Changes in v2:
  - Simplify the implementation (parse .cmd files after ELF)
  - New patch
 - replace the chain of $(if ...) with $(and )
  - New patch
  - New patch

Masahiro Yamada (10):
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

 arch/m68k/include/asm/Kbuild    |   1 +
 arch/m68k/include/asm/export.h  |   2 -
 arch/powerpc/Kconfig            |   1 -
 arch/s390/Kconfig               |   1 -
 arch/um/Kconfig                 |   1 -
 include/asm-generic/export.h    |  22 ++-
 include/linux/export-internal.h |  16 +++
 include/linux/export.h          |  30 ++--
 init/Kconfig                    |   4 -
 kernel/module.c                 |  10 +-
 scripts/Kbuild.include          |  10 +-
 scripts/Makefile.build          | 134 ++++++------------
 scripts/Makefile.lib            |   7 -
 scripts/Makefile.modfinal       |   5 +-
 scripts/Makefile.modpost        |   9 +-
 scripts/check-local-export      |  64 +++++++++
 scripts/genksyms/genksyms.c     |  18 +--
 scripts/link-vmlinux.sh         |  33 ++---
 scripts/mod/modpost.c           | 236 +++++++++++++++++++++-----------
 19 files changed, 320 insertions(+), 284 deletions(-)
 delete mode 100644 arch/m68k/include/asm/export.h
 create mode 100644 include/linux/export-internal.h
 create mode 100755 scripts/check-local-export

-- 
2.32.0

