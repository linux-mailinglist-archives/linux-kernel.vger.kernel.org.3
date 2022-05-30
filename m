Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E837537A05
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiE3Lh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiE3Lh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:37:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06B4EF6F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:37:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id wh22so20287659ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/LkbtPQcvwsRsFCT5B2kafAu6Wm//Jx4TksDG+egz0c=;
        b=qj5/Flbj+znEbYrCKN88/BLH1DQQSNRbO1JdpNo36o4slyOTzw8AGeygowAM4/6woR
         l81CdycuLucbenbuxFf4zJAIQ00vD2NIvMG45LP+4H3+jumcWpH6EVpzhsP+dIY/DCk2
         cic8Du6ej5Y1v+OKZuTbzmic5vp0jr8aGdRVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/LkbtPQcvwsRsFCT5B2kafAu6Wm//Jx4TksDG+egz0c=;
        b=Dzg8ZNptin9LzFnV2AbB4HsyKU1fcevwLTU2KivTk7zobfGuAf3DSqbTU3ZMqGWuw1
         Qbp4oS5W1RZm6MorrppmI4Y4sNYKlWQJnK6LISUxsjyUdy6/aOf+x2SmvmoQvxwDOCOe
         yEMb1wZQYtAO5OLGcz8DsTx4npGfbXnyhdontc9hm+OnDsqp6G40Hu27LLUnfb9XWpN0
         F3uhqm6t5QhiFOFcHgx+4vOwXkmGtYRiFgqy02ivD3G26d1aZIgV/fy7bly+dCBOzTL3
         q5JP9W3boNeIi0adYbba0ZXhlXH6+f1cJ8W+AWje/cdZ587U9ljfqS+T/76FkxdOSR7g
         Vn3A==
X-Gm-Message-State: AOAM5332kLbqaFYiQQpiNWCrAFHeZVh65FHgKQ/8fhNylQLfbVopkAxF
        9oWM9nhdT1b136P3qOyDscHgpQ==
X-Google-Smtp-Source: ABdhPJz/AQ/g9cFWSF/kO0IUjFAcw7PU+/bypjmMqBnz8vJn84FyVYW3yTumja8Cn3A5+anbddCwXA==
X-Received: by 2002:a17:907:3f89:b0:6fe:e7a7:c038 with SMTP id hr9-20020a1709073f8900b006fee7a7c038mr32987693ejc.730.1653910673717;
        Mon, 30 May 2022 04:37:53 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-2-39-143-183.cust.vodafonedsl.it. [2.39.143.183])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709060ac100b006f3ef214de1sm3900692ejf.71.2022.05.30.04.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:37:53 -0700 (PDT)
Date:   Mon, 30 May 2022 13:37:50 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: atomisp-mt9m114: Fix pointer dereferenced before
 checking
Message-ID: <20220530113750.GD99280@tom-ThinkPad-T14s-Gen-2i>
References: <1653897481-25681-1-git-send-email-baihaowen@meizu.com>
 <20220530112232.GB99280@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530112232.GB99280@tom-ThinkPad-T14s-Gen-2i>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 01:22:32PM +0200, Tommaso Merciai wrote:
> On Mon, May 30, 2022 at 03:58:01PM +0800, Haowen Bai wrote:
> > The info->data is dereferencing before null checking, so move
> > it after checking.
> > 
> > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> > ---
> >  drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> > index 00d6842c07d6..3c81ab73cdae 100644
> > --- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> > +++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> > @@ -616,13 +616,15 @@ static int mt9m114_get_intg_factor(struct i2c_client *client,
> >  				   struct camera_mipi_info *info,
> >  				   const struct mt9m114_res_struct *res)
> >  {
> > -	struct atomisp_sensor_mode_data *buf = &info->data;
> > +	struct atomisp_sensor_mode_data *buf;
> >  	u32 reg_val;
> >  	int ret;
> >  
> >  	if (!info)
> >  		return -EINVAL;
> >  
> > +	buf = &info->data;
> > +
> >  	ret =  mt9m114_read_reg(client, MISENSOR_32BIT,
> >  				REG_PIXEL_CLK, &reg_val);
> >  	if (ret)
> > -- 
> > 2.7.4
> > 
> 
> Hi Haowen,
> Looks good to me, thanks.
> 
> Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Hi,
My bad, Dan is right. Nothing to fix here.
Sorry for previous review.

Regards,
Tommaso
> -- 
> Tommaso Merciai
> Embedded Linux Engineer
> tommaso.merciai@amarulasolutions.com
> __________________________________
> 
> Amarula Solutions SRL
> Via Le Canevare 30, 31100 Treviso, Veneto, IT
> T. +39 042 243 5310
> info@amarulasolutions.com
> www.amarulasolutions.com

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
