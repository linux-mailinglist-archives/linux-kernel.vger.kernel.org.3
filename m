Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5335166CE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353088AbiEARz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiEARz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D703465B;
        Sun,  1 May 2022 10:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7433D60FA1;
        Sun,  1 May 2022 17:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B847C385AA;
        Sun,  1 May 2022 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651427519;
        bh=A+KWCBjbPxzqgaB4YkY3/72H1oSKZcmYsDZciBLSzKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C1fI2IjZFKqbaxS+9Ng29j5164LESe2VsiXsMJtpgpmqsGHvbL/TwqU7hUyj7boNs
         KqP+JpTcRWaAeeYfv5bwrQj0m4VXr00HUUJKS5Ovsn1XvuvzxPTUlpZybjRdq0lglh
         wQyFcTtUrJPBTAgKF2NG1QZC6dKhCxpsxSbre27F/J6+E/5P+727CW8whXgSAqivUx
         mb2LvW6ZArpK+6YsYHVxE+hkJzdbOpuf023ZkDKzJ7BTdz25gQdT7glvITGB0UlWjx
         GR9h5lrV5OHtknDsUDcG83NRRQPjXPw48rd6Uyk+BXmaTkHnNmI45OIwUC3G6o7rO4
         5cIpvxS6oYHiA==
Date:   Sun, 1 May 2022 19:00:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: stmpe-adc: use of_device_id for OF matching
Message-ID: <20220501190015.48d6acd3@jic23-huawei>
In-Reply-To: <20220501103447.111392-1-krzysztof.kozlowski@linaro.org>
References: <20220501103447.111392-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 May 2022 12:34:46 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The of_device_id was added to allow module autoloading, but it should be
> also used to allow driver matching via Devicetree.
>=20
> This also fixes W=3D1 warning:
>   drivers/iio/adc/stmpe-adc.c:357:34: error: =E2=80=98stmpe_adc_ids=E2=80=
=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Series applied to the togreg branch of iio.git and pushed out as testing fo=
r 0-day
to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stmpe-adc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index d2d405388499..0208789fc0f5 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -345,21 +345,22 @@ static int __maybe_unused stmpe_adc_resume(struct d=
evice *dev)
> =20
>  static SIMPLE_DEV_PM_OPS(stmpe_adc_pm_ops, NULL, stmpe_adc_resume);
> =20
> +static const struct of_device_id stmpe_adc_ids[] =3D {
> +	{ .compatible =3D "st,stmpe-adc", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, stmpe_adc_ids);
> +
>  static struct platform_driver stmpe_adc_driver =3D {
>  	.probe		=3D stmpe_adc_probe,
>  	.driver		=3D {
>  		.name	=3D "stmpe-adc",
>  		.pm	=3D &stmpe_adc_pm_ops,
> +		.of_match_table =3D stmpe_adc_ids,
>  	},
>  };
>  module_platform_driver(stmpe_adc_driver);
> =20
> -static const struct of_device_id stmpe_adc_ids[] =3D {
> -	{ .compatible =3D "st,stmpe-adc", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, stmpe_adc_ids);
> -
>  MODULE_AUTHOR("Stefan Agner <stefan.agner@toradex.com>");
>  MODULE_DESCRIPTION("STMPEXXX ADC driver");
>  MODULE_LICENSE("GPL v2");

