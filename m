Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD4C539198
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbiEaNOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244090AbiEaNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:14:17 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B606EB17;
        Tue, 31 May 2022 06:14:14 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 1A3B92000F;
        Tue, 31 May 2022 13:14:10 +0000 (UTC)
Date:   Tue, 31 May 2022 15:14:09 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        michael@amarulasolutions.com,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] media: i2c: ov5695: use
 regulator_bulk_enable/regulator_bulk disable instead of for loop
Message-ID: <20220531131409.f54znvogejkwqqkf@uno.localdomain>
References: <20220519075117.1003520-1-tommaso.merciai@amarulasolutions.com>
 <20220519075117.1003520-2-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220519075117.1003520-2-tommaso.merciai@amarulasolutions.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Thu, May 19, 2022 at 09:51:14AM +0200, Tommaso Merciai wrote:
> Enable regulator using regulator_bulk_enable/regulatore_bulk_disable
> function in __ov5695_power_on/__ov5695_power_off function instead of for loop.
> This reduce code size and make things more clear
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Co-Developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  drivers/media/i2c/ov5695.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5695.c b/drivers/media/i2c/ov5695.c
> index 439385938a51..880b586e55fe 100644
> --- a/drivers/media/i2c/ov5695.c
> +++ b/drivers/media/i2c/ov5695.c
> @@ -972,7 +972,7 @@ static int ov5695_s_stream(struct v4l2_subdev *sd, int on)
>
>  static int __ov5695_power_on(struct ov5695 *ov5695)
>  {
> -	int i, ret;
> +	int ret;
>  	struct device *dev = &ov5695->client->dev;
>
>  	ret = clk_prepare_enable(ov5695->xvclk);
> @@ -987,13 +987,10 @@ static int __ov5695_power_on(struct ov5695 *ov5695)
>  	 * The hardware requires the regulators to be powered on in order,
>  	 * so enable them one by one.
>  	 */

The comment says that the hardware requires regulators to be enabled
in precise order

> -	for (i = 0; i < OV5695_NUM_SUPPLIES; i++) {
> -		ret = regulator_enable(ov5695->supplies[i].consumer);
> -		if (ret) {
> -			dev_err(dev, "Failed to enable %s: %d\n",
> -				ov5695->supplies[i].supply, ret);
> -			goto disable_reg_clk;
> -		}
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ov5695->supplies), ov5695->supplies);

bulk_enable() uses the async API (async_schedule_domain() in
particular) which by the name makes me think such ordering guarantee
cannot be respected.

However most sensors require some kind of ordering when enabling
regulators, and most of the use the bulk API anyhow. The fact this
driver uses the bulk API to get an release the regulators but not for
enabling them and the above comment, makes me think it has been done
on purpose ? Could you check with the driver author maybe ?

> +	if (ret) {
> +		dev_err(dev, "Failed to enable regulators %d\n", ret);
> +		goto disable_reg_clk;
>  	}
>
>  	gpiod_set_value_cansleep(ov5695->reset_gpio, 0);
> @@ -1003,8 +1000,7 @@ static int __ov5695_power_on(struct ov5695 *ov5695)
>  	return 0;
>
>  disable_reg_clk:
> -	for (--i; i >= 0; i--)
> -		regulator_disable(ov5695->supplies[i].consumer);
> +	regulator_bulk_disable(ARRAY_SIZE(ov5695->supplies), ov5695->supplies);

FYI the bulk API does this for you if enabling any of the regulators fails.
Hence this should not be necessary.

Thanks
   j

>  	clk_disable_unprepare(ov5695->xvclk);
>
>  	return ret;
> @@ -1012,8 +1008,6 @@ static int __ov5695_power_on(struct ov5695 *ov5695)
>
>  static void __ov5695_power_off(struct ov5695 *ov5695)
>  {
> -	struct device *dev = &ov5695->client->dev;
> -	int i, ret;
>
>  	clk_disable_unprepare(ov5695->xvclk);
>  	gpiod_set_value_cansleep(ov5695->reset_gpio, 1);
> @@ -1022,12 +1016,7 @@ static void __ov5695_power_off(struct ov5695 *ov5695)
>  	 * The hardware requires the regulators to be powered off in order,
>  	 * so disable them one by one.
>  	 */
> -	for (i = OV5695_NUM_SUPPLIES - 1; i >= 0; i--) {
> -		ret = regulator_disable(ov5695->supplies[i].consumer);
> -		if (ret)
> -			dev_err(dev, "Failed to disable %s: %d\n",
> -				ov5695->supplies[i].supply, ret);
> -	}
> +	regulator_bulk_disable(ARRAY_SIZE(ov5695->supplies), ov5695->supplies);
>  }
>
>  static int __maybe_unused ov5695_runtime_resume(struct device *dev)
> --
> 2.25.1
>
