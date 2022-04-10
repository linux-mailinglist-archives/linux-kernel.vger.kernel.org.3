Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426294FAE95
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiDJPsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiDJPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:48:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32994ECF1;
        Sun, 10 Apr 2022 08:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 267E9B80D93;
        Sun, 10 Apr 2022 15:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08611C385A4;
        Sun, 10 Apr 2022 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649605594;
        bh=oi3eBcfRm1TBC2kfSOu1MJ5ErNGN2JnBRXsGYrFkEtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UVDuXpbe79zgEgAe4W2rVkoS9jR/iHWR2yJ6Gtg1tC9dTCcKWmOhFX/ncuqcZpJma
         Fm80i3q2u86QW3um4y5oSemMJElOAKwiVq4wiQmTJhPMGw3u7T6sflVl4TIy5a17wN
         JpW6iloIitc7o1pksiYabzGHVi2sDVKdVK9GS0Fx4b3OUS5/9rPJyLHkjnuVCsZCim
         SZa2Bz5SJd0uZ3xkGj4P6vpCnGSUHgUvlWSUl2AppQrWTwGJcaeMYpC6l1NZDIYQJI
         pVZOxm1a55ZACcBBdLtB0WKdGMzauhcD2wSK09rGdxQGPgX+7a+46kkNyQGfnRb41R
         ofPSCL1sCT+Ww==
Date:   Sun, 10 Apr 2022 16:54:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] iio: magnetometer: ak8974: Fix the error handling of
 ak8974_probe()
Message-ID: <20220410165425.6c2f60e7@jic23-huawei>
In-Reply-To: <20220409034849.3717231-1-zheyuma97@gmail.com>
References: <20220409034849.3717231-1-zheyuma97@gmail.com>
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

On Sat,  9 Apr 2022 11:48:48 +0800
Zheyu Ma <zheyuma97@gmail.com> wrote:

> When the driver fail at devm_regmap_init_i2c(), we will get the
> following splat:
> 
> [  106.797388] WARNING: CPU: 4 PID: 413 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> [  106.802183] RIP: 0010:_regulator_put+0x3ec/0x4e0
> [  106.811237] Call Trace:
> [  106.811515]  <TASK>
> [  106.811695]  regulator_bulk_free+0x82/0xe0
> [  106.812032]  devres_release_group+0x319/0x3d0
> [  106.812425]  i2c_device_probe+0x766/0x940
> 
> Fix this by disabling the regulators at the error path.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
+ CC Linus W as it's his driver.

Fix looks correct to me, though the handling of runtime pm in here is
probably more complex than it needs to be (and hence this odd error
handling for this one place in the probe).

Jonathan

> ---
>  drivers/iio/magnetometer/ak8974.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index e54feacfb980..84bbf7ccc887 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -862,6 +862,7 @@ static int ak8974_probe(struct i2c_client *i2c,
>  		dev_err(&i2c->dev, "failed to allocate register map\n");
>  		pm_runtime_put_noidle(&i2c->dev);
>  		pm_runtime_disable(&i2c->dev);
> +		regulator_bulk_disable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
>  		return PTR_ERR(ak8974->map);
>  	}
>  

