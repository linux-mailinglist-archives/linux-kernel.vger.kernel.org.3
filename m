Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B424E1D07
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 18:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245682AbiCTRLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245670AbiCTRL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 13:11:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BBD92843;
        Sun, 20 Mar 2022 10:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DB84B80EE5;
        Sun, 20 Mar 2022 17:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D7DC340F4;
        Sun, 20 Mar 2022 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647796202;
        bh=k8jdFKcrSKfMwqREooBwt0Pw3gzreCUO94w2x/+dUdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ubvd0zhv1WwabWYRB/ruxIzjFdiDYG4CByetdlUM24XsF1+v9DE42Ex+PaQxiSRvW
         mBdRza0NAiLUWSnQtC7uLWTvQNiRh3gXssNAJ8iePXoECzi8rqD9G3euKYdGsj6q2V
         7kGczQQS/lJsFoUzJuTSD5THn/rkqA1nvs8oJ+OHMaLNA1vmSJUrd84MBYva3b7jwC
         o8GULG5TvJn/2kieilnFXdsRwFsaBpg5yT5Tu0q5WbQTTMajlEuRxlN2ca1QWXOCOW
         oPAh+zRY0WdCdJENCKu78tuqeGQiDNkAe6rL3gYCRfSX15EuqiuiOZpQ4xiOEjHZNk
         zgygWTZSJSsVg==
Date:   Sun, 20 Mar 2022 17:17:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] iio: accel: bma400: changing scale min and max
 macro values
Message-ID: <20220320171726.7a4bd968@jic23-huawei>
In-Reply-To: <20220319181023.8090-3-jagathjog1996@gmail.com>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
        <20220319181023.8090-3-jagathjog1996@gmail.com>
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

On Sat, 19 Mar 2022 23:40:20 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Changing the scale macro values to match the bma400 sensitivity
> for 1 LSB of all the available ranges.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
This needs a fixes tag and should be the first patch in the series.
I'd also like the maths to be described as these numbers are (I assume)
calculated based on the range and the bit depth of the sensor?
If you can add a comment in the code, then we'll have a convenient
reference alongside the numbers.

> ---
>  drivers/iio/accel/bma400.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index e938da5a57b4..cfc2c9bacec8 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -83,8 +83,8 @@
>  #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
>  #define BMA400_ACC_ODR_MIN_HZ       12
>  
> -#define BMA400_SCALE_MIN            38357
> -#define BMA400_SCALE_MAX            306864
> +#define BMA400_SCALE_MIN            9583
> +#define BMA400_SCALE_MAX            76669
>  
>  #define BMA400_NUM_REGULATORS       2
>  #define BMA400_VDD_REGULATOR        0

