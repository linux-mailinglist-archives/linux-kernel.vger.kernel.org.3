Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA985370E5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 14:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiE2MFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 08:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiE2MF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 08:05:29 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B3662132;
        Sun, 29 May 2022 05:05:27 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p74so8918340iod.8;
        Sun, 29 May 2022 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vaYPiUujwlmlqgiQ7EenZdZZ1AkgwxAdkc9cpStlO38=;
        b=n49JBKB/ehrOBz+qvot+A/Po1vMwPCzRO7A+AHWw3qPP+JEcm+zLOG5+hQ8vkLEx0b
         oMVh6UYEdJVJRRVX1WTuYFWlOcn1HCFlK0RFlEFvLoSIFZDiJf4N107bodlP/WKmXVYR
         omGAWgGKk0UodAZBLQTkU0SihxXFC+9VUeoOoxUG9OVavTWbN1JsHuxWYopXPz+VaXW7
         gRl2sWxM7yYcP7JiE2Y4kHb55qMaqSLewp8wzRT0UvqO7ittyNSphP1V1tPjHanvwNbC
         N5uPCe5aCRxHyuf7GvJMqrslSVxtVXyS+hQgbPvWaoDd7gkzor9UKvGT6u4z1JAwd2fl
         CEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vaYPiUujwlmlqgiQ7EenZdZZ1AkgwxAdkc9cpStlO38=;
        b=4GVAckIUY8IlhVz42KapJCqV2bNMFXmQUk4Z8JasPNr315qqWAqTxhWgGLVJGQy6aW
         RDcK8u/t40cbXHBjPQmnAsub7Y7K2tlPT9NAPPzgDIt0L5ipRjK61kcZFhk5UruiBJfA
         +D44YoCJ8o1vjspuuyrvckx3mkrW4G+JufoF3kcqUKxfyKaNVOHT0ryeTimxDRfBiTEs
         t3bCFM90bIzi4lxvdad1oUg1tMondyBGNcIr6CetUvbw9ogY79l8uSNTPUtOOhWP06dB
         P/R0mSTcBNf44mD4qAyqNGw4P6q/+HElbVdquFLaguXggXIZ62nrPUugqPkaWc1fKF/n
         mTxA==
X-Gm-Message-State: AOAM531CtsL63B99ALQo3V/XPvdOkYbWxgT/YUt0fekUVfU2uesfYNDN
        imY4U/pWEfIKRkBgNcAk7oq7KINkdRuag3FkfzE=
X-Google-Smtp-Source: ABdhPJx/zSiGM2tVMwrRIjXVyzNbhlIn9ipPDVeWOnl4ivNMUJmJq1N9dmZJ/1esJskLwEddjuPxt+tnFTSQ+g5+pWE=
X-Received: by 2002:a05:6638:2053:b0:32e:c941:7dd2 with SMTP id
 t19-20020a056638205300b0032ec9417dd2mr16983192jaj.235.1653825927112; Sun, 29
 May 2022 05:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220528081236.3020-1-arthurchang09@gmail.com>
 <20220528081236.3020-2-arthurchang09@gmail.com> <YpJQoxUt9RhKb0Pr@geo.homenetwork>
In-Reply-To: <YpJQoxUt9RhKb0Pr@geo.homenetwork>
From:   arthur chang arthur <arthurchang09@gmail.com>
Date:   Sun, 29 May 2022 20:05:15 +0800
Message-ID: <CAD4RrFNB3oAh2GW+7Jj3DujLN476N5VUhD3hQs4aw5B5-EBSMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/lib: Optimize memchr()
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     ak@linux.intel.com, jdike@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, linux-um@lists.infradead.org,
        jserv@ccns.ncku.edu.tw
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

On Sun, May 29, 2022 at 12:40 AM Tao Zhou <tao.zhou@linux.dev> wrote:
>
> On Sat, May 28, 2022 at 04:12:35PM +0800, Yu-Jen Chang wrote:
>
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
> > diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/st=
ring_64.h
> > index 6e450827f..edce657e0 100644
> > --- a/arch/x86/include/asm/string_64.h
> > +++ b/arch/x86/include/asm/string_64.h
> > @@ -14,6 +14,9 @@
> >  extern void *memcpy(void *to, const void *from, size_t len);
> >  extern void *__memcpy(void *to, const void *from, size_t len);
> >
> > +#define __HAVE_ARCH_MEMCHR
> > +extern void *memchr(const void *cs, int c, size_t length);
> > +
> >  #define __HAVE_ARCH_MEMSET
> >  void *memset(void *s, int c, size_t n);
> >  void *__memset(void *s, int c, size_t n);
> > diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> > index f76747862..4d530e559 100644
> > --- a/arch/x86/lib/Makefile
> > +++ b/arch/x86/lib/Makefile
> > @@ -69,5 +69,6 @@ else
> >          lib-y +=3D clear_page_64.o copy_page_64.o
> >          lib-y +=3D memmove_64.o memset_64.o
> >          lib-y +=3D copy_user_64.o
> > +        lib-y +=3D string_64.o
> >       lib-y +=3D cmpxchg16b_emu.o
> >  endif
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
> I don't know why this 'd =3D c' is not error.
> d is a char pointer and c is int. At least this is not safe me do not kno=
w.
>

The parameter d is a character value, not a pointer. Therefore 'd =3D c'
is not an error.

> > +     while (!IS_ALIGNED((long)src, sizeof(long))) {
> > +             if (!length--)
> > +                     return NULL;
> > +             if (*src =3D=3D d)
>
> Compare a character value to a pointer value and this value is c.
> May be right do not know.
>
> Or:
>
> char d =3D c;
> ...
>
> > +                     return (void *)src;
> > +             src++;
> > +     }
> > +     if (length >=3D LBLOCKSIZE) {
> > +             unsigned long mask =3D d << 8 | d;
> > +             unsigned int i =3D 32;
> > +             long xor, data;
> > +             const long consta =3D 0xFEFEFEFEFEFEFEFF,
> > +                        constb =3D 0x8080808080808080;
>
> Two magic number..
>
> > +             /*
> > +              * Create a 8-bytes mask for word-wise comparing.
> > +              * For example, a mask for 'a' is 0x6161616161616161.
> > +              */
> > +
> > +             mask |=3D mask << 16;
> > +             for (i =3D 32; i < LBLOCKSIZE * 8; i <<=3D 1)
> > +                     mask |=3D mask << i;
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
>
> s/jne/jnz/
>
> Lack much here from me. But I give example that should check the
> CF flag is zero.
>
> 1) contain matching byte.
>
> 1111111011111111(consta)
>                         +add
> 0000000001101100(xor)
> ------------------------
> 1111111101101011 (%1)
>
>
> 1111111110010100(~xor)
>                         &and
> 1000000010000000(constb)
> ------------------------
> 1000000010000000 (%2)
>
>
> the logical and of %1 and %2 is
> 1000000000000000 that is not zero.
>
> 2) not contain matching byte
>
> 1111111011111111
>                  +
> 0110111011011100
> ----------------
> 0110110111011011(%1)
>
> 1001000100100011
>                  &
> 1000000010000000
> ----------------
> 1000000000000000(%2)
>
> %1 and %2 is
> 0000000000000000 that is zero.
>
> I guess that here should use jump instruction jnz instead.
> Even though, I do not know why that two magic number is so magical..
>
> Thanks,
> Tao

According to the Intel=C2=AE 64 and IA-32 Architectures Developer's Manual:=
 Vol. 2A
page 3-484 and 3-485, instruction jne and jnz jump according to zero flag. =
They
both jump when ZF =3D 0. Here I believe that using jnz is easier to underst=
and the
assembly code.

consta is the 2's complement of 0x0101010101010101. That is, we perform
subtraction here. As a result, it is not necessary to check the CF flags.

Here I explain how these two magic numbers work..

 After we perform xor to the long word and the mask, the match byte will
be 0x00. The goal to subtract 0x0101010101010101 is turning the zero byte
into 0xFF. The following step, ~xor & constb, transforms the zero byte
into 0x80. Then, 0x80 & 0xFF =3D 0x80.

On the other hand, for a none zero byte, let k (0 <=3D k <=3D7) be the posi=
tion
of the lowest 1 in this byte. The lowest k bits are 0. After the addition,
the byte ends in a single bit of value 0 and k bits of value 1. To
explain clearly,
we perform & (~xor) at first. This byte turns into k bits of 1, which
is 2^k - 1.
Then, we perform & constb with the previous result and get 0.  Here we just=
 do
(~xor) & 0x8080808080808080 at first.

Thanks,
Yu-Jen Chang

> > +                          "add $8,%0\n\t"
> > +                          "sub $8,%3\n\t"
> > +                          "cmp $7,%3\n\t"
> > +                          "ja 1b\n\t"
> > +                          "2:\n\t"
> > +                          : "=3DD"(src), "=3Dr"(xor), "=3Dr"(data), "=
=3Dr"(length)
> > +                          : "r"(consta), "r"(constb), "r"(mask), "0"(s=
rc),
> > +                            "1"(xor), "2"(data), "3"(length)
> > +                          : "memory", "cc");
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
> >
