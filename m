Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838D04AA040
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiBDTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiBDTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:41:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F2AC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:41:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61F8DCE22CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 19:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5274BC004E1;
        Fri,  4 Feb 2022 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644003665;
        bh=ckw2IXHCEaaDlGbJk3ekdL1tmOejjiEq11h34072JLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtIMQR3VihMcmi72JgNfzeKqWB74e72isUWpNNnCNS/0sj/lqTJi88aYoyAV+9TwO
         M1I4HYhYwQjImEfwDSYi6xQdecQEg2L3IjDm51YM2A80fOGMvGUwfBuNbIpwFCNsTI
         lKdYfeOav8SsCiOjexVf5QZRn7G6tlg5hxZS0J7Y5LTQddL7a+UTGfKD6Uh+XR+06k
         E8KEKIP8ni3C7bQeOeFO3L2nPtKpu+ywtNEhCe1f60tiKT+x/4n68i7fPQNjp0BKfr
         01xj1UlQTQMgyAFo3snSt6TfIaKlR3eNGyS8Mw3EMwapHLHxBhQOILgL2mV7s77J3H
         MeK2gGxLssKVw==
Date:   Fri, 4 Feb 2022 19:41:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: regmap: mmio: lack of runtime_pm support for debugfs
Message-ID: <Yf2BTelNlqplv06/@sirena.org.uk>
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
 <20200423104000.GD4808@sirena.org.uk>
 <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200423112244.GH4808@sirena.org.uk>
 <DB6PR0402MB2760FBCA05C1BADB27F0356488D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200424103004.GB5850@sirena.org.uk>
 <Ye87P19+JOjPEGTY@google.com>
 <Yf14RJbM10O3RdA+@sirena.org.uk>
 <CA+ASDXP+KeiRKASFakDjJ=cZPD_rGmV4=JgRH26zQi-uZDdiAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+iMZOw02us7dat7E"
Content-Disposition: inline
In-Reply-To: <CA+ASDXP+KeiRKASFakDjJ=cZPD_rGmV4=JgRH26zQi-uZDdiAQ@mail.gmail.com>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+iMZOw02us7dat7E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 04, 2022 at 11:21:51AM -0800, Brian Norris wrote:
> On Fri, Feb 4, 2022 at 11:02 AM Mark Brown <broonie@kernel.org> wrote:

> > Are you sure you wouldn't be better off with a cache here, or marking
> > the registers as precious so they don't get read (perhaps conditionally
> > to allow reading while the device is live)?

> We do actually have a cache for the case I care about, but there's
> also a debugfs file for bypassing that and...for some reason I'm
> dealing with some diagnostic scripts that purposely toggle that. I'm
> not sure how wise that is, but in general I like to reduce the number
> of ways dumb user space can screw things up. I've even had to tell
> people that recursively grepping through sysfs or debugfs is a bad
> idea...

Are you sure this extra thing that bypasses the cache isn't an out of
tree patch?  It really doesn't sound like a good idea to have that, and
if people think they need it they probably have drivers doing something
quite unfortunate.  Or are you just looking at the upstream debugfs with
some volatile registers?

--+iMZOw02us7dat7E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH9gUwACgkQJNaLcl1U
h9B6QQf/V8FpQD0c3GxBAmnKaiJB8IF+/cyPMz72rvNFzk4ZoFdsu2ByVfL+Zrj9
EZEOpisWGmEfzH/L8+pnBKYJu7JqoZWmTItTl2uTX1MBexqrXUko7XnKhYn0GeC1
ADBkssPDFNVGJIKZ8fB00Zx4vWkTUBtvgIxHGWfTPRlZyCsCv2Uq+4zefavk3WoJ
swRa63Syj1MG0kAEU865WcMoCddNmmrEz4eQYv9zwRkOIY+JPB3bUzYrHcNV+USV
jhRYn2Jdz4i+NHCASAGOB0PBvNrFlvDbA6r3mQPhG5r4gMpF6ki5PiQj6YyZ+mbj
bm3bSj5cEpQra7AA79Kz8+XzE3NxUg==
=cp59
-----END PGP SIGNATURE-----

--+iMZOw02us7dat7E--
