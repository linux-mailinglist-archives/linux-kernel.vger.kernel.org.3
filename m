Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77624E415B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiCVOcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbiCVOcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:32:09 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A9180220;
        Tue, 22 Mar 2022 07:30:36 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id a11so10624099qtb.12;
        Tue, 22 Mar 2022 07:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKCeCN4v0IIcKH2AYNMKLGWgRkL6/hNyW/oPzIuHTzU=;
        b=b7Fr2/o5Xtyysbm6K7fWMmyi86+3j3H8CP5ZUlBavLyG1DkXjlN0MTKqF0FwHwxrqP
         74bpUgimLmC+8jJNMYPRJRp2e+tH4jsIPqJ3KXTy8m+dQpJLtp3Vh4DTTht23JTLbNdx
         9eMLUTw4g9EHEzymxrXINN4O0FwvSHkBUI38UTzjIDEE/kxsTmx71IKwShUzEhidmu3V
         1If/yHiF7QPIONGhQrRra4lfGS9J6jlzuFt0HEFJFxMHBCSu6iyd7W7smUPKgi1CQBgO
         cw2CBqj9k+4lmmK6tzIaVrSQ9WrHshHyCzY8hcOPBnNskmbmBn9vUuguaajILZLRiNrh
         hwmg==
X-Gm-Message-State: AOAM530lYCYoxYB+R/PrWSMeQiuGbFo1ockJWUllme2TooqcqnaYJY6y
        ewsC00u5/Dk7hI3XMqtRw1VZ1q00rlZCFw==
X-Google-Smtp-Source: ABdhPJxHKbIdXVVBlHvasT/aTeB1TgkxdMnv+UDxAI+rY7CoeMqFdtty0WTIvmC3eFCaE5eQafjChw==
X-Received: by 2002:a05:622a:82:b0:2e1:d61d:81ec with SMTP id o2-20020a05622a008200b002e1d61d81ecmr20543988qtw.674.1647959434857;
        Tue, 22 Mar 2022 07:30:34 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002e06aa02021sm14172151qta.49.2022.03.22.07.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 07:30:34 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id v35so33919698ybi.10;
        Tue, 22 Mar 2022 07:30:34 -0700 (PDT)
X-Received: by 2002:a25:45:0:b0:633:96e2:2179 with SMTP id 66-20020a250045000000b0063396e22179mr28023894yba.393.1647959434009;
 Tue, 22 Mar 2022 07:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220224055145.1853657-1-keescook@chromium.org>
In-Reply-To: <20220224055145.1853657-1-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Mar 2022 15:30:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_g1tbiUL9PUQdqaegrEzCNN3GtbSvSBFYAL4TzvstFg@mail.gmail.com>
Message-ID: <CAMuHMdX_g1tbiUL9PUQdqaegrEzCNN3GtbSvSBFYAL4TzvstFg@mail.gmail.com>
Subject: Re: [PATCH] lib: stackinit: Convert to KUnit
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Thu, Feb 24, 2022 at 9:12 AM Kees Cook <keescook@chromium.org> wrote:
> Convert to running under Kunit (and retain being able to run stand-alone
> too). Building under Clang (or GCC 12) with CONFIG_INIT_STACK_ALL_ZERO=y,
> this now passes as expected:
>
> $ ./tools/testing/kunit/kunit.py config --make_option LLVM=1
> $ ./tools/testing/kunit/kunit.py run overflow --make_option LLVM=1 \
>         --kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
> ...

> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch, which is now commit 02788ebcf521fe78 ("lib:
stackinit: Convert to KUnit") upstream.

Out of curiosity, I gave this a try on m68k, and it still seems to
fail the same way of before[1]:

    # Subtest: stackinit
    1..65
    # test_u8_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 1 wide, target offset by 16)
    not ok 1 - test_u8_zero
    # test_u16_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 2 wide, target offset by 16)
    not ok 2 - test_u16_zero
    # test_u32_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 4 wide, target offset by 16)
    not ok 3 - test_u32_zero
    # test_u64_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 8 wide, target offset by 16)
    not ok 4 - test_u64_zero
    # test_char_array_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 5 - test_char_array_zero
    # test_small_hole_zero: ASSERTION FAILED at lib/stackinit_kunit.c:334
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 6 - test_small_hole_zero
    # test_big_hole_zero: ASSERTION FAILED at lib/stackinit_kunit.c:334
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 128 wide, target offset by 64)
    not ok 7 - test_big_hole_zero
    # test_trailing_hole_zero: ASSERTION FAILED at lib/stackinit_kunit.c:334
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 8 - test_trailing_hole_zero
    # test_packed_zero: ASSERTION FAILED at lib/stackinit_kunit.c:334
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 9 - test_packed_zero
    # test_small_hole_dynamic_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:337
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 10 - test_small_hole_dynamic_partial
    ok 11 - test_big_hole_dynamic_partial
    # test_trailing_hole_dynamic_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:337
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 12 - test_trailing_hole_dynamic_partial
    # test_packed_dynamic_partial: ASSERTION FAILED at lib/stackinit_kunit.c:337
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 13 - test_packed_dynamic_partial
    # test_small_hole_assigned_dynamic_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:340
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 14 - test_small_hole_assigned_dynamic_partial
    ok 15 - test_big_hole_assigned_dynamic_partial
    # test_trailing_hole_assigned_dynamic_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:340
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 16 - test_trailing_hole_assigned_dynamic_partial
    # test_packed_assigned_dynamic_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:340
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 17 - test_packed_assigned_dynamic_partial
    # test_small_hole_static_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:336
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 18 - test_small_hole_static_partial
    ok 19 - test_big_hole_static_partial
    # test_trailing_hole_static_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:336
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 20 - test_trailing_hole_static_partial
    # test_packed_static_partial: ASSERTION FAILED at lib/stackinit_kunit.c:336
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 21 - test_packed_static_partial
    # test_small_hole_static_all: ASSERTION FAILED at lib/stackinit_kunit.c:336
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 22 - test_small_hole_static_all
    ok 23 - test_big_hole_static_all
    # test_trailing_hole_static_all: ASSERTION FAILED at
lib/stackinit_kunit.c:336
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 24 - test_trailing_hole_static_all
    # test_packed_static_all: ASSERTION FAILED at lib/stackinit_kunit.c:336
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 25 - test_packed_static_all
    # test_small_hole_dynamic_all: ASSERTION FAILED at lib/stackinit_kunit.c:337
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 26 - test_small_hole_dynamic_all
    ok 27 - test_big_hole_dynamic_all # SKIP XFAIL uninit bytes: 124
    # test_trailing_hole_dynamic_all: ASSERTION FAILED at
lib/stackinit_kunit.c:337
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 28 - test_trailing_hole_dynamic_all
    # test_packed_dynamic_all: ASSERTION FAILED at lib/stackinit_kunit.c:337
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 29 - test_packed_dynamic_all
    # test_small_hole_runtime_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:338
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 30 - test_small_hole_runtime_partial
    ok 31 - test_big_hole_runtime_partial # SKIP XFAIL uninit bytes: 127
    # test_trailing_hole_runtime_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:338
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 32 - test_trailing_hole_runtime_partial
    # test_packed_runtime_partial: ASSERTION FAILED at lib/stackinit_kunit.c:338
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 33 - test_packed_runtime_partial
    # test_small_hole_runtime_all: ASSERTION FAILED at lib/stackinit_kunit.c:338
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 34 - test_small_hole_runtime_all
    ok 35 - test_big_hole_runtime_all # SKIP XFAIL uninit bytes: 124
    # test_trailing_hole_runtime_all: ASSERTION FAILED at
lib/stackinit_kunit.c:338
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 36 - test_trailing_hole_runtime_all
    # test_packed_runtime_all: ASSERTION FAILED at lib/stackinit_kunit.c:338
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 37 - test_packed_runtime_all
    # test_small_hole_assigned_static_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:339
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 38 - test_small_hole_assigned_static_partial
    ok 39 - test_big_hole_assigned_static_partial
    # test_trailing_hole_assigned_static_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:339
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 40 - test_trailing_hole_assigned_static_partial
    # test_packed_assigned_static_partial: ASSERTION FAILED at
lib/stackinit_kunit.c:339
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 41 - test_packed_assigned_static_partial
    # test_small_hole_assigned_static_all: ASSERTION FAILED at
lib/stackinit_kunit.c:339
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 42 - test_small_hole_assigned_static_all
    ok 43 - test_big_hole_assigned_static_all
    # test_trailing_hole_assigned_static_all: ASSERTION FAILED at
lib/stackinit_kunit.c:339
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 44 - test_trailing_hole_assigned_static_all
    # test_packed_assigned_static_all: ASSERTION FAILED at
lib/stackinit_kunit.c:339
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 45 - test_packed_assigned_static_all
    # test_small_hole_assigned_dynamic_all: ASSERTION FAILED at
lib/stackinit_kunit.c:340
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 46 - test_small_hole_assigned_dynamic_all
    ok 47 - test_big_hole_assigned_dynamic_all # SKIP XFAIL uninit bytes: 124
    # test_trailing_hole_assigned_dynamic_all: ASSERTION FAILED at
lib/stackinit_kunit.c:340
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 48 - test_trailing_hole_assigned_dynamic_all
    # test_packed_assigned_dynamic_all: ASSERTION FAILED at
lib/stackinit_kunit.c:340
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 49 - test_packed_assigned_dynamic_all
    # test_small_hole_assigned_copy: ASSERTION FAILED at
lib/stackinit_kunit.c:341
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 50 - test_small_hole_assigned_copy
    ok 51 - test_big_hole_assigned_copy # SKIP XFAIL uninit bytes: 124
    # test_trailing_hole_assigned_copy: ASSERTION FAILED at
lib/stackinit_kunit.c:341
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 52 - test_trailing_hole_assigned_copy
    # test_packed_assigned_copy: ASSERTION FAILED at lib/stackinit_kunit.c:341
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 53 - test_packed_assigned_copy
    # test_u8_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 1 wide, target offset by 16)
    not ok 54 - test_u8_none
    # test_u16_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 2 wide, target offset by 16)
    not ok 55 - test_u16_none
    # test_u32_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 4 wide, target offset by 16)
    not ok 56 - test_u32_none
    # test_u64_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 8 wide, target offset by 16)
    not ok 57 - test_u64_none
    # test_char_array_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 4)
    not ok 58 - test_char_array_none
    # test_switch_1_none: ASSERTION FAILED at lib/stackinit_kunit.c:409
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 80 wide, target offset by 16)
    not ok 59 - test_switch_1_none
    # test_switch_2_none: ASSERTION FAILED at lib/stackinit_kunit.c:410
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 80 wide, target offset by 16)
    not ok 60 - test_switch_2_none
    # test_small_hole_none: ASSERTION FAILED at lib/stackinit_kunit.c:344
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 61 - test_small_hole_none
    ok 62 - test_big_hole_none # SKIP XFAIL uninit bytes: 128
    # test_trailing_hole_none: ASSERTION FAILED at lib/stackinit_kunit.c:344
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 63 - test_trailing_hole_none
    # test_packed_none: ASSERTION FAILED at lib/stackinit_kunit.c:344
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 16 wide, target offset by 16)
    not ok 64 - test_packed_none
    # test_user: ASSERTION FAILED at lib/stackinit_kunit.c:346
    Expected range_contains(fill_start, fill_size, target_start,
target_size) to be true, but is false

stack fill missed target!? (fill 14 wide, target offset by 16)
    not ok 65 - test_user
# stackinit: pass:6 fail:53 skip:6 total:65
# Totals: pass:6 fail:53 skip:6 total:65
not ok 1 - stackinit

[1] https://lore.kernel.org/r/CAMuHMdW6N40+0gGQ+LSrN64Mo4A0-ELAm0pR3gWQ0mNanyBuUQ@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
