Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75FF55AEE2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiFZEdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFZEdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:33:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E5EE009
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 21:33:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso3670176wml.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 21:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kWtI1K8FBljQi8An/wyVTdiQqFYwSP32gsF9BQJ03c=;
        b=FrZZoDyueMWB46rAlqAH1OYPceblyGuoIYSuiJh9AP7soufPKW1Jm2zZlInD7vPgfI
         NdGX3xp4zNoqaACVAwsX+sYkPJm2kTFMCDSR2Ble7RTZVx4h5yM9Jw3Ne9acSpNBuH9a
         pOpSHXejHqY/PixidKUtyNYZ2wsP77du0gW5ht7HC/sE3XMHwI5ks7yjJVy8tNZRRnxp
         nuAYvLzeZTEeBv/e9XwsTzNXD+GY5Svw2Gqe0rRRmur2BeMr1Y6eEKv/zqvBj0HQta4H
         djnLpYv0J0I1qlh3c4tQJKQuPXbyVejuRk9BzjOClEUAiH/eUHlQ342iTEhIRspr6YYU
         0mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kWtI1K8FBljQi8An/wyVTdiQqFYwSP32gsF9BQJ03c=;
        b=hcoCPF+6ySbBsqj1q0DEFonyw/YoDyJS5+7DjPn00XLEUtPxha4jG3CbiMdfrkI9YU
         xHObsWcSKCJmh67gqiI3VXZLK5IYZo9me7SP6Rh1aQbyppoBharZZcKhqQ56KGThcS8X
         4rd3KVlKX+95XuA6D7qdgBb51zdGFxYxA5X79H0+hvajf7+/9wYZBZn8f+KX91jbAkAW
         R/DK+yx29cYqCg6aZjLQFU/OCaPvpjwnyiqv9Cm6gN24MwOS9Dd9hif1sYsoto+XKCQD
         0HYsdXCiK1k/NhVNubU6ouvOvfMHmZ+j6rM2fHyeKPgfeaZFcrIphHVRWKPF35wQYcKe
         XJQQ==
X-Gm-Message-State: AJIora+C02LoxajKzvHyBs47wSqlgr7Wt4hDqwJRRWjYzxT8V+G3MzXE
        K6s4pVPW7IGoyy+VBsXxhG9PSddSd7o8spkGfVlO4Q==
X-Google-Smtp-Source: AGRyM1vAT0OOLfOI5Wn7s+3waQl1AufOpwQ7c6bUsnwcB4orgjTFZbOh+qBgJ1TE3EXFDt05Nh9wdwF8DhrwnXuYvd0=
X-Received: by 2002:a05:600c:1d0b:b0:3a0:3ab8:924 with SMTP id
 l11-20020a05600c1d0b00b003a03ab80924mr7671319wms.137.1656217999456; Sat, 25
 Jun 2022 21:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220521143456.2759-1-jszhang@kernel.org>
In-Reply-To: <20220521143456.2759-1-jszhang@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 26 Jun 2022 10:03:07 +0530
Message-ID: <CAAhSdy0mkwacNMVa_jFZmZ+NRPBa1TpKUQGpzr6Z9_wfoq1R4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] use static key to optimize pgtable_l4_enabled
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 8:13 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> The pgtable_l4|[l5]_enabled check sits at hot code path, performance
> is impacted a lot. Since pgtable_l4|[l5]_enabled isn't changed after
> boot, so static key can be used to solve the performance issue[1].
>
> An unified way static key was introduced in [2], but it only targets
> riscv isa extension. We dunno whether SV48 and SV57 will be considered
> as isa extension, so the unified solution isn't used for
> pgtable_l4[l5]_enabled now.
>
> patch1 fixes a NULL pointer deference if static key is used a bit earlier.
> patch2 uses the static key to optimize pgtable_l4|[l5]_enabled.
>
> [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html
> [2] https://lore.kernel.org/linux-riscv/20220517184453.3558-1-jszhang@kernel.org/T/#t
>
> Since v3:
>  - fix W=1 call to undeclared function 'static_branch_likely' error
>
> Since v2:
>  - move the W=1 warning fix to a separate patch
>  - move the unified way to use static key to a new patch series.
>
> Since v1:
>  - Add a W=1 warning fix
>  - Fix W=1 error
>  - Based on v5.18-rcN, since SV57 support is added, so convert
>    pgtable_l5_enabled as well.
>
>
>
> Jisheng Zhang (2):
>   riscv: move sbi_init() earlier before jump_label_init()
>   riscv: turn pgtable_l4|[l5]_enabled to static key for RV64

I have tested both these patches on QEMU RV64 and RV32.

Tested-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

>
>  arch/riscv/include/asm/pgalloc.h    | 16 ++++----
>  arch/riscv/include/asm/pgtable-32.h |  3 ++
>  arch/riscv/include/asm/pgtable-64.h | 60 ++++++++++++++++++---------
>  arch/riscv/include/asm/pgtable.h    |  5 +--
>  arch/riscv/kernel/cpu.c             |  4 +-
>  arch/riscv/kernel/setup.c           |  2 +-
>  arch/riscv/mm/init.c                | 64 ++++++++++++++++++-----------
>  arch/riscv/mm/kasan_init.c          | 16 ++++----
>  8 files changed, 104 insertions(+), 66 deletions(-)
>
> --
> 2.34.1
>
