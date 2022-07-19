Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD457A01D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiGSNwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiGSNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:52:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E8A9D53D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEB3DB81B89
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9120C341CA;
        Tue, 19 Jul 2022 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658235896;
        bh=Bx7LKchDiAveeOBKr6k9XrTbJD0MgIx3qu4AgTFAg7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXYv6mCsUL2KvMdT3MTrGIW00v3SiZbFkDv9SsjSdo0RUA0ChAKssXSlyQ6j5Ri+C
         AsbBNC/PliftRAw9RhMZjVUhS8V2mWFrZNKchu2MM62vmIShpO4KuWOpgw6AXnMRdu
         GMCZQH6IN+SJpRlQFypH55KF0WGm1Fh4HEtpWvOadbQacSkN3sC59Ksuu3ml9x2xYX
         I6VgN0VWxDiK5sZfboPec9kFe9fQOjXD+Ho1+mF5E+05QqHlQM0DzfuNYHC0RIEk9W
         Vq8l9G0chQ0r0uMDG1bmok/6lkA8m6WeBS2FJRuhuq3E6SIiEh8+9osaq3ggk7A/yD
         uHPBGi7Ip1jXw==
Date:   Tue, 19 Jul 2022 14:04:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] regmap: support regmap_field_write() on non-readable
 fields
Message-ID: <Ytar85UrdSeJuj2Y@sirena.org.uk>
References: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
 <20220719125401.GA92394@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="90wO/64vRt6w3wzR"
Content-Disposition: inline
In-Reply-To: <20220719125401.GA92394@ediswmail.ad.cirrus.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--90wO/64vRt6w3wzR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2022 at 12:54:02PM +0000, Charles Keepax wrote:
> On Tue, Jul 19, 2022 at 02:14:46PM +0200, Krzysztof Kozlowski wrote:

> > +	if (regmap_readable(field->regmap, field->reg))
> > +		return regmap_update_bits_base(field->regmap, field->reg,
> > +					       mask, val << field->shift,
> > +					       change, async, force);

> I think this will break other valid use-cases, regmap_readable (I
> believe) returns if the register is physically readable, however
> it should still be possible to use update bits if the register is
> in the cache even if it can't physically be read. So really you
> need to fall into this path if it is readable or in the cache.

This is true, we don't currently have a readable_or_cached() check -
this is implemented as trying the cache and only considering actually
reading if there's a read, effectively what we want to do here is force
a cache only read.

--90wO/64vRt6w3wzR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWq/IACgkQJNaLcl1U
h9A3wAf8Dt/lXo81K54hsSzJBl/t8426SyZEwBd4MDYdc3TuCwgRKKizU7JvZMyI
Dm2+3G16XPAL+JWuqB+scdyG1bHfTidPtX8KIbwUEJMwgUO07WNNAGWunP294TOO
loAlZh9SUeq1by8eDaBwMDdKaT8Uvi9UYZ7hi+VqIoz1yiOJuRVmZPAEJRDM2q+f
5OBp6WIQXtKqipQygLTM3KFAEyrivtXowUwaVYWlL4qYi5ROZ328/kmBK4HWSC2Y
Kw/gMRunc3v9mL0ogANuBZBGBKXkEU2J6D3YfiZjQIGOYLX2eASJnrGIPUAu71iP
dPCDsaaQrXD0jWiuXYBXPFSBnpbDKg==
=sMAD
-----END PGP SIGNATURE-----

--90wO/64vRt6w3wzR--
