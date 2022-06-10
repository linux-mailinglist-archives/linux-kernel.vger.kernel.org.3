Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6771546558
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245577AbiFJLSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiFJLSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:18:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615CDA463;
        Fri, 10 Jun 2022 04:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17DAAB8343D;
        Fri, 10 Jun 2022 11:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACF2C3411E;
        Fri, 10 Jun 2022 11:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654859882;
        bh=liaJLfEIyp9wRChPg47VA68kcsJONDQXZp7xwIX/Gfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AEo22SY/chNfBVjIyw90+Y9rqn0J0AJAVSEFPpDKCR0aBTXWM9PyPI7A1OcAKbxHD
         E9QsGbBrL2rYhCPdjDeBQTsyWUiKlMohZVTZxuSg22ILp3sSpjL0nYKTYD5Jd4+M+n
         kmI72nwZU9By9XpAtsCOqIQ/1JvjSsF1z3fhCM9aruJ0r3+jrEkyd0P51xn3dIH08a
         IpcMyhw38Lvs+VlCDVvw5tpBYuQNqmU4q52RlUeBMl3LGyX7/3UEEk26YnkySDaB8y
         uo+7NBwyJGy3ThZqdf6MjkTbGOICCsITgu3+SikGJNOrajEk96k7Rw3XS5wFgUbdAr
         pSxNYBur5fpdg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-fb1ae0cd9cso2777440fac.13;
        Fri, 10 Jun 2022 04:18:02 -0700 (PDT)
X-Gm-Message-State: AOAM531YaZl0ayWw1NG/bXhVso4qXXdyJ3bQCAyFOJhA6LR4dXM32ooB
        ih9wZVKOaMG+jXsj71VIFc+/aWDwx6EkVElna18=
X-Google-Smtp-Source: ABdhPJyHV9pczLO7bR3BeXXbXOqxM5v7eVEO9Y+2ijJPmgupZJTu78Yn0kBz4TZEVFpGxJOw3iwB/KiETZKkExxilGw=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr4422589oan.126.1654859871475; Fri, 10
 Jun 2022 04:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-3-mawupeng1@huawei.com> <bfa0b919-fbc1-056c-4ed9-e940edfb6125@huawei.com>
 <CAMj1kXGku3Y5d6Z+AAFkEauMWFY6LYpQAybqkXiQdRCMpS5tbw@mail.gmail.com> <174f988c-ea14-9f10-40e1-7bdddcef5d35@huawei.com>
In-Reply-To: <174f988c-ea14-9f10-40e1-7bdddcef5d35@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Jun 2022 13:17:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEGOmeaWhh6+LhtXTZ-M_cXz1rzTzbaGNrcmyshaSQP=Q@mail.gmail.com>
Message-ID: <CAMj1kXEGOmeaWhh6+LhtXTZ-M_cXz1rzTzbaGNrcmyshaSQP=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] arm64/mirror: arm64 enabling - find mirrored
 memory ranges
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Wupeng Ma <mawupeng1@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>, songmuchun@bytedance.com,
        Randy Dunlap <rdunlap@infradead.org>,
        damien.lemoal@opensource.wdc.com,
        Stephen Boyd <swboyd@chromium.org>,
        Wei Liu <wei.liu@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>, gpiccoli@igalia.com,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        vijayb@linux.microsoft.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 at 12:24, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
> On 2022/6/10 17:34, Ard Biesheuvel wrote:
> > On Fri, 10 Jun 2022 at 11:27, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >>
> >> On 2022/6/7 17:38, Wupeng Ma wrote:
> >>> From: Ma Wupeng <mawupeng1@huawei.com>
> >>>
> >>> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
> >>> introduced mirrored memory support for x86 and this could be used on arm64.
> >>>
> >>> Since we only support this feature on arm64, efi_find_mirror() won't be placed
> >>> into efi_init(), which is used by riscv/arm/arm64, it is added in setup_arch()
> >>> to scan the memory map and mark mirrored memory in memblock.
> >> Move into efi_init() looks better, it won't bring negative effects on
> >> arm/riscv.
> >>
> >> but let's maintainer to make a decision.
> >>
> >> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>
> > I don't disagree with that in principle, but x86 calls the efi fake
> > memmap stuff between efi_init() and efi_find_mirror(), and I already
> > indicated that I don't want to enable fake memmap on !X86.
>
> I mean move into efi_init() in drivers/firmware/efi/efi-init.c which
> only used
>
> in arm32/arm64/riscv.
>
> >
> > But I do think there is some room for improvement here: we could move
> > things like efi_mokvar_table_init() and efi_esrt_init() into
> > efi_init() as well, and make efi_fake_memmap() do nothing on !X86 so
> > we can move it into efi_init() too.
>
> x86 has own efi_init() in arch/x86/platform/efi/efi.c, it seams that all
> the above
>
> function could move into x86's own efi_init(), not sure, but we could do
> it later
>
> if it possible.
>

Yes, I see what you mean now. I agree that would be better.
