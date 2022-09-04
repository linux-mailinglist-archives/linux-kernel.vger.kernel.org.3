Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3DA5AC4F2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIDPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIDPXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:23:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBB33120D;
        Sun,  4 Sep 2022 08:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26041B80D90;
        Sun,  4 Sep 2022 15:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC91FC433D7;
        Sun,  4 Sep 2022 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662305010;
        bh=C5+6BktQ0c4QwzHvwj8UwuDHzj81uEju9cMeYCIBLGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pl/O16D0YiUI+aTtoIUhXPDXONd8yTKQKJDMfs5wAUFOaTnCO5+g9IOI9igtJzJb0
         okDaaHsZsSI8idQ9kTC0Ei1KlM1RnklP5XHYFsHhJ2lmW9jd9BLjGqn58hEBybUZZN
         LB5QFKLEGy8PUEJSytpdGEFkm3P8wLNZaN1s1wBQ417RMhJECczQNCztlXBR0FnpfV
         YXDLFELcj22M5HMfNekI2vQUdqkioZLub+7i0qJwpKY4JjeX74UV8QAiKc5MTEjz10
         NHS/96VXEZGm6J0olpbpCNQ3hA0iIMgHX2BVk4GPSAoKvmeH69CHtAE047R7E7fSa8
         zdjkeNrTlgu7w==
Date:   Sun, 4 Sep 2022 15:49:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 3/3] iio: temperature: mlx90632 Change return value
 of sensor measurement channel
Message-ID: <20220904154923.33b79d83@jic23-huawei>
In-Reply-To: <20220903222422.3426156-1-cmo@melexis.com>
References: <20220903222422.3426156-1-cmo@melexis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun,  4 Sep 2022 00:24:22 +0200
cmo@melexis.com wrote:

> From: Crt Mori <cmo@melexis.com>
> 
> The current EINVAL value is more applicable to embedded library, where
> user can actually put the fixed value to the sensor. In case of the
> driver if the value of the channel is invalid it is better in inform
> userspace that Channel was out of range as that implies more to internal
> driver error than invalid input. It also makes for easier debugging of
> where the error comes from during the development.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
Hmm. That's an obscure return value - I think it's mostly going to confuse
anyone who ever gets it.  So not sure this change is wise even though the
descriptive text for that one does seem very much suited to this usecase.

> ---
>  drivers/iio/temperature/mlx90632.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 37edd324d6a1..d511d36942d3 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -435,7 +435,7 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
>  		*channel_old = 1;
>  		break;
>  	default:
> -		return -EINVAL;
> +		return -ECHRNG;
>  	}
>  
>  	return 0;

