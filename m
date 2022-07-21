Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635B57CCBB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiGUNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGUNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:53:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61912E1D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:53:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j22so3323747ejs.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QTfsunLqKTRB2CFPsnW6lbEDPr/NGxI4rqcD38FJJkw=;
        b=DArx0cdwILUNhnM5+w7oUR7j8ov5x8tkDJdlXFTZUi79VTS/UMrU1tywOPb1RqBeWa
         g/Dw1peDlFsUR5OON4WW29nG6C5hNeWlekxqCj2PxL3nGzZgKQKqvjTx2AIpSOd9+/wa
         rNkf/n8mpaqOUtNgkn0i/XsVM6Jc2u+TzjB61cuX0XyfYZx8zvSTMp/fA+kgqV0YNsgR
         mLefzb3HdB7mHmrwy81dUD0je+ohD29EALmiIJUYVT3thYfdiAHp3SoIR7fy9C04QA10
         fpQ1QT4f2JlxBrcwuj06kZw5L3NnG+KUQUICjYGYNRzqmuq3zUokA8jJY6JVvXkP94y7
         KjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QTfsunLqKTRB2CFPsnW6lbEDPr/NGxI4rqcD38FJJkw=;
        b=liPnxtaEJ58/EJL3cZWHJ1E4IXA+L0YXwyuFVSrauGZl+5mobJTmVkTKYtkI+93OMo
         wnDz948wH4ftF75US0EYF6VnK0NPaZcHg+cGj6dRTe4/j6bBsbeLatfvs3sgq0MuVnQp
         D2JPmzh1FB+aCJWM++TJhTePAhhOjSP8ynm5J68cA/Qz1DZ6I48UiXSnJatqHAICKKzS
         OjhDDfqjCi0yo8bxbHx4jIE+8We5hXxpLNX8mdiJYCUeA09KWUu4/HHk+TlH1E+C7zhp
         7u27gmNOlskvwraXZ0mwODrLrAwo0BhT/Gm8kspUKAIiRlETBBhnT7OWUjUE37ipF/SZ
         qpsQ==
X-Gm-Message-State: AJIora8dt6B1DyoCzCMaDzBcXPVxWVVI7wrK0KjIiPnhpGQ/ti9cR7o5
        xLDIo3SZnBpPKd9rG6W1SeZvPWqwhD0VWTkLR85AYw==
X-Google-Smtp-Source: AGRyM1ud9picHHVdTtA2cJCpNsz7WoU+vwr2wtnyBeX+6n2757l598TbKI0zKDRgvH5Gnk8iWrQ3dDdGNBKQc0p1aFI=
X-Received: by 2002:a17:906:2dd:b0:712:1293:3dd8 with SMTP id
 29-20020a17090602dd00b0071212933dd8mr41059487ejk.448.1658411594627; Thu, 21
 Jul 2022 06:53:14 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Jul 2022 19:23:03 +0530
Message-ID: <CA+G9fYsuUdyUUUa_Xcfzfnh+Y8c82LnjeHum31C2ancBdxswCQ@mail.gmail.com>
Subject: arm64: defconfig build failed on Linux next-20220721
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 defconfig build failed on Linux next-20220721 tag kernel.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on arm64:
   - build-gcc-11-lkftconfig-64k_page_size
   - build-gcc-11-lkftconfig-rcutorture
   - build-gcc-11-lkftconfig-devicetree
   - build-gcc-11-lkftconfig
   - build-gcc-11-lkftconfig-debug
   - build-gcc-11-lkftconfig-armv8_features
   - build-gcc-11-lkftconfig-kselftest
   - build-gcc-11-lkftconfig-kunit
   - build-gcc-11-lkftconfig-libgpiod
   - build-gcc-11-lkftconfig-kasan
   - build-clang-12-lkftconfig
   - build-clang-14-lkftconfig
   - build-clang-13-lkftconfig
   - build-clang-nightly-lkftconfig
   - build-gcc-11-lkftconfig-debug-kmemleak

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build
CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
'HOSTCC=sccache gcc'
/builds/linux/arch/arm64/kernel/head.S: Assembler messages:
/builds/linux/arch/arm64/kernel/head.S:334: Error: immediate cannot be
moved by a single instruction
/builds/linux/arch/arm64/kernel/head.S:343: Error: immediate cannot be
moved by a single instruction
/builds/linux/arch/arm64/kernel/head.S:354: Error: immediate cannot be
moved by a single instruction
/builds/linux/arch/arm64/kernel/head.S:379: Error: immediate cannot be
moved by a single instruction
make[3]: *** [/builds/linux/scripts/Makefile.build:382:
arch/arm64/kernel/head.o] Error 1
/builds/linux/arch/arm64/mm/proc.S: Assembler messages:
/builds/linux/arch/arm64/mm/proc.S:296: Error: immediate cannot be
moved by a single instruction
make[3]: *** [/builds/linux/scripts/Makefile.build:382:
arch/arm64/mm/proc.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [/builds/linux/scripts/Makefile.build:525: arch/arm64/mm] Error 2
make[3]: Target '__build' not remade because of errors.
make[2]: *** [/builds/linux/scripts/Makefile.build:525:
arch/arm64/kernel] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:2005: arch/arm64] Error 2

Build log details link,
https://builds.tuxbuild.com/2CFcb9W3YxjuZPYeK5VFFhsYrbg/

I am running my bisect scripts to find out the first bad commit.

--
Linaro LKFT
https://lkft.linaro.org
