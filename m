Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035595423B5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378325AbiFHBxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582832AbiFGXpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:45:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD286441602
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:04:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u12so37879608eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mv0VwaBbJj5t97Zb21xM6IYXGG5Qm9K6yXJwCzABay4=;
        b=M5PMNwLa8MyWdKLku4+ic9U3z6Gzqi2oHEIJzOSX0fOBoSLwESMbYf3VdzSDsY0HRU
         KXU7Z6vAgsqRCgttm4N21Lmp4UlmYr1l7ab/UZXTLAAG0Ot2yVbF1r2HkjVTmDGn0wBe
         1Wi8eQRzbPu0npYC3f1+J+mfKv1U+Pw8KTE6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mv0VwaBbJj5t97Zb21xM6IYXGG5Qm9K6yXJwCzABay4=;
        b=nghbtUzdvAHMPr0LdkchGHMYVqn2iBPEbZ9OniM/sEBfS7yTtB+7WAy55Nx9C9o43R
         2msGIRoXQFYlUIjy99nOnGMeVtcg+xa/51CMP9zZZXC3c7aLItXc09Ft4dClVA4dKi5P
         sPm9KOWR9+kzBWRxfMrI52bkSToFdstZlzaFYtgn8RClGmjBsExjHK6oF8TOZqCcGHtS
         3DccvyrCnbPfRqLkBmZxcpEyFyr3zBEoOrZ3vMVA3NydOMXAySXqGd0zIf05F7fzC0TE
         /u75T+uHbuSI/A3i+BL6BDJx3BziRRWgoFiHfn2+ZNYz5j+3Gf3KDALYmdbc/RnSw/Mi
         U0xQ==
X-Gm-Message-State: AOAM530JcpnjmU99aBL1CdxA7NgOLqC4CygZ/Ex1BTSwFoyhSjLgY6+v
        p9HdwyEv/zggBwYiNU1bgDOWqQ==
X-Google-Smtp-Source: ABdhPJySmOlt1DiJL18YR0Iqm0CEb1p42z/gKFMZ23iiK2MQtRnEUG+beEIRNfSYdLOPqnK6H0FZ1g==
X-Received: by 2002:a17:907:608f:b0:6f6:1155:99ab with SMTP id ht15-20020a170907608f00b006f6115599abmr27960400ejc.306.1654639448414;
        Tue, 07 Jun 2022 15:04:08 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-2-39-143-183.cust.vodafonedsl.it. [2.39.143.183])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906829800b0070f7d1c5a18sm5660359ejx.55.2022.06.07.15.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 15:04:07 -0700 (PDT)
Date:   Wed, 8 Jun 2022 00:04:05 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, shawnx.tu@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v6 4/4] media: i2c: ov5675: add .get_selection support
Message-ID: <20220607220405.GB821506@tom-ThinkPad-T14s-Gen-2i>
References: <20220607153335.875956-1-foss+kernel@0leil.net>
 <20220607153335.875956-4-foss+kernel@0leil.net>
 <20220607165136.bmriu2n7yorc7fx6@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607165136.bmriu2n7yorc7fx6@uno.localdomain>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin/Jacopo,

On Tue, Jun 07, 2022 at 06:51:36PM +0200, Jacopo Mondi wrote:
> Hi Quentin,
> 
> On Tue, Jun 07, 2022 at 05:33:35PM +0200, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >
> > The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
> > pixels and there are an additional 24 black rows "at the bottom".
> >
> >                      [2624]
> >         +-----+------------------+-----+
> >         |     |     16 dummy     |     |
> >         +-----+------------------+-----+
> >         |     |                  |     |
> >         |     |     [2592]       |     |
> >         |     |                  |     |
> >         |16   |      valid       | 16  |[2000]
> >         |dummy|                  |dummy|
> >         |     |            [1944]|     |
> >         |     |                  |     |
> >         +-----+------------------+-----+
> >         |     |     16 dummy     |     |
> >         +-----+------------------+-----+
> >         |     |  24 black lines  |     |
> >         +-----+------------------+-----+
> >
> > The top-left coordinate is gotten from the registers specified in the
> > modes which are identical for both currently supported modes.
> >
> > There are currently two modes supported by this driver: 2592*1944 and
> > 1296*972. The second mode is obtained thanks to subsampling while
> > keeping the same field of view (FoV). No cropping involved, hence the
> > harcoded values.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > ---
> >
> > v6:
> >  - explicit a bit more the commit log around subsampling for lower
> >  resolution modes,
> >  - (again) fixed reporting for V4L2_SEL_TGT_CROP_* thanks to Jacopo's help,
> >
> > v4:
> >  - explicit a bit more the commit log,
> >  - added drawing in the commit log,
> >  - fixed reporting for V4L2_SEL_TGT_CROP_* thanks to Jacopo's help,
> >
> > added in v3
> >
> >  drivers/media/i2c/ov5675.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
> > index 80840ad7bbb0..2230ff47ef49 100644
> > --- a/drivers/media/i2c/ov5675.c
> > +++ b/drivers/media/i2c/ov5675.c
> > @@ -1121,6 +1121,26 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
> >  	return 0;
> >  }
> >
> > +static int ov5675_get_selection(struct v4l2_subdev *sd,
> > +				struct v4l2_subdev_state *state,
> > +				struct v4l2_subdev_selection *sel)
> > +{
> > +	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> > +		return -EINVAL;
> > +
> > +	switch (sel->target) {
> > +	case V4L2_SEL_TGT_CROP:
> > +	case V4L2_SEL_TGT_CROP_BOUNDS:
> 
> Seem like we have trouble understanding each other, or better, I have
> troubles explaining myself most probably :)
> 
> If the dummy/black area is readable, this should just be (0, 0, 2624,
> 2000) like it was in your previous version. What has changed that I
> have missed ?

Taking as reference drivers/media/i2c/ov5693.c and others,
seems ok what Quentin have done from my side.

Just one thing: maybe is better to avoid magic numbers with more
explicit defines like:

 + case V4L2_SEL_TGT_CROP_DEFAULT:
 +           sel->r.top = OV5675_ACTIVE_START_TOP;
 +           sel->r.left = OV5693_ACTIVE_START_LEFT;
 +           sel->r.width = OV5693_ACTIVE_WIDTH;
 +           sel->r.height = OV5693_ACTIVE_HEIGHT;
 
What do you think about?

Thanks,
Tommaso


> 
> Thanks
>   j
> 
> 
> > +	case V4L2_SEL_TGT_CROP_DEFAULT:
> > +		sel->r.top = 16;
> > +		sel->r.left = 16;
> > +		sel->r.width = 2592;
> > +		sel->r.height = 1944;
> > +		return 0;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> >  static int ov5675_enum_mbus_code(struct v4l2_subdev *sd,
> >  				 struct v4l2_subdev_state *sd_state,
> >  				 struct v4l2_subdev_mbus_code_enum *code)
> > @@ -1170,6 +1190,7 @@ static const struct v4l2_subdev_video_ops ov5675_video_ops = {
> >  static const struct v4l2_subdev_pad_ops ov5675_pad_ops = {
> >  	.set_fmt = ov5675_set_format,
> >  	.get_fmt = ov5675_get_format,
> > +	.get_selection = ov5675_get_selection,
> >  	.enum_mbus_code = ov5675_enum_mbus_code,
> >  	.enum_frame_size = ov5675_enum_frame_size,
> >  };
> > --
> > 2.36.1
> >

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
