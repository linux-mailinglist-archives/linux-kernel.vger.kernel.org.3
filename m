Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7878508F53
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359825AbiDTS0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiDTS0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:26:38 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F5369F7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:23:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t13so2368021pgn.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YI0WvZfDRiIZlnYbMs20GbfHnC1WnSfcrZ2nPiwozcg=;
        b=1PVLSSt5QzCV+opfijZEKIpGHKjEQOucuE/Q+opZ6FIycjE30kOhB4S2D+Ybk2pAXP
         gyxbwDOhTlD7iV99Cu88/wxjUGk1PgwsZ2NyiC8BAPz4ZeWqpP82zAy7yqFo3NTYgeT9
         NJ86XUq6abs7jFluTuM/+Yi/zkWvNESZjsmVlu7gw2FovLcCvDcfukhh3AS8tc2d4DEP
         8YpnsIJNwP5Rouu4n0PZRC1026GCHkDEnRcbMbMVQMGwWz83hYQyKVlaZNq/wh6LLXku
         NXvbfoAf1IAG+LLqYXXR0UYZc3rrwktm024I6d/MF1OvYXBvqEowrnYvC7y0AsVnzMX/
         zgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YI0WvZfDRiIZlnYbMs20GbfHnC1WnSfcrZ2nPiwozcg=;
        b=P/IwB63loUp94Sf80Y0yacGmBgk976csG86h1uxN4kL3yRd55alcOGZxfGIR5sk7gs
         7avNBym5/Bic1pH92S3S8W3DzvSVompqg6pAmB0KG1mOLWXwHtGu1zsycvuTzVlLvuyV
         hnv5Y8j8picrj6kE8Ftp0aHuAACuRMBRRhndMYDiV8F+60itEo6TWIBKnikDhHogUb98
         V/Ksjg+nzJX0jQuZBCkiWa5mXmjEQf3ALTEf2bdQ/gM46tfbf0GTgZCpnmtJC9BqI7uH
         Q03f3nVANJwHjq/wVwLWJma7lUoxwa7It7fmd6+LxyopF3vUOpuA7rsma/Z/NcZX0eCZ
         kaVA==
X-Gm-Message-State: AOAM530mjmGlIDaNgbieihpSDvJz14geWWXWI3y2ikhVpF6Y1CA1zgBy
        f+QGFwBBifw6bdGtDc5xTi4/FbH0OegGTw==
X-Google-Smtp-Source: ABdhPJw9PvZMmNFgtvItIL2aweoaYQwF5YVtqGJ72BzHBVfYT7FCLoHrS4h41lIjpYtNjxxSjm8KUw==
X-Received: by 2002:a63:5747:0:b0:381:54b9:b083 with SMTP id h7-20020a635747000000b0038154b9b083mr20271264pgm.178.1650479030161;
        Wed, 20 Apr 2022 11:23:50 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm23350309pfh.58.2022.04.20.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:23:49 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:23:49 -0700 (PDT)
X-Google-Original-Date: Wed, 20 Apr 2022 11:14:06 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: implement cache-management errata for T-Head SoCs
In-Reply-To: <CAHB2gtQMzAgukfF-eFS-OnaULrK6CnqK2AHOFKqKG8e4BtYUCA@mail.gmail.com>
CC:     heiko@sntech.de, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        philipp.tomsich@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     cmuellner@linux.com
Message-ID: <mhng-5e7cf7ec-b9dc-4d7c-ad16-a523d035834c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 07:57:14 PDT (-0700), cmuellner@linux.com wrote:
> On Wed, Apr 20, 2022 at 2:18 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Thu, 31 Mar 2022 01:22:29 PDT (-0700), heiko@sntech.de wrote:
>> > Hi Palmer,
>> >
>> > Am Donnerstag, 31. März 2022, 04:30:36 CEST schrieb Palmer Dabbelt:
>> >> On Mon, 07 Mar 2022 14:46:20 PST (-0800), heiko@sntech.de wrote:
>> >> > The T-Head C906 and C910 implement a scheme for handling
>> >> > cache operations different from the generic Zicbom extension.
>> >> >
>> >> > Add an errata for it next to the generic dma coherency ops.
>> >> >
>> >> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> >> > ---
>> >> >  arch/riscv/Kconfig.erratas           | 10 +++++++
>> >> >  arch/riscv/errata/thead/errata.c     |  5 ++++
>> >> >  arch/riscv/include/asm/errata_list.h | 45
> ++++++++++++++++++++++++++--
>> >> >  3 files changed, 57 insertions(+), 3 deletions(-)
>> >> >
>> >> > diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
>> >> > index de4002baa1d0..89a6dcb8ac2a 100644
>> >> > --- a/arch/riscv/Kconfig.erratas
>> >> > +++ b/arch/riscv/Kconfig.erratas
>> >> > @@ -50,4 +50,14 @@ config ERRATA_THEAD_PBMT
>> >> >
>> >> >      If you don't know what to do here, say "Y".
>> >> >
>> >> > +config ERRATA_THEAD_CMO
>> >> > +  bool "Apply T-Head cache management errata"
>> >> > +  depends on ERRATA_THEAD && RISCV_DMA_NONCOHERENT
>> >> > +  default y
>> >> > +  help
>> >> > +    This will apply the cache management errata to handle the
>> >> > +    non-standard handling on non-coherent operations on T-Head SoCs.
>> >> > +
>> >> > +    If you don't know what to do here, say "Y".
>> >> > +
>> >> >  endmenu
>> >> > diff --git a/arch/riscv/errata/thead/errata.c
> b/arch/riscv/errata/thead/errata.c
>> >> > index fd8e0538a3f0..11c26c37425f 100644
>> >> > --- a/arch/riscv/errata/thead/errata.c
>> >> > +++ b/arch/riscv/errata/thead/errata.c
>> >> > @@ -33,6 +33,11 @@ static const struct errata_info
> errata_list[ERRATA_THEAD_NUMBER] = {
>> >> >            .stage = RISCV_ALTERNATIVES_EARLY_BOOT,
>> >> >            .check_func = errata_mt_check_func
>> >> >    },
>> >> > +  {
>> >> > +          .name = "cache-management",
>> >> > +          .stage = RISCV_ALTERNATIVES_BOOT,
>> >> > +          .check_func = errata_mt_check_func
>> >> > +  },
>> >> >  };
>> >> >
>> >> >  static u32 thead_errata_probe(unsigned int stage, unsigned long
> archid, unsigned long impid)
>> >> > diff --git a/arch/riscv/include/asm/errata_list.h
> b/arch/riscv/include/asm/errata_list.h
>> >> > index 7a2dd61af24d..f7c6805daeab 100644
>> >> > --- a/arch/riscv/include/asm/errata_list.h
>> >> > +++ b/arch/riscv/include/asm/errata_list.h
>> >> > @@ -16,7 +16,8 @@
>> >> >
>> >> >  #ifdef CONFIG_ERRATA_THEAD
>> >> >  #define   ERRATA_THEAD_PBMT 0
>> >> > -#define   ERRATA_THEAD_NUMBER 1
>> >> > +#define   ERRATA_THEAD_CMO 1
>> >> > +#define   ERRATA_THEAD_NUMBER 2
>> >> >  #endif
>> >> >
>> >> >  #define   CPUFEATURE_SVPBMT 0
>> >> > @@ -104,8 +105,37 @@ asm volatile(ALTERNATIVE(
>                                       \
>> >> >  #define CBO_CLEAN_A0      ".long 0x25200F"
>> >> >  #define CBO_FLUSH_A0      ".long 0x05200F"
>> >> >
>> >> > +/*
>> >> > + * dcache.ipa rs1 (invalidate, physical address)
>> >> > + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> >> > + *   0000001    01010      rs1       000      00000  0001011
>> >> > + * dache.iva rs1 (invalida, virtual address)
>> >> > + *   0000001    00110      rs1       000      00000  0001011
>> >> > + *
>> >> > + * dcache.cpa rs1 (clean, physical address)
>> >> > + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> >> > + *   0000001    01001      rs1       000      00000  0001011
>> >> > + * dcache.cva rs1 (clean, virtual address)
>> >> > + *   0000001    00100      rs1       000      00000  0001011
>> >> > + *
>> >> > + * dcache.cipa rs1 (clean then invalidate, physical address)
>> >> > + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> >> > + *   0000001    01011      rs1       000      00000  0001011
>> >> > + * dcache.civa rs1 (... virtual address)
>> >> > + *   0000001    00111      rs1       000      00000  0001011
>> >> > + *
>> >> > + * sync.s (make sure all cache operations finished)
>> >> > + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> >> > + *   0000000    11001     00000      000      00000  0001011
>> >> > + */
>> >> > +#define THEAD_INVAL_A0    ".long 0x0265000b"
>> >> > +#define THEAD_CLEAN_A0    ".long 0x0245000b"
>> >> > +#define THEAD_FLUSH_A0    ".long 0x0275000b"
>> >> > +#define THEAD_SYNC_S      ".long 0x0190000b"
>> >>
>> >> IIRC this came up before, but these really need to get into the
>> >> assembler as actual instructions.
>> >
>> > okay :-) .
>> >
>> > But just for my understanding which of the two ways going forward:
>> > - keep this in the waiting area _until_ a suitable binutils is released
>> > - use the coded instructions now and convert later once binutils is
> released
>> >
>> > The reason I ask is, that any chip with a t-head core like the
> Allwinner-D1
>> > will need this for things like basic networking, so with the binutils
>> > release schedule, I guess we'd be looking at autumn 2022 at the
> earliest.
>>
>> I'm not the binutils release maintainer, so I can't really sign off on a
>> release date, but give the history that sounds about right to me.  I get
>> it's a headache to have to have a toolchain that supports the ISA, but
>> if it was really that important it would have made one of the last two
>> releases -- I very specifically remember talking to the folks at the
>> RISC-V foundation about this the better part of a year ago, but they
>> decided to play at politics instead of being constructive so now we have
>> two messes to clean up.
>>
>> I volunteered Patrick to send binutils patches for the T-Head cache
>> control stuff (as I didn't have time to write it myself this weekend),
>
> I wrote (to you in response to your request) on Mar 31, that I'm going to
> work on that
> in a 3-4 weeks timeframe. Therefore this is quite surprising.
> I wonder how to coordinate work with you.

The coordination looks perfect to me: Patrick started (and finished, as 
it only took an hour or two) the implementation two weeks and six days 
after your post saying you'd start in 3-4 weeks, so presumably you 
hadn't started yet and thus we just saved you some time -- I certainly 
always appreciate folks helping out, doubly so when it seems urgent (as 
this did at the time).

IMO the real coordination miss was that there's already been a much more 
comprehensive implementation of these in one of the RISC-V branches for 
months now, so it looks like this was all finished before any of us even 
started.  Probably best to go talk about this on the binutils mailing 
list, as that's where most of the relevant folks hang out.

Sorry to have stepped on your toes here, I guess this isn't nearly as 
urgent as I thought it was.  I'm in no particular rush for this one, so 
sounds like it can wait for the toolchain stuff to get sorted out

>> it's only a dozen or so instructions and thus shouldn't take that long.
>> At least that way we can get a rough consensus on how we're going to
>> move forward with the toolchain support, which we really need before
>> we're going to start depending on anything.
>>
>> Sorry you got pulled into all this.
>>
>> > Thanks
>> > Heiko
>> >
>> >> > +
>> >> >  #define ALT_CMO_OP(_op, _start, _size)
>                        \
>> >> > -asm volatile(ALTERNATIVE(
>               \
>> >> > +asm volatile(ALTERNATIVE_2(
>                       \
>> >> > +  "nop\n\t"
>               \
>> >> >    "nop\n\t"
>               \
>> >> >    "nop\n\t"
>               \
>> >> >    "nop\n\t"
>               \
>> >> > @@ -117,7 +147,16 @@ asm volatile(ALTERNATIVE(
>                                       \
>> >> >    CBO_##_op##_A0 "\n\t"
>               \
>> >> >    "addi a0, a0, %0\n\t"
>               \
>> >> >    "2:\n\t"
>                \
>> >> > -  "bltu a0, %2, 3b\n\t", 0, CPUFEATURE_CMO,
> CONFIG_RISCV_DMA_NONCOHERENT)         \
>> >> > +  "bltu a0, %2, 3b\n\t"
>               \
>> >> > +  "nop", 0, CPUFEATURE_CMO, CONFIG_RISCV_DMA_NONCOHERENT,
>               \
>> >> > +  "mv a0, %1\n\t"
>               \
>> >> > +  "j 2f\n\t"
>                \
>> >> > +  "3:\n\t"
>                \
>> >> > +  THEAD_##_op##_A0 "\n\t"
>               \
>> >> > +  "addi a0, a0, %0\n\t"
>               \
>> >> > +  "2:\n\t"
>                \
>> >> > +  "bltu a0, %2, 3b\n\t"
>               \
>> >> > +  THEAD_SYNC_S, THEAD_VENDOR_ID, ERRATA_THEAD_CMO,
> CONFIG_ERRATA_THEAD_CMO)       \
>> >> >    : : "I"(L1_CACHE_BYTES), "r"((_start) & ~(L1_CACHE_BYTES - 1)),
>               \
>> >> >        "r"(ALIGN((_start) + (_size), L1_CACHE_BYTES)))
>> >>
