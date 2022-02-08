Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC74ACDEB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbiBHBWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243428AbiBHBVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:21:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D71E038A59;
        Mon,  7 Feb 2022 17:15:24 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 02A60340;
        Tue,  8 Feb 2022 02:14:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644282900;
        bh=blvBN8apDdKJGfvkuQRdzEoFeeraC+PwppRok6BR2Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G43PehzyokojQcX2wngd0xQ2hpShQbkk+sdysXF9nIvq9IeVUZvELzCr6NUwTkdL7
         Z/mtgc3Vq4BH5ryF70FJonQVUVesvtOdgJ448B616j1cIG0kV/hSospSUs/QHAvpto
         XBQ2Pvc86H7sQo3oVpVgtTkVBeW2jicD2Hq6axps=
Date:   Tue, 8 Feb 2022 03:14:57 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH 4/8] media: imx: Fail conversion if pixel
 format not supported
Message-ID: <YgHEEa4WhXmThiX0@pendragon.ideasonboard.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
 <Yf34CXvZQPQPAxma@pendragon.ideasonboard.com>
 <20220205085151.61088d8e.dorota.czaplejewicz@puri.sm>
 <1905895.usQuhbGJ8B@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1905895.usQuhbGJ8B@steina-w>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Feb 07, 2022 at 10:52:00AM +0100, Alexander Stein wrote:
> Am Samstag, 5. Februar 2022, 08:51:51 CET schrieb Dorota Czaplejewicz:
> > On Sat, 5 Feb 2022 06:07:37 +0200 Laurent Pinchart wrote:
> > > On Fri, Feb 04, 2022 at 01:15:10PM +0100, Alexander Stein wrote:
> > > > From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > > > 
> > > > imx_media_find_mbus_format has NULL as a valid return value,
> > > > therefore the caller should take it into account.
> > > > 
> > > > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > ---
> > > > 
> > > >  drivers/staging/media/imx/imx-media-utils.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/staging/media/imx/imx-media-utils.c
> > > > b/drivers/staging/media/imx/imx-media-utils.c index
> > > > 32aaa2e81bea..e0a256a08c3b 100644
> > > > --- a/drivers/staging/media/imx/imx-media-utils.c
> > > > +++ b/drivers/staging/media/imx/imx-media-utils.c
> > > > @@ -544,6 +544,9 @@ static int imx56_media_mbus_fmt_to_pix_fmt(struct
> > > > v4l2_pix_format *pix,> > 
> > > >  		cc = imx_media_find_mbus_format(code, PIXFMT_SEL_YUV);
> > > 
> > > The code passed to the function comes from the previous line:
> > > 	imx_media_enum_mbus_formats(&code, 0, PIXFMT_SEL_YUV);
> > > 
> > > As far as I can tell, this is guaranteed to return a code that will
> > > result in imx_media_find_mbus_format() returning a non-NULL pointer.
> > 
> > While I am not well-versed in the implicit code style of the kernel, I
> > decided to leave it in because it makes the code more locally legible. With
> > a check here, even a non-functional one, there's no need to understand the
> > internals of `imx_media_find_mbus_format` that are only implicit. That
> > makes the code less surprising when interested only in the outer function.
> > 
> > The other advantage of a check is becoming robust against future changes to
> > `imx_media_find_mbus_format` itself.
> > 
> > I don't have a strong preference about keeping or leaving this patch, but if
> > this check was there in the first place, I wouldn't have spent time trying
> > to figure out whether there's a bug here.
> 
> Laurent, thanks for your feedback.
> I'm on Dorota's side here. While you are right that the code from 
>   imx_media_enum_mbus_formats(&code, 0, PIXFMT_SEL_YUV);
> is guaranteed to return something. I don't lnek this implicit assumption over 
> 2 function calls. Better be safe than sorry. For that reason code should be 
> initialized as well. Will create a patch for that.

I'm fine with hardening the code even if the issue can't occur at the
moment.

-- 
Regards,

Laurent Pinchart
