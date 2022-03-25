Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1B64E7C7C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiCYWF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 18:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiCYWFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:05:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F158613BADF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:03:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so4892215pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=F1cl22dPfbgw4CHrs1SfUAlvbEdIMiTM5Jgl06wTsCQ=;
        b=CmVO13C+dS/O6WM3blGDeY1sVqeF+gRrQrtu21YaYPFlA9Xa5dQqkV7L5Fm+vChYuJ
         GdVaAqXKiY3OVou43Czv/goYDuWh2yPE2EeWGUoitMVojfySZdnWTHXFTyGJnU8/ctLW
         re+MkkKvywOKV29zCA2sf8ltxdjYm7pTsrOpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=F1cl22dPfbgw4CHrs1SfUAlvbEdIMiTM5Jgl06wTsCQ=;
        b=W15WZdkcrizLjmJqXqj/9TQiLykstI2N5jeX++8P7Z58zuH7/9Ih9UZV20k8KR1qSw
         A5m5VK7mhmPOLcLT439KBnlUWcX4qcB1vwKF/O5zoz1fWLjGmBh7e8pveuGGSbv7aJlH
         Mq8OJ04/GgvVEdi0UR6aASOBYjdNtkUUnx3lMD1oCp1NhISlan5nN5OXQvesnLKHnrt+
         +05oxt2g3ze+GprKy0LvPL7vmCfR2HpOFHXDudPlGIQKvmUBIFN/FSzc8JsLsZPU1/xU
         6B+1yaaBof5eyOVsJNgbH4JWNHMJVmurvZtUP49eVCvTA+hJjN141sop9ypV+9PBw/89
         ZR/w==
X-Gm-Message-State: AOAM5304biyeqVuMTTmwUTw+cU0UPP1qydzM04osN1gsuqL8Y4R17IGn
        1dXJksCF6ra1hQu/3vQyHBaZLQ==
X-Google-Smtp-Source: ABdhPJzDkiJrPUYM7qLN3Sj0nWpVkCZOULBiG9dPZTq3hhO/0HYRD8PEYshHQLol+XIg1yTjMTYl9Q==
X-Received: by 2002:a17:902:d4cc:b0:154:3a3b:4172 with SMTP id o12-20020a170902d4cc00b001543a3b4172mr13611246plg.165.1648245824405;
        Fri, 25 Mar 2022 15:03:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cq13-20020a056a00330d00b004faa1fffd18sm7152444pfb.124.2022.03.25.15.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 15:03:44 -0700 (PDT)
Date:   Fri, 25 Mar 2022 15:03:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, George Burgess IV <gbiv@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] FORTIFY_SOURCE updates for v5.18-rc1
Message-ID: <202203251443.9BBADFD98@keescook>
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

Please pull these FORTIFY_SOURCE updates for v5.18-rc1.

This series consists of two halves:

- strict compile-time buffer size checking under FORTIFY_SOURCE for
  the memcpy()-family of functions (for extensive details and rationale,
  see the first commit),

- enabling FORTIFY_SOURCE for Clang, which has had many overlapping bugs
  that we've finally worked past.

It looks like all the dependent trees with related buffer fixes have been
merged (I was waiting for the scsi tree to get pulled). This has been
in -next for almost 2 development cycles, and I did overnight build
testing merged against your tree under the following combinations,
with no new warnings (there is one Clang 14+ specific issue in
drivers/net/ethernet/huawei/hinic that we're still tracking down as a
likely compiler regression[1]):

gcc   11.2.1 (Fedora 35)    defconfig:    x86_64 i386 arm64
gcc   11.2.1 (Fedora 35)    allmodconfig: x86_64 i386 arm64
gcc   11.2.0 (Ubuntu 21.10) defconfig:    x86_64 i386 arm64
gcc   11.2.0 (Ubuntu 21.10) allmodconfig: x86_64 i386 arm64
gcc   10.3.0 (Ubuntu 21.10) defconfig:    x86_64 i386 arm64
gcc   10.3.0 (Ubuntu 21.10) allmodconfig: x86_64 i386 arm64
gcc    9.4.0 (Ubuntu 21.10) defconfig:    x86_64 i386 arm64
gcc    9.4.0 (Ubuntu 21.10) allmodconfig: x86_64 i386 arm64
gcc    8.5.0 (Ubuntu 21.10) defconfig:    x86_64 i386 arm64
gcc    8.5.0 (Ubuntu 21.10) allmodconfig: x86_64 i386 arm64
clang 15.0.0 (local build)  defconfig:    x86_64 i386 arm64
clang 14.0.0 (Ubuntu 22.04) defconfig:    x86_64 i386 arm64
clang 13.0.0 (Fedora 35)    defconfig:    x86_64 i386 arm64
clang 12.0.1 (Ubuntu 21.10) defconfig:    x86_64 i386 arm64
clang 13.0.0 (Ubuntu 21.10) allmodconfig: x86_64 i386
clang 12.0.1 (Ubuntu 21.10) allmodconfig: x86_64 i386

There is also still 1 runtime fix pending for the comedi driver's
selftests[2], which is living in my "pending-fixes" tree (for fixes that
maintainers appear to have picked up, but haven't appeared in -next yet).

Beyond that, as far as I've been able to track, all the other architecture
also build cleanly; we've been fixing any issues as they are reported
by various builders, and when we find them in our builds.

Thanks!

-Kees

[1] https://github.com/ClangBuiltLinux/linux/issues/1592
[2] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/pending-fixes&id=77cc24d543c46076d753348b6178473eb16fc788

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/memcpy-v5.18-rc1

for you to fetch changes up to 281d0c962752fb40866dd8d4cade68656f34bd1f:

  fortify: Add Clang support (2022-02-13 16:50:07 -0800)

----------------------------------------------------------------
memcpy updates for v5.18-rc1

- Enable strict FORTIFY_SOURCE compile-time validation of memcpy buffers

- Add Clang features needed for FORTIFY_SOURCE support

- Enable FORTIFY_SOURCE for Clang where possible

----------------------------------------------------------------
Kees Cook (12):
      fortify: Detect struct member overflows in memcpy() at compile-time
      fortify: Detect struct member overflows in memmove() at compile-time
      fortify: Detect struct member overflows in memset() at compile-time
      fortify: Update compile-time tests for Clang 14
      fortify: Replace open-coded __gnu_inline attribute
      Compiler Attributes: Add __pass_object_size for Clang
      Compiler Attributes: Add __overloadable for Clang
      Compiler Attributes: Add __diagnose_as for Clang
      fortify: Make pointer arguments const
      fortify: Use __diagnose_as() for better diagnostic coverage
      fortify: Make sure strlen() may still be used as a constant expression
      fortify: Add Clang support

 arch/x86/boot/compressed/misc.c                 |   3 +-
 arch/x86/lib/memcpy_32.c                        |   1 +
 include/linux/compiler_attributes.h             |  39 ++++
 include/linux/fortify-string.h                  | 238 +++++++++++++++++++-----
 lib/Makefile                                    |   3 +-
 lib/string_helpers.c                            |   6 +
 lib/test_fortify/read_overflow2_field-memcpy.c  |   5 +
 lib/test_fortify/read_overflow2_field-memmove.c |   5 +
 lib/test_fortify/write_overflow_field-memcpy.c  |   5 +
 lib/test_fortify/write_overflow_field-memmove.c |   5 +
 lib/test_fortify/write_overflow_field-memset.c  |   5 +
 scripts/test_fortify.sh                         |   8 +-
 security/Kconfig                                |   5 +-
 13 files changed, 272 insertions(+), 56 deletions(-)
 create mode 100644 lib/test_fortify/read_overflow2_field-memcpy.c
 create mode 100644 lib/test_fortify/read_overflow2_field-memmove.c
 create mode 100644 lib/test_fortify/write_overflow_field-memcpy.c
 create mode 100644 lib/test_fortify/write_overflow_field-memmove.c
 create mode 100644 lib/test_fortify/write_overflow_field-memset.c

-- 
Kees Cook
