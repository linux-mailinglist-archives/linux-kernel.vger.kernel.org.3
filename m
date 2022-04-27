Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BF05112AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358935AbiD0Hkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356856AbiD0Hkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:40:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5950B42E7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:37:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so2261875wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=C+ivkSXy22CxM4HSJNgcGW9tO9ymWN+9G3c0eZLhcWE=;
        b=ZxvujRm0q/Q0tYpti4IvXmqh6sn1iWC1CuE9Or5xvCIpCqzBQLvTJCrrQKGuthN0pg
         S+pg2XjFxenD3EC8GdBho6OOYVuTPaeGCUQOxMGHSOS68vOL5H4yr+4WpX9o3QHxW1Wd
         MPfppr8ZsXPNWL+OwZkZYxMC29faAP+9uLC/TphmoAbWFPXoj/FKKTXSf0HgGLBHqVau
         Hl8aepF+uv6+LkaJBBP740Bqpn7lK5T62du7fwU3XWDBgxfw8+cmqzwfl+Cip+8mMA73
         waw+pUNwlPsL21z9XfNXVd+BOjeQ36JF/Ej14k8T8Wd9EhqY7woEGaoQg6fBbuAkcVhk
         k11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C+ivkSXy22CxM4HSJNgcGW9tO9ymWN+9G3c0eZLhcWE=;
        b=JVvcww0oySYUvA73zb/2yGFZk1XWB5xzHlJ7y3Ps0fJxUmO/GAnH7lhOVuESDC+Ai8
         IZRj0iRL8icg/iKdEXM9hqAaPAVfsZI+SMnSt6Bm2GDm6vO97LfEE+5MQ1kknu/iUvqF
         MGr6yLtSBQ2G/Rm5xLAuAm/QaIWtEYIf5BrLdtaxV5U6kCWG20WnRdowi7GRkPyL1d7V
         KyoxJRdOnFcpri7BrG7EZfXhAp7aGjZseGQzMtCYkj3ewP4Z8wZuJ9CwFsfF7DqAwJxz
         u7+clqRW/ntUkS1Tcf4RetJE+pzi0a8T3nmiCwc19d8AR4DscbvRcw/MffGV9jaxeg/i
         GxEQ==
X-Gm-Message-State: AOAM533W/gc2010XnKHRwP7zak2fy3ERhmrPcp0PihUIuM5dsmRRoG4s
        0PNtsaoMoC6jRkNuv6W/W2vo0MhRWbVqFw==
X-Google-Smtp-Source: ABdhPJzB6loISezCeFGxVbnTnvbh6sTlUlkFs97gSH/NZw6TqObDEtT+le8K81leo4xopB+iDlW2Gw==
X-Received: by 2002:a05:600c:2107:b0:393:da62:1b1e with SMTP id u7-20020a05600c210700b00393da621b1emr23257004wml.82.1651045054393;
        Wed, 27 Apr 2022 00:37:34 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r14-20020adfa14e000000b0020aeab110b8sm1960190wrr.74.2022.04.27.00.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:37:33 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:37:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: sprd: Add SC2730 PMIC to SPI device ID table
Message-ID: <YmjyvM32FQKx50iL@google.com>
References: <20220425132410.2708304-1-gengcixi@gmail.com>
 <YmgFXLAGDlQe4LZ4@google.com>
 <CAF12kFtjMEohkv27cWQYqTaFdASt05P1B02pAHEYugMYUJArJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF12kFtjMEohkv27cWQYqTaFdASt05P1B02pAHEYugMYUJArJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022, Cixi Geng wrote:

> Lee Jones <lee.jones@linaro.org> 于2022年4月26日周二 22:44写道：
> >
> > On Mon, 25 Apr 2022, Cixi Geng wrote:
> >
> > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > >
> > > Add the SC2730 PMIC support for module autoloading
> > > through SPI modalises.
> > >
> > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > ---
> > >  drivers/mfd/sprd-sc27xx-spi.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > > index 55d2c31bdfb2..cf4f89114ae4 100644
> > > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > > @@ -248,6 +248,7 @@ MODULE_DEVICE_TABLE(of, sprd_pmic_match);
> > >
> > >  static const struct spi_device_id sprd_pmic_spi_ids[] = {
> > >       { .name = "sc2731", .driver_data = (unsigned long)&sc2731_data },
> > > +     { .name = "sc2730", .driver_data = (unsigned long)&sc2730_data },
> >
> > Nicer if these were ordered with the smallest number at the top.
> I followed the order of struct of_device_id sprd_pmic_match[1],Do I need
> adjust it as well?
> [1].https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/mfd/sprd-sc27xx-spi.c#L242

I've applied this patch for now.

Could you please submit a follow-up changing both?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
