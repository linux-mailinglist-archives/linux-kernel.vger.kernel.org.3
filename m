Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4DE553621
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351809AbiFUPbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiFUPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:31:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2C52A731
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21720B81A66
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6833DC3411C;
        Tue, 21 Jun 2022 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655825504;
        bh=QH3IfRsSkOBT2QoawtIpMgrweswcjVapae4Wk3ONlV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+wNc6FA3rkYWrp8fwJUfky57rP86Uxjyvbcd7iQYPgaH2FerjUFC8K8EUc/WgjU0
         frAsYm1jnhlzLexwmdYgS3YehxbOpcMxCnzsW3BE9UMHQquRT1efwLTsQrA08MvXMM
         xIFQfEIEuBMsvjq5ujgerCbZVZK9aoR1hsoHnZpGBQs+Gm4a2xrB9qGRDHN6M7SlKL
         Uke9ZpHBhwL5R7vkZac0eeITMTvo9shL/cgBBHTvu64zgZzIEG5jhjsuEPzLrwa40k
         S3EksluD+0T6ZGGx9Mxy8taDn8bnIkcfY9j2FMYuV/rDore+ylSlI+5I+z9slj9dsZ
         J6TX2rkquI2Pw==
Date:   Tue, 21 Jun 2022 16:31:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
Message-ID: <YrHkXH1M4NydBfQT@sirena.org.uk>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
 <20220620134758.1286480-2-aisheng.dong@nxp.com>
 <YrCM0reni+x/KWsG@sirena.org.uk>
 <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk>
 <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk>
 <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j+2qesJ+vOzgaqpI"
Content-Disposition: inline
In-Reply-To: <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
X-Cookie: Edited for television.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j+2qesJ+vOzgaqpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 21, 2022 at 02:56:58PM +0000, Aisheng Dong wrote:

> > so if we can't satisfy the read from the cache then we'll hit the cache_only
> > check and return -EBUSY before we start trying to do any physical I/O.  The
> > debugfs code will handle that gracefully, indicating that it couldn't get a value
> > for the volatile register by showing all Xs for the value.  If none of the registers
> > are cached then the file won't be terribly useful but it at least shouldn't cause
> > any errors with accessing the device when it's powered down.

> That means we have to use cache_only mode to workaround the issue, right?
> I saw that cache_only mode has to be explicated enable/disable by driver,
> commonly used in device rpm in kernel right now.

Yes.

> However, things are a little bit complicated on i.MX that 1) imx blkctl
> needs follow strict registers r/w flow interleaved with handshakes with upstream gpc
> power operations and delay may be needed between registers writing
> 2) blkctl itself does not enable runtime pm, it simply call rpm to resume upstream power
> domains devices and necessary clocks before r/w registers.

I'm not sure I fully understand the issue here?  If the driver can
safely manage the hardware surely it can safely manage cache only mode
too?  If there are duplicate resumes then cache only enable/disable is a
boolean flag rather than refcounted so that shouldn't be a problem.

> Furthermore, current imx blkctl is a common driver used by many devices [1].
> Introducing volatile registers and cache may bloat the driver a lot unnecessarily.

You don't actually need to have a cache to use cache only mode, if there
are no cached registers then you'll just get -EBUSY on any access to the
registers but that's hopefully fine since at the minute things will just
fall over anyway.  You shouldn't even need to flag registers as volatile
if there's no cache since it's not really relevant without a cache.

> The simplest way for i.MX case may be just disabling debugfs as it can't reflect the actually
> HW state without power. So we would wish the regmap core could provide an option to users.

The goal here is to describe the regmap itself so that there's less
fragility as things change and we don't needlessly disable anything else
that happens to be added to debugfs in the future due to having an
overly generic flag, and we get the ability to directly catch access to
the hardware that misses doing power management properly while we're at
it.

We already have a way to describe it being unsafe to access the
hardware, we may as well use it.

> And I noticed that syscon [2] seems have the same issue since the following commit:

> commit 9b947a13e7f6017f18470f665992dbae267852b3
> Author: David Lechner <david@lechnology.com>
> Date:   Mon Feb 19 15:43:02 2018 -0600

>     regmap: use debugfs even when no device

>     This registers regmaps with debugfs even when they do not have an
>     associated device. For example, this is common for syscon regmaps.

That's a different thing, that's due to us naming the directory after
the struct device but syscons being created before we have that struct
device available.

--j+2qesJ+vOzgaqpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKx5FsACgkQJNaLcl1U
h9D+1Af/YqAqXUsZeXJsnvaUzq+RcR0sZ+pLAVSE+gKYxIGycNrmBpV7XAIbpLxt
ctXCX3Lk799GaVZjmS9CY2n11Ep1niPK9IrVxuLTgAEwZwz8psGZ4OJPHT3Ip9QF
13MYSXL4o40Na78gegF2UZzO/jrJKymxPnWZqrS+VHDdZ+ibq/2Q0bBH+MTkBDKI
WPYu3lRYprVSqCRNY0G/4X/oLmN/2Yw/b5LWFIu98GcYYJe10vd90W+/VQM2IzJ5
N5hX+5ignDx5RVzCP1zCjnbTXk0NVigN9yqzM+JlB76JnxyC519V+LGqJLoaICVH
10MT2ZIFbFDyANt9dA8SzqaLcZACMQ==
=CERs
-----END PGP SIGNATURE-----

--j+2qesJ+vOzgaqpI--
