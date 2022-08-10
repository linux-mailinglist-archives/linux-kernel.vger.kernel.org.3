Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7597958E902
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiHJIpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiHJIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:45:39 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F00E27B31
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:45:38 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 06081309215;
        Wed, 10 Aug 2022 10:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660121137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wW1BnO3D+++ZeyOAYr0klJvyf1VeScMpK2Hw/FycF80=;
        b=PitDpYXr1MTFKl5Vc0Z0t9rnVUhvdMBVFgQN+FBbKqtRsWVvaWSZYLas5Pkgd82fMQA3j6
        hz4RfghwAZznttQPPnCCJaxWRjqLdw4l2+CPFuSBBpKm6l99AxiPHH8fuTy2DYr4gRzy3G
        2lwNPo7bDFwYduG+m6lW7IoIuF111L3y4cShuPs65OuXo1TEttxHx9Vz/hgiTPKsX7LmOA
        4ULn5oagnjTlazB2iwa49z/kD88FgDLTtmcv0uA2ClnBmOsVwVrlhztfvOjXusFrQSCz2E
        cRnTl4G+WgVZmS3DfawNB/HAJ+v8YCQHBcdqP/20IAg+cwx6RIpGOZCG8/2OFA==
Message-ID: <4f334657f927865266fee19a7920f7248a111ef8.camel@svanheule.net>
Subject: Re: [PATCH v1 1/5] lib/test_cpumask: drop cpu_possible_mask full
 test
From:   Sander Vanheule <sander@svanheule.net>
To:     David Gow <davidgow@google.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Date:   Wed, 10 Aug 2022 10:45:35 +0200
In-Reply-To: <CABVgOSmcKHH2zcCbT-jzekFP8RFov4V0AFBsGjU9kXSy9pJ9HQ@mail.gmail.com>
References: <cover.1660068429.git.sander@svanheule.net>
         <30d8882efedea697da20c27563050008d1569b9e.1660068429.git.sander@svanheule.net>
         <CABVgOSmcKHH2zcCbT-jzekFP8RFov4V0AFBsGjU9kXSy9pJ9HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

Hi David,

On Wed, 2022-08-10 at 12:06 +0800, David Gow wrote:
> On Wed, Aug 10, 2022 at 2:09 AM Sander Vanheule <sander@svanheule.net> wr=
ote:
> >=20
> > cpu_possible_mask is not necessarily completely filled.=C2=A0 That mean=
s
> > running a check on cpumask_full() doesn't make sense, so drop the test.
> >=20
> > Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
> > Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73=
@riseup.net/
> > Reported-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > Cc: David Gow <davidgow@google.com>
> > ---
>=20
> Looks good to me. It'd maybe be worth noting _why_=C2=A0 cpu_possible_mas=
k
> is not always filled (i.e., that the number of available CPUs might
> not match the maximum number of CPUs the kernel is built to support),
> but it's probably not worth doing a new version of the patch series
> just for that.
>=20
> Reviewed-by: David Gow <davidgow@google.com>

Thanks for the reviews!

Perhaps the commit message could be replaced by:

"When the number of CPUs that can possibly be brought online is known at bo=
ot time, e.g. when
HOTPLUG is disabled, nr_cpu_ids may be smaller than NR_CPUS. In that case, =
cpu_possible_mask would
not be completely filled, and cpumask_full(cpu_possible_mask) may return fa=
lse for valid system
configurations."


Best,
Sander

>=20
> Cheers,
> -- David
>=20
>=20
> > =C2=A0lib/test_cpumask.c | 1 -
> > =C2=A01 file changed, 1 deletion(-)
> >=20
> > diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> > index a31a1622f1f6..4ebf9f5805f3 100644
> > --- a/lib/test_cpumask.c
> > +++ b/lib/test_cpumask.c
> > @@ -54,7 +54,6 @@ static cpumask_t mask_all;
> > =C2=A0static void test_cpumask_weight(struct kunit *test)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_TRUE(test, cpum=
ask_empty(&mask_empty));
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_TRUE(test, cpumask_f=
ull(cpu_possible_mask));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_TRUE(test, cpum=
ask_full(&mask_all));
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_EXPECT_EQ(test, 0, cpu=
mask_weight(&mask_empty));
> > --
> > 2.37.1
> >=20
