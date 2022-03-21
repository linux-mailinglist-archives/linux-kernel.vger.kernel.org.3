Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909BE4E2C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350168AbiCUP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350225AbiCUP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:27:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33899109A5F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:26:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s8so15684225pfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Q4NOeoj72t/xyIHwYgDmg6MvXTR5THfLjr7+BD7Q2rQ=;
        b=WfOHKiM6+TBGTccSD7rMFfL/clpc6ZnzBjQ8Q8CJfMkEPDH4EH7178trlBJXupymF8
         EEhpiH5StU/kzajKN2sYFl+aBvJvzq+z3qoegReC31SJJ//QqycAcZRj9TgRKHgWQApv
         he0DSrcrwuaphqmg2ai+/5KVyOiW8BRyms4gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Q4NOeoj72t/xyIHwYgDmg6MvXTR5THfLjr7+BD7Q2rQ=;
        b=wufPyElILFQOa7R7TMaCEUeFqqJkoEpr/Q3piaiGTmImce6DDq/44LME7lA0plNtDl
         Ll0p0KG6+9N9rGHlVSasnbQGSnfnIXirksGLznkhsZ2mrQV+gTs9IK1wLWnp5w2kZ8FO
         z46WPno1aAWDiATk3L0jr5MUDeb0XOmFxu1FSAcj5yCNWTdOnJRhTRqhxUKl6LRGPfJJ
         NqcKp18oLFm7lecDXbsslRKk1GY64zA4jaQn+T1dGmSLF5lOgao/gPjygRFC7xQ45HhQ
         LtbuwW6mh8oZFT0cTn5XINAavnWa25mKWkVYJfOb7lI3EsAGPKqD+v8PvDI1kWENLyfn
         c0hA==
X-Gm-Message-State: AOAM532dla9u5fcHnYkoTcdV6IisiB4xlTIN9acwKc0wF94CEfmmiEMH
        4rLImjP6mzG+fmlaD2Ot+Fc3Fg==
X-Google-Smtp-Source: ABdhPJxnlr6oZFlC5KIOc+nwNqzIiYfQsHB+C0fTYN72eZj+JztRQeZEKy36jbSY1NG+lkgsKta9FQ==
X-Received: by 2002:a05:6a00:21c6:b0:4fa:914c:2c2b with SMTP id t6-20020a056a0021c600b004fa914c2c2bmr8503434pfj.56.1647876392503;
        Mon, 21 Mar 2022 08:26:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4-20020a056a00158400b004fa0263cf5dsm20634979pfk.130.2022.03.21.08.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:26:32 -0700 (PDT)
Date:   Mon, 21 Mar 2022 08:26:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Richard Weinberger <richard@nod.at>,
        Vitor Massaru Iha <vitor@massaru.org>
Subject: [GIT PULL] overflow updates for v5.18-rc1
Message-ID: <202203210821.9E5FDCA863@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these overflow updates for v5.18-rc1. These changes come in
roughly two halves: support of Gustavo A. R. Silva's struct_size()
work via additional helpers for catching overflow allocation size
calculations, and conversions of selftests to KUnit (which includes
some tweaks for UML + Clang).

Thanks!

-Kees

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.18-rc1

for you to fetch changes up to 02788ebcf521fe78c24eb221fd1ed7f86792c330:

  lib: stackinit: Convert to KUnit (2022-03-21 08:13:04 -0700)

----------------------------------------------------------------
overflow updates for v5.18-rc1

- Convert overflow selftest to KUnit
- Convert stackinit selftest to KUnit
- Implement size_t saturating arithmetic helpers
- Allow struct_size() to be used in initializers

----------------------------------------------------------------
Kees Cook (6):
      test_overflow: Regularize test reporting output
      overflow: Implement size_t saturating arithmetic helpers
      overflow: Provide constant expression struct_size
      lib: overflow: Convert to Kunit
      um: Allow builds with Clang
      lib: stackinit: Convert to KUnit

 Documentation/process/deprecated.rst        |  20 +-
 arch/um/os-Linux/execvp.c                   |   1 +
 arch/x86/um/user-offsets.c                  |   9 +-
 include/linux/overflow.h                    | 114 +++---
 lib/Kconfig.debug                           |  38 +-
 lib/Makefile                                |   6 +-
 lib/{test_overflow.c => overflow_kunit.c}   | 518 +++++++++++++++-------------
 lib/{test_stackinit.c => stackinit_kunit.c} | 269 ++++++---------
 scripts/Makefile.clang                      |   1 +
 9 files changed, 518 insertions(+), 458 deletions(-)
 rename lib/{test_overflow.c => overflow_kunit.c} (54%)
 rename lib/{test_stackinit.c => stackinit_kunit.c} (66%)

-- 
Kees Cook
