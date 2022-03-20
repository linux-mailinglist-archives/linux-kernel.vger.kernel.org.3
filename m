Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22B4E1C37
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbiCTPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiCTPOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:14:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB412CE3A;
        Sun, 20 Mar 2022 08:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E335FB80E47;
        Sun, 20 Mar 2022 15:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717A3C340E9;
        Sun, 20 Mar 2022 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647789203;
        bh=dIrdSkDayyt2W+Bbvgmfrz/vkuTTAijlyK1oC0ZZ4KQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H5EfJW0KkFZALD5ehFwPwYaY1q+QqYvkTcL1M3ondAK7pwGfQ2PuQRPuS+ICtBiF5
         JfRHcMNdy6MkZRHMN/AEiI3vXw++cjrbklKZGb4Yr/qoAiP1VezeWzLznLtOKO2LKS
         zvYEPOw0E7gr2pzwQoeUjrd0gJtOlcAzzkz04ZnHn+6CPKFUGItQwo74sy4uzTZ93u
         BNX2sKnKkX3gdggyjJ3z+QJJ20GdGXntcX5Jg3p9f2myhv1t8YjanLnuCISGdWKDqT
         3ajkjvMs4wfyFLIW0AVbkZRERg455Btm4ywthBRxg0L63RlP10xzjU99+NwFrPX73I
         X7U4rZBEGcjqg==
Date:   Sun, 20 Mar 2022 15:20:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zizhuang Deng <sunsetdzz@gmail.com>
Cc:     Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Paul Cercueil <paul.cercueil@analog.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] iio: dac: ad5592r: Fix the missing return value.
Message-ID: <20220320152047.2a04a62e@jic23-huawei>
In-Reply-To: <20220310125450.4164164-1-sunsetdzz@gmail.com>
References: <20220310125450.4164164-1-sunsetdzz@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 20:54:50 +0800
Zizhuang Deng <sunsetdzz@gmail.com> wrote:

> The third call to `fwnode_property_read_u32` did not record
> the return value, resulting in `channel_offstate` possibly
> being assigned the wrong value.
> 
> Signed-off-by: Zizhuang Deng <sunsetdzz@gmail.com>
Hi,

Definitely rather odd looking and I think your conclusion is correct.
+CC Paul for confirmation that this isn't doing something clever..

> ---
>  drivers/iio/dac/ad5592r-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index a424b7220b61..4434c1b2a322 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -522,7 +522,7 @@ static int ad5592r_alloc_channels(struct iio_dev *iio_dev)
>  		if (!ret)
>  			st->channel_modes[reg] = tmp;
>  
> -		fwnode_property_read_u32(child, "adi,off-state", &tmp);
> +		ret = fwnode_property_read_u32(child, "adi,off-state", &tmp);
>  		if (!ret)
>  			st->channel_offstate[reg] = tmp;
>  	}

