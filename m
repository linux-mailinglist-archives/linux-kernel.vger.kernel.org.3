Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B953553FEA2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbiFGMV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbiFGMVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:21:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B28F7488
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AE1AB81F85
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D0BC34115;
        Tue,  7 Jun 2022 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654604455;
        bh=w2aQJy8XTcqWcZ5VipuId8VpFh1nL10EEwBkOwvPTtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gI6YDL0YkG7mKXGMOKq+mUybDcF6mtaMPz2d/YmYXxLK7gjJcQ+XVgKLFrlQdEhII
         XNZAn5ZLGk6qOfBUrWW4u+bTVXm9tlCZd95p2CW9TXAh2xIxt1OppGcEoJugBmg3uW
         MUI75PkbvmCjbqliTGFW5adTAuxW3uhug5XqwrzEmvhx7fwKUCFRXUc73dexjn/0MN
         5/aJI5Xjv9a6/nlVzAJXC2TyrDKfu7ks2ajEcy0aPAckWvqdmH2Phh08Dt2cRFHRvA
         EZooL/vzyEVRobNF/JGwj3u9ieuOuV5vw3iRqzJ21DQzT2dEbm38MAwkONlDdCL2Z7
         cxwfCcgT4R3/Q==
Date:   Tue, 7 Jun 2022 13:20:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/3] ASoC: wm8940: Rewrite code to set proper clocks
Message-ID: <Yp9CoibeiXff43//@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
 <20220606154441.20848-2-lukma@denx.de>
 <Yp4o2bQammYjv7Kt@sirena.org.uk>
 <20220607141309.11ec7503@ktm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oD4aHu7NoJLDSZnJ"
Content-Disposition: inline
In-Reply-To: <20220607141309.11ec7503@ktm>
X-Cookie: Where's SANDY DUNCAN?
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oD4aHu7NoJLDSZnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 07, 2022 at 02:13:09PM +0200, Lukasz Majewski wrote:
> > On Mon, Jun 06, 2022 at 05:44:40PM +0200, Lukasz Majewski wrote:

> > I don't entirely follow the above - in what way might the core adjust
> > the clocking, and why would we want to allow the use of invalid
> > clocks? Surely that just makes error checking worse.

> Hmm, it is a bit complicated.

> When I enabed wm8940 support in mainline - the first call to
> wm8940_set_dai_sysclk (the set_sysclk callback) required mclk = 11997070
> frequency.

> With the current code [1] the initialization of the codec returns
> -EINVAL and the codec is not supported in the system:

> asoc-simple-card: probe of sound failed with error -22

Well, that looks like a bug in either simple-card or it's configuration
which should be fixed then (you should probably use audio-graph-card for
new things BTW).  If a machine driver just randomly sets a clock rate
that the system can't support and doesn't want then that's a problem,
presuambly it's getting that rate from somewhere.  Note that this is the
machine driver trying to set a clock rate, not the core.

--oD4aHu7NoJLDSZnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKfQqEACgkQJNaLcl1U
h9CwNQf/SQ1IIya40BCk6cTxfy5APPyLi0PkvOK018oGnfnEu32l/1vb6bVISsbX
PHvisytP3OCYODHV7aPKS3hOGYdzE6FE7dkh2BNITANR7b/2w+e035IeNDSb5pw6
VvBQSiOoKGvwiDcwC6qTf7FV7ok0IUAYiEZWs9288QnzfXy8lwEWFujAkEV/hV6q
nLx9rP0vwtEIAzzqOjtOZyFWDl7XT5+EdlRvxtSQopJzBieIcFuBBJQw9FJdr1Gk
Z9SrxAwfmyKeIhn5tegWV1NewUHZwaEnK7Vpc/j6LXkuhSBD20ngNMio5bTNy123
+mcivhXqL5A9VKdjhg1FpAdOWdBAFg==
=nfuP
-----END PGP SIGNATURE-----

--oD4aHu7NoJLDSZnJ--
