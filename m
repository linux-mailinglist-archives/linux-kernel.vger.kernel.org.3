Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066B4E2B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349786AbiCUPE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349788AbiCUPEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:04:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E5833EAC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:03:21 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g19so15649191pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Nhh1H5DwQtGWexOG0k4s/vMCmoZ8SV+44k6F0KWQplI=;
        b=S5b9kICkwpsHhPBIj57u4Q7BlY0n10vzOlvTCSkZzfn9g45E+fLZN4RcgZmMM3M1yn
         xrFS/z1ZWnoFOQEx0+WAtstAMv3hU4AppFGBwOW/Gy66oGac+BhcEVB/q9ubL09wDcHe
         DG5164NIbOIjQX+sXR78E642xvppKbhgI+B9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Nhh1H5DwQtGWexOG0k4s/vMCmoZ8SV+44k6F0KWQplI=;
        b=RUONj8zx1ZpyEaGBbilLdnu+UK69uXNhNQS7L71dqvJJkKqvlWDTjqDfbIJ4mILeOP
         C9nSZsf56yprlrBZb1J4DWTTSWp9Uy3xPAVF5NlBzrHrj51+j/LRQCvtLur8jXjbrAwC
         6LLph9P7Ww/+qg5AfrlqnHYlkujKrD2FL7QRgyPgeP6eeFOWAeL9hxHZ1IsUgK61orMg
         0QtmdltHvh5YB2lBOKh/2cXeh9dUkUJmvBA9T+RD0KYB1sun7VuxGT57EOdqoszPrrdq
         EajApZROxuaS1O6mDE1Ykj1pzhbK5RSJPIdDFxYp/T3d8KcJngUqSQ7yF5oY4UoWvu1r
         FINg==
X-Gm-Message-State: AOAM5302K3mrVzyd8TmoaEYqqWkVFqFaYwuh8kV/JnML77jjNr/NyVsf
        BhioH7/uFuhGLnWJIMscGLl64Q==
X-Google-Smtp-Source: ABdhPJyrzyLgi3yX6JHTvMUlBsI8HgpJc7tkb7Iujp8EqM9RRVHxeL8uKkkyaDz9TJ1xK/jogMhUWA==
X-Received: by 2002:a05:6a00:848:b0:4f7:ba8b:4429 with SMTP id q8-20020a056a00084800b004f7ba8b4429mr24156951pfk.4.1647875000530;
        Mon, 21 Mar 2022 08:03:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ep2-20020a17090ae64200b001c6a7c22aedsm10301241pjb.37.2022.03.21.08.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:03:20 -0700 (PDT)
Date:   Mon, 21 Mar 2022 08:03:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Dan Li <ashimida@linux.alibaba.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>, Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] hardening updates for v5.18-rc1
Message-ID: <202203210755.C56A4CD5@keescook>
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

Please pull these hardening updates for v5.18-rc1. A notable change is
support for arm64 Shadow Call Stack under GCC 12, which was originally
proposed[1] as a kernel-specific gcc plugin, but was instead implemented
in upstream[2] GCC.

Thanks!

-Kees

[1] https://lore.kernel.org/linux-hardening/1632069436-25075-1-git-send-email-ashimida@linux.alibaba.com/
[2] https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=ce09ab17ddd21f73ff2caf6eec3b0ee9b0e1a11e

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.18-rc1

for you to fetch changes up to afcf5441b9ff22ac57244cd45ff102ebc2e32d1a:

  arm64: Add gcc Shadow Call Stack support (2022-03-10 09:22:09 -0800)

----------------------------------------------------------------
hardening updates for v5.18-rc1

- Add arm64 Shadow Call Stack support for GCC 12 (Dan Li)
- Avoid memset with stack offset randomization under Clang (Marco Elver)
- Clean up stackleak plugin to play nice with .noinstr (Kees Cook)
- Check stack depth for greater usercopy hardening coverage (Kees Cook)

----------------------------------------------------------------
Dan Li (1):
      arm64: Add gcc Shadow Call Stack support

Kees Cook (6):
      gcc-plugins/stackleak: Provide verbose mode
      gcc-plugins/stackleak: Exactly match strings instead of prefixes
      gcc-plugins/stackleak: Ignore .noinstr.text and .entry.text
      usercopy: Check valid lifetime via stack depth
      xtensa: Implement "current_stack_pointer"
      m68k: Implement "current_stack_pointer"

Marco Elver (2):
      stack: Introduce CONFIG_RANDOMIZE_KSTACK_OFFSET
      stack: Constrain and fix stack offset randomization with Clang builds

 arch/Kconfig                           | 43 +++++++++++++++++++++++-----------
 arch/arm/Kconfig                       |  1 +
 arch/arm64/Kconfig                     |  3 ++-
 arch/m68k/Kconfig                      |  1 +
 arch/m68k/include/asm/current.h        |  4 +++-
 arch/powerpc/Kconfig                   |  1 +
 arch/s390/Kconfig                      |  1 +
 arch/sh/Kconfig                        |  1 +
 arch/x86/Kconfig                       |  1 +
 arch/xtensa/Kconfig                    |  1 +
 arch/xtensa/include/asm/current.h      |  2 ++
 arch/xtensa/include/asm/stacktrace.h   |  8 +++----
 arch/xtensa/kernel/irq.c               |  3 +--
 include/linux/compiler-gcc.h           |  4 ++++
 include/linux/randomize_kstack.h       | 21 +++++++++++++++--
 init/main.c                            |  2 +-
 mm/Kconfig                             |  9 +++++++
 mm/usercopy.c                          | 23 ++++++++++++++++--
 scripts/Makefile.gcc-plugins           |  2 ++
 scripts/gcc-plugins/stackleak_plugin.c | 29 +++++++++++++++++++----
 security/Kconfig.hardening             | 10 ++++++++
 21 files changed, 139 insertions(+), 31 deletions(-)

-- 
Kees Cook
