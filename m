Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D0F53E00C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352309AbiFFD0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiFFD0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:26:00 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587C50005;
        Sun,  5 Jun 2022 20:25:59 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f7so11152680ilr.5;
        Sun, 05 Jun 2022 20:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ukIT3B6hBMFSPp16HUKNAMiUDGfxCc3pND9Rxs8UI8Y=;
        b=DW9rNpFS2MJt6SmT1vldjP10FL6qXbj3+e9zxTfsg53TQaARjVumx2Yoz3BgQ9/TvT
         ssXrNrclXSQRWTkrwrOwXM/Yc0hpucqaFS4K7V2hCxlCP0G9+soIVYOd8yCaS3Ia9XEN
         Yo3773ytPJkQpwnLLzhdwszkWIWycxN6W+xbe8M/IZ/1YYGXGCVemQt5gQJzTnfZ00Vq
         2n6hcJ8FXtFHLO4ewgmiNOJNppGG+ByTkVbvpmA/GuoEPsGLuaFRiv8Nea7CjijUFRuE
         wh9jlkXTCmv5n5zftumv/sd7fnHCw09b0pKc6M1+b26YZjHfrgmnIz8GK+mnOApHyPt7
         3bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ukIT3B6hBMFSPp16HUKNAMiUDGfxCc3pND9Rxs8UI8Y=;
        b=Yht3eYI5lDBZb7Y4Q7hiVh1JKbT9Sj0SSmkeLDcNgd6J35MayKn2tU7zkMChM3C1+b
         e/6gfzLRPG1w5OflwSEm4YMRbbFDtnDHDJl2pzpGkFCGnUxLkscSLr+bEm7JPb5lk8Bs
         HWAGhSXnbaHB/3QyKou90u4xt6hfNEyf1/ith2DZftWc7x91xeBF55E6qRdXTB/bapOx
         rqP6yFJPRBgxlWNjfCuy01FdjqarJ1O+pMjrKlLS0cvz7S/Vvq+fWsZSRVvDV0hDX8vr
         HW7GzqpuGOn9XL4bXpBU2ueNiSnSq8HTaPgt1V/YCAx/DlFeJ59D3znbcjPMNCP7BIAI
         YKRg==
X-Gm-Message-State: AOAM530r4M6Al8bsSTK54xig5MNOlshopPDCqO9ECzMijsWywhVNFpiU
        KaDl7aa1BQg41BTl38nvS/XAdRrgW5fsS5qfvlo=
X-Google-Smtp-Source: ABdhPJyPN3PCuSdBiKHcfEllvw6Dvs+RP1Q83f7g25f/TfIPu9LmjIk5C4TfEyzuAa6RZd4FXBDg4M8aPV9OUTl7pvk=
X-Received: by 2002:a05:6e02:174c:b0:2d3:c1e2:36fe with SMTP id
 y12-20020a056e02174c00b002d3c1e236femr13826360ill.121.1654485958245; Sun, 05
 Jun 2022 20:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220528081236.3020-1-arthurchang09@gmail.com>
 <20220528081236.3020-2-arthurchang09@gmail.com> <8b480c85f53c4f3b88bf99ba585e8768@AcuMS.aculab.com>
 <CAD4RrFOHaE0NKjPHw3RaUSrD6vZwnpHbY01bcO3emkoia2of6Q@mail.gmail.com> <5afc275656764ee6818693dfd39df764@AcuMS.aculab.com>
In-Reply-To: <5afc275656764ee6818693dfd39df764@AcuMS.aculab.com>
From:   Yu-Jen Chang <arthurchang09@gmail.com>
Date:   Mon, 6 Jun 2022 11:25:46 +0800
Message-ID: <CAD4RrFOtP3VZaszTmA3M7WkEgqc_KxejpZ57BpWRoC8+rs7=bQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/lib: Optimize memchr()
To:     David Laight <David.Laight@aculab.com>
Cc:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "jdike@linux.intel.com" <jdike@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@aculab.com> =E6=96=BC 2022=E5=B9=B46=E6=9C=881=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:25=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Yu-Jen Chang
> > Sent: 01 June 2022 06:59
> >
> > David Laight <David.Laight@aculab.com> =E6=96=BC 2022=E5=B9=B45=E6=9C=
=8830=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:10=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > From: Yu-Jen Chang
> > > > Sent: 28 May 2022 09:13
> > > >
> > > > The original assembly version of memchr() is implemented with
> > > > the byte-wise comparing technique, which does not fully
> > > > use 64-bits registers in x86_64 CPU. We use word-wide
> > > > comparing so that 8 characters can be compared at the same time
> > > > on x86_64 CPU. First we align the input and then use word-wise
> > > > comparing to find the first 64-bit word that contain the target.
> > > > Secondly, we compare every byte in the word and get the output.
> > > >
> > > > We create two files to measure the performance. The first file
> > > > contains on average 10 characters ahead the target character.
> > > > The second file contains at least 1000 characters ahead the
> > > > target character. Our implementation of =E2=80=9Cmemchr()=E2=80=9D =
is slightly
> > > > better in the first test and nearly 4x faster than the orginal
> > > > implementation in the second test.
> > > >
> > > > Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
> > > > Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> > > > ---
> > > >  arch/x86/include/asm/string_64.h |  3 ++
> > > >  arch/x86/lib/Makefile            |  1 +
> > > >  arch/x86/lib/string_64.c         | 78 ++++++++++++++++++++++++++++=
++++
> > > >  3 files changed, 82 insertions(+)
> > > >  create mode 100644 arch/x86/lib/string_64.c
> > > >
> > > ...
> > > > diff --git a/arch/x86/lib/string_64.c b/arch/x86/lib/string_64.c
> > > > new file mode 100644
> > > > index 000000000..4e067d5be
> > > > --- /dev/null
> > > > +++ b/arch/x86/lib/string_64.c
> > > > @@ -0,0 +1,78 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +#include <linux/string.h>
> > > > +#include <linux/export.h>
> > > > +#include <linux/align.h>
> > > > +
> > > > +/* How many bytes are loaded each iteration of the word copy loop =
*/
> > > > +#define LBLOCKSIZE (sizeof(long))
> > > > +
> > > > +#ifdef __HAVE_ARCH_MEMCHR
> > > > +
> > > > +void *memchr(const void *cs, int c, size_t length)
> > > > +{
> > > > +     const unsigned char *src =3D (const unsigned char *)cs, d =3D=
 c;
> > >
> > > You don't need the cast.
> > >
> > > > +
> > > > +     while (!IS_ALIGNED((long)src, sizeof(long))) {
> > > > +             if (!length--)
> > > > +                     return NULL;
> > > > +             if (*src =3D=3D d)
> > > > +                     return (void *)src;
> > > > +             src++;
> > > > +     }
> > >
> > > There is no point aligning the address.
> > > On tests I've done misaligned reads don't even take an extra
> > > clock - even if you get the cpu doing two reads/clock.
> > > Even if they did the code isn't memory limited.
> > >
> > > > +     if (length >=3D LBLOCKSIZE) {
> > > > +             unsigned long mask =3D d << 8 | d;
> > > > +             unsigned int i =3D 32;
> > > > +             long xor, data;
> > > > +             const long consta =3D 0xFEFEFEFEFEFEFEFF,
> > > > +                        constb =3D 0x8080808080808080;
> > > > +
> > > > +             /*
> > > > +              * Create a 8-bytes mask for word-wise comparing.
> > > > +              * For example, a mask for 'a' is 0x6161616161616161.
> > > > +              */
> > > > +
> > > > +             mask |=3D mask << 16;
> > > > +             for (i =3D 32; i < LBLOCKSIZE * 8; i <<=3D 1)
> > > > +                     mask |=3D mask << i;
> > >
> > > Given that consta/b only support 64 bit why the loop.
> > > Just do mask |=3D mask << 32.
> > > I'd also put all 3 calculations together - not hide one
> > > in the initialiser.
> > >
> > > > +             /*
> > > > +              * We perform word-wise comparing with following oper=
ation:
> > > > +              *      1. Perform xor on the long word @src and @mas=
k
> > > > +              *         and put into @xor.
> > > > +              *      2. Add @xor with @consta.
> > > > +              *      3. ~@xor & @constb.
> > > > +              *      4. Perform & with the result of step 2 and 3.
> > > > +              *
> > > > +              * Step 1 creates a byte which is 0 in the long word =
if
> > > > +              * there is at least one target byte in it.
> > > > +              *
> > > > +              * Step 2 to Step 4 find if there is a byte with 0 in
> > > > +              * the long word.
> > > > +              */
> > > > +             asm volatile("1:\n\t"
> > > > +                          "movq (%0),%1\n\t"
> > > > +                          "xorq %6,%1\n\t"
> > > > +                          "lea (%1,%4), %2\n\t"
> > > > +                          "notq %1\n\t"
> > > > +                          "andq %5,%1\n\t"
> > > > +                          "testq %1,%2\n\t"
> > > > +                          "jne 2f\n\t"
> > > > +                          "add $8,%0\n\t"
> > > > +                          "sub $8,%3\n\t"
> > > > +                          "cmp $7,%3\n\t"
> > > > +                          "ja 1b\n\t"
> > > > +                          "2:\n\t"
> > > > +                          : "=3DD"(src), "=3Dr"(xor), "=3Dr"(data)=
, "=3Dr"(length)
> > >
> > > Why constrain src to %rdi?
> >
> > At first I try to use some instructions related to %rdi, but I realize
> > that I won't use these instructions. It is unnecessary to constrain
> > src to %rdi.
> >
> > >
> > > > +                          : "r"(consta), "r"(constb), "r"(mask), "=
0"(src),
> > > > +                            "1"(xor), "2"(data), "3"(length)
> > >
> > > Use "+r" in the outputs instead of respecifying the args.
> > > I'd also suggest using named arguments - much easier to read.
> > >
> > > > +                          : "memory", "cc");
> > >
> > > Doesn't the compiler generate much the same code?
> > > You should also be able to code without needing add, sub and cmp
> > > at the end of the loop.
> > > If you use negative offsets from the end of the buffer
> > > the loop can be a single add and jnz.
> > >
> > >         David
> > >
> > > > +     }
> > > > +
> > > > +     while (length--) {
> > > > +             if (*src =3D=3D d)
> > > > +                     return (void *)src;
> > > > +             src++;
> > > > +     }
> > > > +     return NULL;
> > > > +}
> > > > +EXPORT_SYMBOL(memchr);
> > > > +#endif
> > > > --
> > > > 2.25.1
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,=
 MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
> >
> > I remove the aligning address part. On my tests the performance are sim=
ilar.
> > Here I rewrite the assembly using named arguments and I reduce one inst=
ruction
> > in the loop by adding two parameters, which are  'end' and 'dst'.
> > 'end' stores the
> > address of the end of the string. 'dst' stores the address of the end
> > of word-wise
> > comparison. As a result, when 'src' is equal to 'dst', the number of re=
maining
> > characters is less than 8. The following while loop will find if the
> > target character is
> > in these remaining characters.
> >
> > On my test the performance is similar with the my original implementati=
on. Only
> > a little bit fast when going through a very long string, which contains=
 128*1024
> > characters and the target character is near the end of the string.
> >
> > I also explain how consta and constb work clearly in the comments. Hope=
 that it
> > helps understanding.
> >
> > The following code is what I change.
> >
> > void *memchr(const void *cs, int c, size_t length)
> > {
> >      const unsigned char *src =3D (const unsigned char *)cs;
> >      const unsigned char *end =3D src + length;
> >
> >      if (length >=3D LBLOCKSIZE) {
> >              unsigned long mask =3D c << 8 | c;
>
> That is wrong if 'c' is outside 0..255.
> I suspect it is best to at least allow -128..-1.
>
> >              long xor, data;
> >              const long consta =3D 0xFEFEFEFEFEFEFEFF,
> >                         constb =3D 0x8080808080808080;
> >              const unsigned char *dst =3D (const unsigned char *)src +
> >                                                (length & 0xFFFFFFFFFFFF=
FFF8);
> >
> >              /*
> >               * Create a 8-bytes mask for word-wise comparing.
> >               * For example, a mask for 'a' is 0x6161616161616161.
> >               */
> >
> >              mask |=3D mask << 16;
> >              mask |=3D mask << 32;
> >              /*
> >               * We perform word-wise comparing with following operation=
:
> >               * 1. Perform xor on the long word @src and @mask
> >               *    and put into @xor.
> >               * 2. Add @xor with @consta.
> >               * 3. ~@xor & @constb.
> >               * 4. Perform & with the result of step 2 and 3.
> >               *
> >               * If there is a zero byte in @xor, step 2 turns it into
> >               * 0xFF. Then step 3 and 4 turn it into 0x80.
> >               *
> >               * If there is a none-zero byte in @xor, let k
> >               * (0 <=3D k <=3D 7) be the lowest 1 in this byte. The low=
est
> >               * k bits are 0. After step 2, the byte ends in a single
> >               * bit of value 0. Step 3 and 4 turns this byte into k
> >               * bits of 1, which is 2^k - 1, at first. Then & @constb
> >               * makes it into 0.
> >               *
> >               * Step 2 to Step 4 find if there is a byte with 0 in
> >               * the long word.
> >               */
> >               asm volatile("1:\n\t"
> >                             "movq (%[src]),%[xor]\n\t"
> >                             "xorq %[mask],%[xor]\n\t"
> >                             "lea (%[xor],%[const_a]), %[tmp]\n\t"
> >                             "notq %[xor]\n\t"
> >                             "andq %[const_b],%[xor]\n\t"
> >                             "testq %[xor],%[tmp]\n\t"
> >                             "jnz 2f\n\t"
> >                             "add $8,%[src]\n\t"
> >                             "cmp %[src], %[dst]\n\t"
> >                             "ja 1b\n\t"
> >                             "2:\n\t"
> >                             :
> >                             [src] "+r"(src), [xor] "+r"(xor), [tmp] "+r=
"(data)
> >                             : [const_a] "r"(consta), [const_b] "r"(cons=
tb),
> >                               [mask] "r"(mask), [dst] "r"(dst)
> >                             : "memory", "cc");
> >         }
> >
> >         while (src <=3D end) {
> >              if (*src =3D=3D d)
>
> I think you mean 'c'.
>
> >                      return (void *)src;
> >              src++;
> >         }
> >         return NULL;
> > }
> >
> > Thanks,
> > Yu-Jen Chang
>
> Gcc compiles this C to the same loop and is easier to read.
> Valid on all LE 64bit systems.
>
> void *memchr(const void *p, int c, unsigned long length)
> {
>     unsigned long mask, val;
>     const void *end =3D p + length;
>
>     c &=3D 0xff;
>     if (p <=3D end - 8) {
>         mask =3D c | c << 8;
>         mask |=3D mask << 16;
>         mask |=3D mask << 32;
>
>         for (; p <=3D end - 8; p +=3D 8) {
>             val =3D *(unsigned long *)p ^ mask;
>             if ((val + 0xfefefefefefefeffu) & (~val & 0x8080808080808080u=
))
>                 break;
>         }
>     }
>
>     for (; p < end; p++)
>         if (*(unsigned char *)p =3D=3D c)
>             return p;

Here I think we should return (void*) p. So that there is no
compilation warning.

>
>     return NULL;
> }
>
> See https://godbolt.org/z/6rqTqfEsx
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

Your modification is easier to understand. I add the comments to
explain how it work.
I will use it in the second version of the patch. Thanks for your advice.

Yu-Jen Chang

void *memchr(const void *p, int c, unsigned long length)
{
    unsigned long mask, val;
    const void *end =3D p + length;

    c &=3D 0xff;
    if (p <=3D end - 8) {


        /*
         * Create a 8-bytes mask for word-wise comparing.
         * For example, a mask for 'a' is 0x6161616161616161.
         */

        mask =3D c | c << 8;
        mask |=3D mask << 16;
        mask |=3D mask << 32;

        /*
         * We perform word-wise comparing with following operation:
         * 1. Perform xor on the long word @p and @mask
         *    and put into @val.
         * 2. Add @val with 0xfefefefefefefeff.
         * 3. ~@val & 0x8080808080808080
         * 4. Perform & with the result of step 2 and 3.
         *
         * If there is a zero byte in @val, step 2 turns it into
         * 0xFF. Then step 3 and 4 turn it into 0x80.
         *
         * If there is a none-zero byte in @val, let k
         * (0 <=3D k <=3D 7) be the lowest 1 in this byte. The lowest
         * k bits are 0. After step 2, the byte ends in a single
         * bit of value 0. Step 3 and 4 turns this byte into k
         * bits of 1, which is 2^k - 1, at first. Then &
         * 0x8080808080808080 makes it into 0
         */

        for (; p <=3D end - 8; p +=3D 8) {
            val =3D *(unsigned long *)p ^ mask;
            if ((val + 0xfefefefefefefeffu) & (~val & 0x8080808080808080u))
                break;
        }
    }

    for (; p < end; p++)
        if (*(unsigned char *)p =3D=3D c)
            return (void *)p;

    return NULL;
}
