Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09E34AB855
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351318AbiBGKJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351004AbiBGJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:55:38 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4889C043188;
        Mon,  7 Feb 2022 01:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644227738; x=1675763738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZVRjRyATxf2Qkee+j9MOy2u+QDZKwKyc2bx88y3hm0=;
  b=OL1lJBJZb9xi8XIXgGWMST9Zs3EBiRSQXhAnLlh2MnDc7DXQDjjXfmFF
   Z0f+XuNT0qRhDXvuK5Q5vM41cx3zHkRsRo/PtxQBGIQoksUlrPhCnrcVE
   cOyXzY4mLbGgDjO+vtOVzP9B6R5u+SfEkrV3JPqHlT2rQDJufP/E+sv4C
   CHT4cDVkLoNzyZsqwNvACc90HlJPAuCn37QJ0chOi0kYnq8RPyfy01dCD
   MyowkI0QNUUkUZicgZQxRWk8LzZZZqoAm96VOsgRM/hE8yV6naflH+41Z
   9MkbXgFEM32RS072i2DvSOfe85pDhoZdZ0vzlT4ZXzrbiXHDGjIJfsZDb
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21927972"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Feb 2022 10:55:35 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Feb 2022 10:55:35 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Feb 2022 10:55:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644227735; x=1675763735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZVRjRyATxf2Qkee+j9MOy2u+QDZKwKyc2bx88y3hm0=;
  b=lbxml+8Wn9Pzsc8pbu6YdlJ4pqaflfVEsVk/UDk89REMBuvD/cP50XUq
   mzkyiaoDX+QZhACO0e6MBTAZB36UgXq6nTYFDb4wmBcTgxShyXiBrWSh6
   zqVAs8Npx/cz57tKRElBvS0ev3Y1wbfS37iyD3Qdmjq0FU0AEBXErpFKg
   JrKqWXL2U4X6dX1QTAGjZNw54k4jDRY2kPkhLjDKYM0v/qe6JebMjdl4R
   FuEsH4Cy94yIBmu+bDDaoHjjeyWtnBKIKT0e45gXnNL6XvweRMRCO10ku
   zd9x6lHhy3PrHis0cx13prilAP1MUcm2KlpX37FRvyp39WYx5oFbzvgvM
   g==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21927971"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Feb 2022 10:55:35 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 930E1280065;
        Mon,  7 Feb 2022 10:55:35 +0100 (CET)
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
Subject: Re: (EXT) Re: [PATCH 5/8] media: imx: imx7_mipi_csis: store colorspace in set_fmt as well
Date:   Mon, 07 Feb 2022 10:55:33 +0100
Message-ID: <22528721.6Emhk5qWAg@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Yf3uZ9fzQ4UM76gs@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com> <20220204121514.2762676-6-alexander.stein@ew.tq-group.com> <Yf3uZ9fzQ4UM76gs@pendragon.ideasonboard.com>
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

Am Samstag, 5. Februar 2022, 04:26:31 CET schrieb Laurent Pinchart:
> Hi Alexander,
> 
> Thank you for the patch.
> 
> On Fri, Feb 04, 2022 at 01:15:11PM +0100, Alexander Stein wrote:
> > Without this the default (SMPTE 170M) from init_cfg stays unchanged.
> > Even after configuring 'srgb' colorspace (or 'raw')
> > $ media-ctl -V "'csis-32e30000.mipi-csi':0 [colorspace:srgb]"
> > the colorspace does not change at all:
> > $ media-ctl --get-v4l2 "'csis-32e30000.mipi-csi':0"
> > 
> >   [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:smpte170m xfer:709
> >   
> >    ycbcr:601 quantization:lim-range]
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > 
> >  drivers/staging/media/imx/imx7-mipi-csis.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c
> > b/drivers/staging/media/imx/imx7-mipi-csis.c index
> > a22d0e6b3d44..7b0e57efcf82 100644
> > --- a/drivers/staging/media/imx/imx7-mipi-csis.c
> > +++ b/drivers/staging/media/imx/imx7-mipi-csis.c
> > @@ -1062,6 +1062,7 @@ static int mipi_csis_set_fmt(struct v4l2_subdev *sd,
> > 
> >  	fmt->code = csis_fmt->code;
> >  	fmt->width = sdformat->format.width;
> >  	fmt->height = sdformat->format.height;
> > 
> > +	fmt->colorspace = sdformat->format.colorspace;
> 
> Looks good, but shouldn't you also store the other colorspace-related
> fields (ycbcr_enc, quantization and xfer_func) ?

Thanks for that feedback. Sounds reasonable, will do that. 

Regards,
Alexander



