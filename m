Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9D854AC62
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242359AbiFNIrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355880AbiFNIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:45:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC815BCBD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655196341; x=1686732341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=730WLOxUDl/tCCXOxzEMJE/Etnsc1xvpiRS8SMWclV4=;
  b=Fs56aKPDnaxtAYnHtHu8a9ZvoIXAGUoGxn5KknLa6Uy67nMnuCZY932a
   TCYUC7ELi3CJvzGyJq7J5t1OS4W4hVqw9q4krwYNUe7+PgiDmRy7OXQpa
   Z+m+ObVNiK66ByO8+3T5RdoZDsGCC7i4QGuwoOrF1rtlwaHFcyIyLsWUc
   KeoKtdmofizCM91oiu7GSppAh8wy/Ux2ibZRQozz09vBae6SksiMlgVst
   1i2tqwfsZEJkE266I6RO1uuh0CgM2YkfRD62NedjGHVy0W5iplgI8oeYG
   eHbo0ib4Ggp6bEKfyp8FGB7pzAqsiX8WXs9wojSMgcL0NcBOk6jrNDWvn
   g==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="307388539"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 16:45:40 +0800
IronPort-SDR: HkUahpm5A3Zh/IWQnH9d0t0uNXevoQUguqM7180TVqgeZ50Vb4UGA9lb+9cS+BCmSxedgEh3/a
 YhHSHEL82wvmgAD7N6btdrZs5ZOlUwQ5s6bx9j9J28q7jANfr6lh/74ozSjYVeDQ00pHL16hSe
 wCRCPRyoxHvZ4QLpZG//AT62kD2BcxOuC3s3CShpkY8ITRAJemKE89aWa7ZYyuxEkHFJ3MBDPZ
 zpiYZb3QXlBDu6ejdbwRSPf5oa/fT6jA9AcRMe6PDPBNtEg1Tu9ZH4wH761FRrNdSD8NCMfB/f
 SzQss5vAzM/Sc8sAHy11tcqx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 01:08:39 -0700
IronPort-SDR: 4xBh05AFk7GH9IHUIpgn/GyLfXwy3+gy/qUkeyrq9SE3QN3NkdNqOT4OMdyRJXtJ/aVagbZKBs
 jFzaupwGL1azoL4P/EFG2Lrq74VJVh0qQTT3F8OayOjl4dEPanzuvKKB7OYwZVaTrF1/GvCkwC
 cO0S3Q4BQNoQDm7V7XGoiz8zy/HJvJSy50M47Cq+o0DtKww7Ese8kO7dE/X/4w2XFyDsCnSD+s
 B7MI22J7g9O9SdBFXFPLHkEEmQ/s2H+WDAaFGP0svBYPCyfz6aJsPjcroUZrIqvIExQ5DoZGJe
 bf0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 01:45:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LMhpq5ZPFz1SVp3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:45:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655196338; x=1657788339; bh=730WLOxUDl/tCCXOxzEMJE/Etnsc1xvpiRS
        8SMWclV4=; b=iMAF22D08tLP22EwyW2EGAImbpK8eQcBbDj01cr5hIdTvMvn9pl
        Z/xRZHFpQs+YVoEdTBqfq0NqDouapToDlh8A9TSpdO9Dp0Bk8kza4wB95o4kOUCh
        bKBxD34JxEGV1T/fUMszf/o+rIlyL4nCfwxD4dH2MwSnQPm5FH5bRPjMTE2Y3dAz
        derj6ZqUDHj4Y6mieLfh0do48fDsyz3OA4etLnu5zXg85LW/mwcXOZT/3HKB1QS+
        O7n1pg/UpQLtzJY5Ikore7lRjNXFehJmKUBmoSYW0mLnHU77J9XxbPrakqxVcf9q
        vTyT1w9p0RSWdf30ruP4Q40mQQEr7dEcIIQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OfiwjPnO6XjX for <linux-kernel@vger.kernel.org>;
        Tue, 14 Jun 2022 01:45:38 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LMhpn0mkyz1Rvlc;
        Tue, 14 Jun 2022 01:45:36 -0700 (PDT)
Message-ID: <611c8eeb-fa7e-286c-bef2-0e24cc2b6b2e@opensource.wdc.com>
Date:   Tue, 14 Jun 2022 17:45:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 18/23] ata: libahci_platform: Add function returning a
 clock-handle by id
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
 <20220610081801.11854-19-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220610081801.11854-19-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 17:17, Serge Semin wrote:
> Since all the clocks are retrieved by the method
> ahci_platform_get_resources() there is no need for the LLD (glue) drivers
> to be looking for some particular of them in the kernel clocks table
> again. Instead we suggest to add a simple method returning a
> device-specific clock with passed connection ID if it is managed to be
> found. Otherwise the function will return NULL. Thus the glue-drivers
> won't need to either manually touching the hpriv->clks array or calling
> clk_get()-friends. The AHCI platform drivers will be able to use the new
> function right after the ahci_platform_get_resources() method invocation
> and up to the device removal.
> 
> Note the method is left unused here, but will be utilized in the framework
> of the DWC AHCI SATA driver being added in the next commit.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Fix some grammar mistakes in the method description.
> 
> Changelog v4:
> - Add a note regarding the new method usage.
> ---
>  drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
>  include/linux/ahci_platform.h  |  3 +++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 8b542a8bc487..418961f954af 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -95,6 +95,33 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
>  }
>  EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
>  
> +/**
> + * ahci_platform_find_clk - Find platform clock
> + * @hpriv: host private area to store config values
> + * @con_id: clock connection ID
> + *
> + * This function returns a pointer to the clock descriptor of the clock with
> + * the passed ID.
> + *
> + * RETURNS:
> + * Pointer to the clock descriptor on success otherwise NULL
> + */
> +struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id)
> +{
> +	struct clk *clk = NULL;
> +	int i;
> +
> +	for (i = 0; i < hpriv->n_clks; i++) {
> +		if (!strcmp(hpriv->clks[i].id, con_id)) {
> +			clk = hpriv->clks[i].clk;

			return hpriv->clks[i].clk;

> +			break;
> +		}
> +	}
> +
> +	return clk;

And then "return NULL;" here and you do not need the clk variable.

> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
> +
>  /**
>   * ahci_platform_enable_clks - Enable platform clocks
>   * @hpriv: host private area to store config values
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 6d7dd472d370..3418980b0341 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/compiler.h>
>  
> +struct clk;
>  struct device;
>  struct ata_port_info;
>  struct ahci_host_priv;
> @@ -21,6 +22,8 @@ struct scsi_host_template;
>  
>  int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
>  void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
> +struct clk *
> +ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);

Please make this:

struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv,

                                   const char *con_id);

>  int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>  void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
>  int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv);


-- 
Damien Le Moal
Western Digital Research
