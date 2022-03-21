Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9014E2B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349564AbiCUOqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349551AbiCUOqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:46:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C923BBC6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:44:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso10528251pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ClhnJdJTqnZtjLO3RHLfsE96yXzBXFLvBmG8Gral5Ic=;
        b=CFRr9IGtGoLbOb0ocxztPa+AInf++i6g9LYw0HyLfLMt5cKbqWXL/6h3ZgTMgV9oed
         /cT+Qnb3GEJSrwD0apvaRxaEmjsz5P2cMlFpVSl3SRqWwLFC+CKofLTyOCcSjhmx3PMf
         wICkXVrwRtQdumF0067zCec+Gt6kekqBp8cAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ClhnJdJTqnZtjLO3RHLfsE96yXzBXFLvBmG8Gral5Ic=;
        b=3T2VME6Zkr17NvrYAp6sNRJ5klAlWvALidkB2D4FxfpDYNgrFHbyaUauORGQWd2jEE
         9k2NMJrtzfO9E+K8uVig7B2q8r/Cll5wG/IKd+70w6pTBy9fJkOOs3Yu++G22wmLfmUC
         LA77s67tZiZHDevTp4EZcmH9W15SUzqXFdTBHxOKwoakrPV8fo3akrEROWFiL1Czgaan
         EXy3pEbrUbt+/F1IgIt3AteJWQInEuCg638+A75IuIimOzn56gbiesboI3+9hkPWzuNB
         mW+TggfWEvCf0Imj4y9ZF2OM2JAcdCOQY6EYwtXIc8ZnGFkj9ggmyMzoe3zA2oUSm7Dt
         qU8w==
X-Gm-Message-State: AOAM533uopVl7Ide8pBgFK/lOW6yvxcuSIY3FXZ2dTGVi0EPfv5kgwCK
        YVOAJH4DqHLV/ica92zrCsVUCg==
X-Google-Smtp-Source: ABdhPJx4cQs1kLUnwd2uwcRNE1jZBqIaKJ3kv0HdqKN44pTZSA6p8FodSoC9+Adbm6aKi33UhwRCyQ==
X-Received: by 2002:a17:902:cf08:b0:151:9d28:f46f with SMTP id i8-20020a170902cf0800b001519d28f46fmr13019294plg.53.1647873895363;
        Mon, 21 Mar 2022 07:44:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm19501335pfm.207.2022.03.21.07.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:44:55 -0700 (PDT)
Date:   Mon, 21 Mar 2022 07:44:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Akira Kawata <akirakawata1@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Bill Messmer <wmessmer@microsoft.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        David Gow <davidgow@google.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        Matthew Wilcox <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Rich Felker <dalias@libc.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>, Tom Rix <trix@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [GIT PULL] execve updates for v5.18-rc1
Message-ID: <202203210740.98EB66F8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these execve and binfmt updates for v5.18-rc1. Eric and I
have stepped up to be the active maintainers of this area, so here's our
first collection. The bulk of the work was in coredump handling fixes;
additional details are noted below.

Thanks!

-Kees

The following changes since commit 439a8468242b313486e69b8cc3b45ddcfa898fbf:

  binfmt_elf: Avoid total_mapping_size for ET_EXEC (2022-03-01 10:29:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v5.18-rc1

for you to fetch changes up to dd664099002db909912a23215f8775c97f7f4f10:

  binfmt_elf: Don't write past end of notes for regset gap (2022-03-18 10:17:09 -0700)

----------------------------------------------------------------
execve updates for v5.18-rc1

- Handle unusual AT_PHDR offsets (Akira Kawata)
- Fix initial mapping size when PT_LOADs are not ordered (Alexey Dobriyan)
- Move more code under CONFIG_COREDUMP (Alexey Dobriyan)
- Fix missing mmap_lock in file_files_note (Eric W. Biederman)
- Remove a.out support for alpha and m68k (Eric W. Biederman)
- Include first pages of non-exec ELF libraries in coredump (Jann Horn)
- Don't write past end of notes for regset gap in coredump (Rick Edgecombe)
- Comment clean-ups (Tom Rix)
- Force single empty string when argv is empty (Kees Cook)
- Add NULL argv selftest (Kees Cook)
- Properly redefine PT_GNU_* in terms of PT_LOOS (Kees Cook)
- MAINTAINERS: Update execve entry with tree (Kees Cook)
- Introduce initial KUnit testing for binfmt_elf (Kees Cook)

----------------------------------------------------------------
Akira Kawata (2):
      fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
      fs/binfmt_elf: Refactor load_elf_binary function

Alexey Dobriyan (2):
      ELF: fix overflow in total mapping size calculation
      binfmt: move more stuff undef CONFIG_COREDUMP

Eric W. Biederman (7):
      coredump: Move definition of struct coredump_params into coredump.h
      coredump: Snapshot the vmas in do_coredump
      coredump: Remove the WARN_ON in dump_vma_snapshot
      coredump/elf: Pass coredump_params into fill_note_info
      coredump: Use the vma snapshot in fill_files_note
      coredump: Don't compile flat_core_dump when coredumps are disabled
      a.out: Stop building a.out/osf1 support on alpha and m68k

Jann Horn (1):
      coredump: Also dump first pages of non-executable ELF libraries

Kees Cook (6):
      exec: Force single empty string when argv is empty
      selftests/exec: Test for empty string on NULL argv
      MAINTAINERS: Update execve entry with more details
      ELF: Properly redefine PT_GNU_* in terms of PT_LOOS
      binfmt_elf: Introduce KUnit test
      Merge branch 'coredump-vma-snapshot-fix-for-v5.18' of https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace into for-next/execve

Rick Edgecombe (1):
      binfmt_elf: Don't write past end of notes for regset gap

Tom Rix (1):
      exec: cleanup comments

 MAINTAINERS                              |   4 +
 arch/alpha/Kconfig                       |   1 -
 arch/m68k/Kconfig                        |   1 -
 fs/Kconfig.binfmt                        |  10 ++
 fs/binfmt_elf.c                          | 153 +++++++++++++++++--------------
 fs/binfmt_elf_fdpic.c                    |  20 ++--
 fs/binfmt_elf_test.c                     |  64 +++++++++++++
 fs/binfmt_flat.c                         |   7 ++
 fs/compat_binfmt_elf.c                   |   2 +
 fs/coredump.c                            |  86 +++++++++++++----
 fs/exec.c                                |  32 ++++++-
 include/linux/binfmts.h                  |  15 +--
 include/linux/coredump.h                 |  20 +++-
 include/uapi/linux/elf.h                 |   7 +-
 tools/testing/selftests/exec/Makefile    |   1 +
 tools/testing/selftests/exec/null-argv.c |  78 ++++++++++++++++
 16 files changed, 374 insertions(+), 127 deletions(-)
 create mode 100644 fs/binfmt_elf_test.c
 create mode 100644 tools/testing/selftests/exec/null-argv.c

-- 
Kees Cook
