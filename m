Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058515292B6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349128AbiEPVPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347967AbiEPVPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:15:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B894C17A84
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:10:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7dbceab08so139075457b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FZcSyeZsO9IL5sGZuwA1FFxJdj4vwGJ4vjI3g4Z2mBk=;
        b=Bx7tgt+GJfqaLCs7xBMlT7qFLIwiPAwovX3m4OrDqEAu4mraTTnFTrHLsZlBXSYwEd
         S9NV+5/yKgYiy//X7fyyyi9qEzfSo11N2NGm9LtwMN4jqNFfeNb9uG/a6QKN59Q2YCX7
         vHA+1Jld+DnCpZCLfn/1/+uk6RNWLTl6QoRe8Y3mDmyiJW90vwozTDGsxiPiQFQHjgX8
         imq/7dPd+H0KTJd/I8085oKBUynPopN2VnrIxnA0LtnNS/pkVlxY0t5D02cUN8rYKeq9
         BKwzNqNWEJJ41+ZJCV7KTfi3QncaffOx2ihSMKc/kZMxDtBbCeuoyh7ghugflNSW/l97
         VY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FZcSyeZsO9IL5sGZuwA1FFxJdj4vwGJ4vjI3g4Z2mBk=;
        b=sJhx5AxwrjtWyjW1xc73SlzPei1Kqq6/vk0RJe/XTxh5RksKplLmxxVJWki+zVQ7UH
         YItzI0BMYAuXRtGZn2/AnQDN0CUSd0E7XzjUAgDYeEi/zFFU99zZOoHRHzf3y3mX6IBK
         nWKpk02L703b0TF6vLRTLLSJU+HCXepsmZvH7VuoveXZPIYFYxXv6OwTpNNOuNU03Z2W
         zCcBVqFe5x7P9AAlWsQl15tXNe6H1D/3NVrHXSOEn2P96BaLWDaUKVv+xpFpezH9EmY0
         1f2e6Lzpw7yV+wNZpfkWtnsqNWkiYllLeLBuBbe4y42N1EVYx3SdTheMQMcK9unVaZlV
         qY5g==
X-Gm-Message-State: AOAM530MKjX1RyrpMfXcDCUCdEXS9NM2k9XqWkOuastQW4zrV1YGrb0/
        pbTRsLjC/+RZnJHf0Dom+y0s6UeleLVqj8TcquU=
X-Google-Smtp-Source: ABdhPJzceMbqMCWcaHO+Vaq4YPwgIaTtdI456jBiTN6H9DjqGxN7HtVrx2dWttRmI63nR6Bo6qP6htuKd+wL0/i1wGU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2ef0:b8de:b9c8:da45])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:1501:b0:649:ff91:5409 with
 SMTP id q1-20020a056902150100b00649ff915409mr19972941ybu.278.1652735402915;
 Mon, 16 May 2022 14:10:02 -0700 (PDT)
Date:   Mon, 16 May 2022 14:09:50 -0700
Message-Id: <20220516210954.1660716-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652735394; l=2928;
 s=20211004; h=from:subject; bh=nQYhTiVBaVqJ4Yl9K4hhhOCSOYjfiGjNQuRqR5ZoaZY=;
 b=MlL9nMS36OSe4Xc71noVArPyrOx9FfKJ4WVEjRfBsGB6qnO0RlQm4T/J0zfA7HK3VONHQk0DUkNF
 9HCJ9boqDoPPJ8T3o7x4TYAe9ONvn4bz+m/8mAmV0RwDV2Rj4Jlz
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 0/4] pass -march= only to compiler
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@arndb.de>, Ard@google.com,
        Biesheuvel@google.com
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
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

When both -march= and -Wa,-march= are specified for assembler or
assembler-with-cpp sources, GCC and Clang will prefer the -Wa,-march=
value but Clang will warn that -march= is unused.

warning: argument unused during compilation: '-march=armv6k'
[-Wunused-command-line-argument]

This is the top group of warnings we observe when using clang to
assemble the kernel via `ARCH=arm make LLVM=1`.

Arnd sent a v2 of my previous patch
https://lore.kernel.org/linux-arm-kernel/20210928154143.2106903-14-arnd@kernel.org/
I added yet a few more instances I found since then.

Fixing this will allow us to enable
-Werror=unused-command-line-argument for clang builds.

Nick Desaulniers (4):
  ARM: remove lazy evaluation in Makefile
  ARM: use .arch directives instead of assembler command line flags
  ARM: only use -mtp=cp15 for the compiler
  ARM: pass -march= only to compiler

 arch/arm/Makefile                   | 76 ++++++++++++++++-------------
 arch/arm/boot/compressed/Makefile   |  1 -
 arch/arm/common/Makefile            |  2 -
 arch/arm/common/mcpm_head.S         |  2 +
 arch/arm/common/vlock.S             |  2 +
 arch/arm/kernel/Makefile            |  2 -
 arch/arm/kernel/hyp-stub.S          |  2 +
 arch/arm/kernel/swp_emulate.c       |  1 +
 arch/arm/lib/Makefile               |  4 --
 arch/arm/lib/delay-loop.S           |  4 ++
 arch/arm/mach-at91/Makefile         |  3 --
 arch/arm/mach-at91/pm_suspend.S     |  4 ++
 arch/arm/mach-imx/Makefile          |  3 --
 arch/arm/mach-imx/headsmp.S         |  2 +
 arch/arm/mach-imx/resume-imx6.S     |  2 +
 arch/arm/mach-imx/suspend-imx6.S    |  2 +
 arch/arm/mach-mvebu/Makefile        |  3 --
 arch/arm/mach-mvebu/coherency_ll.S  |  1 +
 arch/arm/mach-mvebu/pmsu.c          |  1 +
 arch/arm/mach-npcm/Makefile         |  2 -
 arch/arm/mach-npcm/headsmp.S        |  2 +
 arch/arm/mach-tegra/Makefile        |  2 -
 arch/arm/mach-tegra/reset-handler.S |  2 +
 arch/arm/mach-tegra/sleep-tegra20.S |  2 +
 arch/arm/mach-tegra/sleep-tegra30.S |  2 +
 arch/arm/mm/Makefile                | 15 ------
 arch/arm/mm/abort-ev6.S             |  1 +
 arch/arm/mm/abort-ev7.S             |  1 +
 arch/arm/mm/cache-v6.S              |  2 +
 arch/arm/mm/cache-v7.S              |  2 +
 arch/arm/mm/cache-v7m.S             |  2 +
 arch/arm/mm/copypage-feroceon.c     |  1 +
 arch/arm/mm/proc-v6.S               |  2 +
 arch/arm/mm/proc-v7-2level.S        |  2 +
 arch/arm/mm/proc-v7.S               |  2 +
 arch/arm/mm/tlb-v6.S                |  2 +
 arch/arm/mm/tlb-v7.S                |  2 +
 drivers/memory/Makefile             |  2 -
 drivers/memory/ti-emif-sram-pm.S    |  1 +
 drivers/soc/bcm/brcmstb/pm/Makefile |  1 -
 drivers/soc/bcm/brcmstb/pm/s2-arm.S |  1 +
 41 files changed, 94 insertions(+), 74 deletions(-)


base-commit: 0ac824f379fba2c2b17b75fd5ada69cd68c66348
-- 
2.36.0.550.gb090851708-goog

