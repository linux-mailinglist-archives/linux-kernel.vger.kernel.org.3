Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3525302A4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245040AbiEVLXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiEVLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F48119C1B;
        Sun, 22 May 2022 04:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B482EB80AC0;
        Sun, 22 May 2022 11:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7E6C385AA;
        Sun, 22 May 2022 11:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653218619;
        bh=9f2iXwecnVb772Z2NNfbPH7l5LuCIfXWdWIxvNZiS0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kfl1qSvGcByxwj7QROpVX0BF4U1anyizOZLZ2xw+qaueFsWlDCPyvNqZ59RZGjTq3
         daQdvN/1sbcS7u67LYlCVKsyXeVc4JkLCXiyvx7ogvR7zOTzn2hcB8B2e+hX3dMEqu
         nx67UBDHLUqIoBVN3MRhgj1U/BsNb9+ffmNQIwbckpO6cVrBuGTHGxDrcW8BfIZOsR
         r9UinJa5FNxDWBPipEGYvGP+HOQXuZ2uDSelKLHH1KA7vEsW9iRJCxqY3Oq8i/vfc8
         NrE+zh/NPMpRWsHzBmqQKaZsZ2TblIE7iiISt9UAYUb2jn1aNskBalqhYzcDQZQWYw
         syC1GNmFh143Q==
Date:   Sun, 22 May 2022 12:32:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jialin Zhang <zhangjialin11@huawei.com>
Cc:     <tomislav.denis@avl.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ti-ads131e08: add missing fwnode_handle_put()
 in ads131e08_alloc_channels()
Message-ID: <20220522123225.3f948d5e@jic23-huawei>
In-Reply-To: <20220517033020.2033324-1-zhangjialin11@huawei.com>
References: <20220517033020.2033324-1-zhangjialin11@huawei.com>
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

On Tue, 17 May 2022 11:30:20 +0800
Jialin Zhang <zhangjialin11@huawei.com> wrote:

> fwnode_handle_put() should be used when terminating
> device_for_each_child_node() iteration with break or
> return to prevent stale device node references from
> being left behind.
This one seems obviously correct so I'll not wait on anyone else
looking at it - still time though as I won't be sending a pull
request until these have been in next for a day or two.

Applied to the fixes-togreg branch of iio.git.

I rewrapped the description to use longer lines.

Jonathan

> 
> Fixes: d935eddd2799 ("iio: adc: Add driver for Texas Instruments ADS131E0x ADC family")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
> ---
>  drivers/iio/adc/ti-ads131e08.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> index 0c2025a22575..80a09817c119 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -739,7 +739,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
>  	device_for_each_child_node(dev, node) {
>  		ret = fwnode_property_read_u32(node, "reg", &channel);
>  		if (ret)
> -			return ret;
> +			goto err_child_out;
>  
>  		ret = fwnode_property_read_u32(node, "ti,gain", &tmp);
>  		if (ret) {
> @@ -747,7 +747,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
>  		} else {
>  			ret = ads131e08_pga_gain_to_field_value(st, tmp);
>  			if (ret < 0)
> -				return ret;
> +				goto err_child_out;
>  
>  			channel_config[i].pga_gain = tmp;
>  		}
> @@ -758,7 +758,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
>  		} else {
>  			ret = ads131e08_validate_channel_mux(st, tmp);
>  			if (ret)
> -				return ret;
> +				goto err_child_out;
>  
>  			channel_config[i].mux = tmp;
>  		}
> @@ -784,6 +784,10 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
>  	st->channel_config = channel_config;
>  
>  	return 0;
> +
> +err_child_out:
> +	fwnode_handle_put(node);
> +	return ret;
>  }
>  
>  static void ads131e08_regulator_disable(void *data)

