Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96A544727
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiFIJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiFIJRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:17:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BA11CB22
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:17:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so30326526edm.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=boCzqqT5TJ09DQSvElsZCM76ABJa0T7dS+o6/tDOxwM=;
        b=mpmOOFscyMqw+GwY/eg9JNVWN0vUrPX1093FaoVHwxm3++EvRefqZZsBheBiJU4sHR
         SlhVD1fL1TcijeTNLor0ZibOo0nGxIZn0w+lsFt7j68sty1XLV/inCbcpuwFFDH6+kot
         YJRk/slSTDijoKiYWMGmPt3nKS/Thx3sLbCVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=boCzqqT5TJ09DQSvElsZCM76ABJa0T7dS+o6/tDOxwM=;
        b=JLIo00U2PWYzYk0lXwp+aI8MMTHE0VI+1NC8wc+kXXKQLud7O/Dhb4zpeq9Rrpd9LL
         O7zr+n8LudS5jJOSV4RriwZoR6YtyE5PL0LqnRZ6kIQ23jNTc81znfa7e3ijYGERSrMa
         YOGlFe8pAPFOYfBMedNeOqAZ7KIR6TMmyePDdqvf89dW/S0PkSRI7cb11YDHxN3Ibwl4
         Od5lk7jBOlgOAqLit+feSA8SUaLsJLfuyxmgSnw5dCgdcuYdTpmobI2ExY97r4JshEIu
         q/rgj4gQffFWXBPohyd+phX+GrshEInOn7g3d66JksKQUbwYar4V65QJLifLsfph8SA9
         tiUw==
X-Gm-Message-State: AOAM531UrlMNIaVilkJL/YjRbRZfZshGUFGhQlKFw8Jx/UFjF/IV5e0j
        TqUbr+RS+u7bLH1+5B/IYRukGQ==
X-Google-Smtp-Source: ABdhPJz/EiF4HAeY1NUbSgiJMvqjfEhWawkjuaMtjj1l9TkUrpWQvgVpkpmdPUrxosqUmGapdvYkNw==
X-Received: by 2002:a05:6402:1907:b0:42d:e90e:337 with SMTP id e7-20020a056402190700b0042de90e0337mr44745227edz.405.1654766229219;
        Thu, 09 Jun 2022 02:17:09 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-55-105.cust.vodafonedsl.it. [188.217.55.105])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7cfd2000000b0042dc8dd59c7sm14090609edy.51.2022.06.09.02.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:17:08 -0700 (PDT)
Date:   Thu, 9 Jun 2022 11:17:06 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Quentin Schulz <foss+kernel@0leil.net>, shawnx.tu@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] media: i2c: ov5675: add .get_selection supporty
Message-ID: <20220609091706.GA1950409@tom-ThinkPad-T14s-Gen-2i>
References: <20220607153335.875956-1-foss+kernel@0leil.net>
 <20220607153335.875956-4-foss+kernel@0leil.net>
 <20220607165136.bmriu2n7yorc7fx6@uno.localdomain>
 <20220607220405.GB821506@tom-ThinkPad-T14s-Gen-2i>
 <20220608064209.roub7uk7kx4k4muf@uno.localdomain>
 <941c3300-05e9-18b3-999a-1885585cf972@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <941c3300-05e9-18b3-999a-1885585cf972@theobroma-systems.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 08, 2022 at 03:05:29PM +0200, Quentin Schulz wrote:
> Jacopo, Tommaso,
> 
> On 6/8/22 08:42, Jacopo Mondi wrote:
> > Hi
> > 
> > On Wed, Jun 08, 2022 at 12:04:05AM +0200, Tommaso Merciai wrote:
> > > Hi Quentin/Jacopo,
> > > 
> > > On Tue, Jun 07, 2022 at 06:51:36PM +0200, Jacopo Mondi wrote:
> > > > Hi Quentin,
> > > > 
> > > > On Tue, Jun 07, 2022 at 05:33:35PM +0200, Quentin Schulz wrote:
> > > > > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > > > 
> > > > > The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
> > > > > pixels and there are an additional 24 black rows "at the bottom".
> > > > > 
> > > > >                       [2624]
> > > > >          +-----+------------------+-----+
> > > > >          |     |     16 dummy     |     |
> > > > >          +-----+------------------+-----+
> > > > >          |     |                  |     |
> > > > >          |     |     [2592]       |     |
> > > > >          |     |                  |     |
> > > > >          |16   |      valid       | 16  |[2000]
> > > > >          |dummy|                  |dummy|
> > > > >          |     |            [1944]|     |
> > > > >          |     |                  |     |
> > > > >          +-----+------------------+-----+
> > > > >          |     |     16 dummy     |     |
> > > > >          +-----+------------------+-----+
> > > > >          |     |  24 black lines  |     |
> > > > >          +-----+------------------+-----+
> > > > > 
> > > > > The top-left coordinate is gotten from the registers specified in the
> > > > > modes which are identical for both currently supported modes.
> > > > > 
> > > > > There are currently two modes supported by this driver: 2592*1944 and
> > > > > 1296*972. The second mode is obtained thanks to subsampling while
> > > > > keeping the same field of view (FoV). No cropping involved, hence the
> > > > > harcoded values.
> > > > > 
> > > > > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > > > ---
> > > > > 
> > > > > v6:
> > > > >   - explicit a bit more the commit log around subsampling for lower
> > > > >   resolution modes,
> > > > >   - (again) fixed reporting for V4L2_SEL_TGT_CROP_* thanks to Jacopo's help,
> > > > > 
> > > > > v4:
> > > > >   - explicit a bit more the commit log,
> > > > >   - added drawing in the commit log,
> > > > >   - fixed reporting for V4L2_SEL_TGT_CROP_* thanks to Jacopo's help,
> > > > > 
> > > > > added in v3
> > > > > 
> > > > >   drivers/media/i2c/ov5675.c | 21 +++++++++++++++++++++
> > > > >   1 file changed, 21 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
> > > > > index 80840ad7bbb0..2230ff47ef49 100644
> > > > > --- a/drivers/media/i2c/ov5675.c
> > > > > +++ b/drivers/media/i2c/ov5675.c
> > > > > @@ -1121,6 +1121,26 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
> > > > >   	return 0;
> > > > >   }
> > > > > 
> > > > > +static int ov5675_get_selection(struct v4l2_subdev *sd,
> > > > > +				struct v4l2_subdev_state *state,
> > > > > +				struct v4l2_subdev_selection *sel)
> > > > > +{
> > > > > +	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	switch (sel->target) {
> > > > > +	case V4L2_SEL_TGT_CROP:
> > > > > +	case V4L2_SEL_TGT_CROP_BOUNDS:
> > > > 
> > > > Seem like we have trouble understanding each other, or better, I have
> > > > troubles explaining myself most probably :)
> > > > 
> > > > If the dummy/black area is readable, this should just be (0, 0, 2624,
> > > > 2000) like it was in your previous version. What has changed that I
> > > > have missed ?
> > > 
> 
> I wouldn't say there's some misunderstanding, it's just super hard to figure
> out how to match what the datasheet says to what the kernel wants. Yay to
> obscure/confusing datasheets \o/

I know your feels :)

> 
> I just did things too quickly, nothing changed. Sorry, will send a v7.
> 
> > > Taking as reference drivers/media/i2c/ov5693.c and others,
> > > seems ok what Quentin have done from my side.
> > > 
> > > Just one thing: maybe is better to avoid magic numbers with more
> > > explicit defines like:
> > > 
> > >   + case V4L2_SEL_TGT_CROP_DEFAULT:
> > >   +           sel->r.top = OV5675_ACTIVE_START_TOP;
> > >   +           sel->r.left = OV5693_ACTIVE_START_LEFT;
> > >   +           sel->r.width = OV5693_ACTIVE_WIDTH;
> > >   +           sel->r.height = OV5693_ACTIVE_HEIGHT;
> > > 
> 
> They are hardcoded today but actually depend on what;s set in the registers
> too, which might differ if we add more modes in the future? It's anyway
> auto-magic and it's the only place it's used, so not sure it brings much
> especially since the variable names on the left hand side of the operator
> are pretty self-explanatory (not talking about V4L2_SEL_TGT_CROP_* :p)? Not
> that I'm against it.

Thanks for the explaination.
You are right.

Regards,
Tommaso

> 
> Cheers,
> Quentin

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
