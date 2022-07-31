Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CE7585F8F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiGaPmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiGaPmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:42:11 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F12E0B9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:42:09 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id C72BB303F57;
        Sun, 31 Jul 2022 17:42:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1659282126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDW87rzq7ro2FgSIprUGPHMmnXWSqtXOaM2kkRevn9s=;
        b=7mDls5q4oHDOEttNS6eT19X+xsOOpHubgLsLZGOwJfMyBgLdyWMWLykAxnYy/Z5il9CaYG
        T11MvGbSX2xzD72D6F3/jX9y2b64Hl2RiuGHR3JDYYkjJBYSz5w4r5NXsJZIggwZ2xtGZL
        3J2PGbT9IC8RrP5NZZE7i2v43IGrSrPWEAu3Cqgzs4lQ9ocA3HpNQlE3g+v1yA6fxmyfX5
        xNAGZ5vuWxHpRDNCm+EOzjmCg4DBfKxDxD3hmtl0YMczQYa0k8W9uwvTVo+XjOFY8hJlGs
        2KGo29cGi+6N/ka414zcwV49ApUnfM5Vb81nod8I7cprkMR9o08ivYufNNjzIw==
Message-ID: <1ad99cc0df85c932a7df18f67560930e37976e2b.camel@svanheule.net>
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
Date:   Sun, 31 Jul 2022 17:42:03 +0200
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

That's what I had originally, exactly because I copied the naming from othe=
r
files in lib/. That didn't match the style guide [1] which proposes the _te=
st.c
or _kunit.c suffix.

Most files in lib/ use the test_ prefix (45), but some use the  _test.c suf=
fix
(4), or _kunit.c suffix (6). Of the "test_" ones, only 8 are actually KUnit=
 test
suites. I personally think the style guide makes a good argument to use a
suffix, as that clearly places the test suite next to the relevant file in =
an
alphabetic listing.

Based on the above, would you agree with using "cpumask_kunit.c" as the
filename? That distinguishes it from the non-KUnit test files, and follows =
the
style guide.

[1] https://docs.kernel.org/dev-tools/kunit/style.html#test-file-and-module=
-names

>=20
> Thank you for the respin to the series! All tests are passing now.
>=20
> Tested-by: Ma=C3=ADra Canal <mairacanal@riseup.net>

Thank you for testing!

Best,
Sander
