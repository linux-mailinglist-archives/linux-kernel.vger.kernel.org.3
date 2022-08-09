Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603C558DFBD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345495AbiHITE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344971AbiHITDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:03:19 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4424F2BB12
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:38:35 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id B6DBC308D38;
        Tue,  9 Aug 2022 20:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660070313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XCAlQh340Gv2GXIfBR/MCf+ZNSS5XsT3mS3hrXItgo=;
        b=KO37h82ctwaPkHgAPj0X3iSVtxwg5nu/Xh3FNBu5FFallbWjizQcSIhho/J/igKVUb6cIl
        Q9GE7JqVhHkyqeqPzgdkhfkOC1XE6cI1Bn1eulnJKYDixM0soL/gsXxWAyM4jDqKgcpr0t
        KXeLin3le3A3SWKoOZWBaprCiaUtuLTmklhFd4YDs88HfU/kEAPAbMftUC9CcBgj5r5i+n
        J+ftGYvl/VQxscGFIbay2VJVPYX4h0DrO2PnIRJpDUYxFr9utuhR77doup97kze99thOPT
        CQ/LqsMW8n2K7l42pelpSAKenJjQPYNL4mOTRIgrFqXRdYcGVg6jBG1C/iqxFw==
Message-ID: <9f8e0340a7e70f03a5629247384a9b282af8de18.camel@svanheule.net>
Subject: Re: [PATCH v5 4/5] lib/test: introduce cpumask KUnit test suite
From:   Sander Vanheule <sander@svanheule.net>
To:     =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
Date:   Tue, 09 Aug 2022 20:38:31 +0200
In-Reply-To: <b6b20883-3fe7-9a5d-ab55-b5a61cef996c@riseup.net>
References: <cover.1659077534.git.sander@svanheule.net>
         <85217b5de6d62257313ad7fde3e1969421acad75.1659077534.git.sander@svanheule.net>
         <b6b20883-3fe7-9a5d-ab55-b5a61cef996c@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
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

Hi Ma=C3=ADra,

On Sun, 2022-07-31 at 12:23 -0300, Ma=C3=ADra Canal wrote:
> Hi Sander
>=20
> On 7/29/22 04:01, Sander Vanheule wrote:
> > Add a basic suite of tests for cpumask, providing some tests for empty =
and
> > completely filled cpumasks.
> >=20
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Ma=C3=ADra Canal <mairacanal@riseup.net>
> > ---
> > Changes since v4:
> > - Belated addition of Yury's Suggested-by:
> > - Follow KUnit style more closely
> > - Drop full check on cpu_possible_mask
> > - Update last check on cpu_possible_mask
> > - Log masks when starting test
> > - Update commit message=20
> > =C2=A0=20
> > Changes since v3:
> > - Test for_each_cpu*() over empty mask and cpu_possible_mask
> > - Add Andy's Reviewed-by
> > - Use num_{online,present,possible}_cpus() for builtin masks
> > - Guard against CPU hotplugging during test for dynamic builtin CPU mas=
ks
> > =C2=A0
> > Changes since v2:
> > - Rework for_each_* test macros, as suggested by Yury
> >=20
> > Changes since v1:
> > - New patch
> >=20
> > =C2=A0lib/Kconfig.debug=C2=A0 |=C2=A0 12 ++++
> > =C2=A0lib/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 =
+
> > =C2=A0lib/cpumask_test.c | 147 ++++++++++++++++++++++++++++++++++++++++=
+++++
> > =C2=A03 files changed, 160 insertions(+)
> > =C2=A0create mode 100644 lib/cpumask_test.c
> >=20
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 2e24db4bff19..e85e74646178 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2021,6 +2021,18 @@ config LKDTM
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation on how to=
 use the module can be found in
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation/fault-inj=
ection/provoke-crashes.rst
> > =C2=A0
> > +config CPUMASK_KUNIT_TEST
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "KUnit test for cpu=
mask" if !KUNIT_ALL_TESTS
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on KUNIT
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default KUNIT_ALL_TESTS
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable to turn on cpu=
mask tests, running at boot or module load
> > time.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For more information =
on KUnit and unit tests in general, please
> > refer
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to the KUnit document=
ation in Documentation/dev-tools/kunit/.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If unsure, say N.
> > +
> > =C2=A0config TEST_LIST_SORT
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Linked list s=
orting test" if !KUNIT_ALL_TESTS
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on KUNIT
> > diff --git a/lib/Makefile b/lib/Makefile
> > index bcc7e8ea0cde..9f9db1376538 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -59,6 +59,7 @@ obj-$(CONFIG_TEST_BPF) +=3D test_bpf.o
> > =C2=A0obj-$(CONFIG_TEST_FIRMWARE) +=3D test_firmware.o
> > =C2=A0obj-$(CONFIG_TEST_BITOPS) +=3D test_bitops.o
> > =C2=A0CFLAGS_test_bitops.o +=3D -Werror
> > +obj-$(CONFIG_CPUMASK_KUNIT_TEST) +=3D cpumask_test.o
> > =C2=A0obj-$(CONFIG_TEST_SYSCTL) +=3D test_sysctl.o
> > =C2=A0obj-$(CONFIG_TEST_SIPHASH) +=3D test_siphash.o
> > =C2=A0obj-$(CONFIG_HASH_KUNIT_TEST) +=3D test_hash.o
> > diff --git a/lib/cpumask_test.c b/lib/cpumask_test.c
> > new file mode 100644
> > index 000000000000..0f8059a5e93b
> > --- /dev/null
> > +++ b/lib/cpumask_test.c
>=20
> In order to make the tests at lib/ with more compliant naming, it would
> make more sense to name it test_cpumask.c.
>=20
> Thank you for the respin to the series! All tests are passing now.
>=20
> Tested-by: Ma=C3=ADra Canal <mairacanal@riseup.net>

I have posted some follow-up patches for the cpumask test suite:
https://lore.kernel.org/lkml/cover.1660068429.git.sander@svanheule.net/

As you will see, I have not included your Tested-by: there.  The changes we=
re
split, so I didn't want to just add your tag to the individual patches.  Ma=
y I
ask you to re-test the new patches on top of current master, so you can pro=
vide
your Tested-by: where relevant?

Thanks,
Sander
