Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C414B6C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbiBOMg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:36:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiBOMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:36:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1645C10D6;
        Tue, 15 Feb 2022 04:36:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64FED61690;
        Tue, 15 Feb 2022 12:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600B6C340EB;
        Tue, 15 Feb 2022 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644928605;
        bh=+Fx82csho4bi9Bhwr3sF7WXHtnIqEKHbXNQg/Lt7SSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCnN4ckpP3IPeqyTF2eF29V2sLdIB+sp/B/AmCTbv6MUdKamnqAk5jOZ7cVkugTgE
         NzP3kPRCYTzfMT8rGT3+lvLvq4Lz8S/d0n1px65f3j8jOr4HS0fNMipfiihYM8JFcM
         hkzFPignEDEPsDG5XucPKiFqfJ4LRuyml8DgpiURGX4PsxEBGzwGcanXCpJv6azgVn
         Y6MdZSU23/+58Hc9QVfQIFmTZ4IxetLAKEGHRRB36/vU477zp89OfkKXqi2IT6pher
         0rCOvLFA0LcIfPLpmAo0aWw7R1WtQBtZCdK8Y05rvPu/6C7CMwhtbsJOubaROnd+FJ
         E1gSgNGyPhzOg==
Date:   Tue, 15 Feb 2022 12:36:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] spi: rockchip: Preset cs-high and clk polarity in
 setup progress
Message-ID: <YgueWHKur2w55s+0@sirena.org.uk>
References: <20220211034344.4130-1-jon.lin@rock-chips.com>
 <20220211034344.4130-2-jon.lin@rock-chips.com>
 <YgZHalrdhhilxROt@sirena.org.uk>
 <4222ce7d-a1e3-1728-fec2-976946b06ba9@rock-chips.com>
 <YgpP9j80OuhkCN8p@sirena.org.uk>
 <e0f0ca0d-40df-cf86-9471-9272bcc171f9@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+aDZkCYiUMiCzT/F"
Content-Disposition: inline
In-Reply-To: <e0f0ca0d-40df-cf86-9471-9272bcc171f9@rock-chips.com>
X-Cookie: I have accepted Provolone into my life!
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+aDZkCYiUMiCzT/F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 11:00:54AM +0800, Jon Lin wrote:
> =E5=9C=A8 2022/2/14 20:49, Mark Brown =E5=86=99=E9=81=93:

> > As covered in the documentation setup() for one device may run while
> > another is active, therefore if multiple devices are configured in the
> > same register you should use a lock to ensure there can't be multiple
> > writes.  Note that the above appears to not just be setting the mode but
> > also the chip select so if you've got two SPI_CS_HIGH devices then
> > they'll both be going in and separately setting cr0.

> Is the io_mutex in function spi_setup is good enough?

It's not supposed to be for that but looking at the code quickly I
*think* setup() is never called with io_mutex held so it might well be
fine - you should double check though.  If not you'd need to add another
lock in your driver data.

--+aDZkCYiUMiCzT/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmILnlgACgkQJNaLcl1U
h9B2NAf/QN5joxtVPoutx+2TSlooN/Z0rZTKsAu3UvL8NbXQpUZK/TYIaBtXXMWp
CaQgwdWxzZCAtUVulGlp1i8i/CKSyGevk9eYqtCiN3iKS96RmvScrd9Hrh746PZx
RNbS+c6qFodIXVjq0RJPAAXIhH33HrFplqa0qipfbI4YEvKPZLAdJKi8hLEv51tP
UpD0GpZ2StBDrwmHdRjGS7EtKJ9gbqqJBdokKnv1OXZobdBEWnkKq7btqxDyMkTo
w9wNNM+xhOqWIZF+Jwm0lLVkju19tjqbZ5782yI+YSNhBMtp91PeN1efmLQs9+Lp
PCwRQQDLfe8UttKpOX1qpaRZrMGprw==
=DFZt
-----END PGP SIGNATURE-----

--+aDZkCYiUMiCzT/F--
