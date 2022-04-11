Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229F54FBBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiDKMOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiDKMOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:14:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04571D327;
        Mon, 11 Apr 2022 05:11:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o16so13944075ljp.3;
        Mon, 11 Apr 2022 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zfeBm/kVL7aGnHvdVGIGPzHXygZReL8/W34TZ9i5NvE=;
        b=UiiFofvP/OoQHfUlKFdlwFJi2wkIVy4C9/JkVNzU5seZrRkbTNnoN+lssIRbk8OAe/
         nHhPfochu7ArxRw5FvWpGt1r29oA8qIGMyNVnblaf8ED3R5nFcpkWbEtVo9+ah4iNbg5
         297dpFXaeX6yhyh57wNGK/31X51slp+z4nZKEmb8SqWfTTuElusc+Rc9XH+a2BSJn8Jb
         gRqdXi8sTSAx2V870JCbQYkd0JZVNc7w/0dwRyUFoT1Brz24vWe2WqC6NdD5ej83Ie9+
         9KI/5ngDCgfORVftxoG1JnMPbUP1Rb9XmS3jbK8IPEp9Us87iv9ihUMBhTJsGllH5oFo
         fMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zfeBm/kVL7aGnHvdVGIGPzHXygZReL8/W34TZ9i5NvE=;
        b=AyamJEmaPAfevD5LWTQ+ljRaZtkHFSHNPPtAs4kQkxb7Lj/uDhl+yE4+/pNeiYuSuA
         NLcOBoPUFND0dcxvVYE9ITV+SAu7vxTv2DUpv8ryT/YTdNpd7gQntbgEUyWGYlGRhejU
         kqsLmxuPC8q5pLKRgD663tvcn9MYCx1v0cXvE6MxQVWaAOR2gFFqD+MZ+xFqhTMWpJ3C
         84z3znsuAmAXgpfTnKHG4s8oNNCLlHmjpZGvn8YqR4OEJImJacHTRIIdeaQIIOVsVq+Q
         eFfEiSpHaXCbjynT7v8hDVNAIT6tPYBhmMLDW5b6FVcsmHD9Fbt/9+XgoolaOtk43uad
         gOdA==
X-Gm-Message-State: AOAM531dNNQ1f/0sCm4Z1I19m+thv9JxJBPsTUCFfaS5l+WZ6VQNh679
        pMpOcgSIl8QYXm9yPVVsiMg=
X-Google-Smtp-Source: ABdhPJy9xf4gUMMhQCrqDFkw5fqBWr/OIqByXvT2Gbv7DkvMSjP3ICj162Bwm3cIS33i48YxaMadZw==
X-Received: by 2002:a2e:8942:0:b0:24b:405d:ce6d with SMTP id b2-20020a2e8942000000b0024b405dce6dmr13760358ljk.270.1649679114559;
        Mon, 11 Apr 2022 05:11:54 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id m8-20020a194348000000b0046bae58249asm135828lfj.212.2022.04.11.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 05:11:53 -0700 (PDT)
Date:   Mon, 11 Apr 2022 15:11:51 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 12/21] ata: libahci: Discard redundant force_port_map
 parameter
Message-ID: <20220411121151.vm6wmtalbl2lgtgo@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-13-Sergey.Semin@baikalelectronics.ru>
 <b06a8382-d5c1-e3a5-8577-692fa82cb3c1@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06a8382-d5c1-e3a5-8577-692fa82cb3c1@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 11:05:58AM +0900, Damien Le Moal wrote:
> On 3/24/22 09:16, Serge Semin wrote:
> > Currently there are four port-map-related fields declared in the
> > ahci_host_priv structure and used to setup the HBA ports mapping. First
> > the ports-mapping is read from the PI register and immediately stored in
> > the saved_port_map field. If forced_port_map is initialized with non-zero
> > value then its value will have greater priority over the value read from
> > PI, thus it will override the saved_port_map field. That value will be then
> > masked by a non-zero mask_port_map field and after some sanity checks it
> > will be stored in the ahci_host_priv.port_map field as a final port
> > mapping.
> > 
> > As you can see the logic is a bit too complicated for such a simple task.
> > We can freely get rid from at least one of the fields with no change to
> > the implemented semantic. The force_port_map field can be replaced with
> > taking non-zero saved_port_map value into account. So if saved_port_map is
> > pre-initialized by the glue-driver/platform-specific code then it will
> 

> glue-driver == LLDD (low level device driver), for the entire series please.

Why? It's a normal term and well known amongst developers. I've used it
in a plenty of my patches before and none of them has been questioned in that
part so far.

-Sergey

> 
> > have greater priority over the value read from PI register and will be
> > used as actual HBA ports mapping later on. Thus the ports map forcing task
> > will be just transferred from the force_port_map to saved_port_map field.
> > 
> > This modification will perfectly fit into the feature of having OF-based
> > initialization of the HW-init HBA CSR fields we are about to introduce in
> > the next commit.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/ata/ahci.c             |  2 +-
> >  drivers/ata/ahci.h             |  1 -
> >  drivers/ata/libahci.c          | 10 ++++++----
> >  drivers/ata/libahci_platform.c |  2 +-
> >  4 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index ab5811ef5a53..8ce0d166cc8d 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -654,7 +654,7 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
> >  {
> >  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
> >  		dev_info(&pdev->dev, "JMB361 has only one port\n");
> > -		hpriv->force_port_map = 1;
> > +		hpriv->saved_port_map = 1;
> >  	}
> >  
> >  	/*
> > diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> > index 04690b4168a3..519d148ecaea 100644
> > --- a/drivers/ata/ahci.h
> > +++ b/drivers/ata/ahci.h
> > @@ -329,7 +329,6 @@ struct ahci_port_priv {
> >  struct ahci_host_priv {
> >  	/* Input fields */
> >  	unsigned int		flags;		/* AHCI_HFLAG_* */
> > -	u32			force_port_map;	/* force port map */
> >  	u32			mask_port_map;	/* mask out particular bits */
> >  
> >  	void __iomem *		mmio;		/* bus-independent mem map */
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index 0ed484e04fd6..011175e82174 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -453,7 +453,6 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
> >  	 * reset.  Values without are used for driver operation.
> >  	 */
> >  	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
> > -	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
> >  
> >  	/* CAP2 register is only defined for AHCI 1.2 and later */
> >  	vers = readl(mmio + HOST_VERSION);
> > @@ -517,10 +516,13 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
> >  		cap &= ~HOST_CAP_SXS;
> >  	}
> >  
> > -	if (hpriv->force_port_map && port_map != hpriv->force_port_map) {
> > +	/* Override the HBA ports mapping if the platform needs it */
> > +	port_map = readl(mmio + HOST_PORTS_IMPL);
> > +	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
> >  		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
> > -			 port_map, hpriv->force_port_map);
> > -		port_map = hpriv->force_port_map;
> > +			 port_map, hpriv->saved_port_map);
> > +		port_map = hpriv->saved_port_map;
> > +	} else {
> >  		hpriv->saved_port_map = port_map;
> >  	}
> >  
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index febad33aa43c..5cbc2c42164d 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -539,7 +539,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >  	}
> >  
> >  	of_property_read_u32(dev->of_node,
> > -			     "ports-implemented", &hpriv->force_port_map);
> > +			     "ports-implemented", &hpriv->saved_port_map);
> >  
> >  	if (child_nodes) {
> >  		for_each_child_of_node(dev->of_node, child) {
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
