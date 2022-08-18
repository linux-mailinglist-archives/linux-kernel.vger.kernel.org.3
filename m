Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ECE5980BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbiHRJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiHRJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:22:40 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD629AFAB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:22:39 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I99Tjq032417;
        Thu, 18 Aug 2022 04:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=35zxBcGa9py/6SDlDzI/3BWwAdGou8pGG9sIeeZdZpU=;
 b=bbHXb4ZZivPNyCwfkjzSSD7MYxQ1GcuNWmp0VpCOP2PcmSorkqJfI//FO3X0jHK0NGOo
 0dgv96v/cY8eQnPcTaYIC2zCPutI+/285avPm+cJwMiyh6gTniYsDk+0wH4rJ6YXeCk9
 TGq3oIf0lZOAQffmReKsIFhwcTrW3epb19LCCRtIuBNoX3F3q+FcVTMCo+psRpFa6e6r
 XXZxhGe36Fc0Q2MmlmdfoioL5E1jkpQoeNlbA0TJJlfClfNbzMcbzNVXMaguvCc0JOo+
 ZL1BNDKAG3iGz2BLwEx2Htqp/oBP/B0gZAzj9UVnkt3Xzb19WbuocFND/+DXx84M0sww Jg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hx9c1x17x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:22:06 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 18 Aug
 2022 04:22:04 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Thu, 18 Aug 2022 04:22:04 -0500
Received: from [198.61.64.137] (EDINJT38163.ad.cirrus.com [198.61.64.137])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 87C6E459;
        Thu, 18 Aug 2022 09:22:03 +0000 (UTC)
Message-ID: <d21568e5-854b-0a3e-f71d-947198aa61a5@opensource.cirrus.com>
Date:   Thu, 18 Aug 2022 10:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] regmap: spi: Reserve space for register address/padding
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
References: <20220817213835.359037-1-cristian.ciocaltea@collabora.com>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20220817213835.359037-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LD4O6Wf4g8a22T6IuIlmKTRFvBBxwDKZ
X-Proofpoint-GUID: LD4O6Wf4g8a22T6IuIlmKTRFvBBxwDKZ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 22:38, Cristian Ciocaltea wrote:
> Currently the max_raw_read and max_raw_write limits in regmap_spi struct
> do not take into account the additional size of the transmitted register
> address and padding.  This may result in exceeding the maximum permitted
> SPI transfer size, which could cause undefined behaviour, e.g. data
> corruption.
> 
> Fix regmap_get_spi_bus() to properly adjust the above mentioned limits
> by reserving space for the register address/padding as set in the regmap
> configuration.
> 
> Fixes: f231ff38b7b2 ("regmap: spi: Set regmap max raw r/w from max_transfer_size")
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   drivers/base/regmap/regmap-spi.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
> index 719323bc6c7f..6fb94c06a447 100644
> --- a/drivers/base/regmap/regmap-spi.c
> +++ b/drivers/base/regmap/regmap-spi.c
> @@ -113,6 +113,7 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
>   						   const struct regmap_config *config)
>   {
>   	size_t max_size = spi_max_transfer_size(spi);
> +	size_t max_msg_size, reg_reserve_size;
>   	struct regmap_bus *bus;
> 
>   	if (max_size != SIZE_MAX) {
> @@ -120,9 +121,15 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
>   		if (!bus)
>   			return ERR_PTR(-ENOMEM);
> 
> +		max_msg_size = spi_max_message_size(spi);
> +		reg_reserve_size = config->reg_bits / 8 + config->pad_bits / 8;
I think you can use BITS_PER_BYTE here instead of 8.

> +		if (max_size + reg_reserve_size > max_msg_size)
> +			max_size -= reg_reserve_size;
> +
>   		bus->free_on_exit = true;
>   		bus->max_raw_read = max_size;
>   		bus->max_raw_write = max_size;
> +
>   		return bus;
>   	}
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> --
> 2.37.2

