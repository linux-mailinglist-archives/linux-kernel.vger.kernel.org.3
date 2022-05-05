Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7C51B8D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343947AbiEEHaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343736AbiEEH34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:29:56 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBAB31DE9;
        Thu,  5 May 2022 00:26:17 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2457Neni019426;
        Thu, 5 May 2022 16:23:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2457Neni019426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651735421;
        bh=mq8Yk8ot1m2mhjLX32XL2W0Bgs0dGB51vVKxKbSTMUk=;
        h=From:To:Cc:Subject:Date:From;
        b=T77AYbWp+W8B/eXgnFGulan20TeHw3N6W7RIXt54h6dPGoOqBWyaZNhM/USm2COY1
         1ai4VjljO6SS+KIZdz9zDlbPcqhQnBQeKneHyAHJdZ84G+BLsISEwrf5tO5Dr/i9PB
         F94bzoe3Oo0TSu1N115G9q5JVECDckPxmFdLpg9iBzUQAI0aY2wPXdhmYVFSHyMMFO
         q9se3e2KHp4ASisYM7uhuvaAfDDmUKe07fp1pOQ7PQebdARYuQLzr56U6xU38UYJDq
         pBOrMk+PhVZ1hXHhscAEgaCyhjpTKX5PIofvTZP38NtlwKytBpwbg0AN2yAxcYmtWJ
         JIz/mJfS9d9Bw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 00/15] kbuild: yet another series of cleanups (modpost, LTO, MODULE_REL_CRCS)
Date:   Thu,  5 May 2022 16:22:29 +0900
Message-Id: <20220505072244.1155033-1-masahiroy@kernel.org>
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

Major changes in v3:

 - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.

Major changes in v2:

 - V1 did not work with CONFIG_MODULE_REL_CRCS.
   I fixed this for v2.

 - Reflect some review comments in v1

 - Refactor the code more

 - Avoid too long argument error


Masahiro Yamada (15):
  modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
  modpost: change the license of EXPORT_SYMBOL to bool type
  modpost: merge add_{intree_flag,retpoline,staging_flag} to add_header
  modpost: move *.mod.c generation to write_mod_c_files()
  kbuild: generate a list of objects in vmlinux
  kbuild: record symbol versions in *.cmd files
  modpost: extract symbol versions from *.cmd files
  kbuild: link symbol CRCs at final link, removing
    CONFIG_MODULE_REL_CRCS
  kbuild: stop merging *.symversions
  genksyms: adjust the output format to modpost
  kbuild: do not create *.prelink.o for Clang LTO or IBT
  modpost: simplify the ->is_static initialization
  modpost: use hlist for hash table implementation
  kbuild: make built-in.a rule robust against too long argument error
  kbuild: make *.mod rule robust against too long argument error

 arch/powerpc/Kconfig         |   1 -
 arch/s390/Kconfig            |   1 -
 arch/um/Kconfig              |   1 -
 include/asm-generic/export.h |  22 +-
 include/linux/export.h       |  30 +--
 include/linux/symversion.h   |  13 +
 init/Kconfig                 |   4 -
 kernel/module.c              |  10 +-
 scripts/Kbuild.include       |   4 +
 scripts/Makefile.build       | 118 +++------
 scripts/Makefile.lib         |   7 -
 scripts/Makefile.modfinal    |   5 +-
 scripts/Makefile.modpost     |   9 +-
 scripts/genksyms/genksyms.c  |  18 +-
 scripts/link-vmlinux.sh      |  46 ++--
 scripts/mod/file2alias.c     |   2 -
 scripts/mod/list.h           |  52 ++++
 scripts/mod/modpost.c        | 449 ++++++++++++++++++++---------------
 scripts/mod/modpost.h        |   2 +
 19 files changed, 402 insertions(+), 392 deletions(-)
 create mode 100644 include/linux/symversion.h

-- 
2.32.0

