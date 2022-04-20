Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F36508977
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378590AbiDTNoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349445AbiDTNoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:44:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1689F3ED11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADA4B60AED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FCDC385A0;
        Wed, 20 Apr 2022 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650462086;
        bh=Dcd35gd/yME79u472SK0FGJY8V4bi6shwSPiC4TSVYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwtH860n3dkz9FoDyODSJfzkzBga/TavlHq0Yc0lsFLU4ZFhaFKDYLXAjtHQgqOSx
         QEuilni54niqFzOLIKU5LNS6bYINOEbarvCFkc83qDvM5fF336IlhAgKX1CyqqDRFc
         3GVMkl36yLXCJkzCgxMDqOc8kV2gCFcgcYe7JlfxAA/JVFkZeOLa7iIrXP4OwB2DWp
         qHyK8iD5owEszls2fy0KkZOLO0+hgekPZQdqma3pG5bDQaS8Tsv49inLOlHeDSyekC
         gVJi42BalPuXA3t3AIpMPn4qdYZsy8Dq7Bo/QZYVXnJN+JtVZyJfp5gJx/9kEpFAW6
         euiYppCrp31BQ==
Date:   Wed, 20 Apr 2022 14:41:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl: Fix error handling in pcm030_fabric_probe
Message-ID: <YmANgcO9BMxp8PLC@sirena.org.uk>
References: <Yh90u+E3RTuGEDWU@sirena.org.uk>
 <20220420021855.8224-1-linmq006@gmail.com>
 <YmAD6MIuKdjgm7Yu@sirena.org.uk>
 <4e3309d9-879f-3385-3e8e-0fa1a31ddd9a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rm+GGDPp5GTQyZKB"
Content-Disposition: inline
In-Reply-To: <4e3309d9-879f-3385-3e8e-0fa1a31ddd9a@gmail.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rm+GGDPp5GTQyZKB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2022 at 09:35:55PM +0800, Miaoqian Lin wrote:
> On 2022/4/20 21:00, Mark Brown wrote:

> >> - rebase on top of commit 559089e0a93d ("vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP")

> > Why rebase on top of that seemingly random commit?  Is there some sort
> > of dependency here?

> Hi, it the head of master in when I made this patch. It's because you pointed out

> that patch v1 doesn't apply against current code. But I am not sure what's the problem.

> So I ensure the codebase is up-to-date. If this patch have no conflict, you can ignore it.

Current code here is my git tree (-next is often a fair approximation) -
if people have been making changes since the merge window then often
code written against mainline won't apply and things need to be based on
people's current work.  You're looking for

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

--rm+GGDPp5GTQyZKB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJgDYAACgkQJNaLcl1U
h9Aevwf/ULNqXVQDbV8fuV6Qilw1nnp30Uhxr1swwNI5GZq806ylondesmsA/Bao
KcooPJ6fC01+V2mjTBdS2ixwZnNHBddgTRixaYW52BnFiul+dFi21NiD7K8Japhh
lkk+HGCAOhyBUOrOcSuHIKmof5UuBuzQh5ObwPWW5e7O+2jcy8p/CD5SdSWvrKrL
J9t4dWoBeBFXUnXzIieAbJ2A24P+RSteGoGsOhfbgkBGTxNihe63TSUY5rZYw7LX
0QswaM07k9hUACCJTHamwQTgjRIfMiYLQmgM70iCm4h+DsTcYcthrW5/cgcicvgC
hzJ0B1d6KbYrpQlk23vciyh9mHBQ0g==
=eH5c
-----END PGP SIGNATURE-----

--rm+GGDPp5GTQyZKB--
