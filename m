Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2B654B48B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356390AbiFNPYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344330AbiFNPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0BF220DF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D93F36114C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DACC3411B;
        Tue, 14 Jun 2022 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655220279;
        bh=eafRioV4cM1WwsTt8j9HKQBbSmesvY/NPNGEeGkdCaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZKQZ6lMl8lZawEh5WPG8EF4Q3BxouZz5Kh3Jq1VUETaEC515k2vOI5+OLM4Pynwkw
         ZXq8vERqlgz5HhxNDOiYiegdshnMupqFoJXTJgKGmD0IuDtNxiGyNd2oV81GA1CnpW
         c1lZEoZUkPSnNKjhXllLnJzP9PO/uzV0tO+0yKOs=
Date:   Tue, 14 Jun 2022 17:24:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Vetter <jvetter@kalrayinc.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        ysionneau@kalrayinc.com, jmaselbas@kalrayinc.com
Subject: Re: [PATCH v2 2/2] msi: Add sanity check if more than MAX_DEV_MSIS
 MSIs are requested
Message-ID: <YqioNIOaAWfgX5sk@kroah.com>
References: <20220614151411.32674-1-jvetter@kalrayinc.com>
 <20220614151411.32674-2-jvetter@kalrayinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614151411.32674-2-jvetter@kalrayinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:14:11PM +0200, Julian Vetter wrote:
> If a device requests more than MAX_DEV_MSIS the MSI index will collide with
> the devid and might cause Linux to compute twice the same virtual interrupt
> number for two different devices.
> 
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> Changes v1->v2:
>   - Took Greg Kroah-Hartman's comments into account
>   - Replaced WARN_ON() by proper error handling
> 
>  drivers/base/platform-msi.c       |  8 +++++++-
>  drivers/bus/fsl-mc/fsl-mc-msi.c   |  3 ++-
>  drivers/irqchip/irq-ti-sci-inta.c |  3 ++-
>  drivers/pci/controller/vmd.c      |  3 ++-
>  drivers/pci/msi/irqdomain.c       |  3 ++-
>  include/linux/msi.h               |  2 +-
>  kernel/irq/msi.c                  | 12 +++++++++---
>  7 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 4b0b2fe3a7ff..8330153c0067 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -43,10 +43,16 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
>  	return (devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;
>  }
>  
> -static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
> +static int platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
>  {
>  	arg->desc = desc;
>  	arg->hwirq = platform_msi_calc_hwirq(desc);
> +
> +	if (desc->msi_index >= MAX_DEV_MSIS) {
> +		dev_err(desc->dev, "Number of msis exceeds %d\n", MAX_DEV_MSIS);
> +		return -EINVAL;
> +	}
> +	return 0;
>  }
>  
>  static int platform_msi_init(struct irq_domain *domain,
> diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
> index 0cfe859a4ac4..63b5ae8de391 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-msi.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
> @@ -32,12 +32,13 @@ static irq_hw_number_t fsl_mc_domain_calc_hwirq(struct fsl_mc_device *dev,
>  	return (irq_hw_number_t)(desc->msi_index + (dev->icid * 10000));
>  }
>  
> -static void fsl_mc_msi_set_desc(msi_alloc_info_t *arg,
> +static int fsl_mc_msi_set_desc(msi_alloc_info_t *arg,
>  				struct msi_desc *desc)
>  {
>  	arg->desc = desc;
>  	arg->hwirq = fsl_mc_domain_calc_hwirq(to_fsl_mc_device(desc->dev),
>  					      desc);
> +	return 0;
>  }
>  #else
>  #define fsl_mc_msi_set_desc NULL
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
> index 5fdbb4358dd0..0c26690c074b 100644
> --- a/drivers/irqchip/irq-ti-sci-inta.c
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -589,13 +589,14 @@ static struct irq_chip ti_sci_inta_msi_irq_chip = {
>  	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
>  };
>  
> -static void ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
> +static int ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
>  				     struct msi_desc *desc)
>  {
>  	struct platform_device *pdev = to_platform_device(desc->dev);
>  
>  	arg->desc = desc;
>  	arg->hwirq = TO_HWIRQ(pdev->id, desc->msi_index);
> +	return 0;
>  }
>  
>  static struct msi_domain_ops ti_sci_inta_msi_ops = {
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 94a14a3d7e55..929ba2a991b5 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -296,9 +296,10 @@ static int vmd_msi_prepare(struct irq_domain *domain, struct device *dev,
>  	return 0;
>  }
>  
> -static void vmd_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
> +static int vmd_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
>  {
>  	arg->desc = desc;
> +	return 0;
>  }
>  
>  static struct msi_domain_ops vmd_msi_domain_ops = {
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index e9cf318e6670..3191f15a07b8 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -108,11 +108,12 @@ static int pci_msi_domain_check_cap(struct irq_domain *domain,
>  	return 0;
>  }
>  
> -static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
> +static int pci_msi_domain_set_desc(msi_alloc_info_t *arg,
>  				    struct msi_desc *desc)
>  {
>  	arg->desc = desc;
>  	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
> +	return 0;
>  }
>  
>  static struct msi_domain_ops pci_msi_domain_ops_default = {
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index fc918a658d48..17228d6e8d85 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -355,7 +355,7 @@ struct msi_domain_ops {
>  	int		(*msi_prepare)(struct irq_domain *domain,
>  				       struct device *dev, int nvec,
>  				       msi_alloc_info_t *arg);
> -	void		(*set_desc)(msi_alloc_info_t *arg,
> +	int		(*set_desc)(msi_alloc_info_t *arg,
>  				    struct msi_desc *desc);
>  	int		(*domain_alloc_irqs)(struct irq_domain *domain,
>  					     struct device *dev, int nvec);
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index a9ee535293eb..a20c85334b58 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -592,10 +592,11 @@ static int msi_domain_ops_prepare(struct irq_domain *domain, struct device *dev,
>  	return 0;
>  }
>  
> -static void msi_domain_ops_set_desc(msi_alloc_info_t *arg,
> +static int msi_domain_ops_set_desc(msi_alloc_info_t *arg,
>  				    struct msi_desc *desc)
>  {
>  	arg->desc = desc;
> +	return 0;
>  }
>  
>  static int msi_domain_ops_init(struct irq_domain *domain,
> @@ -726,7 +727,10 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
>  		desc = xa_load(&dev->msi.data->__store, virq);
>  		desc->irq = virq;
>  
> -		ops->set_desc(arg, desc);
> +		ret = ops->set_desc(arg, desc);
> +		if (ret)
> +			goto fail;
> +
>  		ret = irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
>  		if (ret)
>  			goto fail;
> @@ -888,7 +892,9 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  	}
>  
>  	msi_for_each_desc(desc, dev, MSI_DESC_NOTASSOCIATED) {
> -		ops->set_desc(&arg, desc);
> +		ret = ops->set_desc(&arg, desc);
> +		if (ret)
> +			return ret;

Shouldn't you unwind anything that was already allocated before this
call?

thanks,

greg k-h
