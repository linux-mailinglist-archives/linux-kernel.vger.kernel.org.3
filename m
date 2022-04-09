Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1B44FA4B7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiDIFE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242547AbiDIFCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:02:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0906BB39;
        Fri,  8 Apr 2022 21:59:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b21so18160764lfb.5;
        Fri, 08 Apr 2022 21:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zVSR57Cc7QE1uggb8Qy0UDFjKrea3UykmqHWvT1DiyY=;
        b=E3LGWZi8amaw7nhl++phVHvK+pbP2A/KT0gzkMp73wWpmD0qgt2M6oLozmkokX/mn7
         uANjh2KJQjjru18AzOHnUrRUNYp+6iDZdfWz3nurk2oW91foLcRGLDleKhyZ0wyG/ry1
         0IAibz60tK0+dHykDpjU7LNPjgWmDYyLw3l4fbttNQVOet/WxdHRXpzuiJ7MIm0XbT0U
         MDLgxVDCC1c/q9jS/00PVjh0RADo/N5FA5hrcrclCtpFPaPQ/jg6rmbicnrc6Fmezjh7
         +pDK8140WXosP5Js07Go7J1sTH02Fb2eQDgQJjs4uppo51W2JB6l9NpCtqiheQs/Sam4
         ksAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zVSR57Cc7QE1uggb8Qy0UDFjKrea3UykmqHWvT1DiyY=;
        b=nxb6ybykwFs0XEtYHQNIC0rLvJCuoFIKJvp10afHuFqdHpd+ns+f9+/t6VH6nj+ad3
         wsfHV+OutpNRRYREbQ5x9Sz1gUOjLT7e/4OE9srE9ibt8IMh8nxsm1DYRhGLr4t3xcUJ
         0/001B6JpjRo871xgOdeY2u3n0osu5W3+EFgBzdPImWseLHwnOE9wWODhuOBh+/LbfSZ
         xFiGvKRg1OoqWMlkTtV7vokLckhr1FLWvOiVmsvsKaZLzHpVf2tLQ3NRj2itUo6o2gI1
         VyUJliw0jOLSaXnTOx3GHsv4o+2J12dWdML2OcMORWkeXdw1VCrgZzTe9Jdh98YuMHpY
         3W7Q==
X-Gm-Message-State: AOAM530RNeTZT5Z4cUYRmofXKyPMRVkln0abmUooB+UbmHkLLpLIYJr4
        rILhs89Uk/2qVGyERLonk/k=
X-Google-Smtp-Source: ABdhPJx782kS+jVFQgcJrQHY8TzqoG50hdn9605PvdQiq4hfmTjCeemXIq3OPsPkDHgTvnHA2Q31Ww==
X-Received: by 2002:a05:6512:304a:b0:44a:c4a4:8e9d with SMTP id b10-20020a056512304a00b0044ac4a48e9dmr14458299lfb.624.1649480395014;
        Fri, 08 Apr 2022 21:59:55 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id w17-20020a194911000000b0046b9191418fsm100214lfa.64.2022.04.08.21.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 21:59:54 -0700 (PDT)
Date:   Sat, 9 Apr 2022 07:59:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 05/21] ata: libahci_platform: Convert to using devm bulk
 clocks API
Message-ID: <20220409045952.3h4jkzkgziea4ysh@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-6-Sergey.Semin@baikalelectronics.ru>
 <603eb020-3f43-c193-b3f6-8ff697f845c8@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603eb020-3f43-c193-b3f6-8ff697f845c8@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:29:01AM +0900, Damien Le Moal wrote:
> On 3/24/22 09:16, Serge Semin wrote:
> > In order to simplify the clock-related code there is a way to convert the
> > current fixed clocks array into using the common bulk clocks kernel API
> > with dynamic set of the clock handlers and device-managed clock-resource
> > tracking. It's a bit tricky due to the complication coming from the
> > requirement to support the platforms (da850, spear13xx) with the
> > non-OF-based clock source, but still doable.
> > 
> > Before this modification there are two methods have been used to get the
> > clocks connected to an AHCI device: clk_get() - to get the very first
> > clock in the list and of_clk_get() - to get the rest of them. Basically
> > the platforms with non-OF-based clocks definition could specify only a
> > single reference clock source. The platforms with OF-hw clocks have been
> > luckier and could setup up to AHCI_MAX_CLKS clocks. Such semantic can be
> > retained with using devm_clk_bulk_get_all() to retrieve the clocks defined
> > via the DT firmware and devm_clk_get_optional() otherwise. In both cases
> > using the device-managed version of the methods will cause the automatic
> > resources deallocation on the AHCI device removal event. The only
> > complicated part in the suggested approach is the explicit allocation and
> > initialization of the clk_bulk_data structure instance for the non-OF
> > reference clocks. It's required in order to use the Bulk Clocks API for
> > the both denoted cases of the clocks definition.
> > 
> > Note aside with the clock-related code reduction and natural
> > simplification, there are several bonuses the suggested modification
> > provides. First of all the limitation of having no greater than
> > AHCI_MAX_CLKS clocks is now removed, since the devm_clk_bulk_get_all()
> > method will allocate as many reference clocks data descriptors as there
> > are clocks specified for the device. Secondly the clock names are
> > auto-detected. So the glue drivers can make sure that the required clocks
> > are specified just by checking the clock IDs in the clk_bulk_data array.
> > Thirdly using the handy Bulk Clocks kernel API improves the
> > clocks-handling code readability. And the last but not least this
> > modification implements a true optional clocks support to the
> > ahci_platform_get_resources() method. Indeed the previous clocks getting
> > procedure just stopped getting the clocks on any errors (aside from
> > non-critical -EPROBE_DEFER) in a way so the callee wasn't even informed
> > about abnormal loop termination. The new implementation lacks of such
> > problem. The ahci_platform_get_resources() will return an error code if
> > the corresponding clocks getting method ends execution abnormally.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/ata/ahci.h             |  4 +-
> >  drivers/ata/libahci_platform.c | 82 +++++++++++++++-------------------
> >  2 files changed, 37 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> > index eeac5482f1d1..1564c691094a 100644
> > --- a/drivers/ata/ahci.h
> > +++ b/drivers/ata/ahci.h
> > @@ -38,7 +38,6 @@
> >  
> >  enum {
> >  	AHCI_MAX_PORTS		= 32,
> > -	AHCI_MAX_CLKS		= 5,
> >  	AHCI_MAX_SG		= 168, /* hardware max is 64K */
> >  	AHCI_DMA_BOUNDARY	= 0xffffffff,
> >  	AHCI_MAX_CMDS		= 32,
> > @@ -341,7 +340,8 @@ struct ahci_host_priv {
> >  	u32			em_msg_type;	/* EM message type */
> >  	u32			remapped_nvme;	/* NVMe remapped device count */
> >  	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
> > -	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
> > +	unsigned int		n_clks;
> > +	struct clk_bulk_data	*clks;		/* Optional */
> >  	struct reset_control	*rsts;		/* Optional */
> >  	struct regulator	**target_pwrs;	/* Optional */
> >  	struct regulator	*ahci_regulator;/* Optional */
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 8eabbb5f208c..d805ddc3a024 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -8,6 +8,7 @@
> >   *   Anton Vorontsov <avorontsov@ru.mvista.com>
> >   */
> >  
> > +#include <linux/clk-provider.h>
> >  #include <linux/clk.h>
> >  #include <linux/kernel.h>
> >  #include <linux/gfp.h>
> > @@ -97,28 +98,14 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
> >   * ahci_platform_enable_clks - Enable platform clocks
> >   * @hpriv: host private area to store config values
> >   *
> > - * This function enables all the clks found in hpriv->clks, starting at
> > - * index 0. If any clk fails to enable it disables all the clks already
> > - * enabled in reverse order, and then returns an error.
> > + * This function enables all the clks found for the AHCI device.
> >   *
> >   * RETURNS:
> >   * 0 on success otherwise a negative error code
> >   */
> >  int ahci_platform_enable_clks(struct ahci_host_priv *hpriv)
> >  {
> > -	int c, rc;
> > -
> > -	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {
> > -		rc = clk_prepare_enable(hpriv->clks[c]);
> > -		if (rc)
> > -			goto disable_unprepare_clk;
> > -	}
> > -	return 0;
> > -
> > -disable_unprepare_clk:
> > -	while (--c >= 0)
> > -		clk_disable_unprepare(hpriv->clks[c]);
> > -	return rc;
> > +	return clk_bulk_prepare_enable(hpriv->n_clks, hpriv->clks);
> >  }
> >  EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
> >  
> > @@ -126,16 +113,13 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
> >   * ahci_platform_disable_clks - Disable platform clocks
> >   * @hpriv: host private area to store config values
> >   *
> > - * This function disables all the clks found in hpriv->clks, in reverse
> > - * order of ahci_platform_enable_clks (starting at the end of the array).
> > + * This function disables all the clocks enabled before
> > + * (bulk-clocks-disable function is supposed to do that in reverse
> > + * from the enabling procedure order).
> >   */
> >  void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
> >  {
> > -	int c;
> > -
> > -	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
> > -		if (hpriv->clks[c])
> > -			clk_disable_unprepare(hpriv->clks[c]);
> > +	clk_bulk_disable_unprepare(hpriv->n_clks, hpriv->clks);
> >  }
> >  EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
> >  
> > @@ -292,8 +276,6 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
> >  		pm_runtime_disable(dev);
> >  	}
> >  
> > -	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
> > -		clk_put(hpriv->clks[c]);
> >  	/*
> >  	 * The regulators are tied to child node device and not to the
> >  	 * SATA device itself. So we can't use devm for automatically
> > @@ -374,8 +356,8 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
> >   * 1) mmio registers (IORESOURCE_MEM 0, mandatory)
> >   * 2) regulator for controlling the targets power (optional)
> >   *    regulator for controlling the AHCI controller (optional)
> > - * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
> > - *    or for non devicetree enabled platforms a single clock
> > + * 3) all clocks specified in the devicetree node, or a single
> > + *    clock for non-OF platforms (optional)
> >   * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
> >   * 5) phys (optional)
> >   *
> > @@ -385,11 +367,10 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
> >  struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >  						   unsigned int flags)
> >  {
> > +	int enabled_ports = 0, rc = 0, child_nodes;
> >  	struct device *dev = &pdev->dev;
> >  	struct ahci_host_priv *hpriv;
> > -	struct clk *clk;
> >  	struct device_node *child;
> > -	int i, enabled_ports = 0, rc = 0, child_nodes;
> >  	u32 mask_port_map = 0;
> >  
> >  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> > @@ -413,25 +394,32 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >  		}
> >  	}
> >  
> > -	for (i = 0; i < AHCI_MAX_CLKS; i++) {
> > -		/*
> > -		 * For now we must use clk_get(dev, NULL) for the first clock,
> > -		 * because some platforms (da850, spear13xx) are not yet
> > -		 * converted to use devicetree for clocks.  For new platforms
> > -		 * this is equivalent to of_clk_get(dev->of_node, 0).
> > -		 */
> > -		if (i == 0)
> > -			clk = clk_get(dev, NULL);
> > -		else
> > -			clk = of_clk_get(dev->of_node, i);
> > -
> > -		if (IS_ERR(clk)) {
> > -			rc = PTR_ERR(clk);
> > -			if (rc == -EPROBE_DEFER)
> > -				goto err_out;
> > -			break;
> > +	/*
> > +	 * Bulk clock get procedure can fail to find any clock due to running
> > +	 * an a non-OF platform or due to the clocks being defined in bypass
> > +	 * from the DT firmware (like da850, spear13xx). In that case we
> > +	 * fallback to getting a single clock source right from the dev clocks
> > +	 * list.
> > +	 */
> > +	rc = devm_clk_bulk_get_all(dev, &hpriv->clks);
> 

> I would move the error check first here to make things more readable:

Agreed. Good note.

> 
> 	rc = devm_clk_bulk_get_all(dev, &hpriv->clks);
> 	if (rc < 0)
> 		goto err_out;
> 
> 	if (rc) {
> 		/* Got clocks in bulk */
> 		hpriv->n_clks = rc;
> 	} else {
> 		/*
> 		 * No clock bulk found: fallback to manually getting
> 		 * the optional clock.
> 		 */
> 		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks),
> 					   GFP_KERNEL);
> 		...
> 	}
> 
> And it may be cleaner to move this entire code hunk into a helper,
> something like ahci_platform_get_clks() ?

I'd rather keep the code embedded seeing it won't be used anywhere
than here and in order to keep the ahci_platform_get_resources()
function more-or-less coherent.  Otherwise moving just a part of the
function would be a half-measure since the methods like
ahci_platform_get_regs(), ahci_platform_get_regulators(), etc could be
also unpinned.

-Sergey

> 
> > +	if (rc > 0) {
> > +		hpriv->n_clks = rc;
> > +	} else if (!rc) {
> > +		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
> > +		if (!hpriv->clks) {
> > +			rc = -ENOMEM;
> > +			goto err_out;
> >  		}
> > -		hpriv->clks[i] = clk;
> > +		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
> > +		if (IS_ERR(hpriv->clks->clk)) {
> > +			rc = PTR_ERR(hpriv->clks->clk);
> > +			goto err_out;
> > +		} else if (hpriv->clks->clk) {
> > +			hpriv->clks->id = __clk_get_name(hpriv->clks->clk);
> > +			hpriv->n_clks = 1;
> > +		}
> > +	} else {
> > +		goto err_out;
> >  	}
> >  
> >  	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
