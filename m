Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1E4C5E3A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiB0SqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiB0SqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:46:04 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D028E2C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:45:22 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id ay5so6084721plb.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4qXA3qAOIxxv6eU3E6Ltva1sTSq91s873Aqz1SumJw=;
        b=TPEEPFr+ElZw97J4S63RpaUWxPCpqUhGD4V/ibIonIS5ximIvfwgHdCFrqArJCmD1u
         ANX3JLAg0nj/Hvaddv0Gga8APVwwJiTtr0qsTgKO+/FGmkaak4/lj5Y6dWJSstRJ3f+k
         bisr8GfoavobbFdjWb7WFBkfU8QlUxrZEc+gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z4qXA3qAOIxxv6eU3E6Ltva1sTSq91s873Aqz1SumJw=;
        b=qNSpipVPpnaT7C2XwKVI9hzYDyEyRXDEuyBsS6FUPyG64KJWhF3aIFYUsS+L3u+kmH
         dCrH/OgxNoXUIX3UtVG/HozhrLOjHgmzA1D/dvIoEBn5yWM+eAz2+E/Dj6JpghPxCGK9
         rLr6AvvChNRD0wsQ0rU8zwO3Y0WWf/DUbom0yDSS8oCY9t0F73M+QJYNs7+swScbMA95
         cwnUaFUtdNzKrnjqDdnvArZE/zOgw19LjAttkrervsEB7P1BpjRur6iCK5NYNHB9b/Q4
         o2P0+752W7PfdwFEGs5aky/TPwC5MkuGqnjEFsEuydTLIoa/EKodAQG1BhLXtYr/U57p
         sSzA==
X-Gm-Message-State: AOAM531QKWDUD+o2AHn7qtcCWWILQrqD5GUB/Ly7Q8eamP8nzkG8tRB+
        d1Sq9unIaF2nFTLeoOKX/nnwEQ==
X-Google-Smtp-Source: ABdhPJzIIRRbSJ21FELEpDpxMgc2ETCyQMr+Ty4K6o7rm/QyPHSr4FMBpDZYfTMMBKWbTkHi+/1gog==
X-Received: by 2002:a17:90a:ee93:b0:1bc:3abc:91fd with SMTP id i19-20020a17090aee9300b001bc3abc91fdmr13050246pjz.92.1645987522015;
        Sun, 27 Feb 2022 10:45:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s4-20020a056a00194400b004f0fbeb6006sm10390883pfk.88.2022.02.27.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:45:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/7] Convert overflow and stackinit to KUnit
Date:   Sun, 27 Feb 2022 10:45:10 -0800
Message-Id: <20220227184517.504931-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; h=from:subject; bh=K7cNIhWttE5J2hAwWOxDFld7SujXLeKgqWt+Szmsi/4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiG8a64weRf63QOmyPMpBVbd/L8Zu3PYukknitZ5WB 9wHC49CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhvGugAKCRCJcvTf3G3AJjV8D/ wIIXLS3mfhRhgdUv4s2F/rwzN2/KW5PowNLr9aBWsGTeAQtrTxO3Op1YD3I0NbBIqi9Ltx9zDM4PhX 90FOdH7uu3ypv3mzoqcc/z+2mWMITMpkEedP+QimK8st2/tZlr8T2ugE4j+pWo3PUnx1N8bOquvzFg hBEtgklsG/8LoEh8TIPcxsbDqKG7FynORTY+5QWSIVklj65fwnCGeYeRdgvs7Zlq84qNalYOViX3py YfL50Ti7PspcNKWrbUwtOgHaqHZI+CkRC2zv7EPch1hSPTVvAWt78OLBMcY1VIEV3ewfZYzBbTEPfB H+6faH09gyz8rEJe5Bf81tUadWJNiKLvFu3/p6JZsFpnTSMxkIrpxGyHLinGZjwISPE7nFiXJ3SCmE Qf5A+55/wlySOECuzBSCk1YgVHYBPDjiqo7E1ShtVDAHOasY7V19duZDYSd0lDDZu/cQHFwMR5dy/c D7Ep8f2hJi2KafZBoFFStRhP6P2J9kAQtkFLsxhLQDssaaBsTQalI70pBSQcVyflRu5z38yLyQ/qNY 7NIXLP3G7VN9jHM/rZ9C6SQbOcsq3GoLgb4AZe7hmY1Y4DQ58g0ZFZYSmb0I1/VZlHaKVu2xkRHWQF hWL8U/PgSlKAspAfHJb9wYP6+4eFwL2isgFNCxfSSBzdQMeqgbccmXa3HQxg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These changes all build on each other, so I'm sending this as a series
to hopefully reduce confusion. I chose "v3" because it seemed the least
confusing of various options.

The um changes are needed to get Clang building with um to test the
stackinit KUnit test more easily (i.e. needing neither GCC 12 nor QEMU).

-Kees

David Gow (2):
  um: Cleanup syscall_handler_t definition/cast, fix warning
  um: Remove unused timeval_to_ns() function

Kees Cook (5):
  overflow: Provide constant expression struct_size
  lib: overflow: Convert to Kunit
  um: Allow builds with Clang
  lib: stackinit: Convert to KUnit
  UAPI: Introduce KUnit userspace compatibility

 arch/um/os-Linux/execvp.c                   |   1 +
 arch/um/os-Linux/time.c                     |   6 -
 arch/x86/um/shared/sysdep/syscalls_64.h     |   5 +-
 arch/x86/um/user-offsets.c                  |   9 +-
 include/linux/overflow.h                    |  10 +-
 include/uapi/misc/kunit.h                   | 181 +++++++
 lib/Kconfig.debug                           |  38 +-
 lib/Makefile                                |   6 +-
 lib/{test_overflow.c => overflow_kunit.c}   | 562 +++++++++-----------
 lib/{test_stackinit.c => stackinit_kunit.c} | 268 ++++------
 scripts/Makefile.clang                      |   1 +
 11 files changed, 593 insertions(+), 494 deletions(-)
 create mode 100644 include/uapi/misc/kunit.h
 rename lib/{test_overflow.c => overflow_kunit.c} (54%)
 rename lib/{test_stackinit.c => stackinit_kunit.c} (67%)

-- 
2.32.0

