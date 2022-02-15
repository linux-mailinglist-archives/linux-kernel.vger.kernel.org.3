Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FF24B645A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiBOH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:29:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiBOH3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:29:49 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0967106119;
        Mon, 14 Feb 2022 23:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644910179; x=1676446179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CuEMJmA9h+m8AulyGOrOUYh21nJq6vCzLpq25JW9MGY=;
  b=PggtTNd3ECDDLPLteUPIP21inIQjSUQqwxu1O9BVPX+ZBzfX1vkfiU90
   91yf9rePwHw7WN5L6MeseB5HGMErDJmweBzKVZeBWJh5CSTzU4omuCDej
   vPhN63rrDS80fH9tbviJm3fsLGls3ze7No58HBYdy8fTQNHK2s0nED+Zr
   JZLgnTP5IJQZojRSNis6NOMoEg7c4c9s6POuCHxumrSHv8MTX0c5EFDeB
   /3nIjoeIvcEbkYCT82TWF0llevGQ+fH/YnXs23VE1jXwTA06JheEPpCgV
   UYjzTBbNg8ONTIwnbRHPgFXCKMrMrQLnOnL7A1reWbB80lSuoIoKHA2ZJ
   A==;
X-IronPort-AV: E=Sophos;i="5.88,370,1635199200"; 
   d="scan'208";a="22084228"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Feb 2022 08:29:36 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 15 Feb 2022 08:29:37 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 15 Feb 2022 08:29:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644910177; x=1676446177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CuEMJmA9h+m8AulyGOrOUYh21nJq6vCzLpq25JW9MGY=;
  b=NnEhC4bCVVDumb+pGTmdZRYWByzP/B27Mu1AMUUYsTc/5crugdps+lPy
   4050OLmwNyYApFAJE4+QBybBwy4kamAUAs0om8v2DOKbY9Ru5c0QN34Tq
   ej2laN9Dm6Eaf5vhvQMQPFFpcHnQ/7l6G/Ye5eznu899Sqi8MTgX3CEnp
   4dJn8uMCZol6DA6VE+2qZHlyTw0Xegt2UUJHNEXpxY+lVXRDuK6VWq/gr
   bd3Gwef0iRmPBxO30AUwzr4//i1E4qB9SpBEBjuIg5bN838cdne5KCYvS
   GbK7p2c3Us2ADo+ynXsp7kQKEMQGy0yrUgWqG8chZe9+fv+ZnExrIxQkP
   A==;
X-IronPort-AV: E=Sophos;i="5.88,370,1635199200"; 
   d="scan'208";a="22084227"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Feb 2022 08:29:36 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 97C3B280065;
        Tue, 15 Feb 2022 08:29:36 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH v2 3/9] media: imx: Use dedicated format handler for i.MX7/8
Date:   Tue, 15 Feb 2022 08:29:34 +0100
Message-ID: <2319937.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220214185115.y3rdxyvi7dmupeye@uno.localdomain>
References: <20220211142752.779952-1-alexander.stein@ew.tq-group.com> <20220211142752.779952-4-alexander.stein@ew.tq-group.com> <20220214185115.y3rdxyvi7dmupeye@uno.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Am Montag, 14. Februar 2022, 19:51:15 CET schrieb Jacopo Mondi:
> Hello
> 
> On Fri, Feb 11, 2022 at 03:27:46PM +0100, Alexander Stein wrote:
> > From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > 
> > This splits out a format handler which takes into account
> > the capabilities of the i.MX7/8 video device,
> > as opposed to the default handler compatible with both i.MX5/6 and
> > i.MX7/8.
> > 
> > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > Changes in v2:
> > * Switch back to using enum
> > * Get rid of an additional call to v4l2_fill_pixfmt()
> > 
> >  drivers/staging/media/imx/imx-media-utils.c | 60 +++++++++++++++++++--
> >  1 file changed, 56 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/media/imx/imx-media-utils.c
> > b/drivers/staging/media/imx/imx-media-utils.c index
> > c42f3da8e3a8..02a4cb124d37 100644
> > --- a/drivers/staging/media/imx/imx-media-utils.c
> > +++ b/drivers/staging/media/imx/imx-media-utils.c
> > @@ -516,10 +516,9 @@ void imx_media_try_colorimetry(struct
> > v4l2_mbus_framefmt *tryfmt,> 
> >  }
> >  EXPORT_SYMBOL_GPL(imx_media_try_colorimetry);
> > 
> > -int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> > -				  const struct v4l2_mbus_framefmt 
*mbus,
> > -				  const struct imx_media_pixfmt 
*cc,
> > -				  enum imx_media_device_type type)
> > +static int imx56_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> > +					   const struct 
v4l2_mbus_framefmt *mbus,
> > +					   const struct 
imx_media_pixfmt *cc)
> > 
> >  {
> >  
> >  	u32 width;
> >  	u32 stride;
> > 
> > @@ -568,6 +567,59 @@ int imx_media_mbus_fmt_to_pix_fmt(struct
> > v4l2_pix_format *pix,> 
> >  	return 0;
> >  
> >  }
> > 
> > +
> > +static int imx78_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> > +					   const struct 
v4l2_mbus_framefmt *mbus,
> > +					   const struct 
imx_media_pixfmt *cc)
> > +{
> > +	u32 aligned_width;
> > +	int ret;
> > +
> > +	if (!cc)
> > +		cc = imx_media_find_mbus_format(mbus->code, 
PIXFMT_SEL_ANY);
> > +
> > +	if (!cc)
> > +		return -EINVAL;
> > +	/*
> > +	 * The hardware can handle line lengths divisible by 4 pixels
> > +	 * as long as the whole buffer size ends up divisible by 8 bytes.
> > +	 * If not, use the value of 8 pixels recommended in the datasheet.
> > +	 * Only 8bits-per-pixel formats may need to get aligned to 8 
pixels,
> > +	 * because both 10-bit and 16-bit pixels occupy 2 bytes.
> > +	 * In those, 4-pixel aligmnent is equal to 8-byte alignment.
> > +	 */
> > +	if (cc->bpp == 1)
> 
> Am I mistaken or in the format enumeration bpp is expressed in bits
> and not bytes ?

No, you are completely right. Thanks for find noticing that.

Regards,
Alexander

> > +		aligned_width = round_up(mbus->width, 8);
> > +	else
> > +		aligned_width = round_up(mbus->width, 4);
> > +
> > +	ret = v4l2_fill_pixfmt(pix, cc->fourcc,
> > +			       aligned_width, mbus->height);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pix->colorspace = mbus->colorspace;
> > +	pix->xfer_func = mbus->xfer_func;
> > +	pix->ycbcr_enc = mbus->ycbcr_enc;
> > +	pix->quantization = mbus->quantization;
> > +	pix->field = mbus->field;
> > +
> > +	return ret;
> > +}
> > +
> > +int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> > +				  const struct v4l2_mbus_framefmt 
*mbus,
> > +				  const struct imx_media_pixfmt 
*cc,
> > +				  enum imx_media_device_type type)
> > +{
> > +	switch (type) {
> > +	case DEVICE_TYPE_IMX56:
> > +		return imx56_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
> > +	case DEVICE_TYPE_IMX78:
> > +		return imx78_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
> > +	}
> > +	return -EINVAL;
> > +}
> > 
> >  EXPORT_SYMBOL_GPL(imx_media_mbus_fmt_to_pix_fmt);
> >  
> >  void imx_media_free_dma_buf(struct device *dev,
> > 
> > --
> > 2.25.1




