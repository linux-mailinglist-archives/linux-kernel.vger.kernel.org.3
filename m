Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CA44E5CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347171AbiCXBan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345146AbiCXBak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:30:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA89B3B553
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648085349; x=1679621349;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sYk23p88QaG4iUDw1nrLnsq/olOpHpMdw0A7ultn47c=;
  b=git3JRbOyajPJ1VaKY2aXJeM2Ot6Whuzn0corbNHmwW4g0WNPsaQXUac
   FQQ6CqClIGBhpqjYyD15Gui5tiJHHCbxyvLDKVo8eFFpyr8gxJY8Wzy66
   ZszwrkjSm7SQXkPeACcBt5AwCk+nCnnyGnJGV8rc5oVE1uD+PvJI1s0wA
   AWS6TJK5ianziwGdtLwEjB46ON2pIR0TU0R4mQEr0yGRgDuyDYF9+ufYm
   YYJ2F/1RQWKMlQIDnHybYkrYlnO2lzkDw/MFrUVchqh1ZWBgyiiSpghF4
   4Hbb7FnLGmndgMULS20I1R9zXx68j84vCMS1lP9bjOgkKiMzbVyuZwRxq
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="300266420"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 09:29:06 +0800
IronPort-SDR: YD55I9mg3/5X/fM5aXLbH58bnhhX1XBxgVxXZReyDHb3vMcgVmQKx/zXgzc4/RhAybTb+miAFX
 IAj81eoNPVekDx271OvJbY/00TUpoz/BqyTykq10AcLUsWYDfoflSXun3EEAkuM+qJbvM3QbQJ
 P+KDBzzfFUfXzwCNJySZr3PjLcsG6XWuxdp2pWQ3qAHT+EcZQ3D0dqNaxgYww0UlyLBPCg9fCe
 3EYiAidLqzCRlRsX3vC+LTpltMCUljCs9wCkjCP2mOmaNBgcgIyvlJJDTvWNWGIGOknyvamEf9
 tQgJAdOoP/jTdvI/qcoDnhs1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:00:03 -0700
IronPort-SDR: Pc39ZQktXYfFd6R2qyVmgVGPw/cZIvSB+xStvZ+2lEcEC2SNHTN849hZReNpboZfYdoOWr/99d
 8RnZz8HKE3qGdwYah43fGc8wHOV1imfmoRTAeno6QP+UqY15zw/5OYF4GV9SO40+1IcOnkwlD4
 GrFVZb50KjcS35EvpPacJSy82NOmKwLOP4UroqIHzpR3rkNeFIlZIIi2YvCxLbjl5vuGv5NoDo
 phtgwvvFhcu1gqyiXY+Bsk4LtnwOtoX+MuZW+drI9bvhDcgUBfN+oKSIAjBknKv/0Fm7A+WE5q
 8EQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:29:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP70x6n5qz1SVp3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:29:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648085344; x=1650677345; bh=sYk23p88QaG4iUDw1nrLnsq/olOpHpMdw0A
        7ultn47c=; b=YtmkRzlBci7GDgr4lTu6BQJ93bXV3RR2HpobwXABh4ys6Bu2sFv
        hYVSJH5gtTSpda+z71Iw2pr9P4QfvxEdZU53xHNDrOHpz5myNjbJkz3vUHfOlX/M
        bk2DFYD3C5NOysbALZDVPC5MvgdKtYc3DSb+2WZvcinz4KnfBDeon1hBdGlmCEs1
        Y39IJ9VLmwWURGBcy5d3/DaGn3imAgJ6Dab7CH40XnRM7l/vd2U4z+/l5wGdCz8r
        BMVCA7znNMjQrm3BwlXcKUEnC3p21jmArXkL5X4mcTIFh6SMkYIetxzyZ87PA2ro
        8BY4+q9gF8AQKAevEzOdLuslTd9+mrmlr2w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R7EoYI9vemMQ for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 18:29:04 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP70t5RZxz1Rvlx;
        Wed, 23 Mar 2022 18:29:02 -0700 (PDT)
Message-ID: <603eb020-3f43-c193-b3f6-8ff697f845c8@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 10:29:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 05/21] ata: libahci_platform: Convert to using devm bulk
 clocks API
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-6-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-6-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> In order to simplify the clock-related code there is a way to convert the
> current fixed clocks array into using the common bulk clocks kernel API
> with dynamic set of the clock handlers and device-managed clock-resource
> tracking. It's a bit tricky due to the complication coming from the
> requirement to support the platforms (da850, spear13xx) with the
> non-OF-based clock source, but still doable.
> 
> Before this modification there are two methods have been used to get the
> clocks connected to an AHCI device: clk_get() - to get the very first
> clock in the list and of_clk_get() - to get the rest of them. Basically
> the platforms with non-OF-based clocks definition could specify only a
> single reference clock source. The platforms with OF-hw clocks have been
> luckier and could setup up to AHCI_MAX_CLKS clocks. Such semantic can be
> retained with using devm_clk_bulk_get_all() to retrieve the clocks defined
> via the DT firmware and devm_clk_get_optional() otherwise. In both cases
> using the device-managed version of the methods will cause the automatic
> resources deallocation on the AHCI device removal event. The only
> complicated part in the suggested approach is the explicit allocation and
> initialization of the clk_bulk_data structure instance for the non-OF
> reference clocks. It's required in order to use the Bulk Clocks API for
> the both denoted cases of the clocks definition.
> 
> Note aside with the clock-related code reduction and natural
> simplification, there are several bonuses the suggested modification
> provides. First of all the limitation of having no greater than
> AHCI_MAX_CLKS clocks is now removed, since the devm_clk_bulk_get_all()
> method will allocate as many reference clocks data descriptors as there
> are clocks specified for the device. Secondly the clock names are
> auto-detected. So the glue drivers can make sure that the required clocks
> are specified just by checking the clock IDs in the clk_bulk_data array.
> Thirdly using the handy Bulk Clocks kernel API improves the
> clocks-handling code readability. And the last but not least this
> modification implements a true optional clocks support to the
> ahci_platform_get_resources() method. Indeed the previous clocks getting
> procedure just stopped getting the clocks on any errors (aside from
> non-critical -EPROBE_DEFER) in a way so the callee wasn't even informed
> about abnormal loop termination. The new implementation lacks of such
> problem. The ahci_platform_get_resources() will return an error code if
> the corresponding clocks getting method ends execution abnormally.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/ahci.h             |  4 +-
>  drivers/ata/libahci_platform.c | 82 +++++++++++++++-------------------
>  2 files changed, 37 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index eeac5482f1d1..1564c691094a 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -38,7 +38,6 @@
>  
>  enum {
>  	AHCI_MAX_PORTS		= 32,
> -	AHCI_MAX_CLKS		= 5,
>  	AHCI_MAX_SG		= 168, /* hardware max is 64K */
>  	AHCI_DMA_BOUNDARY	= 0xffffffff,
>  	AHCI_MAX_CMDS		= 32,
> @@ -341,7 +340,8 @@ struct ahci_host_priv {
>  	u32			em_msg_type;	/* EM message type */
>  	u32			remapped_nvme;	/* NVMe remapped device count */
>  	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
> -	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
> +	unsigned int		n_clks;
> +	struct clk_bulk_data	*clks;		/* Optional */
>  	struct reset_control	*rsts;		/* Optional */
>  	struct regulator	**target_pwrs;	/* Optional */
>  	struct regulator	*ahci_regulator;/* Optional */
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 8eabbb5f208c..d805ddc3a024 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -8,6 +8,7 @@
>   *   Anton Vorontsov <avorontsov@ru.mvista.com>
>   */
>  
> +#include <linux/clk-provider.h>
>  #include <linux/clk.h>
>  #include <linux/kernel.h>
>  #include <linux/gfp.h>
> @@ -97,28 +98,14 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
>   * ahci_platform_enable_clks - Enable platform clocks
>   * @hpriv: host private area to store config values
>   *
> - * This function enables all the clks found in hpriv->clks, starting at
> - * index 0. If any clk fails to enable it disables all the clks already
> - * enabled in reverse order, and then returns an error.
> + * This function enables all the clks found for the AHCI device.
>   *
>   * RETURNS:
>   * 0 on success otherwise a negative error code
>   */
>  int ahci_platform_enable_clks(struct ahci_host_priv *hpriv)
>  {
> -	int c, rc;
> -
> -	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {
> -		rc = clk_prepare_enable(hpriv->clks[c]);
> -		if (rc)
> -			goto disable_unprepare_clk;
> -	}
> -	return 0;
> -
> -disable_unprepare_clk:
> -	while (--c >= 0)
> -		clk_disable_unprepare(hpriv->clks[c]);
> -	return rc;
> +	return clk_bulk_prepare_enable(hpriv->n_clks, hpriv->clks);
>  }
>  EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
>  
> @@ -126,16 +113,13 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
>   * ahci_platform_disable_clks - Disable platform clocks
>   * @hpriv: host private area to store config values
>   *
> - * This function disables all the clks found in hpriv->clks, in reverse
> - * order of ahci_platform_enable_clks (starting at the end of the array).
> + * This function disables all the clocks enabled before
> + * (bulk-clocks-disable function is supposed to do that in reverse
> + * from the enabling procedure order).
>   */
>  void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
>  {
> -	int c;
> -
> -	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
> -		if (hpriv->clks[c])
> -			clk_disable_unprepare(hpriv->clks[c]);
> +	clk_bulk_disable_unprepare(hpriv->n_clks, hpriv->clks);
>  }
>  EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
>  
> @@ -292,8 +276,6 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
>  		pm_runtime_disable(dev);
>  	}
>  
> -	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
> -		clk_put(hpriv->clks[c]);
>  	/*
>  	 * The regulators are tied to child node device and not to the
>  	 * SATA device itself. So we can't use devm for automatically
> @@ -374,8 +356,8 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
>   * 1) mmio registers (IORESOURCE_MEM 0, mandatory)
>   * 2) regulator for controlling the targets power (optional)
>   *    regulator for controlling the AHCI controller (optional)
> - * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
> - *    or for non devicetree enabled platforms a single clock
> + * 3) all clocks specified in the devicetree node, or a single
> + *    clock for non-OF platforms (optional)
>   * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
>   * 5) phys (optional)
>   *
> @@ -385,11 +367,10 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
>  struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  						   unsigned int flags)
>  {
> +	int enabled_ports = 0, rc = 0, child_nodes;
>  	struct device *dev = &pdev->dev;
>  	struct ahci_host_priv *hpriv;
> -	struct clk *clk;
>  	struct device_node *child;
> -	int i, enabled_ports = 0, rc = 0, child_nodes;
>  	u32 mask_port_map = 0;
>  
>  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> @@ -413,25 +394,32 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  		}
>  	}
>  
> -	for (i = 0; i < AHCI_MAX_CLKS; i++) {
> -		/*
> -		 * For now we must use clk_get(dev, NULL) for the first clock,
> -		 * because some platforms (da850, spear13xx) are not yet
> -		 * converted to use devicetree for clocks.  For new platforms
> -		 * this is equivalent to of_clk_get(dev->of_node, 0).
> -		 */
> -		if (i == 0)
> -			clk = clk_get(dev, NULL);
> -		else
> -			clk = of_clk_get(dev->of_node, i);
> -
> -		if (IS_ERR(clk)) {
> -			rc = PTR_ERR(clk);
> -			if (rc == -EPROBE_DEFER)
> -				goto err_out;
> -			break;
> +	/*
> +	 * Bulk clock get procedure can fail to find any clock due to running
> +	 * an a non-OF platform or due to the clocks being defined in bypass
> +	 * from the DT firmware (like da850, spear13xx). In that case we
> +	 * fallback to getting a single clock source right from the dev clocks
> +	 * list.
> +	 */
> +	rc = devm_clk_bulk_get_all(dev, &hpriv->clks);

I would move the error check first here to make things more readable:

	rc = devm_clk_bulk_get_all(dev, &hpriv->clks);
	if (rc < 0)
		goto err_out;

	if (rc) {
		/* Got clocks in bulk */
		hpriv->n_clks = rc;
	} else {
		/*
		 * No clock bulk found: fallback to manually getting
		 * the optional clock.
		 */
		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks),
					   GFP_KERNEL);
		...
	}

And it may be cleaner to move this entire code hunk into a helper,
something like ahci_platform_get_clks() ?

> +	if (rc > 0) {
> +		hpriv->n_clks = rc;
> +	} else if (!rc) {
> +		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
> +		if (!hpriv->clks) {
> +			rc = -ENOMEM;
> +			goto err_out;
>  		}
> -		hpriv->clks[i] = clk;
> +		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
> +		if (IS_ERR(hpriv->clks->clk)) {
> +			rc = PTR_ERR(hpriv->clks->clk);
> +			goto err_out;
> +		} else if (hpriv->clks->clk) {
> +			hpriv->clks->id = __clk_get_name(hpriv->clks->clk);
> +			hpriv->n_clks = 1;
> +		}
> +	} else {
> +		goto err_out;
>  	}
>  
>  	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");


-- 
Damien Le Moal
Western Digital Research
