Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07F75A5974
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiH3CeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiH3CeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:34:01 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F92190C7C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:34:00 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MGrwR0z6YzDqNy;
        Tue, 30 Aug 2022 02:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661826839; bh=FBA7vMb+rgG7Qoy28W2Z07a8D5nOpV54IOm0PHU9X+4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=skPASDkcQSSFSas3Z56yj28qCarMA6dolky44XaBZgvSHqN4sBQx5YLeLOKoLoiRO
         qPsB+rlHCW6+E5R2w9shk6vaMdeQ4xZMFeAVtAzRRMcBITuDikPOfwX/Cy2AtCC/NH
         1atKAxKrMP7cjg+W/vkN4trOBg+m4KPKgu7aZ/7k=
X-Riseup-User-ID: DA68E99367F6891740E74145F1354C44AA2E3FF34314E3D12E4572AD807607F0
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MGrwK0WcYz1yQt;
        Tue, 30 Aug 2022 02:33:52 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/2] testing/selftests: Add tests for the is_signed_type()
 macro
From:   Isabella Basso <isabbasso@riseup.net>
In-Reply-To: <20220826162116.1050972-2-bvanassche@acm.org>
Date:   Mon, 29 Aug 2022 23:33:50 -0300
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sander Vanheule <sander@svanheule.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yury Norov <yury.norov@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <74370E0B-AC37-435F-A44C-5DBAA8A38496@riseup.net>
References: <20220826162116.1050972-1-bvanassche@acm.org>
 <20220826162116.1050972-2-bvanassche@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bart,

Glad to see some more KUnit tests making it inside of the kernel=E2=80=99s=
 lib folder :).

> Am 26/08/2022 um 1:21 PM schrieb Bart Van Assche <bvanassche@acm.org>:
>=20
> Although not documented, is_signed_type() must support the 'bool' and
> pointer types next to scalar and enumeration types. Add a selftest =
that
> verifies that this macro handles all supported types correctly.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Isabella Basso <isabbasso@riseup.net>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Sander Vanheule <sander@svanheule.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> lib/Kconfig.debug         | 12 ++++++++++
> lib/Makefile              |  1 +
> lib/is_signed_type_test.c | 48 +++++++++++++++++++++++++++++++++++++++
> 3 files changed, 61 insertions(+)
> create mode 100644 lib/is_signed_type_test.c
>=20
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 072e4b289c13..36455953d306 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2506,6 +2506,18 @@ config MEMCPY_KUNIT_TEST
>=20
> 	  If unsure, say N.
>=20
> +config IS_SIGNED_TYPE_KUNIT_TEST
> +	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds unit tests for the is_signed_type() macro.
> +
> +	  For more information on KUnit and unit tests in general please =
refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
> config OVERFLOW_KUNIT_TEST
> 	tristate "Test check_*_overflow() functions at runtime" if =
!KUNIT_ALL_TESTS
> 	depends on KUNIT
> diff --git a/lib/Makefile b/lib/Makefile
> index 5927d7fa0806..70176ff17023 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -377,6 +377,7 @@ obj-$(CONFIG_BITS_TEST) +=3D test_bits.o
> obj-$(CONFIG_CMDLINE_KUNIT_TEST) +=3D cmdline_kunit.o
> obj-$(CONFIG_SLUB_KUNIT_TEST) +=3D slub_kunit.o
> obj-$(CONFIG_MEMCPY_KUNIT_TEST) +=3D memcpy_kunit.o
> +obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) +=3D is_signed_type_test.o
> obj-$(CONFIG_OVERFLOW_KUNIT_TEST) +=3D overflow_kunit.o
> CFLAGS_stackinit_kunit.o +=3D $(call cc-disable-warning, =
switch-unreachable)
> obj-$(CONFIG_STACKINIT_KUNIT_TEST) +=3D stackinit_kunit.o
> diff --git a/lib/is_signed_type_test.c b/lib/is_signed_type_test.c
> new file mode 100644
> index 000000000000..f2eedb1f0935
> --- /dev/null
> +++ b/lib/is_signed_type_test.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + *	./tools/testing/kunit/kunit.py run is_signed_type [--raw_output]
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <kunit/test.h>
> +#include <linux/overflow.h>

Nit: I don=E2=80=99t know if that makes a huge difference but you might =
include
`<linux/compiler.h>` directly to make the final object smaller. Of =
course, that
would ideally be a change happening in 2/2 but that was already merged =
:).

> +
> +enum unsigned_enum {
> +	constant_a =3D 3,
> +};
> +
> +enum signed_enum {
> +	constant_b =3D -1,
> +	constant_c =3D 2,
> +};
> +
> +static void is_signed_type_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, is_signed_type(bool), false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(signed char), true);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned char), false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(int), true);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned int), false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(long), true);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned long), false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(long long), true);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned long long), =
false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(enum unsigned_enum), =
false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(enum signed_enum), true);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(void *), false);
> +	KUNIT_EXPECT_EQ(test, is_signed_type(const char *), false);
> +}
> +
> +static struct kunit_case is_signed_type_test_cases[] =3D {
> +	KUNIT_CASE(is_signed_type_test),
> +	{}
> +};
> +
> +static struct kunit_suite is_signed_type_test_suite =3D {
> +	.name =3D "is_signed_type",
> +	.test_cases =3D is_signed_type_test_cases,
> +};
> +
> +kunit_test_suite(is_signed_type_test_suite);
> +
> +MODULE_LICENSE("Dual MIT/GPL=E2=80=9C);

Tested-by: Isabella Basso <isabbasso@riseup.net>

Cheers,
--
Isabella Basso=
