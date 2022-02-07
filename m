Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE04AB85F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353186AbiBGKJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245372AbiBGKBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:01:47 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B43AC043181;
        Mon,  7 Feb 2022 02:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644228106; x=1675764106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OLBk8VmXYB8jx7aVY5Bxh1lSXhO4OOTwnhTpzDJBWAE=;
  b=RcDjGY1HjM+vqyW9NxHirDB4DPkjTqf9JZ1TxJzOeO1Oq7wm+e0ddYy2
   FtMh3ipCTRnsca1VLe1LXs+irOVbqKqASlabK0XsU41hgJrjWPHB7UncA
   HtsTa9oswj/E9t6Rg8q7w4nglKFRp6wHKBKot/5/yIFSXLYuz3AQC1bBb
   EQhHKcPt1ouh8SnZzYWTE4ODz1mXWoGR3akHYHY5uVpxvLBsKWvTYk9Z4
   bIfdA/UUNGj2sEnjRty4Z/Swhjm2uEv1O6i8mdO3uzde4NCCoD/bdWPSx
   0NNMlNnWL5Py/b7zh10fqTn/THfEmI8h9QyBqtAnwxvK3JgPf23XIMoNK
   A==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21928203"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Feb 2022 11:01:44 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Feb 2022 11:01:44 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Feb 2022 11:01:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644228104; x=1675764104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OLBk8VmXYB8jx7aVY5Bxh1lSXhO4OOTwnhTpzDJBWAE=;
  b=hTq700xWMAQBrKds3eG6S/ofOq0kY7Hqgbbp7K74N89UweNr1HkEiEei
   MMKBPzuDWVtEH+my1B3XVis0zemDUPfd6H+89WWDI0xsY5arHrdHFTnG4
   Gw9lSsvRJvPt4WSRRkcbQjEhoWefIbaLIYwskJTB17rapdRCvKnEpMqXe
   f2JW/SdllrNPxBqeBum+DpzEQrsZolbscI1J5kL9+gVw0kmXp70Va5fLp
   XZX0mcl8XTEGSclphQogOnwtqVFp7F8YCTsDbYU43zbGxy68gmDuCcAP6
   7qUlOuDuqWs5+eqHMYx33267YejIonEwIGLbsydlpJIfBpktDpGdS8bwc
   A==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21928202"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Feb 2022 11:01:44 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2F966280065;
        Mon,  7 Feb 2022 11:01:44 +0100 (CET)
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
Subject: Re: (EXT) Re: [PATCH 6/8] media: imx: imx7_media-csi: Add support for additional Bayer patterns
Date:   Mon, 07 Feb 2022 11:01:43 +0100
Message-ID: <3473889.R56niFO833@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Yf3xni8i4AAOZ7HF@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com> <20220204121514.2762676-7-alexander.stein@ew.tq-group.com> <Yf3xni8i4AAOZ7HF@pendragon.ideasonboard.com>
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

Am Samstag, 5. Februar 2022, 04:40:14 CET schrieb Laurent Pinchart:
> Hi Alexander,
> 
> Thank you for the patch.
> 
> On Fri, Feb 04, 2022 at 01:15:12PM +0100, Alexander Stein wrote:
> > imx7_csi_configure() allows configuring these Bayer patterns when
> > starting a stream. So allow these in link_validate() as well.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> > I'm wondering if V4L2_PIX_FMT_SBGGR16 (and their variants) is correct in
> > this function. imx7_csi_configure() does not list
> > MEDIA_BUS_FMT_Sxxxx16_1X16. Also I can't find a proper a proper setting
> > in CSI_CR18 of CSI Bridge in IMX8M Mini RM for RAW16. The feature list
> > names a  "16-bit data port for Bayer data input", but is it actually
> > supported? I do not know anything about the MIPI CSI data formats though.
> > Maybe someone else can clarify this.
> The CSI bridge has a 16-bit input. The MIPI_DATA_FORMAT field in CR18
> maps to the CSI-2 DT value, and it's not clear if it's only used to
> filter on the CSI-2 DT, or if it does more than that. If we're lucky,
> it's the former and we can just use 0x2e.

Well, 0x2e is not listed as a valid value for MIPI_DATA_FORMAT in both i.MX7D 
RM Rev1 and i.MX8M Mini RM Rev 3. So I'm not so sure about that. Maybe this 
holds true for other devices as well. I can not test RAW16 anyway, so I just 
wanted to raise a possible issue here.

Regards,
Alexander

> 
> >  drivers/staging/media/imx/imx7-media-csi.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/staging/media/imx/imx7-media-csi.c
> > b/drivers/staging/media/imx/imx7-media-csi.c index
> > 158d2a736c6d..7e737221f187 100644
> > --- a/drivers/staging/media/imx/imx7-media-csi.c
> > +++ b/drivers/staging/media/imx/imx7-media-csi.c
> > @@ -1004,6 +1004,18 @@ static int imx7_csi_pad_link_validate(struct
> > v4l2_subdev *sd,> 
> >  	case V4L2_PIX_FMT_SGBRG8:
> >  	case V4L2_PIX_FMT_SGRBG8:
> > 
> >  	case V4L2_PIX_FMT_SRGGB8:
> > +	case V4L2_PIX_FMT_SBGGR10:
> > +	case V4L2_PIX_FMT_SGBRG10:
> > +	case V4L2_PIX_FMT_SGRBG10:
> > +	case V4L2_PIX_FMT_SRGGB10:
> > +	case V4L2_PIX_FMT_SBGGR12:
> > +	case V4L2_PIX_FMT_SGBRG12:
> > +	case V4L2_PIX_FMT_SGRBG12:
> > +	case V4L2_PIX_FMT_SRGGB12:
> > +	case V4L2_PIX_FMT_SBGGR14:
> > +	case V4L2_PIX_FMT_SGBRG14:
> > +	case V4L2_PIX_FMT_SGRBG14:
> > 
> > +	case V4L2_PIX_FMT_SRGGB14:
> >  	case V4L2_PIX_FMT_SBGGR16:
> >  	case V4L2_PIX_FMT_SGBRG16:
> >  	case V4L2_PIX_FMT_SGRBG16:




