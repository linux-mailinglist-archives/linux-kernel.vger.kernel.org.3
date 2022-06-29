Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9558756050F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiF2P7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiF2P7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:59:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670EE1BE8C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBFA961892
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 15:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A471AC34114;
        Wed, 29 Jun 2022 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656518348;
        bh=vkCMRqaCWUx4F0m0dc0QUXqxBSA2sPUMQx/IJbseS2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toanYwsEgQT1GQBCfgkgpOloQvb0+sOkiUXC5hGJ9PXvaVxKVSIk/boRFelncp4cn
         XxinNnjJS/1IDML3UkqDQ2/h+bssAeGimUdAtByN10tW+o9CJ6nHBfsvsfg19Jsf3a
         nQf06malJlk2TZKpNtqWWiZ98OOxymBWHg/ajc3fOmmPsYQCyZ0rK4y9JyyRVjBwAr
         +s/rwFP4uduBXrl2H/2ORHYoDOPaZp5EjVkZtm0aEPhB7C5BNwNU5EvScNj9Fyxerw
         OSNkGvcxnALbfmPan+VVYgvYH0MGSSlnImRZOjg5cKUIDLLDVj1FJnnTktwRxL0HUe
         TDuBDGc4JJcMg==
Date:   Wed, 29 Jun 2022 16:59:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: Add initial set of stack unwinder self tests
Message-ID: <Yrx2xwbYMfcl8Qok@sirena.org.uk>
References: <20220624141000.88120-1-iivanov@suse.de>
 <20220624141000.88120-2-iivanov@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OcGioRICVq9yfSBj"
Content-Disposition: inline
In-Reply-To: <20220624141000.88120-2-iivanov@suse.de>
X-Cookie: Booths for two or more.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OcGioRICVq9yfSBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2022 at 05:10:00PM +0300, Ivan T. Ivanov wrote:
> Add kunit tests for obvious cases where stack unwind could be needed.
> Like these:
>=20
>  * Unwind a separate task
>  * Unwind starting from caller
>  * Unwind from irq context
>  * Unwind from kprobe handler called via ftrace
>  * Unwind from ftrace handler
>  * Unwind through kretprobed function
>  * Unwind from kretprobe handler
>=20
> Tests are completely based on code used in s390 unwinder tests.
> Cases which where not relevant to aarch64 where removed and
> some places where adjusted to address aarch64 specifics.

I think this would be a bit easier to digest if it were a series which
builds things up with the test cases in individual patches, or at least
things like ftrace and kprobes split out a bit more, rather than every
single test all at once.  I've got a few *very* superficial comments
below, I think the code is fine but there's several moving pieces to
check.

> +/*
> + * Calls test_arch_stack_walk() which is handy wrapper of aarch64 unwind
> + * functionality, and verifies that the result contains unwindme_func2
> + *followed by unwindme_func1.

Missing space.

> +	ret =3D register_ftrace_function(fops);
> +	if (!ret) {
> +		ret =3D test_unwind_ftraced_func(u);
> +		unregister_ftrace_function(fops);
> +	} else {
> +		kunit_err(current_test,
> +			  "failed to register ftrace handler (%d)\n", ret);
> +	}

Shouldn't we return an error here?

--OcGioRICVq9yfSBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8dsYACgkQJNaLcl1U
h9C6Egf9GSle5eDoCuHiH/eFkHYYrFpZpnWzgNctALXJSONbkHnpSlnIyL4T6hzX
XoYDY3/6N0WdvTS2bJX5HY29zpxHMT+4GILMsW8z3pBcd5QskK0fP37/xR8F34Bf
/YHcW0mBh868LtHg6mdhPpWGQDOemt+BgB7oR+Uy68XxCP4BBZj1dsJuZIzxpu/E
GUhh6t4zWGrP3gr51ZxsqCpcnun4NjyGHrDlliNApLItPpr7wLWrQ3ZdUzbFMjLg
I7C5sRk5yV+xgnYRrYW3ZFrLuOoXsEf+aR95yguthYa4UG4VU+lll4ZAXObQbqH/
aZZZepN0KJE/dl/bd1Tx4N2GN7anNA==
=XUtp
-----END PGP SIGNATURE-----

--OcGioRICVq9yfSBj--
