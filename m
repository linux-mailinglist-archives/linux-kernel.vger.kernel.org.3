Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFE0581561
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiGZOeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiGZOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B12B195
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5340A61650
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF61C433C1;
        Tue, 26 Jul 2022 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658846051;
        bh=p2tvdR/m+sxzsLxs5/qItkjzVJ2I3yM1XR+mYnyc0Ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hs411YusHafoixLqrOgQ8ZHvLCB304wjjhSD+OqtW2UZ6ekEV6fP6SoDMENpF13e1
         Z8um+b+iJadQi6/xEdDV8LIiuvPt5ooPNH9j9UCo1TmU/rbMltHejT+UWgmsofeikE
         CVnSy5XhQ342WdJZW0pnVTOYWV6/gzWMm3pP3PjNM46ChyQ+JVjvTUC23v5/LcfnYa
         p3C1M2HeqUG3Te7u1Bqn5cs8SGVEFQQvyLrsGDCX8xqxAnSR39bqvknotpyymfO11w
         6eZ+4wHjrqkzc7O+gmoRh8svTz1Gt7xvKgd5EZrZ+kfaBiSY2DkvGyxYlrtkzYNiEQ
         vge4MqDJq39WA==
Date:   Tue, 26 Jul 2022 15:34:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, madvenka@linux.microsoft.com,
        tabba@google.com, oliver.upton@linux.dev, will@kernel.org,
        qperret@google.com, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v6 04/17] arm64: stacktrace: Handle frame pointer from
 different address spaces
Message-ID: <Yt/7WzuBzc1m/6JU@sirena.org.uk>
References: <20220726073750.3219117-1-kaleshsingh@google.com>
 <20220726073750.3219117-5-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EaZlof6ZidZOvm5w"
Content-Disposition: inline
In-Reply-To: <20220726073750.3219117-5-kaleshsingh@google.com>
X-Cookie: All rights reserved.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EaZlof6ZidZOvm5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 12:37:37AM -0700, Kalesh Singh wrote:
> The unwinder code is made reusable so that it can be used to
> unwind various types of stacks. One usecase is unwinding the
> nVHE hyp stack from the host (EL1) in non-protected mode. This
> means that the unwinder must be able to translate HYP stack
> addresses to kernel addresses.
>=20
> Add a callback (stack_trace_translate_fp_fn) to allow specifying
> the translation function.

Reviewed-by: Mark Brown <broonie@kernel.org>

with or without one very minor thing:

>  static inline int unwind_next_common(struct unwind_state *state,
> -				     struct stack_info *info)
> +				     struct stack_info *info,
> +				     stack_trace_translate_fp_fn translate_fp)
>  {
> +	unsigned long fp =3D state->fp, kern_fp =3D fp;

As a coding style nit I don't love having multiple assignments on a
single line especially as part of declarations.

--EaZlof6ZidZOvm5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLf+1oACgkQJNaLcl1U
h9D6QggAgqsmZ8mydShiSjezLG0cke2LdLT+FUK0qBgaBpRGDl0V3nysu3AwZHDK
x5J27veMMJPOhXrlIBGeexncpsAzerUu0gnqaCaSchCg3+nJ5icOwm3oseVBWNqU
qkgBVFEKk1mSwMjn7NfgsfJl+hCxykg+E3UqycOPMskyx88qiAqjPXUYJ/3au3Gt
gWu5Q2uNZ2TRdvPT5z0Cued1slb4+y+aPSZW/6KqYnrVARg+Tk6O1QDHYO+DakOU
e2R7hexHSyrGA5gkg5nh2REeVAi46Lf1xTDYhO8JxdS2l6rwLswP2Dw/bUyYIyqv
JCGy7XtA5k4RK05GlerYcRM8q5DnhQ==
=YaN6
-----END PGP SIGNATURE-----

--EaZlof6ZidZOvm5w--
