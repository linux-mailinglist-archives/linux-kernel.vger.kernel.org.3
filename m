Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C359349424A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 22:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbiASVDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 16:03:11 -0500
Received: from 8.mo560.mail-out.ovh.net ([188.165.52.147]:37621 "EHLO
        8.mo560.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245242AbiASVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 16:03:09 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jan 2022 16:03:09 EST
Received: from player791.ha.ovh.net (unknown [10.108.1.146])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id B63D422BFB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:55:55 +0000 (UTC)
Received: from etezian.org (82-181-27-157.bb.dnainternet.fi [82.181.27.157])
        (Authenticated sender: andi@etezian.org)
        by player791.ha.ovh.net (Postfix) with ESMTPSA id D597A266CDB75;
        Wed, 19 Jan 2022 20:55:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006390dcab6-99cd-4766-9f5f-a59f7922d779,
                    EAD790EBCBC9E102087108CB0F5556A3B44BAE4B) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 82.181.27.157
Date:   Wed, 19 Jan 2022 22:55:35 +0200
From:   Andi Shyti <andi@etezian.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 5/5] spi: s3c64xx: allow controller-data to be optional
Message-ID: <Yeh6x6U3tA7y5gvF@jack.zhora.eu>
References: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
 <20220119201005.13145-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119201005.13145-6-krzysztof.kozlowski@canonical.com>
X-Ovh-Tracer-Id: 8852669495508536017
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucggtffrrghtthgvrhhnpedtgfduudfhfeeuueejfeeihedtfeetgfegveehgfeuleelhfduteegieekudeifeenucfkpheptddrtddrtddrtddpkedvrddukedurddvjedrudehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jan 19, 2022 at 09:10:05PM +0100, Krzysztof Kozlowski wrote:
> The Samsung SoC SPI driver requires to provide controller-data node
> for each of SPI peripheral device nodes.  Make this controller-data node
> optional, so DTS could be simpler.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 8755cd85e83c..769d958a2f86 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -796,16 +796,14 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	data_np = of_get_child_by_name(slave_np, "controller-data");
> -	if (!data_np) {
> -		dev_err(&spi->dev, "child node 'controller-data' not found\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> -
>  	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
> -	if (!cs) {
> -		of_node_put(data_np);
> +	if (!cs)
>  		return ERR_PTR(-ENOMEM);
> +
> +	data_np = of_get_child_by_name(slave_np, "controller-data");
> +	if (!data_np) {
> +		dev_info(&spi->dev, "child node 'controller-data' not found, using defaults\n");

"not found" sounds like an error; I would just write something
like "feedback delay set to '0' dfault", you also tell that the
default value is '0'.

In any case,

Reviewed-by: Andi Shyti <andi@etezian.org>

Andi
