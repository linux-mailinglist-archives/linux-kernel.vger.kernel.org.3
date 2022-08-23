Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F8359E54A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243093AbiHWOq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242814AbiHWOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA062DF767;
        Tue, 23 Aug 2022 05:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46191615B4;
        Tue, 23 Aug 2022 12:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEB8C433D6;
        Tue, 23 Aug 2022 12:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661256377;
        bh=nAP0qzks6gVn5Zi51T/jnpO8q7K05qtrEhchRMrXEho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehLhM25C776yGvnlRfUpApU4JH17JXj9hEg2MlapBomf+ExB5N5JjWBvwLWnSCxiT
         6hgQXrG95GCMnX/75gqAvsOomwqiTcdTXYAja8xp4oLilfBarjK0tK+gCIRWinmYVl
         Ti8QAAL4e83+Od+/lQncwrrCFC+FMxBxIWdoTPkwZv5joJn2XC9NpMAq0QwI9rJLgP
         w5c/XBuTysv+HtY/Zwt56WNQ3jmnq0cuVUNlQkVVCBkELPmhLOTdi5h9etuyGYYkmE
         m3Fc9ouH1L1cKOKoX3krK2nSp2ViGw+CDMtnko4+QTPLw/u44zGH+WeMwvlqRIYmLS
         TrfQ70iovX3EA==
Date:   Tue, 23 Aug 2022 13:06:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Add deferred controller registration support
Message-ID: <YwTCtOp30H2JIkkV@sirena.org.uk>
References: <20220822181853.23063-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Poi0BA6RrE2EcrsC"
Content-Disposition: inline
In-Reply-To: <20220822181853.23063-1-Sergey.Semin@baikalelectronics.ru>
X-Cookie: The revolution will not be televised.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Poi0BA6RrE2EcrsC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2022 at 09:18:53PM +0300, Serge Semin wrote:
> It's pretty possible to have the spi_register_controller() method
> returning -EPROBE_DEFER status in case, for instance, if the GPIOs used
> for the CS implementation aren't ready to be requested due to the
> corresponding platform devices still pending to be probed. Let's make sure
> the DW SSI driver won't print error message in that case by calling the
> dev_err_probe() function if the SPI-registration procedure exited with
> a non-zero status.

This isn't adding any new support, it's making the logging less verbose
- deferred probe worked perfectly fine without this patch.

--Poi0BA6RrE2EcrsC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMEwrMACgkQJNaLcl1U
h9Bl1gf+Msioy2Df8da5Fhj/2K2KV4WM2KH1K9TJoZfs8rWO0URZ8y1GV3PTDgbm
ycx3fcmvP0uyzv3PoCrwrHftTyZ3lPRHpKTrzvbZhYj+FAVwZnBWI7/jrhjnRjtg
GU116AwtYRglf+Wd4A/Bc2sepIA35oYOYxw4sC2BIr96ACS32YtTKimEamQIXCps
FmFfl3C2ix9Auiv5aDGYf9byD8Xt7iYgKucCNMf5RDfRTpa0SnqpMbpQeyEoXB6R
U9QW4D54XZWC+pgUq99e8WRGRpk6bnrGPzelrs2yBiCSyJ/MtTh/z6+5oP+UflAx
Qn7PKVfROgnnw4hsmln4hvuSoG+SPw==
=VYuY
-----END PGP SIGNATURE-----

--Poi0BA6RrE2EcrsC--
