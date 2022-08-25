Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2545A5A088B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiHYFxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbiHYFxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:53:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3683E3ED70;
        Wed, 24 Aug 2022 22:53:38 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u24so12816045lji.0;
        Wed, 24 Aug 2022 22:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=0ypDwSiMryq+XgEa4md5x8eMYTCE+HB9qKpRj7L5oyg=;
        b=bGCik2w1EN6v9BJ6+vZfKQNtJTRYfX/10JGgdA2UqXIM9gpDP/kiqOgNETyA61H/Sw
         vxyxZJMEpexliG2cHdsexxO5Rs7pJiqHjeAqdGmbbQza8HONBVJ75aepSxiTMUQYthoZ
         8YKx06sX6OadLFHoFzE5WjPQpjQ83UkOuXac+lO0+oeGagqP73TQBYzxOmr4H6qocyDR
         MpyScXiNW1Ezk3KYmP219guSoseIND9P27e1zS6DTCZJW07g7aLfEkXcJiRhJQRw0Ol2
         NB17eNWGGcmGCHTGmxykM01UdfYBni6H0WS1HeGV0RzLtBaWYWUS4hqwxuJ/rFE3CHM0
         18dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0ypDwSiMryq+XgEa4md5x8eMYTCE+HB9qKpRj7L5oyg=;
        b=56UVaDMCG3GtqD1eqUdUCofywnzXp+/0FiWXxoXbglnUdMJT7JOq5yq/18rnmtEDZJ
         sIzWovjMcjADq5DQVDP+fi5PC2iGd6W5hStF4YC2APdsSiK30f6yk9r3IkvaHnU44RlT
         Nf7AC7qGBbVH9yBiMo9D7IvSdmrTleGq92jrPzt+7hChwPFoak5jtftQ5NvcW/Hg/C/c
         yoDe1BJzIKM7isPuVLjcfAxsYIsQ5N6xx28uhZ9Cpzg6TWAl6U0HyGH9cwEZujb7AqZ2
         p41DiCdg5kTZrMdv6yiLiYC1OdbRt9drj0rMua3Fok67bVK5Q1rb9r114LHY50C15nI3
         Mw5g==
X-Gm-Message-State: ACgBeo2FtAeQUSSZo7l33hiyyxCd5aeAmC5PcN/pSuGDmYvJdtR076O5
        ylAZgHLn3RwD01WsPnmOXuE=
X-Google-Smtp-Source: AA6agR65RhsaVvh3U1Tnbbwx1a+q/VmtKGnZDR2aifCuWuD/q8eIFykGHp/A/Dpaw4ISrVWsfoJNhg==
X-Received: by 2002:a2e:a548:0:b0:261:c647:1d86 with SMTP id e8-20020a2ea548000000b00261c6471d86mr656779ljn.237.1661406816343;
        Wed, 24 Aug 2022 22:53:36 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24c4b000000b0048cf7e8145asm310718lfk.117.2022.08.24.22.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 22:53:35 -0700 (PDT)
Date:   Thu, 25 Aug 2022 08:53:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 07/23] ata: libahci_platform: Convert to using devm
 bulk clocks API
Message-ID: <20220825055333.kvdv3ddys2dcu3dg@mobilestation>
References: <20220822183728.24434-1-Sergey.Semin@baikalelectronics.ru>
 <20220822183728.24434-8-Sergey.Semin@baikalelectronics.ru>
 <402afc6b-0b52-f538-b706-31164ea041c7@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402afc6b-0b52-f538-b706-31164ea041c7@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 04:19:54PM -0700, Damien Le Moal wrote:
> On 2022/08/22 11:37, Serge Semin wrote:
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
> > auto-detected. So the LLDD (glue) drivers can make sure that the required
> > clocks are specified just by checking the clock IDs in the clk_bulk_data
> > array.  Thirdly using the handy Bulk Clocks kernel API improves the
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
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> 

> The build bot complains about this patch. Please see the build report.

What an unfortunate patch.) Thanks for noting.

To sum up alas I can't use __clk_get_name() to get the default clock
name because the method is undefined for the platforms with no clock
support. But we still need some name of the clock connection ID. Seeing
in case of a single clock case, the clock connection ID isn't that
needed I'll just use a default ID like "ahci".

-Sergey

> 
> > 
> > ---
> > 
> > Changelog v2:
> > - Convert to checking the error-case first in the devm_clk_bulk_get_all()
> >   method invocation. (@Damien)
> > - Fix some grammar mistakes in the comments.
> > 
> > Changelog v7:
> > - Fix Davinci DA850 and Omap2 DM816 AHCI LLDD to be using the new bulk
> >   clocks interface.
> > ---
> >  drivers/ata/ahci.h             |  4 +-
> >  drivers/ata/ahci_da850.c       | 47 ++++++++-----------
> >  drivers/ata/ahci_dm816.c       |  4 +-
> >  drivers/ata/libahci_platform.c | 84 ++++++++++++++++------------------
> >  4 files changed, 62 insertions(+), 77 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> > index ad11a4c52fbe..c3770a19781b 100644
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
> > @@ -339,7 +338,8 @@ struct ahci_host_priv {
> >  	u32			em_msg_type;	/* EM message type */
> >  	u32			remapped_nvme;	/* NVMe remapped device count */
> >  	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
> > -	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
> > +	unsigned int		n_clks;
> > +	struct clk_bulk_data	*clks;		/* Optional */
> >  	struct reset_control	*rsts;		/* Optional */
> >  	struct regulator	**target_pwrs;	/* Optional */
> >  	struct regulator	*ahci_regulator;/* Optional */
> > diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> > index 052c28e250aa..dc8a019b8340 100644
> > --- a/drivers/ata/ahci_da850.c
> > +++ b/drivers/ata/ahci_da850.c
> > @@ -163,7 +163,6 @@ static int ahci_da850_probe(struct platform_device *pdev)
> >  	struct ahci_host_priv *hpriv;
> >  	void __iomem *pwrdn_reg;
> >  	struct resource *res;
> > -	struct clk *clk;
> >  	u32 mpy;
> >  	int rc;
> >  
> > @@ -172,36 +171,28 @@ static int ahci_da850_probe(struct platform_device *pdev)
> >  		return PTR_ERR(hpriv);
> >  
> >  	/*
> > -	 * Internally ahci_platform_get_resources() calls clk_get(dev, NULL)
> > -	 * when trying to obtain the functional clock. This SATA controller
> > -	 * uses two clocks for which we specify two connection ids. If we don't
> > -	 * have the functional clock at this point - call clk_get() again with
> > -	 * con_id = "fck".
> > +	 * Internally ahci_platform_get_resources() calls the bulk clocks
> > +	 * get method or falls back to using a single clk_get_optional().
> > +	 * This AHCI SATA controller uses two clocks: functional clock
> > +	 * with "fck" connection id and external reference clock with
> > +	 * "refclk" id. If we haven't got all of them re-try the clocks
> > +	 * getting procedure with the explicitly specified ids.
> >  	 */
> > -	if (!hpriv->clks[0]) {
> > -		clk = clk_get(dev, "fck");
> > -		if (IS_ERR(clk))
> > -			return PTR_ERR(clk);
> > -
> > -		hpriv->clks[0] = clk;
> > -	}
> > -
> > -	/*
> > -	 * The second clock used by ahci-da850 is the external REFCLK. If we
> > -	 * didn't get it from ahci_platform_get_resources(), let's try to
> > -	 * specify the con_id in clk_get().
> > -	 */
> > -	if (!hpriv->clks[1]) {
> > -		clk = clk_get(dev, "refclk");
> > -		if (IS_ERR(clk)) {
> > -			dev_err(dev, "unable to obtain the reference clock");
> > -			return -ENODEV;
> > -		}
> > -
> > -		hpriv->clks[1] = clk;
> > +	if (hpriv->n_clks < 2) {
> > +		hpriv->clks = devm_kcalloc(dev, 2, sizeof(*hpriv->clks), GFP_KERNEL);
> > +		if (!hpriv->clks)
> > +			return -ENOMEM;
> > +
> > +		hpriv->clks[0].id = "fck";
> > +		hpriv->clks[1].id = "refclk";
> > +		hpriv->n_clks = 2;
> > +
> > +		rc = devm_clk_bulk_get(dev, hpriv->n_clks, hpriv->clks);
> > +		if (rc)
> > +			return rc;
> >  	}
> >  
> > -	mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1]));
> > +	mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1].clk));
> >  	if (mpy == 0) {
> >  		dev_err(dev, "invalid REFCLK multiplier value: 0x%x", mpy);
> >  		return -EINVAL;
> > diff --git a/drivers/ata/ahci_dm816.c b/drivers/ata/ahci_dm816.c
> > index 8a92112dcd59..d26efcd20f64 100644
> > --- a/drivers/ata/ahci_dm816.c
> > +++ b/drivers/ata/ahci_dm816.c
> > @@ -69,12 +69,12 @@ static int ahci_dm816_phy_init(struct ahci_host_priv *hpriv, struct device *dev)
> >  	 * keep-alive clock and the external reference clock. We need the
> >  	 * rate of the latter to calculate the correct value of MPY bits.
> >  	 */
> > -	if (!hpriv->clks[1]) {
> > +	if (hpriv->n_clks < 2) {
> >  		dev_err(dev, "reference clock not supplied\n");
> >  		return -EINVAL;
> >  	}
> >  
> > -	refclk_rate = clk_get_rate(hpriv->clks[1]);
> > +	refclk_rate = clk_get_rate(hpriv->clks[1].clk);
> >  	if ((refclk_rate % 100) != 0) {
> >  		dev_err(dev, "reference clock rate must be divisible by 100\n");
> >  		return -EINVAL;
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 1e9e825d6cc5..814804582d1d 100644
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
> > +	int child_nodes, rc = -ENOMEM, enabled_ports = 0;
> >  	struct device *dev = &pdev->dev;
> >  	struct ahci_host_priv *hpriv;
> > -	struct clk *clk;
> >  	struct device_node *child;
> > -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
> >  	u32 mask_port_map = 0;
> >  
> >  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> > @@ -415,25 +396,38 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >  		goto err_out;
> >  	}
> >  
> > -	for (i = 0; i < AHCI_MAX_CLKS; i++) {
> > +	/*
> > +	 * Bulk clocks getting procedure can fail to find any clock due to
> > +	 * running on a non-OF platform or due to the clocks being defined in
> > +	 * bypass of the DT firmware (like da850, spear13xx). In that case we
> > +	 * fallback to getting a single clock source right from the dev clocks
> > +	 * list.
> > +	 */
> > +	rc = devm_clk_bulk_get_all(dev, &hpriv->clks);
> > +	if (rc < 0)
> > +		goto err_out;
> > +
> > +	if (rc > 0) {
> > +		/* Got clocks in bulk */
> > +		hpriv->n_clks = rc;
> > +	} else {
> >  		/*
> > -		 * For now we must use clk_get(dev, NULL) for the first clock,
> > -		 * because some platforms (da850, spear13xx) are not yet
> > -		 * converted to use devicetree for clocks.  For new platforms
> > -		 * this is equivalent to of_clk_get(dev->of_node, 0).
> > +		 * No clock bulk found: fallback to manually getting
> > +		 * the optional clock.
> >  		 */
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
> > +		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
> > +		if (!hpriv->clks) {
> > +			rc = -ENOMEM;
> > +			goto err_out;
> > +		}
> > +		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
> > +		if (IS_ERR(hpriv->clks->clk)) {
> > +			rc = PTR_ERR(hpriv->clks->clk);
> > +			goto err_out;
> > +		} else if (hpriv->clks->clk) {
> > +			hpriv->clks->id = __clk_get_name(hpriv->clks->clk);
> > +			hpriv->n_clks = 1;
> >  		}
> > -		hpriv->clks[i] = clk;
> >  	}
> >  
> >  	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
