Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F875983BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244908AbiHRNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244299AbiHRNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:04:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C99DB5E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:04:23 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ICdnIc015150;
        Thu, 18 Aug 2022 08:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=nGjzw+hXhMpPjDZykCqJG0YNPmreufR6lBHR3QElQvE=;
 b=jhKWlCbbyo6rCnzMMRcWD5Lg23lkvfP1bQ6nlC/s0QFydlT+0rq5XRsZB60IvzD4vD5l
 5O04hOnRntk7h3FcVVFWQJh7G1Pwh0/PDWFt/XnCsuPp5UdxkN5aiyA4hOYrMfJ1iEWJ
 WBwjX3CsNE34hve/ZdeUoSsuAsavSGj7LObclnfuUc7lnKn8EWjLiOMRsjV83vj3TiVQ
 e7dBOVgsnJ6Ihq2xYZ9TowfCTjmqZpHQx0L/jEFy3B8FcHXhYE/Wcy/FOWnUNEKrwJFw
 dGt1jnkhqNuJFPHenKJGaGzjIODHOYsdWpQDCYkisTsyrK6+8D2i47O6HUNadSvW47Wb 4w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpedh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 08:03:51 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 18 Aug
 2022 08:03:49 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Thu, 18 Aug 2022 08:03:49 -0500
Received: from [198.61.64.137] (unknown [198.61.64.137])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 876897C;
        Thu, 18 Aug 2022 13:03:49 +0000 (UTC)
Message-ID: <3929af86-b427-a745-984d-9a9b9ab17337@opensource.cirrus.com>
Date:   Thu, 18 Aug 2022 14:03:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] regmap: spi: Reserve space for register
 address/padding
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
References: <20220818104851.429479-1-cristian.ciocaltea@collabora.com>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20220818104851.429479-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lsjUtoZOgLkHVv06JduHNxqd_heKed0J
X-Proofpoint-GUID: lsjUtoZOgLkHVv06JduHNxqd_heKed0J
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

On 8/18/22 11:48, Cristian Ciocaltea wrote:
> Currently the max_raw_read and max_raw_write limits in regmap_spi struct
> do not take into account the additional size of the transmitted register
> address and padding.  This may result in exceeding the maximum permitted
> SPI message size, which could cause undefined behaviour, e.g. data
> corruption.
> 
> Fix regmap_get_spi_bus() to properly adjust the above mentioned limits
> by reserving space for the register address/padding as set in the regmap
> configuration.
> 
> Fixes: f231ff38b7b2 ("regmap: spi: Set regmap max raw r/w from max_transfer_size")
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
> Changes in v2:
>   - Make use of BITS_PER_BYTE, as suggested by Lucas
>   - Small correction in the commit message
> 
>   drivers/base/regmap/regmap-spi.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
> index 719323bc6c7f..37ab23a9d034 100644
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
> @@ -120,9 +121,16 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
>   		if (!bus)
>   			return ERR_PTR(-ENOMEM);
>   
> +		max_msg_size = spi_max_message_size(spi);
> +		reg_reserve_size = config->reg_bits / BITS_PER_BYTE
> +				 + config->pad_bits / BITS_PER_BYTE;
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
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868

