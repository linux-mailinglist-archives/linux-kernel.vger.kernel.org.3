Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D155539CD7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349754AbiFAF7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349703AbiFAF7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:59:04 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B836431209;
        Tue, 31 May 2022 22:59:01 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a15so544545ilq.12;
        Tue, 31 May 2022 22:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h7+QuIqIAukkZaII831OWuKCPI8ugWUjDciaU8BwTko=;
        b=HT/kJ6NtFgEEBDW0k+DzT1D+n3GjvMQV23c5h7hlN0n/HXv6kS8Y2xxfFULvW1QidW
         IgEieEQ+xQ3veaL7lW9apqLL7ba+tN/x4/9l3Ds3HoEbgAZmAQ4N3hdRzPZd+D5WT3qH
         t/ufM9hWVCaz7gNemO6PbpQzEsGJo4V5wwEcAIEuXsxM4s4M9B+jATuxt1VofrCmDJmT
         ZZzm4XXc2FUDbr8lBhEQszE7MNo+/oxz62b8RWAu2qN2ZQfUxVrUw1Fw/Xr/rAahiSPj
         sRIi4bFY36Rm109PYB+6OZqwfoXOsrqZSCLxEORJ71VMI+HG4AX0Wl3zKK0ykMf2c3SK
         +vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h7+QuIqIAukkZaII831OWuKCPI8ugWUjDciaU8BwTko=;
        b=cx3L5bkm7pzQicc19krM/8ndIkfm3DzksQ/xyWi36nTKf71S04QTsdtpz9hHKnzzUQ
         FQAeSuzYlgFARQTgaTYM4cUv2y0Ot6U25G8kNePcSRz4pwSVlHGF4IghzNZAvOzHVJ/c
         H+0M66nhYkleiivqoLJoDlnmCifTnOkoaTmL8nyG2ZaHTCHC1d1ssnNChO/U8piFZNwJ
         MKIemrR4rYwjCpZfNd6pZ+9qP9WkDyCN/Aiv4eSCdxricD45CuHihftCwOPoi9TQOKnu
         nkc504ygzBMT1/CiWFTgrqC4S7zwkMFY6NbfyAoVDLpX6AMVhWnnSpTZct3NJiCPKfHi
         0gRg==
X-Gm-Message-State: AOAM5313QIMCBd/c7zAGTctuB8x+FX+t9pTGo10bMOExaG+FvoSl5sk6
        7zNKWKTSqqnx/zl2UWu2wql87UYSckW326IfLgs=
X-Google-Smtp-Source: ABdhPJxF18sY9RgAP6Pa4rePvDoMP1cwV2gj6ZS3WfGDvB4mt2p1yZG3o5htvFvgPP4hsc9zGqlBErQtbJ10dRaX/Xk=
X-Received: by 2002:a05:6e02:174c:b0:2d3:c1e2:36fe with SMTP id
 y12-20020a056e02174c00b002d3c1e236femr3911515ill.121.1654063140900; Tue, 31
 May 2022 22:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220528081236.3020-1-arthurchang09@gmail.com>
 <20220528081236.3020-2-arthurchang09@gmail.com> <8b480c85f53c4f3b88bf99ba585e8768@AcuMS.aculab.com>
In-Reply-To: <8b480c85f53c4f3b88bf99ba585e8768@AcuMS.aculab.com>
From:   Yu-Jen Chang <arthurchang09@gmail.com>
Date:   Wed, 1 Jun 2022 13:58:49 +0800
Message-ID: <CAD4RrFOHaE0NKjPHw3RaUSrD6vZwnpHbY01bcO3emkoia2of6Q@mail.gmail.com>
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

David Laight <David.Laight@aculab.com> =E6=96=BC 2022=E5=B9=B45=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:10=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Yu-Jen Chang
> > Sent: 28 May 2022 09:13
> >
> > The original assembly version of memchr() is implemented with
> > the byte-wise comparing technique, which does not fully
> > use 64-bits registers in x86_64 CPU. We use word-wide
> > comparing so that 8 characters can be compared at the same time
> > on x86_64 CPU. First we align the input and then use word-wise
> > comparing to find the first 64-bit word that contain the target.
> > Secondly, we compare every byte in the word and get the output.
> >
> > We create two files to measure the performance. The first file
> > contains on average 10 characters ahead the target character.
> > The second file contains at least 1000 characters ahead the
> > target character. Our implementation of =E2=80=9Cmemchr()=E2=80=9D is s=
lightly
> > better in the first test and nearly 4x faster than the orginal
> > implementation in the second test.
> >
> > Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
> > Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> > ---
> >  arch/x86/include/asm/string_64.h |  3 ++
> >  arch/x86/lib/Makefile            |  1 +
> >  arch/x86/lib/string_64.c         | 78 ++++++++++++++++++++++++++++++++
> >  3 files changed, 82 insertions(+)
> >  create mode 100644 arch/x86/lib/string_64.c
> >
> ...
> > diff --git a/arch/x86/lib/string_64.c b/arch/x86/lib/string_64.c
> > new file mode 100644
> > index 000000000..4e067d5be
> > --- /dev/null
> > +++ b/arch/x86/lib/string_64.c
> > @@ -0,0 +1,78 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/string.h>
> > +#include <linux/export.h>
> > +#include <linux/align.h>
> > +
> > +/* How many bytes are loaded each iteration of the word copy loop */
> > +#define LBLOCKSIZE (sizeof(long))
> > +
> > +#ifdef __HAVE_ARCH_MEMCHR
> > +
> > +void *memchr(const void *cs, int c, size_t length)
> > +{
> > +     const unsigned char *src =3D (const unsigned char *)cs, d =3D c;
>
> You don't need the cast.
>
> > +
> > +     while (!IS_ALIGNED((long)src, sizeof(long))) {
> > +             if (!length--)
> > +                     return NULL;
> > +             if (*src =3D=3D d)
> > +                     return (void *)src;
> > +             src++;
> > +     }
>
> There is no point aligning the address.
> On tests I've done misaligned reads don't even take an extra
> clock - even if you get the cpu doing two reads/clock.
> Even if they did the code isn't memory limited.
>
> > +     if (length >=3D LBLOCKSIZE) {
> > +             unsigned long mask =3D d << 8 | d;
> > +             unsigned int i =3D 32;
> > +             long xor, data;
> > +             const long consta =3D 0xFEFEFEFEFEFEFEFF,
> > +                        constb =3D 0x8080808080808080;
> > +
> > +             /*
> > +              * Create a 8-bytes mask for word-wise comparing.
> > +              * For example, a mask for 'a' is 0x6161616161616161.
> > +              */
> > +
> > +             mask |=3D mask << 16;
> > +             for (i =3D 32; i < LBLOCKSIZE * 8; i <<=3D 1)
> > +                     mask |=3D mask << i;
>
> Given that consta/b only support 64 bit why the loop.
> Just do mask |=3D mask << 32.
> I'd also put all 3 calculations together - not hide one
> in the initialiser.
>
> > +             /*
> > +              * We perform word-wise comparing with following operatio=
n:
> > +              *      1. Perform xor on the long word @src and @mask
> > +              *         and put into @xor.
> > +              *      2. Add @xor with @consta.
> > +              *      3. ~@xor & @constb.
> > +              *      4. Perform & with the result of step 2 and 3.
> > +              *
> > +              * Step 1 creates a byte which is 0 in the long word if
> > +              * there is at least one target byte in it.
> > +              *
> > +              * Step 2 to Step 4 find if there is a byte with 0 in
> > +              * the long word.
> > +              */
> > +             asm volatile("1:\n\t"
> > +                          "movq (%0),%1\n\t"
> > +                          "xorq %6,%1\n\t"
> > +                          "lea (%1,%4), %2\n\t"
> > +                          "notq %1\n\t"
> > +                          "andq %5,%1\n\t"
> > +                          "testq %1,%2\n\t"
> > +                          "jne 2f\n\t"
> > +                          "add $8,%0\n\t"
> > +                          "sub $8,%3\n\t"
> > +                          "cmp $7,%3\n\t"
> > +                          "ja 1b\n\t"
> > +                          "2:\n\t"
> > +                          : "=3DD"(src), "=3Dr"(xor), "=3Dr"(data), "=
=3Dr"(length)
>
> Why constrain src to %rdi?

At first I try to use some instructions related to %rdi, but I realize
that I won't use these instructions. It is unnecessary to constrain
src to %rdi.

>
> > +                          : "r"(consta), "r"(constb), "r"(mask), "0"(s=
rc),
> > +                            "1"(xor), "2"(data), "3"(length)
>
> Use "+r" in the outputs instead of respecifying the args.
> I'd also suggest using named arguments - much easier to read.
>
> > +                          : "memory", "cc");
>
> Doesn't the compiler generate much the same code?
> You should also be able to code without needing add, sub and cmp
> at the end of the loop.
> If you use negative offsets from the end of the buffer
> the loop can be a single add and jnz.
>
>         David
>
> > +     }
> > +
> > +     while (length--) {
> > +             if (*src =3D=3D d)
> > +                     return (void *)src;
> > +             src++;
> > +     }
> > +     return NULL;
> > +}
> > +EXPORT_SYMBOL(memchr);
> > +#endif
> > --
> > 2.25.1
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

I remove the aligning address part. On my tests the performance are similar=
.
Here I rewrite the assembly using named arguments and I reduce one instruct=
ion
in the loop by adding two parameters, which are  'end' and 'dst'.
'end' stores the
address of the end of the string. 'dst' stores the address of the end
of word-wise
comparison. As a result, when 'src' is equal to 'dst', the number of remain=
ing
characters is less than 8. The following while loop will find if the
target character is
in these remaining characters.

On my test the performance is similar with the my original implementation. =
Only
a little bit fast when going through a very long string, which contains 128=
*1024
characters and the target character is near the end of the string.

I also explain how consta and constb work clearly in the comments. Hope tha=
t it
helps understanding.

The following code is what I change.

void *memchr(const void *cs, int c, size_t length)
{
     const unsigned char *src =3D (const unsigned char *)cs;
     const unsigned char *end =3D src + length;

     if (length >=3D LBLOCKSIZE) {
             unsigned long mask =3D c << 8 | c;
             long xor, data;
             const long consta =3D 0xFEFEFEFEFEFEFEFF,
                        constb =3D 0x8080808080808080;
             const unsigned char *dst =3D (const unsigned char *)src +
                                               (length & 0xFFFFFFFFFFFFFFF8=
);

             /*
              * Create a 8-bytes mask for word-wise comparing.
              * For example, a mask for 'a' is 0x6161616161616161.
              */

             mask |=3D mask << 16;
             mask |=3D mask << 32;
             /*
              * We perform word-wise comparing with following operation:
              * 1. Perform xor on the long word @src and @mask
              *    and put into @xor.
              * 2. Add @xor with @consta.
              * 3. ~@xor & @constb.
              * 4. Perform & with the result of step 2 and 3.
              *
              * If there is a zero byte in @xor, step 2 turns it into
              * 0xFF. Then step 3 and 4 turn it into 0x80.
              *
              * If there is a none-zero byte in @xor, let k
              * (0 <=3D k <=3D 7) be the lowest 1 in this byte. The lowest
              * k bits are 0. After step 2, the byte ends in a single
              * bit of value 0. Step 3 and 4 turns this byte into k
              * bits of 1, which is 2^k - 1, at first. Then & @constb
              * makes it into 0.
              *
              * Step 2 to Step 4 find if there is a byte with 0 in
              * the long word.
              */
              asm volatile("1:\n\t"
                            "movq (%[src]),%[xor]\n\t"
                            "xorq %[mask],%[xor]\n\t"
                            "lea (%[xor],%[const_a]), %[tmp]\n\t"
                            "notq %[xor]\n\t"
                            "andq %[const_b],%[xor]\n\t"
                            "testq %[xor],%[tmp]\n\t"
                            "jnz 2f\n\t"
                            "add $8,%[src]\n\t"
                            "cmp %[src], %[dst]\n\t"
                            "ja 1b\n\t"
                            "2:\n\t"
                            :
                            [src] "+r"(src), [xor] "+r"(xor), [tmp] "+r"(da=
ta)
                            : [const_a] "r"(consta), [const_b] "r"(constb),
                              [mask] "r"(mask), [dst] "r"(dst)
                            : "memory", "cc");
        }

        while (src <=3D end) {
             if (*src =3D=3D d)
                     return (void *)src;
             src++;
        }
        return NULL;
}

Thanks,
Yu-Jen Chang
