Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C026542F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiFHLYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbiFHLYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:24:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23D412C97E;
        Wed,  8 Jun 2022 04:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A0C0B8271E;
        Wed,  8 Jun 2022 11:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EFAC34116;
        Wed,  8 Jun 2022 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654687490;
        bh=gxuRxmn8LltL6EShbwujtTGcPs590C9dPrlLHgw8yFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0+PV/9eBcimatHw1QFoUGvheIowOl9qq2FFyDOD3cBHqgEbBeyHUC+D8j0XdXd2m
         A4Oh7V1PRqZmIqrvBAK8ejapVyycZ/IKBraDQYigEjf6T/CqPLsNezjNag0ZfqtTty
         aIjaUe6Uj9XoGrW5cL3sQQ29XZL8QxiNYNyBZ+LYg7KdZKdnYHLZCtM0J2OyYGwm7w
         w7Tw2ky3wrcHAwtFIzPFBc0eTDadiv1XVUTxNAD9L+EkZRnvFv8+8wYwRaGrDTlIC+
         GrMAk0Ju6QNB2YQaNUnm8z0+OWcmZvkbNZAObcbgx7Ui2cCkJ9VmwAqK442Yuxkblg
         27fSaQaECCi5Q==
Date:   Wed, 8 Jun 2022 12:24:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 2/8] ASoC: mediatek: mt8186: add platform driver
Message-ID: <YqCG+9YkuXsDeh/I@sirena.org.uk>
References: <20220607142046.28060-1-jiaxin.yu@mediatek.com>
 <20220607142046.28060-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ETWoB/2pglKUOdqk"
Content-Disposition: inline
In-Reply-To: <20220607142046.28060-3-jiaxin.yu@mediatek.com>
X-Cookie: Never give an inch!
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ETWoB/2pglKUOdqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 07, 2022 at 10:20:40PM +0800, Jiaxin Yu wrote:

> +obj-$(CONFIG_SND_SOC_MT8186) += snd-soc-mt8186-afe.o
> +obj-$(CONFIG_SND_SOC_MT8186_MT6366_DA7219_MAX98357) += mt8186-mt6366-da7219-max98357.o
> +obj-$(CONFIG_SND_SOC_MT8186_MT6366_RT1019_RT5682S) += mt8186-mt6366-rt1019-rt5682s.o

This breaks bisection - these drivers are being added to the build here
but the relevant source files aren't added until later on in the series
so the commits in between won't build when the relevant Kconfig options
are selected.  The Makefile and Kconfig updates should be moved into the
driver patches.

--ETWoB/2pglKUOdqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKghvsACgkQJNaLcl1U
h9B4mwf9HGDlHmNk1TjFP832KkIO385bqzgKxTOtgibu1i5TUutnTN3f36lv+FUc
IIi+QaUpFHyArXuTY9vK8ucB4JU4Lv2uPXSngImJwTCIFhcOxgnKymFYhrTXoyPN
Vjd45Su/+rD0FtSZfyoltQ55n/InkmXhSSM+YnPdAef1fyyRneTXE/XQUf9jGacR
hIxq2HvnVFk/ts/N6U29ebBTDjISvCax0YUBBhbw494r1QTKFMSRIdSZ9ETOQeep
WtxnWuVmFNm8WhWK5Fgl2cSCI+NmJ1XvlwJSUsTTf6ogdifjwYF+PyzlqEaVpddT
0HyYM/5R86UhVW1MY9AqJ1yR4Wg8Wg==
=2c29
-----END PGP SIGNATURE-----

--ETWoB/2pglKUOdqk--
