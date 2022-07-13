Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D745736F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiGMNMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiGMNMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:12:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574F7D5B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:12:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so1198186wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AP82AD5KWIZdTSQN9k7J7EQojQga5xqW2stU2XHkM8g=;
        b=DY4VquCBnT0ULVc2GG9Y3scnxHHr9iRGCWK2tAX8hBIFBA+Q3wApM9BEobIFgwcWYU
         Aq6+v0N5VS86SLf3FcLI8lEq2rl4J7iK0EG0evIU5CbhumQNLnCeEPqyeTFA2vs6++u+
         M8+aZANBUK3EUFXkqeJ6k6/hxa4ABb8nXObfWRrr7o1dFgPb5jV2vnNMZbF/YKIlVDta
         T/5YBzlOLWbqAHPSIJtLRzwOEUFmCB2nPHlxxWPrLRiAj1HtnoQUOfQckOrWvSrI0lOa
         fOkhGzJozWSXfYD5lBuufH+Clnt9l4fai+IdjlpYiPe1c9phxTKdoWhqAy3ywyi4FVmm
         34+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AP82AD5KWIZdTSQN9k7J7EQojQga5xqW2stU2XHkM8g=;
        b=FT+t1PTS5EA8FFbTVAwL9l2D/8xCjG/xCW/XbzHkug7BpJyJnUqpphh3r8Lf89ivi9
         kWrN0boR4+uARd7gHLMbvju6NzIK8qfH/xLrHZHjyK7zGmdvTAavGO6jkKBp+zDTiOWk
         70+4akludJeZzk/7IIP2EyhMxGIS4/V9OgAfEJtx+SWkGDCh26jPHAUxY2d8Hg5+eXCd
         3mM7aFqIhVsRKIvGAOxSfEWIuOqUJbHJo6sPWjMSiEuS61YPrsFMAMQYIbJL5uj6DSv2
         MgPY/MxWHk1UPgC9v8WZnc2hzwIdLP2GMNmEaDEx+2TEjwN1VC6Jwhmo+86bPZMtIWAu
         zTJQ==
X-Gm-Message-State: AJIora+1oFBgOUhtwpG2y62Xxn7BFGPAA1W188Jwk+7T3hwu79xfVfBw
        t90zgTdd4g6indSHUtE4h96/jrj7gv8+Fw==
X-Google-Smtp-Source: AGRyM1sTNVL6DYxrRxDnbRm9scf50hIwYb3qp04OJuPQN+a1fzZT9gWqLwRA1ATa5TWhySbTuN0fFQ==
X-Received: by 2002:a05:600c:3b9e:b0:3a2:feb5:2b43 with SMTP id n30-20020a05600c3b9e00b003a2feb52b43mr529975wms.26.1657717949909;
        Wed, 13 Jul 2022 06:12:29 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l26-20020a1ced1a000000b003a17ab4e7c8sm2056541wmh.39.2022.07.13.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:12:29 -0700 (PDT)
Date:   Wed, 13 Jul 2022 14:12:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Provide an SSP type to the SPI
 driver
Message-ID: <Ys7Eu72Xf5EnGDWM@google.com>
References: <20220702211903.9093-1-andriy.shevchenko@linux.intel.com>
 <Ys593spfcFtoILhS@google.com>
 <Ys6lFqm4/T/Kb3et@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ys6lFqm4/T/Kb3et@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022, Andy Shevchenko wrote:

> On Wed, Jul 13, 2022 at 09:10:06AM +0100, Lee Jones wrote:
> > On Sun, 03 Jul 2022, Andy Shevchenko wrote:
> 
> > > +static const struct property_entry spt_spi_properties[] = {
> > > +	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_SPT_SSP),
> > > +	{ }
> > > +};
> > > +
> > > +static const struct software_node spt_spi_node = {
> > > +	.properties = spt_spi_properties,
> > > +};
> > > +
> > >  static const struct intel_lpss_platform_info spt_info = {
> > >  	.clk_rate = 120000000,
> > > +	.swnode = &spt_spi_node,
> > >  };
> > 
> > IMHO, this is a rubbish interface.
> > 
> > The amount of 10-line changes required to store a 32-bit value is
> > depressing.  Is there not a reduced interface for storing small pieces
> > of data that doesn't require arrays of structs?
> 
> The part of it that makes it longer because of differentiating the hardware,
> but see the difference here:
> 
> In this change:
> 	95 insertions(+), 46 deletions(-)
> 
> In the follow up SPI driver cleaning (not yet submitted):
> 	14 insertions(+), 121 deletions(-)

Not sure we are understanding each other.

The patch is fine.  I'm referring to the software_node interface.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
