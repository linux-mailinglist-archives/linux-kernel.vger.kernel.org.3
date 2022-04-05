Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445C84F4B62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574435AbiDEW4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384219AbiDEM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:16 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0DF7486F;
        Tue,  5 Apr 2022 04:35:52 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 235BYCGm000464;
        Tue, 5 Apr 2022 20:34:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 235BYCGm000464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649158453;
        bh=tlKllE+DeH+owxkSzZkT6wnBC6VcqxWAXsQhSEB8rk0=;
        h=From:To:Cc:Subject:Date:From;
        b=YdaL0ynmtbZVeMCw/+dhJuynpbARiMg258nxmjvJekOGt/BAROJZ5u5E6dzP9wHKk
         z5WhiExOSraf3CMM3c6G+MBalNLwRSGDm+9bYdG5m0wFFYf8nRPWh9cmzKi924/NMO
         AjCuGRYQZ8qtd70DvHof32c9rcC6cOiqixuQ3s7ZqYWWeS0/zYgRBTKEITtDktDB9X
         a5r0Dly+Or5at2+zpXgdhCnEdSBqqQd6W6cWZmLP1hPR9XE/aYOGGg9WIK+12igwJn
         wP97HdvKtkFIMPe+w69PRGXtEsrb+/Eo5STtoAHjICWMdV9YuDuv2bfDgpgRkmYk/z
         fvA9GM3qVrezA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <n.schier@avm.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev
Subject: [PATCH v2 00/10] kbuild: misc cleanups
Date:   Tue,  5 Apr 2022 20:33:48 +0900
Message-Id: <20220405113359.2880241-1-masahiroy@kernel.org>
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


This is a series of prerequisite cleanups of my next work.


Masahiro Yamada (10):
  kbuild: factor out genksyms command from cmd_gensymtypes_{c,S}
  kbuild: do not remove empty *.symtypes explicitly
  modpost: remove useless export_from_sec()
  modpost: move export_from_secname() call to more relevant place
  modpost: remove redundant initializes for static variables
  modpost: remove annoying namespace_from_kstrtabns()
  kbuild: get rid of duplication in the first line of *.mod files
  kbuild: split the second line of *.mod into *.usyms
  kbuild: refactor cmd_modversions_c
  kbuild: refactor cmd_modversions_S

 .gitignore                  |  1 +
 Makefile                    |  2 +-
 scripts/Makefile.build      | 86 ++++++++++++++++---------------------
 scripts/adjust_autoksyms.sh |  2 +-
 scripts/gen_autoksyms.sh    | 18 +++++---
 scripts/mod/modpost.c       | 49 ++++++---------------
 scripts/mod/modpost.h       |  4 --
 scripts/mod/sumversion.c    | 11 +----
 8 files changed, 64 insertions(+), 109 deletions(-)

-- 
2.32.0

