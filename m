Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368BE5AFB80
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIGE7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIGE73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:59:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02301F1D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:59:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n17-20020a254011000000b006a90a92cf87so5838124yba.19
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 21:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=5KkuUj+pLuobeBW2hd5taBieJOu5xIF1y/ExdwvwcYQ=;
        b=jPsWc5iLwVSH8Jex2jZMQg0g+sBWwbkomQw8CS2JtuDLvxbVzVve3vsKUA/MIVj0xq
         DhRGCtoJV3TkWc/eYwUB2fYGtktwiJob7Z/Ox6Jg+RwTM7/Z8DY4BGOZYO1jF4KBs95W
         3ac0We94KbB+ruCEMO2X4L95e3ujfUh4WUpYqlGE7couvbyczOsIywa05FVAILdK5pWr
         z8EUcu/UB/FIGPXzFb2Ooadlr7QJeZbLqJsshexCviPpHCgKcQQcTG5LU7Vf0ix5teGS
         JMxYIDOKYFj9Tua4v52Os6wYjS1mER3O6On+raKw8ojznumDmsofIfYTgcyQoRx6nm+/
         JYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5KkuUj+pLuobeBW2hd5taBieJOu5xIF1y/ExdwvwcYQ=;
        b=UaCq9wEpfRFOGwppjDVeCLnfyiSsbWsNL9N54kL9iM9ByyevJWL+sGczwoe7RuGB90
         8J+j+LL3ViboiygJ8hIijYeRHMLT1BYJ8LYGk2Msme3PZH1sVGxfqwplumGQQ0II0iUH
         a7TeWRj82WBkpVvPrQ8DFO0lEcDE4LTDOyTeYJYI6lwo0r+sikaStrWyc8TUgnK48enu
         P5wN3H2PUeWmjOLldSdAe4i7bAuJWHw9njTuNE/qtheA5OIy76cV2uUERIUFLSflWIMv
         vFXIXiwTlQ1kqNKd30HqkbTKQfSVF7CXq+cJtz1I8f6IS4YKH4Qm52Zb3uw0IUrtEUH9
         ZoZg==
X-Gm-Message-State: ACgBeo0fj1oKP8HlMlMVPfmef2x0qkUSeBoLIaF8Yjter5RRHkivy9WE
        c4XJMotjzDJpqgxUoMdkW3k551/wnCrzypYsrdI=
X-Google-Smtp-Source: AA6agR7MdDxZiTiXgdzz0N2vozySxVRQWbWIzmMFlwjKBF0W/CgyABVN4YSq/aGy3cFfoGhVsWUCkxn9dpM890qVX+k=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:9755:c523:9dcb:2228])
 (user=ndesaulniers job=sendgmr) by 2002:a25:808d:0:b0:6a8:f9e8:eba0 with SMTP
 id n13-20020a25808d000000b006a8f9e8eba0mr1546168ybk.279.1662526763269; Tue,
 06 Sep 2022 21:59:23 -0700 (PDT)
Date:   Tue,  6 Sep 2022 21:59:02 -0700
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662526746; l=2638;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=cDZUQK3Xlhq6UAisRuFd/LsEsJYlX0H63Fh8sZh2QE8=;
 b=55Dj3em7g+QowMQgxxfkuhkf/HynAElBxrMYYyiZsmn9Ra7w9F298fs1n09sBYVuSHYreiT52jNj
 QtstnzTBCB4DpwQmRc0SDV4nYIpF9tkNtpW5katqXX5ksff6MTl0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907045907.484043-1-ndesaulniers@google.com>
Subject: [PATCH v3 0/5] fix debug info for asm and DEBUG_INFO_SPLIT
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey reported that the fraction of unknown filename instances in
kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
to assembler defined symbols, which regressed as a result of:

commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")

In that commit, I allude to restoring debug info for assembler defined
symbols in a follow up patch, but it seems I forgot to do so in

commit a66049e2cf0e ("Kbuild: make DWARF version a choice")

Do so requires a fixup for as-option, which seems to be failing when
used in scripts/Makefile.debug.

Also includes a fix for DEBUG_INFO_SPLIT while I'm here.  Dmitrii
reports that this has been broken since gcc-11+ & clang-12+. I'm
guessing no one uses this .config option...since no one else has
reported it being broken yet...

Changes from v2 -> v3:
* Pick up Nathan's Reviewed-by and Tested-by tags.
* Reword commit message 1/5 and 2/5 as per Nathan.
* Add Masahiro's Suggested-by tag where relevant.
* Use -x assembler-with-cpp -Werror in as-option and as-instr as per Masahiro.
* Fix AMDGPU compiler version check as per Nathan.
* Drop cc-min-version, as per Masahiro.
* Replace patch 4 with a variant of Masahiro's suggestion.
* Reword commit message 4/5.

Changes from v1 -> v2:
* 5 patches now, rather than 3.
* Split change to arch/x86/boot/compressed/Makefile off of first patch,
  as per Masahiro.
* Introduce compiler specific macros, as per Bill, and eradicate
  cc-ifversion while I'm at it.
* Update commit message of final patch to refer to 866ced950bcd.

v2: https://lore.kernel.org/llvm/20220831184408.2778264-1-ndesaulniers@google.com/
v1: https://lore.kernel.org/llvm/20220826181035.859042-1-ndesaulniers@google.com/

*** BLURB HERE ***

Nick Desaulniers (5):
  x86/boot/compressed: prefer cc-option for CFLAGS additions
  Makefile.compiler: Use KBUILD_AFLAGS for as-option
  Makefile.compiler: replace cc-ifversion with compiler-specific macros
  Makefile.debug: re-enable debug info for .S files
  Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT

 Documentation/kbuild/makefiles.rst          | 29 ++++++++++++---------
 Makefile                                    |  6 ++---
 arch/x86/boot/compressed/Makefile           |  2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile |  2 +-
 lib/Kconfig.debug                           |  4 ++-
 scripts/Makefile.compiler                   | 18 ++++++++-----
 scripts/Makefile.debug                      | 25 ++++++++----------
 7 files changed, 46 insertions(+), 40 deletions(-)

-- 
2.37.2.789.g6183377224-goog

