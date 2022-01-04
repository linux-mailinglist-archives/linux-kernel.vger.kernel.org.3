Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B476483BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiADGVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:21:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55892 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiADGVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:21:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2046LYkG041456;
        Tue, 4 Jan 2022 00:21:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641277294;
        bh=1+Nt70oI0/J32ZtC+2bBxnkdjxh5ylh7BjLRr4Hm0mc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=avzG1KddJNN1oOHB8zJk1/xfuveTwP/Vc7XwdvVrjo5ub2hxN2Ju7RUE05TT6fCYY
         b83Uq2UxsjPF9ZAOuxBeEQq9NTUFNUlSYUpdmtt17tDSawtyQgKOxqLOMs8rELUqkx
         BM4TJKs1ChcdBPyK4MoHtsIN699ZH+k7zplBde78=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2046LYEA128806
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jan 2022 00:21:34 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 4
 Jan 2022 00:21:34 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 4 Jan 2022 00:21:34 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2046LXO8100186;
        Tue, 4 Jan 2022 00:21:34 -0600
Date:   Tue, 4 Jan 2022 11:51:33 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH v5 03/14] media: cadence: csi2rx: Add get_fmt and set_fmt
 pad ops
Message-ID: <20220104062131.72exlmnzp6t2xv6o@ti.com>
References: <20211223191615.17803-1-p.yadav@ti.com>
 <20211223191615.17803-4-p.yadav@ti.com>
 <Yc02WlMLA+mafKDo@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yc02WlMLA+mafKDo@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 30/12/21 06:32AM, Laurent Pinchart wrote:
> Hi Pratyush,
> 
> Thank you for the patch.
> 
> On Fri, Dec 24, 2021 at 12:46:04AM +0530, Pratyush Yadav wrote:
> > The format is needed to calculate the link speed for the external DPHY
> > configuration. It is not right to query the format from the source
> > subdev. Add get_fmt and set_fmt pad operations so that the format can be
> > configured and correct bpp be selected.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > 
> > Changes in v5:
> > - Use YUV 1X16 formats instead of 2X8.
> > - New in v5.
> > 
> >  drivers/media/platform/cadence/cdns-csi2rx.c | 137 +++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> > 
> > diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> > index 2547903f2e8e..4a2a5a9d019b 100644
> > --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> > +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> > @@ -54,6 +54,11 @@ enum csi2rx_pads {
> >  	CSI2RX_PAD_MAX,
> >  };
> >  
> > +struct csi2rx_fmt {
> > +	u32				code;
> > +	u8				bpp;
> > +};
> > +
> >  struct csi2rx_priv {
> >  	struct device			*dev;
> >  	unsigned int			count;
> > @@ -79,12 +84,43 @@ struct csi2rx_priv {
> >  	struct v4l2_subdev		subdev;
> >  	struct v4l2_async_notifier	notifier;
> >  	struct media_pad		pads[CSI2RX_PAD_MAX];
> > +	struct v4l2_mbus_framefmt	fmt;
> >  
> >  	/* Remote source */
> >  	struct v4l2_subdev		*source_subdev;
> >  	int				source_pad;
> >  };
> >  
> > +static const struct csi2rx_fmt formats[] = {
> > +	{
> > +		.code	= MEDIA_BUS_FMT_YUYV8_1X16,
> > +		.bpp	= 16,
> > +	},
> > +	{
> > +		.code	= MEDIA_BUS_FMT_UYVY8_1X16,
> > +		.bpp	= 16,
> > +	},
> > +	{
> > +		.code	= MEDIA_BUS_FMT_YVYU8_1X16,
> > +		.bpp	= 16,
> > +	},
> > +	{
> > +		.code	= MEDIA_BUS_FMT_VYUY8_1X16,
> > +		.bpp	= 16,
> > +	},
> > +};
> 
> bpp isn't used. Unless you need it in a subsequent patch in the series,
> you can turn the formats array into a u32 array.

It is used in the next patch for calculating DPHY parameters.

> 
> > +
> > +static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(formats); i++)
> > +		if (formats[i].code == code)
> > +			return &formats[i];
> > +
> > +	return NULL;
> > +}
> > +
> >  static inline
> >  struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
> >  {
> > @@ -236,12 +272,109 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
> >  	return ret;
> >  }
> >  
> > +static struct v4l2_mbus_framefmt *
> > +csi2rx_get_pad_format(struct csi2rx_priv *csi2rx,
> > +		      struct v4l2_subdev_state *state,
> > +		      unsigned int pad, u32 which)
> > +{
> > +	switch (which) {
> > +	case V4L2_SUBDEV_FORMAT_TRY:
> > +		return v4l2_subdev_get_try_format(&csi2rx->subdev, state, pad);
> > +	case V4L2_SUBDEV_FORMAT_ACTIVE:
> > +		return &csi2rx->fmt;
> > +	default:
> > +		return NULL;
> > +	}
> > +}
> > +
> > +static int csi2rx_get_fmt(struct v4l2_subdev *subdev,
> > +			  struct v4l2_subdev_state *state,
> > +			  struct v4l2_subdev_format *format)
> > +{
> > +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> > +	struct v4l2_mbus_framefmt *framefmt;
> > +
> > +	mutex_lock(&csi2rx->lock);
> > +
> > +	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
> > +					 format->which);
> > +	mutex_unlock(&csi2rx->lock);
> > +
> > +	if (!framefmt)
> > +		return -EINVAL;
> 
> This can't happen, you can drop the check.

The function returns NULL when format->which is neither 
V4L2_SUBDEV_FORMAT_TRY nor V4L2_SUBDEV_FORMAT_ACTIVE. Does V4L2 core 
verify that which is always one of TRY or ACTIVE, and nothing else. Does 
it also guarantee that this would *never* change (like adding a new 
value for example)? If so, I am fine with dropping this check. Otherwise 
I would like to keep it.

> 
> > +
> > +	format->format = *framefmt;
> 
> This is the assignment that needs to be protected by the lock.
> csi2rx_get_pad_format() returns a pointer to the storage, it doesn't
> modify it.
> 
> 	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
> 					 format->which);
> 
> 	mutex_lock(&csi2rx->lock);
> 	format->format = *framefmt;
> 	mutex_unlock(&csi2rx->lock);

Ah, you're right. I feel very stupid now ;-)

> 
> Same comments for csi2rx_set_fmt().

The assignment is csi2rx_set_fmt() is done under the lock. But I should 
move the lock to after csi2rx_get_pad_format() is called so we only hold 
the lock for as little as possible:

	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
					 format->which);
	if (!framefmt) {
		mutex_unlock(&csi2rx->lock);
		return -EINVAL;
	}

	mutex_lock(&csi2rx->lock);
	*framefmt = format->format;
	mutex_unlock(&csi2rx->lock);


> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
> > +			  struct v4l2_subdev_state *state,
> > +			  struct v4l2_subdev_format *format)
> > +{
> > +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> > +	struct v4l2_mbus_framefmt *framefmt;
> > +	const struct csi2rx_fmt *fmt;
> > +
> > +	/* No transcoding, source and sink formats must match. */
> > +	if (format->pad != CSI2RX_PAD_SINK)
> > +		return csi2rx_get_fmt(subdev, state, format);
> > +
> > +	fmt = csi2rx_get_fmt_by_code(format->format.code);
> > +	if (!fmt)
> > +		return -EOPNOTSUPP;
> 
> This should not return an error, but instead adjust the code:
> 
> 	if (!csi2rx_get_fmt_by_code(format->format.code))
> 		format->format.code = formats[0].code;

Ok. I figured it would be better to fail loudly if an unsupported format 
is requested. But if this behavior is preferred that is also fine.

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
