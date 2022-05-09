Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A025206C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiEIVnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiEIVn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:43:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40912F1CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0BB9B8190E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048DBC385BF;
        Mon,  9 May 2022 21:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652132371;
        bh=w64WFP+FS1qwSJLrrBULSTI0uZjKMayFTRWfozu9uWY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gAGP0xXbaGOEmZFA7GOCOb7EDosDpfZvPezk79kmKm3UiwHBf638JxXgRhKRp1UyW
         QaU6dZQSHhE5zxRgkH9CvAl//cKb2nmmJrhVw8jezSaCzUIVlnu1jTgAF/d0byUFDp
         vXqkl0oMdf5/259HkFfAITGp5NyZf98LwoRiWxEJgeH3Fhh6YW9tS06MLDVYaqShip
         c/6yOX1XoQTH6geB1X7IG4QFq0qWHTdIQ7SPvIsR900+rggdPmvlSkvOKPx2Yp8Yta
         L+7Ya24X20Y695X34KBvaYmzpcQqK835jSoTGiN4TmxPPB/IbY2vDOR3m6Q9tIJIKD
         vjmxrqjRK4IFg==
Date:   Mon, 9 May 2022 14:39:31 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 6/7] xen/grant-dma-ops: Retrieve the ID of backend's
 domain for DT devices
In-Reply-To: <1651947548-4055-7-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205091438500.43560@ubuntu-linux-20-04-desktop>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com> <1651947548-4055-7-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Use the presence of recently introduced "xen,dev-domid" property
> in the device node as a clear indicator of enabling Xen grant
> mappings scheme for that device and read the ID of Xen domain where
> the corresponding backend resides. The ID (domid) is used as
> an argument to the Xen grant mapping APIs.
> 
> Also introduce xen_is_grant_dma_device() to check whether xen-grant
> DMA ops need to be set for a passed device.
> 
> Remove the hardcoded domid 0 in xen_grant_setup_dma_ops().
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> Changes RFC -> V1:
>    - new patch, split required changes from commit:
>     "[PATCH 4/6] virtio: Various updates to xen-virtio DMA ops layer"
>    - update checks in xen_virtio_setup_dma_ops() to only support
>      DT devices for now
>    - remove the "virtio,mmio" check from xen_is_virtio_device()
>    - remane everything according to the new naming scheme:
>      s/virtio/grant_dma
> 
> Changes V1 -> V2:
>    - remove dev_is_pci() check in xen_grant_setup_dma_ops()
>    - remove EXPORT_SYMBOL_GPL(xen_is_grant_dma_device);
> ---
>  drivers/xen/grant-dma-ops.c | 24 +++++++++++++++++-------
>  include/xen/xen-ops.h       |  5 +++++
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index 29ad7bf..8924178 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -55,11 +55,6 @@ static struct xen_grant_dma_data *find_xen_grant_dma_data(struct device *dev)
>   * Such a DMA address is formed by using the grant reference as a frame
>   * number and setting the highest address bit (this bit is for the backend
>   * to be able to distinguish it from e.g. a mmio address).
> - *
> - * Note that for now we hard wire dom0 to be the backend domain. In order
> - * to support any domain as backend we'd need to add a way to communicate
> - * the domid of this backend, e.g. via Xenstore, via the PCI-device's
> - * config space or DT/ACPI.
>   */
>  static void *xen_grant_dma_alloc(struct device *dev, size_t size,
>  				 dma_addr_t *dma_handle, gfp_t gfp,
> @@ -275,6 +270,15 @@ static const struct dma_map_ops xen_grant_dma_ops = {
>  	.dma_supported = xen_grant_dma_supported,
>  };
>  
> +bool xen_is_grant_dma_device(struct device *dev)
> +{
> +	/* XXX Handle only DT devices for now */
> +	if (!dev->of_node)
> +		return false;
> +
> +	return of_property_read_bool(dev->of_node, "xen,dev-domid");
> +}
> +
>  void xen_grant_setup_dma_ops(struct device *dev)
>  {
>  	struct xen_grant_dma_data *data;
> @@ -286,8 +290,14 @@ void xen_grant_setup_dma_ops(struct device *dev)
>  		return;
>  	}
>  
> -	/* XXX The dom0 is hardcoded as the backend domain for now */
> -	dev_domid = 0;
> +	/* XXX ACPI device unsupported for now */
> +	if (!dev->of_node)
> +		goto err;
> +
> +	if (of_property_read_u32(dev->of_node, "xen,dev-domid", &dev_domid)) {
> +		dev_err(dev, "xen,dev-domid property is not present\n");
> +		goto err;
> +	}
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> index 4f9fad5..62be9dc 100644
> --- a/include/xen/xen-ops.h
> +++ b/include/xen/xen-ops.h
> @@ -223,10 +223,15 @@ static inline void xen_preemptible_hcall_end(void) { }
>  
>  #ifdef CONFIG_XEN_GRANT_DMA_OPS
>  void xen_grant_setup_dma_ops(struct device *dev);
> +bool xen_is_grant_dma_device(struct device *dev);
>  #else
>  static inline void xen_grant_setup_dma_ops(struct device *dev)
>  {
>  }
> +static inline bool xen_is_grant_dma_device(struct device *dev)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_XEN_GRANT_DMA_OPS */
>  
>  #endif /* INCLUDE_XEN_OPS_H */
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
