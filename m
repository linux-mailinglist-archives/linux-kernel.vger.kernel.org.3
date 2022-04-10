Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290C54FAE98
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiDJPzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbiDJPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1B4B19;
        Sun, 10 Apr 2022 08:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F7561042;
        Sun, 10 Apr 2022 15:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FEBC385A4;
        Sun, 10 Apr 2022 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649606016;
        bh=BS99R+AiEQwgwtL1PMd/OFp/uM9sP7YQaEQHFRyv1FA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KW3sBbvZWOs005rmPVUeOnztbBwXUUjoes3CX0yRnA7fCm3QnDtLJl7yH4M9BGrGR
         BLO23D7gQ6C5gM0h36qrh7D7V22YKFDOOq1Rgvnr9CYFwa2nO29x76hR+KSorZIw7V
         8WhKJ7sOR7VL5em2GdtO1/N8gBLoKjPqNhvPq/gz2nLUtb4ouDpzquD0dsbq1gwgSZ
         u97g+WrTDxQet8yN7o4WaD7eSfvWMtEPRdbrt7jyG1+rHOLW8Lbu9BL3F55tPzq5yd
         pfIHvJyXC6EeQtgBkr6o96zPlpQePW+ht2CN1yIhFawU5wEggl2Xv69kjpmc7hOjql
         smkuWX7lqtOFA==
Date:   Sun, 10 Apr 2022 17:01:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, <linus.walleij@linaro.org>
Subject: Re: [PATCH] iio: magnetometer: ak8975: Fix the error handling in
 ak8975_power_on()
Message-ID: <20220410170127.058fc942@jic23-huawei>
In-Reply-To: <20220409034849.3717231-2-zheyuma97@gmail.com>
References: <20220409034849.3717231-1-zheyuma97@gmail.com>
        <20220409034849.3717231-2-zheyuma97@gmail.com>
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

On Sat,  9 Apr 2022 11:48:49 +0800
Zheyu Ma <zheyuma97@gmail.com> wrote:

> When the driver fails to enable the regulator 'vid', we will get the
> following splat:
> 
> [   79.955610] WARNING: CPU: 5 PID: 441 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> [   79.959641] RIP: 0010:_regulator_put+0x3ec/0x4e0
> [   79.967570] Call Trace:
> [   79.967773]  <TASK>
> [   79.967951]  regulator_put+0x1f/0x30
> [   79.968254]  devres_release_group+0x319/0x3d0
> [   79.968608]  i2c_device_probe+0x766/0x940
> 
> Fix this by disabling the 'vdd' regulator when failing to enable 'vid'
> regulator.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
This driver doesn't really have a maintainer any more, though Linus W actually
last touched this bit of code. So +CC.

However, it's pretty obviously correct so applied to the fixes-togreg branch of iio.git.

For future reference, please don't send one fix as reply to a fix on a different driver.
Makes a mess of thread handling and tracking in patchwork etc.

Ideally also please provide a fixes tag.  For this one I have applied with out it
because it was a long time back and looks like the bug predates a bunch of refactoring
of this code.  

Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan


> ---
>  drivers/iio/magnetometer/ak8975.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 088f748b683e..2432e697150c 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -416,6 +416,7 @@ static int ak8975_power_on(const struct ak8975_data *data)
>  	if (ret) {
>  		dev_warn(&data->client->dev,
>  			 "Failed to enable specified Vid supply\n");
> +		regulator_disable(data->vdd);
>  		return ret;
>  	}
>  

