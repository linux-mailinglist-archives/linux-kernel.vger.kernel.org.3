Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CAE521160
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbiEJJv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbiEJJvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:51:53 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA25B237B86;
        Tue, 10 May 2022 02:47:56 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id F02761C0003;
        Tue, 10 May 2022 09:47:52 +0000 (UTC)
Date:   Tue, 10 May 2022 11:47:51 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v3 3/4] media: i2c: ov5675: parse and register V4L2
 device tree properties
Message-ID: <20220510094751.b6xbevurqhezpsnd@uno.localdomain>
References: <20220509143226.531117-1-foss+kernel@0leil.net>
 <20220509143226.531117-3-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509143226.531117-3-foss+kernel@0leil.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Mon, May 09, 2022 at 04:32:25PM +0200, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Parse V4L2 device tree properties and register controls for them.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  drivers/media/i2c/ov5675.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
> index cee380196774..5544e1ae444e 100644
> --- a/drivers/media/i2c/ov5675.c
> +++ b/drivers/media/i2c/ov5675.c
> @@ -779,12 +779,14 @@ static const struct v4l2_ctrl_ops ov5675_ctrl_ops = {
>
>  static int ov5675_init_controls(struct ov5675 *ov5675)
>  {
> +	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
>  	struct v4l2_ctrl_handler *ctrl_hdlr;
> +	struct v4l2_fwnode_device_properties props;

You could move the line up and maintain the (in)famous
reverse-xmas-tree ordering in variable declaration.

Nit apart, looks good
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

>  	s64 exposure_max, h_blank;
>  	int ret;
>
>  	ctrl_hdlr = &ov5675->ctrl_handler;
> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 8);
> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);
>  	if (ret)
>  		return ret;
>
> @@ -838,9 +840,23 @@ static int ov5675_init_controls(struct ov5675 *ov5675)
>  	if (ctrl_hdlr->error)
>  		return ctrl_hdlr->error;
>
> +	ret = v4l2_fwnode_device_parse(&client->dev, &props);
> +	if (ret)
> +		goto error;
> +
> +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &ov5675_ctrl_ops,
> +					      &props);
> +	if (ret)
> +		goto error;
> +
>  	ov5675->sd.ctrl_handler = ctrl_hdlr;
>
>  	return 0;
> +
> +error:
> +	v4l2_ctrl_handler_free(ctrl_hdlr);
> +
> +	return ret;
>  }
>
>  static void ov5675_update_pad_format(const struct ov5675_mode *mode,
> --
> 2.35.3
>
