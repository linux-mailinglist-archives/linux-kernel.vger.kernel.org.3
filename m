Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EC481C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbhL3NoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhL3NoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:44:05 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D870FC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 05:44:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w20so41547395wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 05:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ig6zmVlsXZoVU3qS9GYP8SWQ0yGF84n3e2wM7iJ8EaM=;
        b=xuHu6OJyHwstTvs/pGh7nrljGZGVw4IATi8sBlZfVNUgOzeSetWxHN/cP27hJfg3ed
         HSyktYnCNEjgn9hsuZuJSLS3WuIScLK/TDCmP+ZSvIxJskvBJNJgvDFdgmAZdXWLFs4z
         A/nKRKNPqThw3dxfxtdukMBXvShPb5S1Z2QMSaZSpr5Fa8Pa5QgHsfpibYfqNwwAnZWS
         J2FePdAyaAuKl0iTxdHPQormUYAGFymTNIFabqIPSpTTu/UaE0S2RilRBBUxah0t9e4V
         GrP8KTKIPHdbm6C1WSLwk3Hej0S7zkSHAnvoiWAHxzu9iIF+Kfw/VMGZHJ6cPnS0zlpg
         B2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ig6zmVlsXZoVU3qS9GYP8SWQ0yGF84n3e2wM7iJ8EaM=;
        b=Vjsa/biUPiZfW+C5tZzqK3foVDKp4OXZvHtJIKyFIe2t+1dCVhLEubB1BFCwjtNyWf
         sVUtT7+CAnQBOQS1ECPdy1HR88z8f3YohuIgeNa9N77cCzF2nMO4psrE6tOEfvDfJGUn
         gANZ7xMVNsjQ7Lfcn2Y0RNZR7d/8t4KNR7FggDvB2Xj4Fs3AoFgazqJRCB8pJoExJEY5
         w5Ko3iqNOyFvpwSs+MHgr3Sc0zbaJINSoFAJ4hl1Gmq480jMT4rWwsiir+/vFMYrOu/w
         ah1Bywn7Ze3XFI0z2f59B/UO3aHBUWFm4xeE8LGekC6vE67ziWM2Ej24xHw5W2Ohqt7y
         T3Ig==
X-Gm-Message-State: AOAM530Q7R01fq/OKadKfR16QrRx7ZkCy30I8xrHNIHFjGwEPL84tovO
        aIpE7onzetxvu91Nicl8Fgwiug==
X-Google-Smtp-Source: ABdhPJzxPkunGX9tRgikCmqk6FG7VSXFwaZometrgf66b91ZcRQVpqO+FoZ4PpOTn2e5axxy42HAtw==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr25290496wro.183.1640871841367;
        Thu, 30 Dec 2021 05:44:01 -0800 (PST)
Received: from google.com ([31.124.24.179])
        by smtp.gmail.com with ESMTPSA id g7sm24269589wrx.104.2021.12.30.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 05:44:00 -0800 (PST)
Date:   Thu, 30 Dec 2021 13:43:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [RFC v5 net-next 08/13] mfd: add interface to check whether a
 device is mfd
Message-ID: <Yc23mTo6g1tBiMjT@google.com>
References: <20211218214954.109755-1-colin.foster@in-advantage.com>
 <20211218214954.109755-9-colin.foster@in-advantage.com>
 <Ycx+A4KNKiVmH2PJ@google.com>
 <20211230020443.GB1347882@euler>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211230020443.GB1347882@euler>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021, Colin Foster wrote:

> On Wed, Dec 29, 2021 at 03:25:55PM +0000, Lee Jones wrote:
> > On Sat, 18 Dec 2021, Colin Foster wrote:
> > 
> > > Some drivers will need to create regmaps differently based on whether they
> > > are a child of an MFD or a standalone device. An example of this would be
> > > if a regmap were directly memory-mapped or an external bus. In the
> > > memory-mapped case a call to devm_regmap_init_mmio would return the correct
> > > regmap. In the case of an MFD, the regmap would need to be requested from
> > > the parent device.
> > > 
> > > This addition allows the driver to correctly reason about these scenarios.
> > > 
> > > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > > ---
> > >  drivers/mfd/mfd-core.c   |  5 +++++
> > >  include/linux/mfd/core.h | 10 ++++++++++
> > >  2 files changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > > index 684a011a6396..905f508a31b4 100644
> > > --- a/drivers/mfd/mfd-core.c
> > > +++ b/drivers/mfd/mfd-core.c
> > > @@ -33,6 +33,11 @@ static struct device_type mfd_dev_type = {
> > >  	.name	= "mfd_device",
> > >  };
> > >  
> > > +int device_is_mfd(struct platform_device *pdev)
> > > +{
> > > +	return (!strcmp(pdev->dev.type->name, mfd_dev_type.name));
> > > +}
> > > +
> > 
> > Why is this device different to any other that has ever been
> > mainlined?
> 
> Hi Lee,
> 
> First, let me apologize for not responding to your response from the
> related RFC from earlier this month. It had been blocked by my spam
> filter and I had not seen it until just now. I'll have to check that
> more diligently now.
> 
> Moving on...
> 
> That's a question I keep asking myself. Either there's something I'm
> missing, or there's something new I'm doing.
> 
> This is taking existing drivers that work via MMIO regmaps and making
> them interface-independent. As Vladimir pointed out here:
> https://lore.kernel.org/all/20211204022037.dkipkk42qet4u7go@skbuf/T/
> device_is_mfd could be dropped in lieu of an mfd-specific probe
> function.
> 
> If there's something I'm missing, please let me know. But it feels like
> devm_get_regmap_from_resource at the end of the day would be the best
> solution to the design, and that doesn't exist. And implementing
> something like that is a task that I feel I'm not capable of tackling at
> this time.

I'm really not a fan of leaking any MFD API outside of drivers/mfd.
MFD isn't a tangible thing.  It's a Linuxiusm, something we made up, a
figment of your imagination.

What happens if you were to all dev_get_regmap() in the non-MFD case
or when you call devm_regmap_init_mmio() when the driver was
registered via the MFD framework?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
