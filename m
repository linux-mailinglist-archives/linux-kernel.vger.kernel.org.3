Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65EA5287DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbiEPPDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244869AbiEPPCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:02:48 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCC83B3F7;
        Mon, 16 May 2022 08:02:46 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id BBC79FF807;
        Mon, 16 May 2022 15:02:39 +0000 (UTC)
Date:   Mon, 16 May 2022 17:02:37 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alain Volmat <alain.volmat@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: Re: [PATCH] media: stm32-dcmi: add support of 1X16 serial pixel
 formats variant
Message-ID: <20220516150237.v3xt7onp2lpmellw@uno.localdomain>
References: <20220516092048.264036-1-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220516092048.264036-1-hugues.fruchet@foss.st.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugues,

On Mon, May 16, 2022 at 11:20:48AM +0200, Hugues Fruchet wrote:
> From: Hugues Fruchet <hugues.fruchet@st.com>
>
> Add support of 1X16 serial pixel formats in order to support
> CSI-2 camera sensor exposing 1x16 pixel formats only.
>
> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Sakari, if you're sending a new pull request for the ov5640 series,
could you include this one as otherwise dcmi would be broken when used
with that sensor.

Thanks
   j

> ---
>  drivers/media/platform/st/stm32/stm32-dcmi.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
> index 09a743cd7004..b2ba4d95bfa3 100644
> --- a/drivers/media/platform/st/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
> @@ -1592,25 +1592,31 @@ static int dcmi_set_default_fmt(struct stm32_dcmi *dcmi)
>  	return 0;
>  }
>
> -/*
> - * FIXME: For the time being we only support subdevices
> - * which expose RGB & YUV "parallel form" mbus code (_2X8).
> - * Nevertheless, this allows to support serial source subdevices
> - * and serial to parallel bridges which conform to this.
> - */
>  static const struct dcmi_format dcmi_formats[] = {
>  	{
>  		.fourcc = V4L2_PIX_FMT_RGB565,
>  		.mbus_code = MEDIA_BUS_FMT_RGB565_2X8_LE,
>  		.bpp = 2,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_RGB565,
> +		.mbus_code = MEDIA_BUS_FMT_RGB565_1X16,
> +		.bpp = 2,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_YUYV,
>  		.mbus_code = MEDIA_BUS_FMT_YUYV8_2X8,
>  		.bpp = 2,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_YUYV,
> +		.mbus_code = MEDIA_BUS_FMT_YUYV8_1X16,
> +		.bpp = 2,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_UYVY,
>  		.mbus_code = MEDIA_BUS_FMT_UYVY8_2X8,
>  		.bpp = 2,
> +	}, {
> +		.fourcc = V4L2_PIX_FMT_UYVY,
> +		.mbus_code = MEDIA_BUS_FMT_UYVY8_1X16,
> +		.bpp = 2,
>  	}, {
>  		.fourcc = V4L2_PIX_FMT_JPEG,
>  		.mbus_code = MEDIA_BUS_FMT_JPEG_1X8,
> --
> 2.25.1
>
