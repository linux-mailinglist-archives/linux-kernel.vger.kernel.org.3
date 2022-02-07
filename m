Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56684AB86B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352017AbiBGKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354107AbiBGJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:52:07 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433FAC0401C4;
        Mon,  7 Feb 2022 01:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644227525; x=1675763525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FPQnUq0e72L30wi5D99t86LFMH3DYM0+N8zdE+KfywE=;
  b=FS+fTRURvOMbq2OoKsDcTRDEju+Bg78KUBEdj/yVELzLqhpYQMT+xKpL
   TN2+EDKSITuK0juA289YVnKP5JY+5ocRIi1BVIxBtefuA/e6YTjlPxgJ8
   wWMvO7ISVhzABfcp1R8+QSg/vSv3sSd704RygaZMwWNIt/6CKV1xtMgLW
   wlrjZCZOdVU/dIjyhWcuys4SVDZCt5QFAJ+DKrQFvELbCpuc5e7gY10O6
   jnsKR99xnm5H7/9hipJhfAiaooIcIq6GmhKjcqjakpn+JCaFLWo7Ff5x3
   utlH/t0RnkBua3gvaswmbzF2otaAt38LfMZRathoiAvo7MnxyZJzsZqfl
   A==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21927829"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Feb 2022 10:52:03 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Feb 2022 10:52:03 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Feb 2022 10:52:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644227523; x=1675763523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FPQnUq0e72L30wi5D99t86LFMH3DYM0+N8zdE+KfywE=;
  b=L9Ra29dMDhwbndddw/0Zxk/VF6Vy3qykG9iw5HVnPBLOkPVuAwsnOlo7
   z1CXqNFSX+vp+7ZAWxPH5p7DxHOCg/hnG0ry8tffCXuipPWuthea466hv
   Z9HiEbcAAHMsrmr8/cvct6CDZvtt/v/vTytSv8PM76w3+2nHqgddcorlg
   h85WhW5CKoF6SLL631BeIcwiIWeplJ8ySW4H9b7Jf2kW+cgmqbVZuo6hw
   ERMEXO6fYVGfcTq8PznAvVV6n2fNE8oXRkygcW1Q98LhcFarpqdcpYA/n
   INIoXZRC5B86ROSgOMAnZUhr1J8q3R9f5zH81xSXxIHjeA8RDgwghtII7
   w==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="21927828"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Feb 2022 10:52:03 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2696E280065;
        Mon,  7 Feb 2022 10:52:03 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
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
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH 4/8] media: imx: Fail conversion if pixel format not supported
Date:   Mon, 07 Feb 2022 10:52:00 +0100
Message-ID: <1905895.usQuhbGJ8B@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220205085151.61088d8e.dorota.czaplejewicz@puri.sm>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com> <Yf34CXvZQPQPAxma@pendragon.ideasonboard.com> <20220205085151.61088d8e.dorota.czaplejewicz@puri.sm>
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

Hi Laurent and Dorota,

Am Samstag, 5. Februar 2022, 08:51:51 CET schrieb Dorota Czaplejewicz:
> * PGP Signed by an unknown key
> 
> Hi Laurent,
> 
> On Sat, 5 Feb 2022 06:07:37 +0200
> 
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> > Hi Alexander and Dorota,
> > 
> > Thank you for the patch.
> > 
> > On Fri, Feb 04, 2022 at 01:15:10PM +0100, Alexander Stein wrote:
> > > From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > > 
> > > imx_media_find_mbus_format has NULL as a valid return value,
> > > therefore the caller should take it into account.
> > > 
> > > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > > 
> > >  drivers/staging/media/imx/imx-media-utils.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/staging/media/imx/imx-media-utils.c
> > > b/drivers/staging/media/imx/imx-media-utils.c index
> > > 32aaa2e81bea..e0a256a08c3b 100644
> > > --- a/drivers/staging/media/imx/imx-media-utils.c
> > > +++ b/drivers/staging/media/imx/imx-media-utils.c
> > > @@ -544,6 +544,9 @@ static int imx56_media_mbus_fmt_to_pix_fmt(struct
> > > v4l2_pix_format *pix,> > 
> > >  		cc = imx_media_find_mbus_format(code, PIXFMT_SEL_YUV);
> > 
> > The code passed to the function comes from the previous line:
> > 	imx_media_enum_mbus_formats(&code, 0, PIXFMT_SEL_YUV);
> > 
> > As far as I can tell, this is guaranteed to return a code that will
> > result in imx_media_find_mbus_format() returning a non-NULL pointer.
> 
> While I am not well-versed in the implicit code style of the kernel, I
> decided to leave it in because it makes the code more locally legible. With
> a check here, even a non-functional one, there's no need to understand the
> internals of `imx_media_find_mbus_format` that are only implicit. That
> makes the code less surprising when interested only in the outer function.
> 
> The other advantage of a check is becoming robust against future changes to
> `imx_media_find_mbus_format` itself.
> 
> I don't have a strong preference about keeping or leaving this patch, but if
> this check was there in the first place, I wouldn't have spent time trying
> to figure out whether there's a bug here.

Laurent, thanks for your feedback.
I'm on Dorota's side here. While you are right that the code from 
  imx_media_enum_mbus_formats(&code, 0, PIXFMT_SEL_YUV);
is guaranteed to return something. I don't lnek this implicit assumption over 
2 function calls. Better be safe than sorry. For that reason code should be 
initialized as well. Will create a patch for that.

Regards,
Alexander



