Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76205573AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiGMQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiGMQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:14:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244392CDCA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:14:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D752CB820D8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52580C34114;
        Wed, 13 Jul 2022 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657728841;
        bh=DvjZSWjJSynzTljUk3T648bwZUpu+50b1mDXGdCiOTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uts4chHNkesQy89lPW2WzTCNX5jezmkEYtgzFkqlT1NsNYaL6tP6TADy05RYUMBFX
         QrbjphlbHqTXXLVgcmcTPy03dlnIoLKkFJePkTzyHe8nj5u2Ru/iqcxQTDq9jA+2a/
         LKWdwUWxkO2lsyj7F3BmffWOb8C/DM4TJSEhinkuJlcJ9crIQXuazKdz351biYvPh5
         M2d+hdLLLhx+nONHBTYDmAwBgYXBOk8n7QiZeAUqo6nGJa8MRdZeK52tLMTu1GzJIi
         iCsTc1xR0PJ+Llf/c6o9jbbcv/bhrxfvwi75MoLJruNvf1Wz5h3JTphVkbrTqat7fb
         JuzlYofbruZUQ==
Date:   Wed, 13 Jul 2022 17:13:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>, peterz@infradead.org
Subject: Re: [PATCH] lkdtm: cfi: add test for HW landing pad CFI
Message-ID: <Ys7vRTThFVNz7moO@sirena.org.uk>
References: <20220713151815.295520-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WlxfRJozGZMblBhb"
Content-Disposition: inline
In-Reply-To: <20220713151815.295520-1-mark.rutland@arm.com>
X-Cookie: Positively no smoking.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WlxfRJozGZMblBhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 13, 2022 at 04:18:15PM +0100, Mark Rutland wrote:
> Some architectures have coarse-grained HW CFI schemes where indirect
> branches must target a "landing pad" instruction (e.g. BTI on arm64,
> ENDBR on x86). These prevent gadgetization of arbitrary portions of
> functions.

> Add a test which checks these work as expected.

> For example, on arm64 HW with BTI this should result in a BTI exception
> being taken:

> +/*
> + * This tries to call an indirect function with an address which is not a
> + * function entry point. This should be caught by architectures with "landing
> + * pad" instructions (e.g. BTI on arm64, or ENDBR on x86).
> + */
> +static void lkdtm_CFI_FORWARD_LANDING_PAD(void)
> +{
> +	void (*func)(int *);
> +
> +	func = (void *)((unsigned long)lkdtm_increment_void + 4);
> +
> +	pr_info("Calling gadget address ...\n");
> +	func(&called_count);
> +
> +	pr_err("FAIL: survived gadget function call!\n");
> +}

Incrementing the address by 4 here is the right number for arm64 and it
looks like it's also right for the x86_64 ENDBR64 instruction but are we
guaranteed that it'll do the right thing for other architectures,
especially those with variable length instructions - couldn't we just
get an illegal instruction exception due to ending up pointing at
something that isn't the start of an instruction even if CFI isn't
active?

Not sure that worrying about that at this point isn't making perfect the
enemy of good though, it could be dealt with later.  Perhaps just put
the offset behind a #define to make it a tiny bit more discoverable?

--WlxfRJozGZMblBhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLO70QACgkQJNaLcl1U
h9D14Af/Zaux0oRRA5qwI/epaZXUJgBNjGSvWjmGaLzusl+j5w6kPReW+Xk/+UxX
Qg7eHQPhR6vOpOmDMlzKvtZHoKM/fiZVJQAGKVQZDJ85+uG5XsoA+wy/EuC69Hm3
Y96or99YmhNacpjh7Tnqmct5pAuiRiCw80vHBsCjJGgONwZPtjnY6163TgGKViKe
cm5EZT4AKPCzAHep0bM+GpMMVF+O/n52Q+kOSVuAhG4HlkACf9uL/IGYI2LUufMk
D7IprNWd+1FAwpcAwe1wVseLwco5sBboyeiit9KOKUVGOLVnnp7bZ0V+QbI7lKoe
EeH5UfIBoQg4j6dz5h/zL4ncMDy0Hg==
=57wd
-----END PGP SIGNATURE-----

--WlxfRJozGZMblBhb--
