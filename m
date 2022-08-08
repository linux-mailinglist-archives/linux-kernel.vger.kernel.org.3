Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7318758C93F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243168AbiHHNSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbiHHNSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:18:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEF25FA9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C7F2B80DDC
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57CEC433D6;
        Mon,  8 Aug 2022 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659964706;
        bh=7ITSBOVxNweF/3UEZBBcK5iG7lD0gHbItZ1uzm6dKz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAE75cZqjRgqMhAJavN7FjlBm0fw/yHDDeWZsoEVMlWkOyA59V1X/+RK11lE0KaZF
         SPCphRlxD15wqCrKm2SrNiYfukRfB1WVQ0QdP5uf+Wbwdhej8KOmBFoMtr8aZokOhE
         IuDXzzFqEN3Qym6K0/s1xigP9hxlZ6YaSMEOmUsDHMW0xhsntFLfBC6QthgVb3jtko
         yVRa0BEZpDwgOIhmjHSGcw01fRjKPFd2A8WMbl4lRS2Tu8yx+FXcYtwxlMkUrOK8Ug
         boK5QJPro+Lnh2qUlDqPR8b5YF/8L71zk7O8J5qcrYwDSwT+UbUtScCBq1PBlQu33W
         HXh7bCobBiYSg==
Date:   Mon, 8 Aug 2022 14:18:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 5/5] regmap: mmio: Introduce IO accessors that can
 talk to IO port
Message-ID: <YvENHSRQuwAzfQJW@sirena.org.uk>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <20220805205321.19452-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i9XU/Qm8+P/E2d47"
Content-Disposition: inline
In-Reply-To: <20220805205321.19452-5-andriy.shevchenko@linux.intel.com>
X-Cookie: Are we running light with overbyte?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i9XU/Qm8+P/E2d47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 05, 2022 at 11:53:21PM +0300, Andy Shevchenko wrote:

> Currently regmap MMIO is inconsistent with IO accessors. I.e.
> the Big Endian counterparts are using ioreadXXbe() / iowriteXXbe()
> which are not clean implementations of readXXbe(). Besides that
> some users may use regmap MMIO for IO ports, and this can be done
> by assigning ioreadXX()/iowriteXX() and their Big Endian counterparts
> to the regmap context.

Have you validated that nothing is relying on whatever the problem is
with using the io versions?

> That said, reimplement current Big Endian MMIO accessors by replacing
> ioread()/iowrite() with respective read()/write() and swab() calls.
> While at it, add IO port support with a corresponding flag added.

This should be a separate patch.

> +			if (config->io_port) {
> +				ctx->reg_read = regmap_mmio_ioread8;
> +				ctx->reg_write = regmap_mmio_iowrite8;
> +			} else if (config->use_relaxed_mmio) {

If these options are mutually exclusive we should validate that they are
not simultaneously set.

--i9XU/Qm8+P/E2d47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxDRwACgkQJNaLcl1U
h9Cbcwf/Trad6vAcRYZP6BRpxuYj5WEIyFGx1k4EjxZRS0vbTYZAnyWY3H7OkYsq
BwmhYJQQrMT3ApfBnRIs+ZK+1XfSXIqCBO9hyBgf+ph8srUT3P2OeNVNTyCTj1vo
royXM6mSaKN/mxl+lVXYH2K2BR05jbWSiwYYMQMp7MflMMZBQlIiLTbW0gbfqDOR
HkYVneNc/ZA4mcRPdgfmNZyu1jLk9vfqHTRATHe4S6vzCvsllTYe62nmII1qWdgz
ztilIFFEaQSmvZUrMH58ZtXk1UR0zO7KJzY3ja3UvyUHds+21wtyZqW87wz0+ZZV
bXAewon/H7CcGW7DlrHmZCCFMUZEFg==
=y+ks
-----END PGP SIGNATURE-----

--i9XU/Qm8+P/E2d47--
