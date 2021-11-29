Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305D3462569
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhK2Wiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhK2WiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:38:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F9CC08EC38
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 11:08:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC064CE13C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 19:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F290BC53FC7;
        Mon, 29 Nov 2021 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638212899;
        bh=lsOyYHMBrlpxe+yOqHBUunxp2HVJbc4SCbYxlMO2eHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b45EzunK8FRmC/e8IW9/UuunZW4l4v6DmdUJ3tqnKAn4QN+RTMeEc416NtcEInCQJ
         VSEkfb+oNx2Pia/CPod2G7cgE8GDcVMKOF13UjQVZ4oKDxHZL7X2pXDF5fg11cAGnG
         j14qOq8GUWQ/t7CqKE4yZfrrNwjIxabvwwkgoLk0zNyQa3Fyx+PpafRChxt91cj4vc
         4ScKGk1lHCM028Zs6qVhJ/JCt0SSHPMCR09UavqAZN93FaK4ft71XJeNVB1NCl+QU3
         /Kj1f24qbLtDmkUCvE7nzyuhtQU1dCCv71Glr3FV6U78fK25B8Hd9dHGcxdnSZxjAv
         KfivHQSCVXUnQ==
Date:   Mon, 29 Nov 2021 19:08:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: atom: Remove redundant check to simplify
 the code
Message-ID: <YaUlHRHu4G0EMHE5@sirena.org.uk>
References: <20211125075028.8500-1-tangbin@cmss.chinamobile.com>
 <3ca07ce3-6d5c-20cc-8992-4700490ea472@linux.intel.com>
 <YaUJ2EfU6kYFfjWn@sirena.org.uk>
 <YaUjfFNA6IScPCY9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k8dI/ervwTv43JI3"
Content-Disposition: inline
In-Reply-To: <YaUjfFNA6IScPCY9@smile.fi.intel.com>
X-Cookie: Thank god!! ... It's HENNY YOUNGMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k8dI/ervwTv43JI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 29, 2021 at 09:01:16PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 29, 2021 at 05:11:52PM +0000, Mark Brown wrote:

> > Zero is (or was, people were working on changing it partly due to
> > confusion and partly due to moving to newer infrastructure which
> > doesn't use it) a valid IRQ on some architectures.  x86 wasn't one of
> > those though, at least AFAIR.

> I guess it's about x86, but the API returns Linux virtual IRQ and 0 shouldn't
> be among them (hardware IRQ != Linux virtual IRQ). Legacy x86 used 1:1 mapping
> for ISA IRQs (lower 16) among which the Timer IRQ is 0. I believe that timer
> code does not use any of those APIs (it most likely and IIRC has it hardcoded).

Right, the virtual IRQs are the newer stuff.  32 bit arm was another
platform that had 0 as a valid IRQ for similar reasons, I don't know if
any of the platforms are still affected though and I'm going to go out
on a limb and say they're not using platform_irq_get_optional().

--k8dI/ervwTv43JI3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGlJR0ACgkQJNaLcl1U
h9B2PQf/WYlsV4CNaOQAoyzsD41CNi8U8xmJLZ8eWTAX5tT8wDWiaeekfJbSNMX+
Ebrezn/oQWkJWO72I8cU1ukfBoe5dZh7/UhWzWZwB4zqVdzAqEjjbluAeT3kQw1t
EoNAmG0r+yqlglNOsW6I//4X2XV5hwrxxcFNOTt1LEefeHia1sdPUtXcx5qr8j/w
PKO0jJ385qQb5MzZTemGWFPw/VXSOeA/7fPIetF6MH/nyqodaAg2XJDg/maN9drb
NNms/8YRZzWQsREsDCMLI+kBy3gMwWfMot6aAbEuf37hK1rPWTsMfkxf7OVXoreg
HRMZ/9WKuV4NM/Owm3Lbl3CDj+FqrA==
=1J2J
-----END PGP SIGNATURE-----

--k8dI/ervwTv43JI3--
