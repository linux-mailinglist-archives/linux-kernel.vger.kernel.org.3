Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711944B8DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiBPQXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:23:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbiBPQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:23:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD2F215C29;
        Wed, 16 Feb 2022 08:23:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7423161B14;
        Wed, 16 Feb 2022 16:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C76C004E1;
        Wed, 16 Feb 2022 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645028596;
        bh=t1UdN8Z5NqtdJPY4399H8c1RO6/wV57dnhQ5F04QgKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJvetdb/g2SSTwAcqcimw8jpt+oqnK0ca3HjrlPbdxGkYQQw1RO+ny2b1jYlb6FWm
         VtPC0B5de/8LFOQcdosILfPSrBAcfAYQ9VpbiR9s72w2byQZDgOf5mPu59pZXr6r8K
         VW637HBQFTC23qksoH5hZ6lmA/69KmNhkdlic2ZIm32giJ0WXVF7iYqbCYSkvx40j2
         FLTVG8dhoiigcy7pEW1Qr7u7yc+EEZV6FgNp2gRHDfUL2Vs0RZYTeB9tRjrTIijc7f
         OSAc78U/hMP7v02559bVLjzRI9XX1HtMOkOXREzZrAovhpEYbK/72kNPZfi5zKauda
         Ly4vtiEp55jSw==
Date:   Wed, 16 Feb 2022 16:23:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xue, Ying" <Ying.Xue@windriver.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] spi: disable
 chipselect after complete transfer
Message-ID: <Yg0k8BH0itmczUDy@sirena.org.uk>
References: <SN6PR11MB3008AF5619B0B026836FD7429F2F9@SN6PR11MB3008.namprd11.prod.outlook.com>
 <YgU1+cIlANAkJCAL@sirena.org.uk>
 <19c69765-8584-2e6b-25b8-7053a5afa5d4@windriver.com>
 <YgVH310gQ1sK6dlr@sirena.org.uk>
 <a5aa6dcf-e3dd-e8ff-edcb-edad96f8ddfe@windriver.com>
 <YgpOzw2rq+vAIPBU@sirena.org.uk>
 <8fd9c3ef-df64-b8ad-de6e-ef86806d53b5@windriver.com>
 <Ygpo9YT9PrQAAIH3@sirena.org.uk>
 <111c2102-5782-2740-65b0-47b0e5194ce9@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TTJc13uKD0gRs45s"
Content-Disposition: inline
In-Reply-To: <111c2102-5782-2740-65b0-47b0e5194ce9@windriver.com>
X-Cookie: Fremen add life to spice!
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TTJc13uKD0gRs45s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 16, 2022 at 06:41:21PM +0800, Yun Zhou wrote:
> On 2/14/22 10:36 PM, Mark Brown wrote:

> > ever or that it'd be done this way if it were new but that doesn't mean
> > we can just randomly change the interface and potentially disrupt users.
> > Whatever else is going on the current behaviour is intentional.

> Although the logic dealing with cs_change in spi_transfer_one_message() has
> existed a long time and nobody reports issue on it, that doesn't mean it is
> correct. I think the main reason is, cs_change is only used to change

Please read and engage with what what I said above about not disrupting
existing users by just randomly changing this, silently changing how the
parameter operates will break any users that rely on the functionality
which is not going to help anyone and to the extent there is an issue
here it is only those users who would be affected in the first place.

This is not a productive discussion, please stop unless you have
concrete proposals that are considerate of existing users.

--TTJc13uKD0gRs45s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmINJO8ACgkQJNaLcl1U
h9C1KAf+PJ+hjgmc8ax0LFniWvgGVMtRikK9+FQzoAMkwPRfaJdqvFwNZt9VjO8o
xueUEqR/3e4n3P9QzW/kMKHlkX1ZBv0ShQ0uiInAmgo7lhr8a2xL/rMZOGOq2DPi
mEQQU5xLK6Bx8dobTYkFcOuwT3yg88SySh2QOFxc1c7j4pTvqq1Z4v9OC3vYh64v
xyLKszUFAxs7FiM3zDrZLjgoKfO53YvpbfNWmAWMe3Gn4pgjSzrjcl6GfkzX9bg9
NrmdtJoVZyFtj+BHA/tqav93rbPC3dhls1dFlHOUqDdH8LmwC1sHzGvbOnsQx8fU
zvE16QZMJiCKtQUUFrT5jNbo+bSshQ==
=mY3I
-----END PGP SIGNATURE-----

--TTJc13uKD0gRs45s--
