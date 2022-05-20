Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF66252EE65
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350421AbiETOpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244390AbiETOpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B918170F28;
        Fri, 20 May 2022 07:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DDF8618DC;
        Fri, 20 May 2022 14:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8C1C385A9;
        Fri, 20 May 2022 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653057934;
        bh=eyy20eLaoZHHhlcdY5b3GARHaDk/Ynm0A8xek9N7alE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmtDN6rzpqT+fYQz7hSlNwVBz6PdgaCRI/+fJz0yhqebalgYoTqztGhfml4F5z/XW
         gs67hODZJYg7mmnma+XHmFxHpsoU24dDBPX6Ryslvk4ir075rW0zF3LS7fKUzlg8Tt
         8XbL1UbUZTCMK/JkbAWRdsAXAhq/iC5E9b01q4tAhBjTSNBcsKg0XfeK7HXhwBOsoi
         QUI1RzLfxraasVYNWRBQxspfvrbtit1S8xkfcQ4XDe77dNw2qIPogeoEUOJfRoCYRP
         Tu/TCg7LwF7BjrwIgHVkXJAJvYsmjICk3xMhO2CtF7Mqtbj75oFSVNcXC0n0Cbfttd
         LYWcH0eTSLc/w==
Date:   Fri, 20 May 2022 15:45:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] regulator: Add driver for MT6331 PMIC regulators
Message-ID: <YoepiTUfdhkYByo7@sirena.org.uk>
References: <20220520133305.265310-1-angelogioacchino.delregno@collabora.com>
 <20220520133305.265310-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7DW/tPgeQFzSu9V"
Content-Disposition: inline
In-Reply-To: <20220520133305.265310-3-angelogioacchino.delregno@collabora.com>
X-Cookie: Happy feast of the pig!
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p7DW/tPgeQFzSu9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 20, 2022 at 03:33:03PM +0200, AngeloGioacchino Del Regno wrote:

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +static const unsigned int ldo_volt_table10[] = {
> +	1200000, 1300000, 1500000, 1800000,
> +	1200000, 1300000, 1500000, 1800000,
> +	1200000, 1300000, 1500000, 1800000,
> +	1200000, 1300000, 1500000, 1800000,
> +};

So the top bits of the voltate selection field just get ignored?  Might
be easier to just write the code to not include the top bits.

> +static int mt6331_get_status(struct regulator_dev *rdev)
> +{
> +	struct mt6331_regulator_info *info = rdev_get_drvdata(rdev);
> +	u32 reg, en_mask, regval;
> +	int ret;
> +
> +	if (info->qi > 0) {
> +		reg = info->desc.enable_reg;
> +		en_mask = info->qi;

If the regulator doesn't have status readback it shouldn't provide a
get_status() operation.

> +static int mt6331_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
> +{
> +	int ret, val = 0;
> +	struct mt6331_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	if (!info->modeset_mask) {
> +		dev_err(&rdev->dev, "regulator %s doesn't support set_mode\n",
> +			info->desc.name);
> +		return -EINVAL;
> +	}

Just don't provide the operation for these regulators then.  That'll
mean a separate ops struct but that's fine.

--p7DW/tPgeQFzSu9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKHqYgACgkQJNaLcl1U
h9CxpAf8Dcb0LgYJswtynhjrPmCXq5dYmagsB3EUxbEJcZXLX4uvOC2xRrQ8qv1F
COwjJwhrHEDaeQGrX0LjxykTeI3RGn4fZGaIOgXtPrqAxETrp25ihtDuIU90LKAr
cWrj82iP0HLYuKvPlkUh1uWlSMZ6vGh2WsJHhpNUIvZHd6swxslp3AXbS5L3hiTz
K8Vq+Vw0TI800vnGy2PysQVb9bM5C7XUtnDOdyrYUl8PEDuJdnuLwiKNF+wZ1WpB
R9ieqffSRUpsFsbJlWueKBcB/8UcHLJ+joI5/SYiL28Xz2fyM6ICUf6tHTARD++r
JM7ueL0Tht/hfeIyuPT987jU5lqPJg==
=7pHa
-----END PGP SIGNATURE-----

--p7DW/tPgeQFzSu9V--
