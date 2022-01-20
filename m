Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9A494F18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiATNgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiATNgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:36:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9DBC061574;
        Thu, 20 Jan 2022 05:36:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F6E0B81D72;
        Thu, 20 Jan 2022 13:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD834C340EB;
        Thu, 20 Jan 2022 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642685767;
        bh=6jJqCWRTzzUUFc2Awke9IkkPGC7X5zNsQTSVKll9PUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f6do9cXfKBIhavH9kot/9wsjq2yObe2lT7dMc1dGUr3hFaIHULRpc6Im9hBAIcisC
         eDekM99GYajIpqxj6pk3pf8POql1UVa55NAT7X5tjRFB9UsnxZslxCWB5WZWqBDVJr
         8gDeXdyIroIlE//1234wZAOr1J5PAF//PpO/tp0C8PN9cs8JcSeKYxBJeAO+fJX5f8
         Zzw9mWQdJHl7vQGGXNGqTETTdXAZvSS2AkRWCFWvBQVfO4iJLfOUyeTYEfGr+VvXtZ
         KkebSvrN6+FTyVOToFkMm3YZrKZfFcQi9tF8PdPBl3l8R5P30PQMDQ75SGyfnZ8nsJ
         hG4QcSP3+PQvg==
Received: by mail-ua1-f44.google.com with SMTP id w21so10825577uan.7;
        Thu, 20 Jan 2022 05:36:07 -0800 (PST)
X-Gm-Message-State: AOAM531LJ70N8LMRZ2TdBPaV73hkp1ciLeoEXk7VY2qxTOh4rmoc68xP
        TkVyDvyfTvnf1f6pQo/gb4BoeN1IYfj2c2iT42o=
X-Google-Smtp-Source: ABdhPJwONmW1aazI1eCt0g+A2J9M0/Dq8pC6p8K0QjKcU/9jXkiBA8g9Bq8N9trIX7DU0e3r8/DVXgSoIzqqFr0N4e8=
X-Received: by 2002:a05:6102:34ec:: with SMTP id bi12mr12309550vsb.51.1642685766798;
 Thu, 20 Jan 2022 05:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-11-guoren@kernel.org> <CAK8P3a2HaeFGdOr4Rm_ZcEP0rjh2Mo53=-ZRnEPtFfnmzfeE6g@mail.gmail.com>
In-Reply-To: <CAK8P3a2HaeFGdOr4Rm_ZcEP0rjh2Mo53=-ZRnEPtFfnmzfeE6g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 Jan 2022 21:35:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQnrCS1X6KQt0pbNFc01sYgBDgfb9RGT1G=rTEGK1mbRQ@mail.gmail.com>
Message-ID: <CAJF2gTQnrCS1X6KQt0pbNFc01sYgBDgfb9RGT1G=rTEGK1mbRQ@mail.gmail.com>
Subject: Re: [PATCH V3 10/17] riscv: compat: Add elf.h implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 9:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Implement necessary type and macro for compat elf. See the code
> > comment for detail.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> > +
> > +/*
> > + * FIXME: not sure SET_PERSONALITY for compat process is right!
> > + */
> > +#define SET_PERSONALITY(ex)                                    \
> > +do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)              \
> > +               set_thread_flag(TIF_32BIT);                     \
> > +       else                                                    \
> > +               clear_thread_flag(TIF_32BIT);                   \
> > +       if (personality(current->personality) != PER_LINUX32)   \
> > +               set_personality(PER_LINUX |                     \
> > +                       (current->personality & (~PER_MASK)));  \
> > +} while (0)
> > +
>
> The implementation looks good to me now,  you can remove that comment above it.
Thx for pointing it out. I forgot.

>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
