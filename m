Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94B4B1228
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbiBJP5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:57:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbiBJP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:57:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C68A1;
        Thu, 10 Feb 2022 07:57:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5016B61C77;
        Thu, 10 Feb 2022 15:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F27C004E1;
        Thu, 10 Feb 2022 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644508669;
        bh=5a0H2dZ8NHiNHJT624T80SiJuLxas7HwdA6coL6AIJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5QTW9HAsjdNi2/UJAjlx35fw12/TB6rehsgpGyA/+E6Hn1gKWbB1N+CEWkh1nBnp
         BUVdN2oxaXOSDxP5412EVZVOenYKjNYbdKDjqJpMibv7wLM2E9A38mLdhDTE9wCX47
         HlPbwNrR1DuiCdxIex0X/w27aNXiVBiog8QoMTy/VRgCl55o3+RGlQ+5FM1duFd8vT
         xgOziHICD2DdyUby81ZtD4PxmGDOAy131tQEXNkREdG8c6YhNOUnf4w8olyIjGyF6n
         9A1oumOfvHxJ/0W17r0vniRtCmu3154LSptFLt539HPQFLk2D6Qgc14jqWeqjS82Uq
         KKiyYZsdIvq0w==
Date:   Thu, 10 Feb 2022 15:57:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Zhou, Yun" <Yun.Zhou@windriver.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xue, Ying" <Ying.Xue@windriver.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] spi: disable
 chipselect after complete transfer
Message-ID: <YgU1+cIlANAkJCAL@sirena.org.uk>
References: <SN6PR11MB3008AF5619B0B026836FD7429F2F9@SN6PR11MB3008.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiQuSH9yRC2LqOqw"
Content-Disposition: inline
In-Reply-To: <SN6PR11MB3008AF5619B0B026836FD7429F2F9@SN6PR11MB3008.namprd11.prod.outlook.com>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiQuSH9yRC2LqOqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 10, 2022 at 03:41:41PM +0000, Zhou, Yun wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> I am sorry that I can not agree with you.

> If there are multiple messages, and each message only has one xfer,
> and the cs_change of each xfer is 1, during the transmission of the
> messages, the CS will keep active even until at the end. This must be
> unreasonable.

This is not something that most drivers are expected to use, cs_change
should only be being used at all for very unusual hardware and it should
be used even less frequently for the last transfer in a message.  It is
fragile and anyone using it really needs to know what they're doing but
the feature is there.

> I can't understand why it have to keep CS active after the
> transmission is completed. Could you please explain this in detail?

The feature predates me working on the SPI stack, the obvious examples
would be a device that doesn't actually use chip select where you want
to avoid all chip select changes or if you need to do some other actions
in the middle of a SPI transaction for some reason (which would need a
bunch of system level considerations to actually be safe/sensible like
making sure you're not sharing the SPI bus).

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--YiQuSH9yRC2LqOqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIFNfgACgkQJNaLcl1U
h9AQQAf/ZYZzgXlybdG4bmNaHaYY6Cr0wodK4VZNJVP7SilnxhpMEOGIrIed8Wct
D3O1mkLf6+qEMFfNQEab0cn9K/etC2aZIzJ0r32uHIkAyXdBTqlgc8nMdv4mlxiy
kUaJlaqbndbwyTO0qDtJ36ivojXQMMhotL74z4yd+AGTZvR45qYI0+8ulgRAj2tq
VMdCPGXVvXN84zDdGoPSwzdex5aFgw/HNkrFLRyQICTOZ9+pjRfR0S/vQbWYqLk2
GM32zJ7q0DLYDV2U5+JqPnDvEEPtzjnUW+2MtIwRvfrOqtqYZQp5WBRrE7ouHZsi
A4JOaFntUJChwkfupM1fU8NV3QFasw==
=4awE
-----END PGP SIGNATURE-----

--YiQuSH9yRC2LqOqw--
