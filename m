Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED835542E12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiFHKnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiFHKnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15535369E1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:43:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A78126120C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293DDC34116;
        Wed,  8 Jun 2022 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654684997;
        bh=0rzpE6UgFWk2qUmyC2Xz5lOzVZ7EhCvecB/fSMM6oe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgFD/7uSPpv6sEfkIXw3IdjRStWpu8k8qWVJp0afiNrgFIT4+TGmVDKUg+1PFLDdZ
         JOm775EVux8mqs8DITKD8O3Nk06k8vCHcbQ+iaNdzrsTGUtmt8gJzuQKVZNtUsbe8N
         7JvpFCUgPtENzrYyVMOQzROj+asVnP5axnSfevIt7JQZsGHrflLGzyswv12Kz3c67P
         FjIqzWgJKcEvBqi4YEJLIrpUWj4WofcgVxagBRx/b7TfutQMC+2YiCub5agQ5h0BnA
         XmpogfLbU5wHgR6TxKA8l8y2ZVBBIZoT8FZ3uB9Vy0SMxKgIKZlI12MJOH9aDiW6Kf
         xqPogR2rKfv3Q==
Date:   Wed, 8 Jun 2022 11:43:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, hao.wu@intel.com, trix@redhat.com,
        yilun.xu@intel.com, russell.h.weight@intel.com
Subject: Re: [PATCH v1] regmap: add generic indirect regmap support
Message-ID: <YqB9O8HhZV2tXo8g@sirena.org.uk>
References: <20220607013755.594554-1-tianfei.zhang@intel.com>
 <Yp9PdZn2Xu/oqiA8@sirena.org.uk>
 <alpine.DEB.2.22.394.2206071714420.3001206@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AJRKzDE6zVy7LGPR"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2206071714420.3001206@rhweight-WRK1>
X-Cookie: My NOSE is NUMB!
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AJRKzDE6zVy7LGPR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 07, 2022 at 05:27:38PM -0700, matthew.gerlach@linux.intel.com wrote:
> On Tue, 7 Jun 2022, Mark Brown wrote:
> > On Mon, Jun 06, 2022 at 09:37:55PM -0400, Tianfei Zhang wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

> > > This patch adds support for regmap APIs that are intended to be used by
> > > the drivers of some devices which support generic indirect register access,
> > > for example PMCI (Platform Management Control Interface) device, HSSI
> > > (High Speed Serial Interface) device in FPGA.

> > What is "generic indirect register access"?  I'm not clear what this is
> > intended to support...

> "indirect register access" is a RTL design pattern we use in FPGAs
> frequently.  The design pattern involves a small number of registers plus a
> little handshake code to access various register spaces inside the FPGA
> fabric.  The design pattern is "generic" in the sense that the same small
> number of registers and handshake can be used with many different IP
> components in the FPGA.  Historically, the bit definitions and handshaking
> was slightly different for each IP component.  This is an attempt at a
> consistent usage across IP components.

> Would a different name help?

This wouldn't address the major problem which is...

> > > +	writel(0, ctx->base + INDIRECT_CMD_OFF);
> > > +	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > > +				 (!cmd), INDIRECT_INT_US, INDIRECT_TIMEOUT_US);
> > > +	if (ret)
> > > +		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn", __func__, cmd);

> > ...and this doesn't look particularly generic, it looks like it's for
> > some particular controller/bridge?

...that this appears to be entirely specific to some particular device,
it's got things like hard coded register addresses and timeouts which
mean it can't be reused.

--AJRKzDE6zVy7LGPR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKgfToACgkQJNaLcl1U
h9CakQf/ZN6Q6QkrEb4nyhW8VMwyjRszU8l1d61t3KPA3ykEw9ycCVGWTcRpH11y
/0nIkHr9dw8AB7/KJ78rYiqzzwjOndZb0ITjVY9Z9B4VC21RrcTttPeohl2MCoNM
vFqQBh4dtbI4a9bOr3Wffz1bF+o/eB2CdkxMgelWlGPA3EXz8gZkPvLNM/FRcKM/
4FLlszKfjHctNKepyEaxI05+Sgj3IxKEhhDXlWBG7jXz5J0lhHn/k+kuD/7PZR10
C3g/NHTJgHUH9RaBddZxRdzgVSH40ROucf77eHGMBVRpEB4+yEQclwB7bxorktLw
Ql1heufgVlrMAkvp0UtSRm1X4Id98g==
=zJWH
-----END PGP SIGNATURE-----

--AJRKzDE6zVy7LGPR--
