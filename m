Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01438474AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhLNSfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:35:36 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58447 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLNSfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:35:34 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id F1A1520002;
        Tue, 14 Dec 2021 18:35:30 +0000 (UTC)
Date:   Tue, 14 Dec 2021 19:36:23 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>
Cc:     slongerbeam@gmail.com, mchehab@kernel.org, hugues.fruchet@st.com,
        jacopo+renesas@jmondi.org, guoniu.zhou@nxp.com,
        manish.bajaj@nxp.com, robert.chiras@nxp.com,
        xavier.roumegue@oss.nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Mirela Rabulea <mirela.rabulea@nxp.com>
Subject: Re: [PATCH] media: ov5640: Fix set format, v4l2_mbus_pixelcode not
 updated
Message-ID: <20211214183623.d3g3e5qwp5rfr3oo@uno.localdomain>
References: <20211101195251.700674-1-mirela.rabulea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211101195251.700674-1-mirela.rabulea@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mirela,

On Mon, Nov 01, 2021 at 09:52:51PM +0200, Mirela Rabulea (OSS) wrote:
> From: Mirela Rabulea <mirela.rabulea@nxp.com>
>
> In ov5640_set_fmt, pending_fmt_change will always be false, because the
> sensor format is saved before comparing it with the previous format:
> 	fmt = &sensor->fmt;...
> 	*fmt = *mbus_fmt;...
> 	if (mbus_fmt->code != sensor->fmt.code)
> 		sensor->pending_fmt_change = true;
> This causes the sensor to capture with the previous pixelcode.
>
> Also, changes might happen even for V4L2_SUBDEV_FORMAT_TRY, so fix that.
>
> Basically, revert back to the state before
> commit 071154499193 ("media: ov5640: Fix set format regression")
> as it was more clear, and then update format even when pixelcode does
> not change, as resolution might change.
>
> Fixes: 071154499193 ("media: ov5640: Fix set format regression")
> Fixes: 6949d864776e ("media: ov5640: do not change mode if format or frame interval is unchanged")
> Fixes: fb98e29ff1ea5 ("media: ov5640: fix mode change regression")

Wow, we really piled bug over bug. So sorry about this and thanks for
fixing

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
   j
>
> Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> ---
>  drivers/media/i2c/ov5640.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index ddbd71394db3..db5a19babe67 100644
> --- a/drivers/media/i2c/ov5640.c
> +++ b/drivers/media/i2c/ov5640.c
> @@ -2293,7 +2293,6 @@ static int ov5640_set_fmt(struct v4l2_subdev *sd,
>  	struct ov5640_dev *sensor = to_ov5640_dev(sd);
>  	const struct ov5640_mode_info *new_mode;
>  	struct v4l2_mbus_framefmt *mbus_fmt = &format->format;
> -	struct v4l2_mbus_framefmt *fmt;
>  	int ret;
>
>  	if (format->pad != 0)
> @@ -2311,12 +2310,10 @@ static int ov5640_set_fmt(struct v4l2_subdev *sd,
>  	if (ret)
>  		goto out;
>
> -	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
> -		fmt = v4l2_subdev_get_try_format(sd, sd_state, 0);
> -	else
> -		fmt = &sensor->fmt;
> -
> -	*fmt = *mbus_fmt;
> +	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
> +		*v4l2_subdev_get_try_format(sd, sd_state, 0) = *mbus_fmt;
> +		goto out;
> +	}
>
>  	if (new_mode != sensor->current_mode) {
>  		sensor->current_mode = new_mode;
> @@ -2325,6 +2322,9 @@ static int ov5640_set_fmt(struct v4l2_subdev *sd,
>  	if (mbus_fmt->code != sensor->fmt.code)
>  		sensor->pending_fmt_change = true;
>
> +	/* update format even if code is unchanged, resolution might change */
> +	sensor->fmt = *mbus_fmt;
> +
>  	__v4l2_ctrl_s_ctrl_int64(sensor->ctrls.pixel_rate,
>  				 ov5640_calc_pixel_rate(sensor));
>  out:
> --
> 2.25.1
>
