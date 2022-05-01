Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37744516325
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbiEAIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344045AbiEAIqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:46:18 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625054DF55;
        Sun,  1 May 2022 01:42:45 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rl008518;
        Sun, 1 May 2022 17:41:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rl008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394463;
        bh=/Fwo8BKbXbId96hk2BkfsZ9ZH5JZlI0k6RMZnYAd2+s=;
        h=From:To:Cc:Subject:Date:From;
        b=XlAJPbMDKox25Yl5u2CLXEnwIVnMtILl/CeHSs5aPJgF2JQS0uCpY1izQAbZI0xyk
         wnYI0OeL2hJPksZfZnZJRQEIwklKqKwXcBwWEaTLMCogVT+gokAEU1gx7eskVvTccm
         Gf7cIuLSSr4D6XH35nUS/f0eLnYw9KUkPIAtR32D6MHdu3kWaEh+HGVSIrXhcbgrTU
         B9Fbr/eqjEiG+Modt0xOIrcUwCnrpKAiEFRyuY5TfIWKbVyKv5toPGn/cyaHdMqnK3
         Gms098Xd8Z6dlY1p2s2gYQRuFi9Go0YpO+CdXAJLuPT6MjUxgP3kXFex7JJfN+WI9c
         83QE0Y0xQ2cMA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev
Subject: [PATCH v2 00/26] kbuild: yet another series of cleanups (modpost and LTO)
Date:   Sun,  1 May 2022 17:40:06 +0900
Message-Id: <20220501084032.1025918-1-masahiroy@kernel.org>
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

Major changes in v2:

 - V1 did not work with CONFIG_MODULE_REL_CRCS.
   I fixed this for v2.

 - Reflect some review comments in v1

 - Refactor the code more

 - Avoid too long argument error



Masahiro Yamada (26):
  modpost: use bool type where appropriate
  modpost: change mod->gpl_compatible to bool type
  modpost: import include/linux/list.h
  modpost: traverse modules in order
  modpost: add sym_add_unresolved() helper
  modpost: traverse unresolved symbols in order
  modpost: use doubly linked list for dump_lists
  modpost: traverse the namespace_list in order
  modpost: dump Module.symvers in the same order of modules.order
  modpost: move static EXPORT_SYMBOL check to check_exports()
  modpost: make multiple export error
  modpost: make sym_add_exported() always allocate a new symbol
  modpost: split new_symbol() to symbol allocation and hash table
    addition
  modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
  kbuild: record symbol versions in *.cmd files
  kbuild: generate a list of objects in vmlinux
  modpost: extract symbol versions from *.cmd files
  modpost: generate linker script to collect symbol versions
  kbuild: embed symbol versions at final link of vmlinux or modules
  kbuild: stop merging *.symversions
  genksyms: adjust the output format for .cmd files
  kbuild: do not create *.prelink.o for Clang LTO or IBT
  kbuild: make built-in.a rule robust against too long argument error
  kbuild: make *.mod rule robust against too long argument error
  modpost: simplify the ->is_static initialization
  modpost: use hlist for hash table implementation

 .gitignore                  |   1 +
 Makefile                    |   1 +
 scripts/Kbuild.include      |   4 +
 scripts/Makefile.build      | 118 +++------
 scripts/Makefile.lib        |   7 -
 scripts/Makefile.modfinal   |   6 +-
 scripts/Makefile.modpost    |  10 +-
 scripts/genksyms/genksyms.c |  17 +-
 scripts/link-vmlinux.sh     |  34 +--
 scripts/mod/file2alias.c    |   2 -
 scripts/mod/list.h          | 265 +++++++++++++++++++
 scripts/mod/modpost.c       | 501 ++++++++++++++++++++++--------------
 scripts/mod/modpost.h       |  24 +-
 scripts/mod/sumversion.c    |   8 +-
 14 files changed, 650 insertions(+), 348 deletions(-)
 create mode 100644 scripts/mod/list.h

-- 
2.32.0

