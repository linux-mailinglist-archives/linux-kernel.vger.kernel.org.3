Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A526257E421
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiGVQIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiGVQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:08:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E7F2AE1E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:08:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e69so3975072iof.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7JAXVEFnWimuZXltx5cxV25+FGeezQ26Tfa548oQO8=;
        b=AKg4CKoLoF1WNueEuRzcsi+0gsOLLmi89vyNneQ5XrS/iWZdXbOPk667+ihJuUftd6
         3abx0TfIakeNsSuoG1TaBjyBIU1AbUNyQ5N5xAHnMl7Q+2nDbcH/ZTDlU/HC3VcKMjzG
         N2ORyQwvsBzcpUPe7ZoYc2XWblFA/sY1/CfcW1UVuL73pN8WUQU3ugO+886jRnfggcvI
         iGUNBB+5qxgbOMymyaMMpYeGveeupWexyDwmzurjtGZuPRluSlgtsV+BW20EwHwKFk0V
         HSrtg8khgA5jgC1fM4VBMJsQZ2bZviVi98p4NVU9S+n5QNQwxybTv9Rn9kB5ohSlHyFK
         K5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7JAXVEFnWimuZXltx5cxV25+FGeezQ26Tfa548oQO8=;
        b=Z2hTD7jpHdK+LAGQEG9dcoritaCswVyiDpPYtmxCoxytGpsVWJgmRI/zHBMhSm07QW
         7Z7ZrD9sZxEFVaelbLffXAGEdNbpKzdincSl+K9V7PkC9ZW9P2daJAAyfINwyLZSgfIq
         aiufFfhXyiEdZ9X4bfCU2kzGK6CqnzMlPi1YmuRdLp06c98Vv9OTXJH97fpNlyiUjAGc
         qumPCl9auyw+AH42Klfv8tFLnBSjnbUKMC+fu/E/T9mLJAZcMfZ1NZKhBQoZPIuHr9mX
         RbWH3dYX2t0aK1GGQdFx0RCRw5u+iOliBpN1jt4PCXNI8RgBYDCqUQXpj2lSVSu04T3v
         peVQ==
X-Gm-Message-State: AJIora+ZhZPNIrUJayxJrimCr0kqKEX0lA2TreZ4VOu7gV9PFtWhJQbP
        RzOgLPBExKj7oLbyh3bi6K/PNmyVP/djrZxS9cApM/WEs24=
X-Google-Smtp-Source: AGRyM1tVSc76ZNELwLEEoFJwS7/fNZtZAtKRXLdOFypcYBPqk+i0C87nyeUkAa0tSOlb1uU1R8yx3Wtn/DydWNX3y2A=
X-Received: by 2002:a02:854b:0:b0:341:7894:6c50 with SMTP id
 g69-20020a02854b000000b0034178946c50mr362379jai.234.1658506093418; Fri, 22
 Jul 2022 09:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com> <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
 <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com>
 <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com> <CAD4RrFPfwu4Ascj5tdz8qq2Qgnu5GN2eHjVwMW5AqUa1H7JapA@mail.gmail.com>
 <49a8be9269ee47de9fc2d0d7f09eb0b1@AcuMS.aculab.com> <5d14cf64-46b7-dc37-bbb8-dd6be82d06af@gmail.com>
 <999057a9-d209-323b-90eb-5756b7c0e91e@gmail.com> <658586b208ea4339b3ead19378484434@AcuMS.aculab.com>
In-Reply-To: <658586b208ea4339b3ead19378484434@AcuMS.aculab.com>
From:   Yu-Jen Chang <arthurchang09@gmail.com>
Date:   Sat, 23 Jul 2022 00:08:02 +0800
Message-ID: <CAD4RrFPeX=HaB9R3MmJgg0BqvPJKVjroMxEpjkS_8eaYe7rUJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
To:     David Laight <David.Laight@aculab.com>,
        "andy@kernel.org" <andy@kernel.org>,
        Andrey Semashev <andrey.semashev@gmail.com>
Cc:     "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 6:24 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Andrey Semashev
> > Sent: 13 July 2022 11:03
> >
> > On 7/13/22 12:49, Andrey Semashev wrote:
> > > On 7/13/22 12:39, David Laight wrote:
> > >> From: Yu-Jen Chang
> > >>> Sent: 12 July 2022 15:59
> > >> ...
> > >>>> I think you're missing the point. Loads at unaligned addresses may not
> > >>>> be allowed by hardware using conventional load instructions or may be
> > >>>> inefficient. Given that this memchr implementation is used as a fallback
> > >>>> when no hardware-specific version is available, you should be
> > >>>> conservative wrt. hardware capabilities and behavior. You should
> > >>>> probably have a pre-alignment loop.
> > >>>
> > >>> Got it. I add  pre-alignment loop. It aligns the address to 8 or 4bytes.
> > >>
> > >> That should be predicated on !HAS_EFFICIENT_UNALIGNED_ACCESS.
> > >>
> > >> ...
> > >>>         for (; p <= end - 8; p += 8) {
> > >>>             val = *(u64*)p ^ mask;
> > >>>             if ((val + 0xfefefefefefefeffull)
> > >>> & (~val & 0x8080808080808080ull))
> > >>>                 break;
> > >>
> > >> I would add a couple of comments, like:
> > >>    // Convert to check for zero byte.
> > >>    // Standard check for a zero byte in a word.
> > >> (But not the big 4 line explanation you had.
> > >>
> > >> It is also worth looking at how that code compiles
> > >> on 32bit arch that don't have a carry flag.
> > >> That is everything based on MIPS, including riscv.
> > >
> > > It may be worth looking at how glibc does it:
> > >
> > >
> > https://sourceware.org/git/?p=glibc.git;a=blob;f=string/memchr.c;h=422bcd0cd646ea46711a57fa3cbdb8a3329
> > fc302;hb=refs/heads/release/2.35/master#l46
> > >
> > > They do use 32-bit words on 32-bit targets and 64-bit on 64-bit ones. I
> > > think memchr in the kernel should follow this.
> >
> > Also, if by chance this optimization is aimed for x86-64, it may be
> > worth adding an arch-specific version that uses ERMS.
>
> Don't believe everything you see in glibc.
> The common cases in the kernel are different from the ones they
> tend to optimise for..
>
> You might try using:
>         #define GEN_MASK(x) (x * (unsigned long)0x0101010101010101ull)
> for the mask and the two constants.
> Then make all the variables 'long'.
>
> I'm not at all sure what the test for fast multiply is about.
> It may be very historic, for modern cpu generating the 64bit
> constant is likely to be more problematic (check arm64).
> If the input value is 'unsigned char' (or masked) then the
> compiler may decide to do the repeated <<= itself.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)


I have rewrite my code as the following. I use several macros to
generate the mask and detect target char for 32-bit or 64-bit.
The  DETECT_CHAR macro is the same as this part:

(val + 0xfefefefefefefeffull) & (~val & 0x8080808080808080ull)

The 0xfefefefefefefeffull is the 2's complement of  0x0101010101010101ULL.
I perform subtraction here exactly.

If the CPU architecture is unable to perform unaligned access
efficiently, the pre-alignment loop will align the string at first.


#define LBLOCKSIZE (sizeof(long))
#if BITS_PER_LONG == 64

#define DETECT_CHAR(X)                                                         \
(((X) - 0x0101010101010101ULL) & ~(X) & 0x8080808080808080ULL)

#define MEMCHR_MASK_GEN(mask)                                                  \
do {                                                                   \
    (mask) |= (mask) << 8;                                         \
    (mask) |= (mask) << 16;                                        \
    (mask) |= (mask) << 32;                                        \
} while (0)

#else

#define DETECT_CHAR(X) (((X)-0x01010101UL) & ~(X)&0x80808080UL)

#define MEMCHR_MASK_GEN(mask)                                                  \
do {                                                                   \
    (mask) |= (mask) << 8;                                         \
    (mask) |= (mask) << 16;                                        \
} while (0)

#endif

void *memchr(const void *p, int c, size_t length)
{
    unsigned long mask, val;
    const void *end = p + length;
    c &= 0xff;
#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
    while ((long)p & (sizeof(long) - 1)) {
        if (p >= end)
            return NULL;
        if (*(unsigned char *)p == c)
            return (void *)p;
        p++;
    }
#endif
    if (p <= end - LBLOCKSIZE) {
        mask = c;
        MEMCHR_MASK_GEN(mask);

       for (; p <= end - LBLOCKSIZE; p += LBLOCKSIZE) {
              val = *(unsigned long *)p ^ mask;
              if (DETECT_CHAR(val))
                  break;
       }
    }

    for (; p < end; p++)
       if (*(unsigned char *)p == c)
           return (void *)p;

    return NULL;
}
