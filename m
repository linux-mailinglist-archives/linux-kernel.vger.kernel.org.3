Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33157B6AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbiGTMn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiGTMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:43:56 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596B66A9EC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:43:55 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 672EB2FDF28;
        Wed, 20 Jul 2022 14:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658321031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLa9ia/5rkmFJmloGz3UgIhzu9GXQxrE148P7DUdWmg=;
        b=JIf4yIIXMCXmA0uJ8AZfbBjgcg/BFhHsjVVWLIkYl67wNlp8lVYQC+y/IFiMlVcv3/6E1H
        9pfFdVYqEPDngZxVTZfuZ6laAYBktzBM5TfbB5ZXFctFnhVWDCRGjEwer2WngzctdTY8Bm
        Ji2MTKf+SAZaeqZRUqf6ROGMF0P5TccB1YMZ0W/URJjMTsXTz+XPRRkDoa935lS8sisOqD
        HsTg23dYGEl6Ms89R2XL5rOaot5NdIxQv3dIX2g+Eq0RGgCZrl03iQbpo0PvguPtVZWmzs
        ClO7Qjz0levsnKCwz/fvlKdoL+lidvmWqIqTgLw06NXvgmEQ2gJRCRxqUNaKdA==
Message-ID: <9b4e181abab0bec20dae93d35fe962b8167c73c9.camel@svanheule.net>
Subject: Re: [PATCH v4 3/5] lib/test: Introduce cpumask KUnit test suite
From:   Sander Vanheule <sander@svanheule.net>
To:     David Gow <davidgow@google.com>,
        =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        bp@alien8.de, dave.hansen@linux.intel.com,
        Marco Elver <elver@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        vschneid@redhat.com, x86@kernel.org, yury.norov@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 20 Jul 2022 14:43:49 +0200
In-Reply-To: <CABVgOSkPXBc-PWk1zBZRQ_Tt+Sz1ruFHBj3ixojymZF=Vi4tpQ@mail.gmail.com>
References: <c96980ec35c3bd23f17c3374bf42c22971545e85.1656777646.git.sander@svanheule.net>
         <346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net>
         <CABVgOSkPXBc-PWk1zBZRQ_Tt+Sz1ruFHBj3ixojymZF=Vi4tpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Ma=C3=ADra,

On Wed, 2022-07-20 at 13:24 +0800, David Gow wrote:
> On Wed, Jul 20, 2022 at 5:31 AM Ma=C3=ADra Canal <mairacanal@riseup.net> =
wrote:
> >=20
> > > Add a basic suite of tests for cpumask, providing some tests for empt=
y
> > > and completely filled cpumasks.
> > >=20
> > > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > The tests test_cpumask_weight and test_cpumask_last are failing on all
> > architectures, as can be seen on [1]. Also this test doesn't follow the
> > standard style for KUnit tests [2].
> >=20
> > [1]
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-2022071=
8/testrun/10865066/suite/kunit/tests/
> > [2] https://docs.kernel.org/dev-tools/kunit/style.html
> >=20
> > CC: Brendan Higgins <brendanhiggins@google.com>
> > CC: David Gow <davidgow@google.com>
> >=20
> > Best Regards,
> > - Ma=C3=ADra Canal
> >=20
>=20
> Hmm... this test passes on the default kunit_tool configs for UML and
> x86_64, which are all without SMP.
>=20
> It looks like the flaw is that, if CONFIG_NR_CPUS is greater than the
> actual number of CPUs present, then the cpu_possible_mask (correctly)
> won't be full.
>=20
> I'm not sure what the right fix is: but removing the checks for
> cpu_possible_mask being full is probably the way to go. Unless we want
> to plumb through some actual detail about the underlying system and
> check against that, it doesn't make sense. (Or, we could generate an
> artificial "possilbe_mask" which is always full, and test the cpu
> against that. But we sort-of already do that with mask_all anyway.)

The description of cpu_possible_mask does indeed allow for it to not be fil=
led
completely.

>=20
> So, my recommendation for a fix would be:
> - Get rid of "KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));"

As per the above, I'll remove this (faulty) check.

> - Replace "KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1,
> cpumask_last(cpu_possible_mask));" with a KUNIT_EXPECT_GE()

I think we can actually use KUNIT_EXPECT_EQ(test, nr_cpu_ids - 1, ...) here=
.

Since cpumask_first() on the same mask must return at most nr_cpu_ids - 1 f=
or a
valid result, cpumask_last() cannot return anything larger than this value.=
=20
This implies that cpu_possible_mask cannot contain gaps if its weight equal=
s
nr_cpu_ids (which is checked in test_cpumask_weight).

> - _Maybe_ add some debug logging with the cpumask value being checked,
> as it's a pain to tell from the expectation failure messages. e.g.,
> kunit_info(test, "cpu_possible_mask =3D '%*pb[l]'\n",
> cpumask_pr_args(cpu_possible_mask));

That would be a useful addition, I'll see where I can add it.

Best,
Sander
>=20

