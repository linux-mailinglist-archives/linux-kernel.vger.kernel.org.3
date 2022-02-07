Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7420E4ABEE5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448576AbiBGNMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442370AbiBGMU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:20:56 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE3C02B5C7;
        Mon,  7 Feb 2022 04:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644235704; x=1675771704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/q6pkb+TA7cRlY6xlVOjKQ4P8DeARpuUdX/+csSvX4=;
  b=VhWW5VlJ+Ij0r7HYtTC7rtGoKQ80lzJSEyGJkhlN9s4/ycNR8STGrIxU
   7wm/M/2AwBtRT56MJyShkV1MCFn7pF3pSvpNXez/h6WCJa0v1ncHg3PhD
   dFmkHn9+X3pR0b11b7TghBjo5GaIBUE4jEGRGogQHHzHFjHYWlyo7VC+Q
   y0wdhQYSXKasobHKSbbu28Yvs5xuN9Zol0lkUq9qQtpy1YiYdDXgq6LFd
   3eg74SNkk0pnzuxMNv3eTVjbi08RZo7+7OR1XFpP2jDG2mt80Z+TALENA
   Nt1dn5pc58mbxQXES4PXzoU3zMWMXaxa2naTIsaoyhdgJh0Yys+vNqjJH
   g==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21932193"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Feb 2022 13:08:22 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Feb 2022 13:08:22 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Feb 2022 13:08:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644235702; x=1675771702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/q6pkb+TA7cRlY6xlVOjKQ4P8DeARpuUdX/+csSvX4=;
  b=R0fUFWOdFK8b/66rT4bIyhvoxx1Q9eS3yMCico9uy5oOjZcwpvbe3rJo
   yudGubxUWLbksbDBdikkQeOl59h9G8PHjwKyoqUyMTVia/RTXNTTDBhZ+
   k3aKu3m7c3nljibsBMdpQQw/Gp9qE2d+ddYPj9IsXXUmQFIhtPAIwcKn9
   otPfVvG1BPDeWlwqLtB8V5ORdujtn7bxEqCA912EUi6eoJmogVGRqdF41
   E2bKKC8DgSrG6nRyUW2uKJbAaowxqPJvxmLKRhiaXGBHh15MazRU6aoTr
   icrdmshwsanwU4zaVZiQF6/B3Y2h7RVQU+dTFmByH8guu4S32pt0nQhKh
   A==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21932192"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Feb 2022 13:08:22 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DE334280065;
        Mon,  7 Feb 2022 13:08:21 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH 3/8] media: imx: Use dedicated format handler for i.MX7/8
Date:   Mon, 07 Feb 2022 13:08:21 +0100
Message-ID: <4044945.1IzOArtZ34@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Yf33YviITGDnolHw@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com> <20220204121514.2762676-4-alexander.stein@ew.tq-group.com> <Yf33YviITGDnolHw@pendragon.ideasonboard.com>
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

Hi Laurent,

Am Samstag, 5. Februar 2022, 05:04:50 CET schrieb Laurent Pinchart:
> Hi Alexander and Dorota,
> 
> Thank you for the patch.
> 
> On Fri, Feb 04, 2022 at 01:15:09PM +0100, Alexander Stein wrote:
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
> > Changes in comparison to original commit from Dorota:
> > * is_imx56 is used instead of enum
> > 
> >  drivers/staging/media/imx/imx-media-utils.c | 56 +++++++++++++++++++--
> >  1 file changed, 52 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/media/imx/imx-media-utils.c
> > b/drivers/staging/media/imx/imx-media-utils.c index
> > 0daa6aad45f4..32aaa2e81bea 100644
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
> > -				  bool is_imx56)
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
> > @@ -568,6 +567,55 @@ int imx_media_mbus_fmt_to_pix_fmt(struct
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
> > +	 */
> > +	ret = v4l2_fill_pixfmt(pix, cc->fourcc,
> > +			       round_up(mbus->width, 4), mbus-
>height);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Only 8bits-per-pixel formats may need to get aligned to 8 
pixels,
> > +	 * because both 10-bit and 16-bit pixels occupy 2 bytes.
> > +	 * In those, 4-pixel aligmnent is equal to 8-byte alignment.
> > +	 */
> > +	if (pix->sizeimage % 8 != 0)
> > +		ret = v4l2_fill_pixfmt(pix, cc->fourcc,
> > +				       round_up(mbus->width, 8), 
mbus->height);
> 
> I think you could simplify this by using cc->bpp to figure out the
> alignment instead of calling v4l2_fill_pixfmt() twice.

Yeah, this should be possible. I can't test it (yet) though, I don't have a 8-
Bit sensor. Will do in the next version.

> > +	pix->colorspace = mbus->colorspace;
> > +	pix->xfer_func = mbus->xfer_func;
> > +	pix->ycbcr_enc = mbus->ycbcr_enc;
> > +	pix->quantization = mbus->quantization;
> > +	pix->field = mbus->field;
> 
> Should v4l2_fill_pixfmt() be updated to handle colorspace and field too
> instead of doing it manually here ?

I'm not so sure which parts of v4l2_pix_format shall be set into 
v4l2_fill_pixfmt(). Unfortunately there is no API description in the header, 
git log doesn't help much either. In the end this should be a separate patch.

Best regards,
Alexander

> > +
> > +	return ret;
> > +}
> > +
> > +int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> > +				  const struct v4l2_mbus_framefmt 
*mbus,
> > +				  const struct imx_media_pixfmt 
*cc,
> > +				  bool is_imx56)
> > +{
> > +	if (is_imx56)
> > +		return imx56_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
> > +	else
> > +		return imx78_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
> > +}
> > 
> >  EXPORT_SYMBOL_GPL(imx_media_mbus_fmt_to_pix_fmt);
> >  
> >  void imx_media_free_dma_buf(struct device *dev,




