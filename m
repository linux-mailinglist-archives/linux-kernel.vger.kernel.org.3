Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B2454ABB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiFNIWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiFNIWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:22:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A91419AF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655194929; x=1686730929;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AaMT0IGd7k5gzjqCn0qpz01EgHi4ZkJG3tpDWeFzWJk=;
  b=ChvXO6ResjdCl2YKYN5SIGuA4I0MvHfMbaGkLPlUY8Dy2Do3Nlh+6Yhw
   P4Bpl9sbmf5Ii3o8WGDrnkp6JiWu/m9rnSHtSOqqu4k/YcaZzvcFC2zKu
   ogz8jI9BM7PplYeqqGfdDuGmmJFVO9LCuRsnco7qbtA3/lQgeoO7aekqm
   0zucgjM4Yt7rR/CIYHR4TxdKmrfCpvw4hAPpEh3oIxsZYAiRpd00/ZjI6
   4oJl0/PbwwEtEHNpbPvMlXPM/FBh6mQMo1/RCB+RhV0TQsbrQ9XX7q3dj
   sGMMJjD0xJEbxaflkruFfuTmTRvPfSqJNzxNl8ALpWNmq3vzQL0pWSbR9
   w==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="201810706"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 16:22:08 +0800
IronPort-SDR: mw39mrGHbDQq05KVrLXzg2zGCURqR73N3dXQMkA5ohqxhi2Oyx1vIc3W73B4WhQq5vueVjvxGT
 pTzS5tMrfSAaDZEC5ROgrslvQAt7u0H97aAGfuUoUQex/gNdB9RnJwgYAXp+u+H7fN/Nj2KaTn
 D8hgn59jhNxQ8sa6X6HrrhOHy1EWpngcVRKf+ZBFDYD3jHBu1rzRS/gAdvBdRwIY3dyo1D5Ajw
 hGnLuanrlYUVZCatpYG7YJssLUQGa6tT7CMTj7oo47MW/SeaXuHCkBkiNGw9ZB93qJNKUbnKKr
 Ed4PJVDwQsbPEvTJmyBc6yKv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 00:40:44 -0700
IronPort-SDR: d/8yRVP+I3Peqhtb9zxg935llFt9jWAel8Bm06F1Gqf+D0+Ys4YiMAUD9fm9gzxaeKBnu3Cl0H
 fEI9/xTWQq7NjQ5tFij3yPMqbXfaatOtYC9z7TLi7UQpCrcMg3wpSXuCWyNVwud05RWwB9OprI
 PIWPw5qo3T6b0YjO4fBSy0WJuEuK7cx8wawuipQTqmlrh3skESkcEYgdAtSRtCmUEJ1r8XG/bJ
 kfolKlgzQ2UixC9NXH8Uwo+1/VqzeodVLEcy1xeK27eKjMaDBTH2ADp7Rfc0MKW/BBYz5qCOhC
 hbQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 01:22:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LMhHh2HrVz1Rwrw
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:22:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655194926; x=1657786927; bh=AaMT0IGd7k5gzjqCn0qpz01EgHi4ZkJG3tp
        DWeFzWJk=; b=LoMhA/ga+XExP07R0kpt+GcAYVZb/LT0oQXer45OGt/tMEdOkLU
        sYwHxf3gcu81RNxlmvgK2EQ40f9iocie2R0eSR3xyrmjg0FJpchadV9jHos8nkuj
        8rMksvwOsWQqQmdcFvEUNQ2oJUQTOSSSeNoXOnNSvu2YWyczMnFYtJ075aOVd/L+
        C1GinbGuMqN8Fdfl/zgieNP6r1d9MINaTwLxEdMGruVIzg7lCItHGzD61uvUcCRe
        bEvxegGhi1ghXaKmN7jIhx2TkSpJxXNvO6rPlXrs/q1EPASPWQLlF1UMyfITyYqm
        GfVBwCOiP+TRe4J5n+3vbsQfvaTQ6zStocw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RmVZBgfM2mwo for <linux-kernel@vger.kernel.org>;
        Tue, 14 Jun 2022 01:22:06 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LMhHc126Gz1Rvlc;
        Tue, 14 Jun 2022 01:22:03 -0700 (PDT)
Message-ID: <3bf20887-6e2f-41f4-e4ec-5c2278f6cb18@opensource.wdc.com>
Date:   Tue, 14 Jun 2022 17:22:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 07/23] ata: libahci_platform: Convert to using devm
 bulk clocks API
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-8-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220610081801.11854-8-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 17:17, Serge Semin wrote:
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
> auto-detected. So the LLDD (glue) drivers can make sure that the required
> clocks are specified just by checking the clock IDs in the clk_bulk_data
> array.  Thirdly using the handy Bulk Clocks kernel API improves the
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
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> ---
> 
> Changelog v2:
> - Convert to checking the error-case first in the devm_clk_bulk_get_all()
>   method invocation. (@Damien)
> - Fix some grammar mistakes in the comments.
> ---
>  drivers/ata/ahci.h             |  4 +-
>  drivers/ata/libahci_platform.c | 84 ++++++++++++++++------------------
>  2 files changed, 41 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index ad11a4c52fbe..c3770a19781b 100644
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
> @@ -339,7 +338,8 @@ struct ahci_host_priv {
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
> index 1e9e825d6cc5..814804582d1d 100644
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
> +	int child_nodes, rc = -ENOMEM, enabled_ports = 0;
>  	struct device *dev = &pdev->dev;
>  	struct ahci_host_priv *hpriv;
> -	struct clk *clk;
>  	struct device_node *child;
> -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
>  	u32 mask_port_map = 0;
>  
>  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> @@ -415,25 +396,38 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  		goto err_out;
>  	}
>  
> -	for (i = 0; i < AHCI_MAX_CLKS; i++) {
> +	/*
> +	 * Bulk clocks getting procedure can fail to find any clock due to
> +	 * running on a non-OF platform or due to the clocks being defined in
> +	 * bypass of the DT firmware (like da850, spear13xx). In that case we
> +	 * fallback to getting a single clock source right from the dev clocks
> +	 * list.
> +	 */
> +	rc = devm_clk_bulk_get_all(dev, &hpriv->clks);
> +	if (rc < 0)
> +		goto err_out;
> +
> +	if (rc > 0) {
> +		/* Got clocks in bulk */
> +		hpriv->n_clks = rc;
> +	} else {
>  		/*
> -		 * For now we must use clk_get(dev, NULL) for the first clock,
> -		 * because some platforms (da850, spear13xx) are not yet
> -		 * converted to use devicetree for clocks.  For new platforms
> -		 * this is equivalent to of_clk_get(dev->of_node, 0).
> +		 * No clock bulk found: fallback to manually getting
> +		 * the optional clock.
>  		 */
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
> +		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
> +		if (!hpriv->clks) {
> +			rc = -ENOMEM;
> +			goto err_out;
> +		}
> +		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
> +		if (IS_ERR(hpriv->clks->clk)) {
> +			rc = PTR_ERR(hpriv->clks->clk);
> +			goto err_out;
> +		} else if (hpriv->clks->clk) {

Nit: the else is not needed here.

> +			hpriv->clks->id = __clk_get_name(hpriv->clks->clk);
> +			hpriv->n_clks = 1;
>  		}
> -		hpriv->clks[i] = clk;
>  	}
>  
>  	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");


-- 
Damien Le Moal
Western Digital Research
