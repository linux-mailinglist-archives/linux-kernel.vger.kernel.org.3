Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CC5585E50
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiGaJnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 05:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiGaJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 05:43:10 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C818811C1F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 02:43:02 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 13BD2303CD8;
        Sun, 31 Jul 2022 11:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659260574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcIRZCKmfsNJNBoCDFI3zaGk03Vbh1HFpMwDEkekvF8=;
        b=CQHI5ifubKcu3CDFgl8p/4bQSoa2R7olJOmcx94Tug7op7S1PvaC5UFj/O8Gt8SrrneyhI
        HBQZmwDdJoFv+1UY/Y2+3edUEI39jvcV8Q6sCzUuszG+wMq+TLPlMCLGRco8CoZiHX5x9Y
        2UUCc98wlJjlWU+FXabMbbRUUpBimBU1iMekVketGCOOLaZMYyJIJDEHNNkKmcH6qmPyZo
        brgCwEGxo8xOhWleVxhaDgAPfzC+Mk4/fi4FKgs2xTw458yzPwtcoQy0OV7ryHG6gl7zrR
        dfUn1Y7+dUsCkW05qTtVWV7H0P7wBT2riQad813sZh5cpT7dl3Aav16JNs3ntw==
Message-ID: <9383b9b62a15ba6f91af5adb0b0b1dd90ac1a3df.camel@svanheule.net>
Subject: Re: [PATCH 06/10] lib/cpumask: move trivial wrappers around
 find_bit to the header
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Date:   Sun, 31 Jul 2022 11:42:52 +0200
In-Reply-To: <20220706174253.4175492-7-yury.norov@gmail.com>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
         <20220706174253.4175492-7-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On Wed, 2022-07-06 at 10:42 -0700, Yury Norov wrote:
> To avoid circular dependencies, cpumask keeps simple (almost) one-line
> wrappers around find_bit() in a c-file.
>=20
> Commit 47d8c15615c0a2 ("include: move find.h from asm_generic to linux")
> moved find.h header out of asm_generic include path, and it helped to fix
> many circular dependencies, including some in cpumask.h.
>=20
> This patch moves those one-liners to header files.
>=20
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
> =C2=A0include/linux/cpumask.h | 57 ++++++++++++++++++++++++++++++++++++++=
---
> =C2=A0lib/cpumask.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 55 ---------------------------------------
> =C2=A02 files changed, 54 insertions(+), 58 deletions(-)
>=20
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 760022bcb925..ea3de2c2c180 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -241,7 +241,21 @@ static inline unsigned int cpumask_last(const struct
> cpumask *srcp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return find_last_bit(cpum=
ask_bits(srcp), nr_cpumask_bits);
> =C2=A0}
> =C2=A0
> -unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
> +/**
> + * cpumask_next - get the next cpu in a cpumask
> + * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @srcp: the cpumask pointer
> + *
> + * Returns >=3D nr_cpu_ids if no further cpus set.
> + */
> +static inline
> +unsigned int cpumask_next(int n, const struct cpumask *srcp)

This also drops the __pure speficier for these functions. Since I have a pa=
tch
that does the opposite for cpumask_next_wrap() [1], I was wondering what yo=
ur
reasoning behind this is.

Since a cpumask like cpu_online_mask may change between subsequent calls, I=
'm
considering to drop my patch adding __pure, and to follow the changes you'v=
e
made here.

[1]
https://lore.kernel.org/all/06eebdc46cfb21eb437755a2a5a56d55c41400f5.165907=
7534.git.sander@svanheule.net/

Best,
Sander

> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* -1 is a legal arg here. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (n !=3D -1)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0cpumask_check(n);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return find_next_bit(cpumask_b=
its(srcp), nr_cpumask_bits, n + 1);
> +}
> =C2=A0
> =C2=A0/**
> =C2=A0 * cpumask_next_zero - get the next unset cpu in a cpumask
> @@ -258,8 +272,25 @@ static inline unsigned int cpumask_next_zero(int n, =
const
> struct cpumask *srcp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return find_next_zero_bit=
(cpumask_bits(srcp), nr_cpumask_bits, n+1);
> =C2=A0}
> =C2=A0
> -unsigned int __pure cpumask_next_and(int n, const struct cpumask *, cons=
t
> struct cpumask *);
> -unsigned int __pure cpumask_any_but(const struct cpumask *mask, unsigned=
 int
> cpu);
> +/**
> + * cpumask_next_and - get the next cpu in *src1p & *src2p
> + * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @src1p: the first cpumask pointer
> + * @src2p: the second cpumask pointer
> + *
> + * Returns >=3D nr_cpu_ids if no further cpus set in both.
> + */
> +static inline
> +unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cpumask *src2p)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* -1 is a legal arg here. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (n !=3D -1)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0cpumask_check(n);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return find_next_and_bit(cpuma=
sk_bits(src1p), cpumask_bits(src2p),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0nr_cpumask_bits, n + 1);
> +}
> +
> =C2=A0unsigned int cpumask_local_spread(unsigned int i, int node);
> =C2=A0unsigned int cpumask_any_and_distribute(const struct cpumask *src1p=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cpumask *src2p);
> @@ -324,6 +355,26 @@ unsigned int cpumask_next_wrap(int n, const struct
> cpumask *mask, int start, boo
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for ((cpu) =3D -1;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(cpu) =3D cpumask_next_and((cpu), (mask1), (mask2))=
,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(cpu) < nr_cpu_ids;)
> +
> +/**
> + * cpumask_any_but - return a "random" in a cpumask, but not this one.
> + * @mask: the cpumask to search
> + * @cpu: the cpu to ignore.
> + *
> + * Often used to find any cpu but smp_processor_id() in a mask.
> + * Returns >=3D nr_cpu_ids if no cpus set.
> + */
> +static inline
> +unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cp=
u)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int i;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpumask_check(cpu);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for_each_cpu(i, mask)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (i !=3D cpu)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return i;
> +}
> =C2=A0#endif /* SMP */
> =C2=A0
> =C2=A0#define CPU_BITS_NONE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index da68f6bbde44..cb7262ff8633 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -7,61 +7,6 @@
> =C2=A0#include <linux/memblock.h>
> =C2=A0#include <linux/numa.h>
> =C2=A0
> -/**
> - * cpumask_next - get the next cpu in a cpumask
> - * @n: the cpu prior to the place to search (ie. return will be > @n)
> - * @srcp: the cpumask pointer
> - *
> - * Returns >=3D nr_cpu_ids if no further cpus set.
> - */
> -unsigned int cpumask_next(int n, const struct cpumask *srcp)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* -1 is a legal arg here. */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (n !=3D -1)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0cpumask_check(n);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return find_next_bit(cpumask_b=
its(srcp), nr_cpumask_bits, n + 1);
> -}
> -EXPORT_SYMBOL(cpumask_next);
> -
> -/**
> - * cpumask_next_and - get the next cpu in *src1p & *src2p
> - * @n: the cpu prior to the place to search (ie. return will be > @n)
> - * @src1p: the first cpumask pointer
> - * @src2p: the second cpumask pointer
> - *
> - * Returns >=3D nr_cpu_ids if no further cpus set in both.
> - */
> -unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cpumask *src2p)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* -1 is a legal arg here. */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (n !=3D -1)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0cpumask_check(n);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return find_next_and_bit(cpuma=
sk_bits(src1p), cpumask_bits(src2p),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0nr_cpumask_bits, n + 1);
> -}
> -EXPORT_SYMBOL(cpumask_next_and);
> -
> -/**
> - * cpumask_any_but - return a "random" in a cpumask, but not this one.
> - * @mask: the cpumask to search
> - * @cpu: the cpu to ignore.
> - *
> - * Often used to find any cpu but smp_processor_id() in a mask.
> - * Returns >=3D nr_cpu_ids if no cpus set.
> - */
> -unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cp=
u)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int i;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpumask_check(cpu);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for_each_cpu(i, mask)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (i !=3D cpu)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return i;
> -}
> -EXPORT_SYMBOL(cpumask_any_but);
> -
> =C2=A0/**
> =C2=A0 * cpumask_next_wrap - helper to implement for_each_cpu_wrap
> =C2=A0 * @n: the cpu prior to the place to search

