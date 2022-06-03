Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3553CC15
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbiFCPOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiFCPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:13:57 -0400
X-Greylist: delayed 65359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Jun 2022 08:13:56 PDT
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966D50479
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:13:56 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id C34122E206B;
        Fri,  3 Jun 2022 17:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654269234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maPbZQINLeItmCDeGMYMpTkH6M0cP+LIAnZ3p998yXc=;
        b=KciBMUhr/npjVFYMbJfJu6A0C+J+9ICTuPXfe50ZtXAMmRVFQ4PLrCM4IkslMq+G3kOWWH
        mEmSHE2Kk+XRAY+SlmjHStnYK+mEnl+9BgYlg3kc97CxTApGTnZcy6nhmKUztdTrh6M388
        Bka0AVf9Tyu8A06R396wPeUU42+bCDYEoqReWXe1AQDONJvRv+FJIFSChlVSuLKqrh16ae
        S1uWOawiTa407geXa3/XVdhJ9+9pZwks/JeI4UVuO8ITbaCMdhT904F0+aB4Fnu8hhuDCk
        UCyHQ2Nv4Q9aGlVEjNQpC1QJi7EGfWV/NBG0D5+2Ua+XrpGwzGDbT3mLqbDcJg==
Message-ID: <4d4af51192f7de92f0c5e2409db1d5cc4983a309.camel@svanheule.net>
Subject: Re: [PATCH v1 1/2] cpumask: Fix invalid uniprocessor mask assumption
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri, 03 Jun 2022 17:13:52 +0200
In-Reply-To: <Ypk+MKSSaSCBnITY@yury-laptop>
References: <cover.1654201862.git.sander@svanheule.net>
         <017b97698ba58d33bf45d30317d5a73c5b93d2a0.1654201862.git.sander@svanheule.net>
         <Ypk+MKSSaSCBnITY@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 15:48 -0700, Yury Norov wrote:
> On Thu, Jun 02, 2022 at 11:04:19PM +0200, Sander Vanheule wrote:
> > On uniprocessor builds, any CPU mask is assumed to contain exactly one
> > CPU (cpu0). This ignores the existence of empty masks, resulting in
> > incorrect behaviour for most of the implemented optimisations.
> >=20
> > Replace the uniprocessor optimisations with implementations that also
> > take into account empty masks. Also drop the incorrectly optimised
> > for_each_cpu implementations and use the generic implementations in all
> > cases.
> >=20
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > ---
> > =C2=A0include/linux/cpumask.h | 35 +++++++++++++++--------------------
> > =C2=A01 file changed, 15 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index fe29ac7cc469..ce8c7b27f6c9 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -117,51 +117,54 @@ static __always_inline unsigned int
> > cpumask_check(unsigned int cpu)
> > =C2=A0}
> > =C2=A0
> > =C2=A0#if NR_CPUS =3D=3D 1
> > -/* Uniprocessor.=C2=A0 Assume all masks are "1". */
> > +/* Uniprocessor. Assume all valid masks are "1" or empty. */
> > =C2=A0static inline unsigned int cpumask_first(const struct cpumask *sr=
cp)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return !(*cpumask_bits(srcp)=
 & 1);
> > =C2=A0}
> =C2=A0
> I think, you can just drop this '#if NR_CPUS =3D=3D 1' part and rely on S=
MP
> versions. find_first_bit() is optimized for short bitmaps, so I expect
> no overhead comparing to this.

I was initially planning to just drop the UP versions, but that means I hav=
e to
include lib/cpumask.o on all builds. I'll have another look at this.

[...]

> > =C2=A0
> > =C2=A0static inline unsigned int cpumask_next_wrap(int n, const struct =
cpumask
> > *mask,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int start, bool wrap)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* cpu0 unless stop conditio=
n, wrap and at cpu0, then
> > nr_cpumask_bits */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (wrap && n =3D=3D 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nr_cpumask_bits at stop c=
ondition, wrap and at cpu0, or empty
> > mask
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * otherwise cpu0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (wrap && n =3D=3D 0) =
|| cpumask_first(mask);
> > =C2=A0}

My tests contained a copy-paste error, so I missed a case. The results curr=
ently
still differ from the SMP implementation though, so this looks like another
reason to just drop the UP optimised version.

> > =C2=A0
> > =C2=A0/* cpu must be a valid cpu, ie 0, so there's no other choice. */
> > @@ -186,14 +189,6 @@ static inline int cpumask_any_distribute(const str=
uct
> > cpumask *srcp)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return cpumask_first(sr=
cp);
> > =C2=A0}
> > =C2=A0
> > -#define for_each_cpu(cpu, mask)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for ((cpu) =3D 0; (cpu) < 1;=
 (cpu)++, (void)mask)
> > -#define for_each_cpu_not(cpu, mask)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for ((cpu) =3D 0; (cpu) < 1;=
 (cpu)++, (void)mask)
> > -#define for_each_cpu_wrap(cpu, mask, start)=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for ((cpu) =3D 0; (cpu) < 1;=
 (cpu)++, (void)mask, (void)(start))
> > -#define for_each_cpu_and(cpu, mask1, mask2)=C2=A0=C2=A0=C2=A0=C2=A0\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for ((cpu) =3D 0; (cpu) < 1;=
 (cpu)++, (void)mask1, (void)mask2)
> > =C2=A0#else
> > =C2=A0/**
> > =C2=A0 * cpumask_first - get the first cpu in a cpumask
> > @@ -259,11 +254,13 @@ static inline unsigned int cpumask_next_zero(int =
n,
> > const struct cpumask *srcp)
> > =C2=A0}
> > =C2=A0
> > =C2=A0int __pure cpumask_next_and(int n, const struct cpumask *, const =
struct
> > cpumask *);
> > +extern int cpumask_next_wrap(int n, const struct cpumask *mask, int st=
art,
> > bool wrap);
>=20
> is this extern needed?

I don't think it is, but this is a line that I just moved around in the hea=
der.
Like for the other functions, I could even add the __pure qualifier.


Thanks for the feedback,
Sander

