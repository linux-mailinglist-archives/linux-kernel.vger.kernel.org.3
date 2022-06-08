Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E60543213
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiFHOAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbiFHOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:00:18 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4AB30388A;
        Wed,  8 Jun 2022 07:00:12 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 702A01BF20E;
        Wed,  8 Jun 2022 14:00:08 +0000 (UTC)
Date:   Wed, 8 Jun 2022 16:00:06 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v7 4/4] media: i2c: ov5675: add .get_selection support
Message-ID: <20220608140006.qhe47mdq423jkcu4@uno.localdomain>
References: <20220608134420.1750530-1-foss+kernel@0leil.net>
 <20220608134420.1750530-4-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220608134420.1750530-4-foss+kernel@0leil.net>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin

On Wed, Jun 08, 2022 at 03:44:20PM +0200, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
> pixels and there are an additional 24 black rows "at the bottom".
>
>                      [2624]
>         +-----+------------------+-----+
>         |     |     16 dummy     |     |
>         +-----+------------------+-----+
>         |     |                  |     |
>         |     |     [2592]       |     |
>         |     |                  |     |
>         |16   |      valid       | 16  |[2000]
>         |dummy|                  |dummy|
>         |     |            [1944]|     |
>         |     |                  |     |
>         +-----+------------------+-----+
>         |     |     16 dummy     |     |
>         +-----+------------------+-----+
>         |     |  24 black lines  |     |
>         +-----+------------------+-----+
>
> The top-left coordinate is gotten from the registers specified in the
> modes which are identical for both currently supported modes.
>
> There are currently two modes supported by this driver: 2592*1944 and
> 1296*972. The second mode is obtained thanks to subsampling while
> keeping the same field of view (FoV). No cropping involved, hence the
> harcoded values.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

yeah! looks good to me now!
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

> ---
>
> v7:
>  - fixed incorrect V4L2_SEL_TGT_CROP_BOUNDS introduced in v6,
>
> v6:
>  - explicit a bit more the commit log around subsampling for lower
>  resolution modes,
>  - (again) fixed reporting for V4L2_SEL_TGT_CROP_* thanks to Jacopo's help,
>
> v4:
>  - explicit a bit more the commit log,
>  - added drawing in the commit log,
>  - fixed reporting for V4L2_SEL_TGT_CROP_* thanks to Jacopo's help,
>
> added in v3
>
>  drivers/media/i2c/ov5675.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
> index 80840ad7bbb0..5f70ead2dd47 100644
> --- a/drivers/media/i2c/ov5675.c
> +++ b/drivers/media/i2c/ov5675.c
> @@ -1121,6 +1121,31 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
>  	return 0;
>  }
>
> +static int ov5675_get_selection(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_state *state,
> +				struct v4l2_subdev_selection *sel)
> +{
> +	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> +		return -EINVAL;
> +
> +	switch (sel->target) {
> +	case V4L2_SEL_TGT_CROP_BOUNDS:
> +		sel->r.top = 0;
> +		sel->r.left = 0;
> +		sel->r.width = 2624;
> +		sel->r.height = 2000;
> +		return 0;
> +	case V4L2_SEL_TGT_CROP:
> +	case V4L2_SEL_TGT_CROP_DEFAULT:
> +		sel->r.top = 16;
> +		sel->r.left = 16;
> +		sel->r.width = 2592;
> +		sel->r.height = 1944;
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>  static int ov5675_enum_mbus_code(struct v4l2_subdev *sd,
>  				 struct v4l2_subdev_state *sd_state,
>  				 struct v4l2_subdev_mbus_code_enum *code)
> @@ -1170,6 +1195,7 @@ static const struct v4l2_subdev_video_ops ov5675_video_ops = {
>  static const struct v4l2_subdev_pad_ops ov5675_pad_ops = {
>  	.set_fmt = ov5675_set_format,
>  	.get_fmt = ov5675_get_format,
> +	.get_selection = ov5675_get_selection,
>  	.enum_mbus_code = ov5675_enum_mbus_code,
>  	.enum_frame_size = ov5675_enum_frame_size,
>  };
> --
> 2.36.1
>
