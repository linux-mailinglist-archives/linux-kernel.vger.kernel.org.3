Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC93F4D0146
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243212AbiCGOc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiCGOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:32:58 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EC27938F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:32:03 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 12so15307663oix.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jAOEfcrHxWTEhg7BxTnoFSoh64ur+frJb+7Etlx9rtQ=;
        b=GJ/zew/2c/T7gmBh99VfzZLRMIr1lWxgtwiRGpln7n6kXctT05678TBF1YPo8K/nyU
         xOL/GNqnsexBZCu2VL/N3mTeUDMxf6kTPDvrzocCn/XswBlLdtp+GJzmpSxz7sqo4KXt
         4wr7xC63ca5frxTj5uJRTgnPWTe6M+mGV6zRZ5vAST0uEDv9m+LWK0h2mFrEPzjBt1Yt
         /X9IYwbSusvVKxyEyVqgZsa1ageF3DyBQDHldMq/hndd38A4zi/b6Iqeqx6a4+T4eW9U
         S8DmT71hgMF8+wgDwfhNOqN3TjxkzV0ImuTqjRWVDS5YjPGK9jGaPbiZxzs0TVQ8sY7R
         7MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAOEfcrHxWTEhg7BxTnoFSoh64ur+frJb+7Etlx9rtQ=;
        b=JJ+ke/EcAgTY7uZQzRdOqQ/9LQ5nxU3XLO8niYqWiSARFuDj9XgGa8k0VWS5zaPioT
         TJbefLICRtngiO7fMnCtipVR4rPVz+skmnQj/7M8t4DjNzZ9ogI/fAj7cD2LkwBek4+v
         HRnBVlJPWVGu6OzhVmtH5M0gxxfoL+SGFGzOsUNYRQbaihAi3O3e59SDXEmDCzx3oa6+
         7wRVdwx/8MsNlqkBORzVy1hZ+3MSrusti3ZsHjSiDpNZV2z2qWsxJ+iU7ahaiLglewce
         1NnChxY3+WforE2yT2Ls4WA1LCGA57e2Fo5Vo0dzbVZgvHfzcwnPEv549GYUkylVIqu9
         Ez9w==
X-Gm-Message-State: AOAM532PwtX3gG9PrsNw0bDudW24q6YXQ4POwEO4IcKdyrz3kle7tGKU
        5oYFlfengelt16IlZBFrLOuDBw==
X-Google-Smtp-Source: ABdhPJzqOXx5kooaXG2dVnX2vpjZX9hB4LZw1mzfujLDchjIhcK0otseZB2nycRu3BZ28DFHpurG6A==
X-Received: by 2002:a05:6808:23ca:b0:2d9:bb42:81e with SMTP id bq10-20020a05680823ca00b002d9bb42081emr5269110oib.141.1646663523111;
        Mon, 07 Mar 2022 06:32:03 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id o10-20020a0568080f8a00b002d726c76b77sm6442939oiw.15.2022.03.07.06.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:32:02 -0800 (PST)
Date:   Mon, 7 Mar 2022 06:33:47 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 3/7] usb: typec: mux: Check dev_set_name() return value
Message-ID: <YiYXywEEz7WZQhfd@ripper>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
 <20220307034040.1111107-3-bjorn.andersson@linaro.org>
 <YiXZkqPQxqQ9I0VH@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiXZkqPQxqQ9I0VH@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Mar 02:08 PST 2022, Andy Shevchenko wrote:

> On Sun, Mar 06, 2022 at 07:40:36PM -0800, Bjorn Andersson wrote:
> > It's possible that dev_set_name() returns -ENOMEM, catch and handle this.
> 
> Thanks!
> Shouldn't we have a Fixes tag and be sent separately for this cycle?
> 

It seems appropriate to add:

Fixes: 3370db35193b ("usb: typec: Registering real device entries for the muxes")


If the maintainer would prefer to get this into v5.18, it could either
be picked ahead of the rest of the series, or I can resubmit it on its
own. I don't think it's a critical fix though.

> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v3:
> > - New patch
> > 
> >  drivers/usb/typec/mux.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> > index c8340de0ed49..d2aaf294b649 100644
> > --- a/drivers/usb/typec/mux.c
> > +++ b/drivers/usb/typec/mux.c
> > @@ -131,8 +131,11 @@ typec_switch_register(struct device *parent,
> >  	sw->dev.class = &typec_mux_class;
> >  	sw->dev.type = &typec_switch_dev_type;
> >  	sw->dev.driver_data = desc->drvdata;
> > -	dev_set_name(&sw->dev, "%s-switch",
> > -		     desc->name ? desc->name : dev_name(parent));
> > +	ret = dev_set_name(&sw->dev, "%s-switch", desc->name ? desc->name : dev_name(parent));
> 
> We may use shorten form of the ternary
> 
> 	ret = dev_set_name(&sw->dev, "%s-switch", desc->name ?: dev_name(parent));
> 
> at the same time, but it's up to you.
> 

I looked at it, but felt it was an unrelated change and decided to leave
it as is.

> Either way code looks good to me,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Thanks,
Bjorn

> > +	if (ret) {
> > +		put_device(&sw->dev);
> > +		return ERR_PTR(ret);
> > +	}
> >  
> >  	ret = device_add(&sw->dev);
> >  	if (ret) {
> > @@ -338,8 +341,11 @@ typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
> >  	mux->dev.class = &typec_mux_class;
> >  	mux->dev.type = &typec_mux_dev_type;
> >  	mux->dev.driver_data = desc->drvdata;
> > -	dev_set_name(&mux->dev, "%s-mux",
> > -		     desc->name ? desc->name : dev_name(parent));
> > +	ret = dev_set_name(&mux->dev, "%s-mux", desc->name ? desc->name : dev_name(parent));
> 
> Ditto.
> 
> > +	if (ret) {
> > +		put_device(&mux->dev);
> > +		return ERR_PTR(ret);
> > +	}
> >  
> >  	ret = device_add(&mux->dev);
> >  	if (ret) {
> > -- 
> > 2.33.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
