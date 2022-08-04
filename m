Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E53589C71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiHDNRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiHDNRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:17:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6BD1DA4A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72104B82529
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214E2C433C1;
        Thu,  4 Aug 2022 13:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659619048;
        bh=pGAubC3p5cu8E3aqPdqw/fxyUjG67zf8Tpf1JKEF55w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6stWst9e41BreGAtGPuz0nAu0TXJwPKwlYdFFr82zphG4M14QXdbrLumphztxMuJ
         YDRDikw+/QifdRAghI887qlMaly1LeHw8FJsuERxDrwM3ejq344jv/6P8SI4qYYdJ6
         5Of9c4WpCS92Rl1VVFiCsroAA0eleXumCjmYnyo8IFRFv4y/qUerR/K5kbtnJ5LAIg
         UDbeeAdrYpjf3kwUPHCL5Z0qhffTosxBEGEg81cPe0P6vOxWBysZgF7P1CoL7ba0tt
         Us8sPo+r1mwRof5YQzLUBmLtUbQcZ4hxS5HMbkd31WBWTjRPaXzWomF7kb8cwcDSmD
         P4nOg8r8+XqwQ==
Date:   Thu, 4 Aug 2022 14:17:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chunxu Li <chunxu.li@mediatek.com>
Cc:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com,
        angelogioacchino.delregno@collabora.com, daniel.baluta@nxp.com,
        matthias.bgg@gmail.com, yc.hung@mediatek.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com
Subject: Re: [PATCH 1/2] ASoC: SOF: Introduce optional callback
 of_machine_select
Message-ID: <YuvG4drwG/rYoozp@sirena.org.uk>
References: <20220804091359.31449-1-chunxu.li@mediatek.com>
 <20220804091359.31449-2-chunxu.li@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3rmzYVoKrLLLmuXO"
Content-Disposition: inline
In-Reply-To: <20220804091359.31449-2-chunxu.li@mediatek.com>
X-Cookie: Did I say 2?  I lied.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3rmzYVoKrLLLmuXO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2022 at 05:13:58PM +0800, Chunxu Li wrote:

> @@ -284,6 +284,7 @@ struct snd_sof_dsp_ops {
>  	void (*machine_unregister)(struct snd_sof_dev *sdev,
>  				   void *pdata); /* optional */
>  	struct snd_soc_acpi_mach * (*machine_select)(struct snd_sof_dev *sdev); /*
>  optional */
> +	struct snd_sof_of_mach * (*of_machine_select)(struct snd_sof_dev *sdev);

I don't understand why we pass this in as a function when as far as I
can see it should always be the standard operation provided by the core
- why not just always call the function?  We can tell at runtime if the
system is using DT so there's no issue there and there shouldn't be any
concerns with ACPI or other firmware interfaces.

--3rmzYVoKrLLLmuXO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLrxuEACgkQJNaLcl1U
h9C1FQf/QjsEtLV9fR8Iz6XmIP9rAebV+D6AS3pDxlY44Q3n5kTg2SprGpkW0N3X
PZVh1GJ4B4MWkO2ODQKF2X322Hr78Np7AzYSQQv0QrcRbRj7/IJHnn4zCs26DlaB
IOk/MGuxUw0kHzBERUoreV9XF2MjBJXTBURBc198Uw1xcb/WarVtk6OPRfmn8blp
5DQZ640pif50r6aQaRaOq9/c7RnUy+hAjsT78GNnIsbEinE1w5JOb2Xf9BTQAXZ5
slxV69bTH2+yDkqU/G92cqXI8RhuD6Sz6KP6gKnAF8n1DNUVTk+pAZeHrRIJ2cQT
pw8nMfmjoexKvLFc+FTsGrdNuJ2zTA==
=PLcm
-----END PGP SIGNATURE-----

--3rmzYVoKrLLLmuXO--
