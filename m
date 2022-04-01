Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA78D4EEA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbiDAJoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344107AbiDAJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:44:20 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699B66F9A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:42:31 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2eb1ab11436so19780007b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5bM14LmT9eRhJ5g9FBd/mcC1NH/E0MkGxXLU7hV68CA=;
        b=OVXxMgnbHKEcpL6VB56qJFQSUZRSCOC2i9d7BL1Q7GEEoTscqfHQSBl3ZRquGCios8
         TLbThyEFhwt6KQPteBuc5Jly37E3poF28saJYMuzjLbtIhX7sJyEC4B4iZle4XvssIIs
         15FrIVwkDJaEJhzxFhpve+w7VPx7CzGrhu44CPdntziGZ09s5j1VeMwce1a1jULtb0nF
         +lwPRcnJSy0CMcVgf+8D5ZkiDpUbNbY/XbnA/07jj4J5gXE6jm16g5YUU6gGosH1lc27
         0Qiu+ktdeu2xrMqLdt0Izqdm6d/JuQXry3yVSnL8j/flpt0GSFfq1gnGQCL2X29FF18F
         mp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5bM14LmT9eRhJ5g9FBd/mcC1NH/E0MkGxXLU7hV68CA=;
        b=rZAQiHOpyN2XPEhkcZY7Cl6yktDXwHa8kdJeWxosjWyOrQImYhkg+knmAnnPZEAgKk
         udZWpxDoEShF1AmOheqzIQ+8LSvpMGljZRTO2nPyZaSNXLeOX/TQhTrk044AT4dQe/SX
         k1LJALlQtYaoUfuDdnLa4CuWCsaC8GuOZkIec5j0vnVNddB3KHNpanvRPvbJLRBZSK6T
         GhKjZXioyMj3v1vioJ8WNY/8nYS+GqgVraLR2gGDL7FJma1lt1xoxReg2bh064z5UDNP
         zGmF8Um/xZzoMB81+SaJYp5OfZvZgS3SAA+bi97J/F3d0Aa+93VmELPaxiZ/gH4rSnop
         5ZGQ==
X-Gm-Message-State: AOAM532k4tJhr0RRurvkp6trXbx7RGR1ZMg1JhHUE8kbbM5bqo8zszQT
        R5h3bpuFCVADlkqJireQ/ie1T8QXbxgBOBcxYrR1YA==
X-Google-Smtp-Source: ABdhPJyuf+EdWUjGBxYG6TPeK8QDsyTYR18oa3YGHbqLeAsM7axMRB8HB5lTnzreVqQvYezbzNoPFFTJA6qYaH+Z0Ug=
X-Received: by 2002:a0d:ffc3:0:b0:2eb:2327:3361 with SMTP id
 p186-20020a0dffc3000000b002eb23273361mr1300759ywf.36.1648806150538; Fri, 01
 Apr 2022 02:42:30 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Apr 2022 15:12:19 +0530
Message-ID: <CA+G9fYvy_98dCAtCiu_SkieKXzya28CKzOmhq0d_RcJkMYYFTw@mail.gmail.com>
Subject: [next] arm64: builds failed - stacktrace.c:(.text+0x55c): undefined
 reference to `arch_stack_walk_shadow'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next-20220401 arm64 builds failed due to below warnings / erros [1].

Regressions found on arm64:
   - arm64-gcc-11-lkftconfig-kunit
   - arm64-clang-12-lkftconfig
   - arm64-gcc-11-lkftconfig-kselftest
   - arm64-gcc-11-lkftconfig-rcutorture
   - arm64-gcc-11-lkftconfig-kasan
   - arm64-gcc-11-lkftconfig-armv8_features
   - arm64-gcc-11-lkftconfig
   - arm64-clang-13-lkftconfig
   - arm64-gcc-11-lkftconfig-perf
   - arm64-clang-14-lkftconfig
   - arm64-gcc-11-lkftconfig-debug
   - arm64-gcc-11-lkftconfig-devicetree
   - arm64-gcc-11-lkftconfig-64k_page_size
   - arm64-gcc-11-lkftconfig-debug-kmemleak
   - arm64-clang-nightly-lkftconfig
   - arm64-gcc-11-lkftconfig-libgpiod

aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
aarch64-linux-gnu-ld: Entry trampoline text too big
aarch64-linux-gnu-ld: kernel/stacktrace.o: in function
`stack_trace_save_shadow':
stacktrace.c:(.text+0x55c): undefined reference to `arch_stack_walk_shadow'
make[1]: *** [/builds/linux/Makefile:1250: vmlinux] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: e5071887cd2296a7704dbcd10c1cedf0f11cdbd5
  git_describe: next-20220401
  kernel-config: https://builds.tuxbuild.com/27BBxWVk7aUyuYUrHdX9sgzoz3h/config

steps to reproduce:

# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
tuxmake --runtime podman --target-arch arm64 --toolchain gcc-11
--kconfig https://builds.tuxbuild.com/27BBxWVk7aUyuYUrHdX9sgzoz3h/config


--
Linaro LKFT
https://lkft.linaro.org

[1] https://builds.tuxbuild.com/27BBxWVk7aUyuYUrHdX9sgzoz3h/
