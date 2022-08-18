Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3538B598874
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344369AbiHRQO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbiHRQOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:14:17 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163484BA50;
        Thu, 18 Aug 2022 09:14:15 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id A28DA20005;
        Thu, 18 Aug 2022 16:14:10 +0000 (UTC)
Date:   Thu, 18 Aug 2022 18:14:08 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 4/4] media: mt9m111: remove .s_power callback
Message-ID: <20220818161408.76ofg2rjvp5whtof@uno.localdomain>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-4-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220818144712.997477-4-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco

On Thu, Aug 18, 2022 at 04:47:12PM +0200, Marco Felsch wrote:
> This is in preparation of switching to the generic dev PM mechanism.
> Since the .s_power callback will be removed in the near future move the
> powering into the .s_stream callback. So this driver no longer depends
> on the .s_power mechanism.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

If you want to move to runtime_pm, I would implement it first and have
s_power call the _resume and _suspend routines, as some platform
drivers still use s_power() and some of them might depend on it.

It's a slippery slope.. I would love to get rid of s_power() but if
any platform uses it with this sensor, it would stop working after
this change.

> ---
>  drivers/media/i2c/mt9m111.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> index cd74c408e110..8e8ba5a8e6ea 100644
> --- a/drivers/media/i2c/mt9m111.c
> +++ b/drivers/media/i2c/mt9m111.c
> @@ -1065,7 +1065,6 @@ static const struct v4l2_ctrl_ops mt9m111_ctrl_ops = {
>  };
>
>  static const struct v4l2_subdev_core_ops mt9m111_subdev_core_ops = {
> -	.s_power	= mt9m111_s_power,
>  	.log_status = v4l2_ctrl_subdev_log_status,
>  	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
>  	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
> @@ -1136,8 +1135,14 @@ static int mt9m111_enum_mbus_code(struct v4l2_subdev *sd,
>  static int mt9m111_s_stream(struct v4l2_subdev *sd, int enable)
>  {
>  	struct mt9m111 *mt9m111 = container_of(sd, struct mt9m111, subdev);
> +	int ret;
>
>  	mt9m111->is_streaming = !!enable;
> +
> +	ret = mt9m111_s_power(sd, enable);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>
> --
> 2.30.2
>
