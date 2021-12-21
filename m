Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B8747C4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbhLURNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:13:06 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:58255 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbhLURNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:13:04 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M4s8v-1n0XuK0OqF-001yOu; Tue, 21 Dec 2021 18:13:03 +0100
Received: by mail-wr1-f48.google.com with SMTP id c4so28305783wrd.9;
        Tue, 21 Dec 2021 09:13:03 -0800 (PST)
X-Gm-Message-State: AOAM531nzMFYvFhmCst1DwC1uT5SXYSZwDc1FAHXjyyMxt4CpVntTUIG
        NPcMvZYqmg6/VkfWkIE0LwB7C5g5AbMeis/BaRA=
X-Google-Smtp-Source: ABdhPJxbIqjyU8TaVGGex6NdChPO7fkenTBnB/BLD4Lq+OCkYunXjff2m0E1G3pTqKAWxFdhJPGy7XhHYU7jc7xKAk4=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr3336935wru.12.1640106782679;
 Tue, 21 Dec 2021 09:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-4-guoren@kernel.org>
In-Reply-To: <20211221163532.2636028-4-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 18:12:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3navO2Z2F5zxisby5EBNDo8rwQ6hxSuyniFgFxrQ5qXQ@mail.gmail.com>
Message-ID: <CAK8P3a3navO2Z2F5zxisby5EBNDo8rwQ6hxSuyniFgFxrQ5qXQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] riscv: compat: Add basic compat date type implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        Drew Fustini <drew@beagleboard.org>, wangjunqiang@iscas.ac.cn,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pBb1Ng8Nh1/iOIIQOjPW9XCHZ5jotfOcKb3GWhsoe9aEOLu57l3
 /RXqhzC/5kSDWRxp2UAPEi9IbSgr78VnWQSu+XzqkTjFNq9q/HbzFfeDTGs4GNv45mf0W+7
 JeLgdiZRSBrF3u+Bx1K3mdmUPA37DsKBYtH652GgVAenKGiHVGjGrXrUTrhdTpsDegW4vGe
 fIPen64j2hxIMC3z1q3OQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0nrr0CbcCTs=:6FDjpdEmuR1HpWIePD19sa
 0jI2NJKmcjQx3/kvY7z6u9FVqKJsgN2Yue9WcpWNPr/d+1eS0sh2XOAt6wjqkgk1ErtqsfrrX
 6t7mjAKr+F+OjU41cPZKFXxaipV5280+dDtroyjNYYfw235EztUx98wBUYyi0/jXJdGy+sjwo
 v4mreNQkwwGK3U/hTh85SdVQzYYc1VhncSJbszVsX6x0F5P0FIBMjJtOzHXC9Y0eg/T+xsAHA
 XbH3Ju5MLAJjQfa7YlzmqvFJjMXSOsZGna4s25hOu9DE30PpmMvLTUxFL6Kig8Q+oFVkbRF3W
 gKBnzF+P2Wv5CvS5At/wxsGtQZrK0yomhvFAnC5TWmdszl0UR7h/g9Uif4Jj6H+CmxEyJNjfM
 ziy1GNFQgWKZ5JuvHnPSkHx1/TbrfU3ToRjvG/zjSReCe8M06jXd1GvSkYCKCq24VYuukNG4o
 gQH2L3K//xVwwqQBYKx1TM1YqBDYfc+eDxlIbUIc8w9v+sZnA99W8+n0Hzs6pGSB8WEVQqqbh
 +vVnfHkniCX1+agZMsgiurvgtzWRi/49fWtT0L58+QCNt8aWcetrRuAyCnP9GtxBiuxQ0Spvq
 MOhG93uLibwVRvUcbMKNKi4Z9n6y1AOY2yG4CS2BxrI7EUY28bI98Ee/3PVQJuzoBSx7u7BPY
 HdwCHsjQ4wcm37KDPB9sLXovJ5IFo7keA5jtPkRAEA1vqlLLzPGc3AEvdAMTK96RiQGlNQvjy
 za9wgLy6t2NLcY8BCULNaP6kY2shhUMvw5NKJQurDJIZTnfpMLKfFPbw0xUcQM18g3E2mwVFV
 CmS/TvRa3AA2jE+plOT/ylqIgfW4VL5TmM5z+R6ly4CZgg5qwQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Implement asm/compat.h for struct compat_xxx, RLIM_INFINITY,
> OFF_T_MAX, is_compat_task, compat_user_regset, regset convert.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/include/asm/compat.h      | 259 +++++++++++++++++++++++++++

Since both the native and compat side use the generic interface, I think this
should all be part of asm-generic/compat.h, in case other architectures want to
share this in the future. Maybe see if any other architectures use the
same definition
for some of the structures and then remove the duplicates.

> +struct compat_stat {
> +       compat_ulong_t  st_dev;
> +       compat_ulong_t  st_ino;
> +       compat_uint_t   st_mode;
> +       compat_uint_t   st_nlink;

You should not need a compat_stat, because native rv32 does not have a
stat() syscall.

> +static inline int is_compat_task(void)
> +{
> +       return test_thread_flag(TIF_32BIT);
> +}
> +
> +struct compat_user_regs_struct {
> +       compat_ulong_t pc;
> +       compat_ulong_t ra;

These clearly need to stay in arch/riscv

        Arnd
