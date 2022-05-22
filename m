Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE35302A0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244990AbiEVLTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244620AbiEVLTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85453D493;
        Sun, 22 May 2022 04:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A07760F9F;
        Sun, 22 May 2022 11:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6DAC385AA;
        Sun, 22 May 2022 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653218370;
        bh=NhyAiVCeqAx2z0dmzBlSZjwSKWMViekhCT2H8px98MA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l63swqfc3lPEaVj4XadbwdxywukzONV+NCFHbNmgmn8IJ8zPQgew1w0mzDjyl7QNn
         /xZG8z9zVUOA3YX3ttPMmIWSb8SyXdNafgmWM2kEyfJam4chomvMBbZh21seChd1Zu
         c+lP4H61M/y58bzvX8rt0lOSNfXP6Jnm4WdElcYgTCoLUQbnEzPXHWR129zAISY7YS
         qdXPvOxwClqAKxzgiQ7s6m1Z5nT4c7Ot4/2510eKjRNuTBvwjfUBrpdkYPN8Ti0QRD
         FhEFPKI7CqFmKTdGyI5dL9hUsBic+fDEKVlUjiA3pc4qYPuDtEpUAKAnbbjE/KdQG2
         ymy8S1SI4wDvg==
Date:   Sun, 22 May 2022 12:28:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jialin Zhang <zhangjialin11@huawei.com>
Cc:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <lars@metafoo.de>,
        <biju.das.jz@bp.renesas.com>, <linux-iio@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: rzg2l_adc: add missing fwnode_handle_put() in
 rzg2l_adc_parse_properties()
Message-ID: <20220522122815.60f09ab7@jic23-huawei>
In-Reply-To: <20220517033526.2035735-1-zhangjialin11@huawei.com>
References: <20220517033526.2035735-1-zhangjialin11@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 11:35:26 +0800
Jialin Zhang <zhangjialin11@huawei.com> wrote:

> fwnode_handle_put() should be used when terminating
> device_for_each_child_node() iteration with break or
> return to prevent stale device node references from
> being left behind.
> 
> Fixes: d484c21bacfa ("iio: adc: Add driver for Renesas RZ/G2L A/D converter")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/rzg2l_adc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 7585144b9715..5b09a93fdf34 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -334,11 +334,15 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
>  	i = 0;
>  	device_for_each_child_node(&pdev->dev, fwnode) {
>  		ret = fwnode_property_read_u32(fwnode, "reg", &channel);
> -		if (ret)
> +		if (ret) {
> +			fwnode_handle_put(fwnode);
>  			return ret;
> +		}
>  
> -		if (channel >= RZG2L_ADC_MAX_CHANNELS)
> +		if (channel >= RZG2L_ADC_MAX_CHANNELS) {
> +			fwnode_handle_put(fwnode);
>  			return -EINVAL;
> +		}
>  
>  		chan_array[i].type = IIO_VOLTAGE;
>  		chan_array[i].indexed = 1;

