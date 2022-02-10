Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821D24B13F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbiBJROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:14:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbiBJROL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:14:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3495E70;
        Thu, 10 Feb 2022 09:14:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 506B961DB5;
        Thu, 10 Feb 2022 17:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8470C004E1;
        Thu, 10 Feb 2022 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644513251;
        bh=R4YGxkGRJP3UE9sHNERL+KlLwZq1bt4mwcWdie67LiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGI5Is9V3BrzKkuuVltpPwlLK5CAvDWRXEXC/cQkf9hsekWTvaZVyKVpncWf+da+C
         4EmOo7nbt86m6RvoVE3eyKPERQH563Jfe3fmMgpF5BdUG2IrDgZ64clvOKrxKpjMDf
         3+Tr71qjF2BF5kSWrld8T9n7zt7JR+Ocpxs72FbcxrsnbX23N3fQ3lnmODxrF9l9rV
         lkLyvMR/wGWYb7ljYHHBK16ginEmoOdxErpWlDFwEybFQBoSlKbKsJ5bWMzbU2Kn9w
         Rcpsq2UUmdZSkt3G/6pl7WrcPgi4Y+0c6CKMkgMsAl1TDqcmGQ0esa4tEvwJ8pMZc9
         JjbmNoIXy5aEA==
Date:   Thu, 10 Feb 2022 17:14:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xue, Ying" <Ying.Xue@windriver.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] spi: disable
 chipselect after complete transfer
Message-ID: <YgVH310gQ1sK6dlr@sirena.org.uk>
References: <SN6PR11MB3008AF5619B0B026836FD7429F2F9@SN6PR11MB3008.namprd11.prod.outlook.com>
 <YgU1+cIlANAkJCAL@sirena.org.uk>
 <19c69765-8584-2e6b-25b8-7053a5afa5d4@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RkQlFNxHBt14WPKO"
Content-Disposition: inline
In-Reply-To: <19c69765-8584-2e6b-25b8-7053a5afa5d4@windriver.com>
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


--RkQlFNxHBt14WPKO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 11, 2022 at 01:01:20AM +0800, Yun Zhou wrote:

> > > If there are multiple messages, and each message only has one xfer,
> > > and the cs_change of each xfer is 1, during the transmission of the
> > > messages, the CS will keep active even until at the end. This must be
> > > unreasonable.

> > This is not something that most drivers are expected to use, cs_change
> > should only be being used at all for very unusual hardware and it should
> > be used even less frequently for the last transfer in a message.  It is
> > fragile and anyone using it really needs to know what they're doing but
> > the feature is there.

> Maybe it's not normal to set "cs_change" in the last xfer. However, in
> most cases, SPI messages come from user space, and these messages may

I would question your use of "most" here...

> come from multiple different applications. We can't make the whole
> controller fail to work normally due to an inappropriate message of one
> application.

This is one of the many hazards of using spidev, it is not an especially
safe or robust interface.  To the extent that there's an issue here it's
something that should be addressed at the spidev level, though I expect
that there will be some users who want this facility and would want a
way to disable any access controls.  I recommend writing device drivers
in kernel.

> > The feature predates me working on the SPI stack, the obvious examples
> > would be a device that doesn't actually use chip select where you want
> > to avoid all chip select changes or if you need to do some other actions
> > in the middle of a SPI transaction for some reason (which would need a
> > bunch of system level considerations to actually be safe/sensible like
> > making sure you're not sharing the SPI bus).

> At present, if "cs_change" is not set, CS will be changed back to inactive
> after the transmission is completed. If "cs_change" is set, CS will not
> be changed. This obviously violates the definition of "cs_change".

No, it is exactly the specified behaviour of cs_change.  Please see
spi.h.

--RkQlFNxHBt14WPKO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIFR94ACgkQJNaLcl1U
h9BY7wf/WSXE2QTOHx2SZ5StZsWW87+Ik0mAmgSq4zVW9bQdn/yEA89AMmEbD0iC
D5lM6yKqqPgX3DL8ZDPxqfUK2t2krs18sWVBX2LdAEjdIpI6SqzCttia5F/5N5l7
zLpzHmpHct/20u5bHCfD0TGco5N+1lyNvu+Cbqk0oZOPRIfLqV+wo0Zq5TEpe+4Y
Pme+2MEjVo7XuM98M3CDdNv/G46hA3zWL7EvvwajTfAaalwW06a1hdiGowul0Sb2
xVTsqGtYXS3Y77SzxXrpxC42hTBkVBNAEBswyziQPw3i3Xyr25tUJjBRqM1XueSd
14Hwkm7BFHgHnl+AQ2mNXUMQQtDCRg==
=ERST
-----END PGP SIGNATURE-----

--RkQlFNxHBt14WPKO--
