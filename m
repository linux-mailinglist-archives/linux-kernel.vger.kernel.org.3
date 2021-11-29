Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE2C46224C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhK2UlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhK2UjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:39:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D50EC096769
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:12:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 207EDCE13A4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 17:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9111C53FAD;
        Mon, 29 Nov 2021 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638205918;
        bh=M0U/awaNrkOnKQiVPjxmOYF9AvjRVUeoKFrehE9lYmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKsFDIK3lx6QsslUBPK9L9CAnFEapP5fhwBvkVuxd+ape7H6SSLt2AFBNdG7fzUk3
         sPrbX3p34Yt0p9d2iUbF+3t/gDoLG20iGweS781xBE1c+DYn/HhiPnSQVFfHc6F8qD
         vs2YLzfRP+lRgSFH1xTeb1bUpaxWJm0Wk/24LVYmduPCGZQdPdNjCoao2STqnZqryD
         wdEelP9I6Ux2pEBnBVbakbbsEcYfAXaW8wGO1Xrs7/cK+vEK3CZYBmq5jNQcWw1QBi
         JPVeDL5GoOysXMQ2OaNlxeacJnLPJGKiO97p43uvojZb7fwlmS0MHzoGdJU4gNYgNC
         B5MdBR+XmCNBw==
Date:   Mon, 29 Nov 2021 17:11:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, tiwai@suse.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: atom: Remove redundant check to simplify
 the code
Message-ID: <YaUJ2EfU6kYFfjWn@sirena.org.uk>
References: <20211125075028.8500-1-tangbin@cmss.chinamobile.com>
 <3ca07ce3-6d5c-20cc-8992-4700490ea472@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qewNUVDuLa2h8xo0"
Content-Disposition: inline
In-Reply-To: <3ca07ce3-6d5c-20cc-8992-4700490ea472@linux.intel.com>
X-Cookie: Thank god!! ... It's HENNY YOUNGMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qewNUVDuLa2h8xo0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 29, 2021 at 10:22:41AM -0600, Pierre-Louis Bossart wrote:
> On 11/25/21 1:50 AM, Tang Bin wrote:

> > In the function sst_platform_get_resources(), if platform_get_irq()
> > failed, the return should not be zero, as the example in
> > platform.c is
> >   * int irq = platform_get_irq(pdev, 0)
> >   * if (irq < 0)
> >   * return irq;
> > So remove the redundant check to simplify the code.

> Humm, it's a bit of a gray area.

> the comments for platform_get_irq and platform_get_irq_optional say:

> * Return: non-zero IRQ number on success, negative error number on failure.

> but if you look at platform_get_irq_optional, there are two references
> to zero being a possible return value:

Zero is (or was, people were working on changing it partly due to
confusion and partly due to moving to newer infrastructure which
doesn't use it) a valid IRQ on some architectures.  x86 wasn't one of
those though, at least AFAIR.

--qewNUVDuLa2h8xo0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGlCdgACgkQJNaLcl1U
h9DRYgf9FdYZMyHp6MdARstXCBHMC+FeTnYwYisfGNU79pntNgQ2+lIi6rgYFlJc
ggiE8TKUPeI2pfGazvlmq1ptjtcFQqE/RMiZIauhywsEiP7mbx5gddpzuZB56120
zqI6HdUdXg3IXeXGuFUeaN1pJ9VgT39nmHp7hxDg5ZiLRagLB+fPXOPiEhNEhI18
WZUZ1lgCuK2xAVqTryiDIE8urLdqml/2EVFic0Z245M/mNayAsdcSIwuKD55XWOa
aFp3qjc6mai7fV6W2KEF3jhWjKUOsdegXbB4HZ9m3xzmv+AoS4rqlHLYm/cuuDPD
gzogxj+NMACm5ewtJ6wo1dF5SmIzHw==
=pPkY
-----END PGP SIGNATURE-----

--qewNUVDuLa2h8xo0--
