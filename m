Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D95F54C91F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbiFOMuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349298AbiFOMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:50:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737533ED08;
        Wed, 15 Jun 2022 05:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADA73B81CD1;
        Wed, 15 Jun 2022 12:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6ECC34115;
        Wed, 15 Jun 2022 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655297371;
        bh=n/hkxLWRuo5jyYf4FAUgEaA1BVrJd2Czge4XtJelj/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj6YQSNKGJZ6a+adgoRSUFb4mC+naZNA9LBgxV4Y8CW9/nX6yNFtgtFL/pf3nkRN5
         IJr9eyM2Cj4fqRRYl/rtf49sZiaVQCy0+wckzRIhLLnqt3EIDAyn668+1Cv3MW/UGr
         28EchJqn9RIWxCmGt0zEMMk6XqWD8r8lQieBYh7/SImQvBNm5NnnwrD+1tNpnXfeaI
         /o5ztXFa3TchU04uYEYKmHNilQja5DYYdz4KEPux81WCVHfJnBl+mC1ClqzVwhjZY4
         ZM6f5e4w+QLwnLxM+/pUcwmkWuty57b6S6vFbavgoFRts5stS+2HZb3z72i/ipkozm
         BaHVm90paq9ow==
Date:   Wed, 15 Jun 2022 13:49:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     Daire.McNamara@microchip.com, Lewis.Hanly@microchip.com,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH] spi: microchip-core: fix passing zero to PTR_ERR warning
Message-ID: <YqnVVizga14qNxkt@sirena.org.uk>
References: <20220615113021.2493586-1-conor.dooley@microchip.com>
 <YqnFLCbvrTxNbG1+@sirena.org.uk>
 <7eda95bd-c7f5-767a-fe88-9f7109467cd8@microchip.com>
 <YqnSlIcAadwxt1Q5@sirena.org.uk>
 <630d60bc-1322-21a9-e4d1-3eb5af40f8a4@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9H7xqTDlMSNY1TLZ"
Content-Disposition: inline
In-Reply-To: <630d60bc-1322-21a9-e4d1-3eb5af40f8a4@microchip.com>
X-Cookie: byob, v:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9H7xqTDlMSNY1TLZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2022 at 12:42:27PM +0000, Conor.Dooley@microchip.com wrote:
> On 15/06/2022 13:37, Mark Brown wrote:

> >> But if spi->clk is NULL, this will return 0 from the probe
> >> rather than returning an error?
> >> If that's not what you meant, lmk

> > Oh, hang on - what error conditions can clk_get() return 0 in?  The
> > documentation doesn't mention any...

> If !CONFIG_HAVE_CLK, (without which it won't boot on the coreplex)
> but I don't think I can be sure that CONFIG_HAVE_CLK will /always/
> be enabled for other uses of the FPGA.

That's not an error, that's returning NULL as a dummy clock.  The
expectation is that the driver will proceed as though it has a clock.

--9H7xqTDlMSNY1TLZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKp1VUACgkQJNaLcl1U
h9D1lQf/TmAxegjzbw14zJim5lch4dpip3+EARf1XdRuoGvxVWeIfrUb08R9z9ke
k3jbrUT+FRSLKb6KedhVXfPVJJXJOo08oA4w2gxw0au6vNqcGD4rI27yWv81azM5
fB7HKV6r3kDwhQcK6yYkao7NltNw6XJKEBlcnnVifo2rekh+guvyFifPX/lP7OWm
jbMZXJG64MG1rzGuHAwoio0skpGjhXwov5D8yNEMLRjXj/JJd/9CV055P6LYYUsT
I/9006E56Rr8XrBD4uJ6W0QokbfP9bAtmHhfcA9R2h3k33+1ERs3QkcmIlOUw3pR
K1QGBayKlESUSDDKmUVS0sJS7MS6xA==
=euyr
-----END PGP SIGNATURE-----

--9H7xqTDlMSNY1TLZ--
