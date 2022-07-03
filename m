Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B056A564597
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 09:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiGCHhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 03:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGCHha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 03:37:30 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34E3A199
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 00:37:29 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id EA3042F2F7B;
        Sun,  3 Jul 2022 09:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1656833848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HM/Mg6d9X85diLmPKMPmQsLH7BC8yOkOnZ2Oh8WVOs4=;
        b=XeyjNwEXvPSZXJ1G6f6K/wSI5kp+2KqL/VMgeuhcCPbBF5aJeoXIF1poJ4N2cj56N5xq4Y
        j6h00ORO7Pi6E9xMh7ZRBgFvNEg99u9ZR9xY+RH6O3O1lCHTSrHGA7wnAAMmdBxQH0DvqH
        1o4y3578h22gDBDEXB7pJkywCN/9I8JsdMLlZV34JJXL1lwq1KSDU3vpJDCvpvCPEg6rWH
        eczYFeBg8KZgASbQ6zLMOdRICM9N1CzJGyfweC7kAWrNVARopvB/bmdDycPIGBOHmyw4+4
        PPIFCjC6Je0L+dHnyrNuLl2rVbceFtyuew8D0bGMQYGbmodrrsktyzMetQk6/w==
Message-ID: <c8285910dfb7f8fe47e978f542ba6cf39b3df619.camel@svanheule.net>
Subject: Re: [PATCH v4 4/5] cpumask: Add UP optimised for_each_*_cpu versions
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Date:   Sun, 03 Jul 2022 09:37:25 +0200
In-Reply-To: <YsC9pH54rpr/lriv@yury-laptop>
References: <cover.1656777646.git.sander@svanheule.net>
         <3a92869b902a075b97be5d1452c9c6badbbff0df.1656777646.git.sander@svanheule.net>
         <YsC9CuiLRbhMAC51@yury-laptop> <YsC9pH54rpr/lriv@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
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

On Sat, 2022-07-02 at 14:50 -0700, Yury Norov wrote:
> On Sat, Jul 02, 2022 at 02:47:55PM -0700, Yury Norov wrote:
> > On Sat, Jul 02, 2022 at 06:08:27PM +0200, Sander Vanheule wrote:
> > > On uniprocessor builds, the following loops will always run over a ma=
sk
> > > that contains one enabled CPU (cpu0):
> > > =C2=A0=C2=A0=C2=A0 - for_each_possible_cpu
> > > =C2=A0=C2=A0=C2=A0 - for_each_online_cpu
> > > =C2=A0=C2=A0=C2=A0 - for_each_present_cpu
> > >=20
> > > Provide uniprocessor-specific macros for these loops, that always run
> > > exactly once.
> > >=20
> > > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> >=20
> > Acked-by: Yury Norov <yury.norov@gmail.com>
>=20
> I think this patch should go before #2 to avoid possible issues while
> bisecting...

The old assumption was valid in this case, but I agree it makes sense to mo=
ve this patch forward in
the series. Also to avoid a cycle of optimised/generic/optimised, even if t=
he behaviour doesn't
change.

Best,
Sander

> >=20
> > > ---
> > > =C2=A0include/linux/cpumask.h | 7 +++++++
> > > =C2=A01 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > > index 7fbef41b3093..6c5b4ee000f2 100644
> > > --- a/include/linux/cpumask.h
> > > +++ b/include/linux/cpumask.h
> > > @@ -750,9 +750,16 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPU=
S);
> > > =C2=A0/* First bits of cpu_bit_bitmap are in fact unset. */
> > > =C2=A0#define cpu_none_mask to_cpumask(cpu_bit_bitmap[0])
> > > =C2=A0
> > > +#if NR_CPUS =3D=3D 1
> > > +/* Uniprocessor: the possible/online/present masks are always "1" */
> > > +#define for_each_possible_cpu(cpu)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for =
((cpu) =3D 0; (cpu) < 1; (cpu)++)
> > > +#define for_each_online_cpu(cpu)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0for ((cpu) =3D 0; (cpu) < 1; (cpu)++)
> > > +#define for_each_present_cpu(cpu)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0for ((cpu) =3D 0; (cpu) < 1; (cpu)++)
> > > +#else
> > > =C2=A0#define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_poss=
ible_mask)
> > > =C2=A0#define for_each_online_cpu(cpu)=C2=A0=C2=A0 for_each_cpu((cpu)=
, cpu_online_mask)
> > > =C2=A0#define for_each_present_cpu(cpu)=C2=A0 for_each_cpu((cpu), cpu=
_present_mask)
> > > +#endif
> > > =C2=A0
> > > =C2=A0/* Wrappers for arch boot code to manipulate normally-constant =
masks */
> > > =C2=A0void init_cpu_present(const struct cpumask *src);
> > > --=20
> > > 2.36.1

