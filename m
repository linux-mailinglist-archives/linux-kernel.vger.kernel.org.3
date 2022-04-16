Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695BA5036DF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiDPNxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 09:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiDPNxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 09:53:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBFE33881;
        Sat, 16 Apr 2022 06:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CB9BB8241F;
        Sat, 16 Apr 2022 13:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8E7C385A1;
        Sat, 16 Apr 2022 13:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650117069;
        bh=d8QKVxdG4FlCyd4OG5tSxmy/2lyoeJsbEk6g26b9g0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I9lICP1Y+XVpygKDt1AUNygvxAvyUKQCp0ybg/cxx1+PZUMzrehupBWrTUTvTWtzl
         rbgGLkefFv4FCFBNi5VOKqzqPBux/BSiJHUZOud+GEi/rAvSHFLBvZ/aI7FergO5s6
         yTdCf1N3sSaOmv7bgRWpTss3Ys8McXk3vj0rJZCm5u/EufcW3ThKtrnZixO2W7RCqF
         YKfmLgHAa0YkladYYgLFzXk+lmMCA7kA7UZNgvsnNuE9A8oeT8p7MkVOEXqTfatZgY
         Btd7e2+HNJk7qZ/yRlglX5YAzJO7yVsJAcPaTEvwfgh7iECvq+Putvt0AvoOaS9lRs
         BIpSq3GzCe2yg==
Date:   Sat, 16 Apr 2022 14:59:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: vl53l0x:  Fix return value check of
 wait_for_completion_timeout
Message-ID: <20220416145906.1162767c@jic23-huawei>
In-Reply-To: <20220412064210.10734-1-linmq006@gmail.com>
References: <PH0PR03MB6786F62DE142E3E2C66C937F99ED9@PH0PR03MB6786.namprd03.prod.outlook.com>
        <20220412064210.10734-1-linmq006@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 06:42:09 +0000
Miaoqian Lin <linmq006@gmail.com> wrote:

> wait_for_completion_timeout() returns unsigned long not int.
> It returns 0 if timed out, and positive if completed.
> The check for <= 0 is ambiguous and should be == 0 here
> indicating timeout which is the only error case.
> 
> Fixes: 3cef2e31b54b ("iio: proximity: vl53l0x: Add IRQ support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Hi,

Applied to the togreg branch of iio.git ready for the next
merge window. I'm not rushing this in because it's removing pointless
and misleading code rather than fixing a bug as such.

Thanks,

Jonathan

> ---
> Changes in v2:
> - add driver name in patch subject.
> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 661a79ea200d..a284b20529fb 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -104,6 +104,7 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
>  	u16 tries = 20;
>  	u8 buffer[12];
>  	int ret;
> +	unsigned long time_left;
>  
>  	ret = i2c_smbus_write_byte_data(client, VL_REG_SYSRANGE_START, 1);
>  	if (ret < 0)
> @@ -112,10 +113,8 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
>  	if (data->client->irq) {
>  		reinit_completion(&data->completion);
>  
> -		ret = wait_for_completion_timeout(&data->completion, HZ/10);
> -		if (ret < 0)
> -			return ret;
> -		else if (ret == 0)
> +		time_left = wait_for_completion_timeout(&data->completion, HZ/10);
> +		if (time_left == 0)
>  			return -ETIMEDOUT;
>  
>  		vl53l0x_clear_irq(data);

