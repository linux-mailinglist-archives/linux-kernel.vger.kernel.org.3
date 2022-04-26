Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8A950FAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349189AbiDZKhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349232AbiDZKgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:36:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD09DD9;
        Tue, 26 Apr 2022 03:19:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E27F3B81CB3;
        Tue, 26 Apr 2022 10:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB09DC385A0;
        Tue, 26 Apr 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650968361;
        bh=j+5Gg04ntkDylu76dqEFRo5qzQpdaCHnki2h2mUTJ84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rudUA0MeC0tgXVdjfH0e2MfpL7sWACDwArIl8G43CGKg8Q6k25aM66KMY558cFvIY
         5Gx8mtlutXr6T3eZCfKTDu/9Ldx1/F+l4PVZPR9tsLpym/NvkFD/WCURHSK49J8aqx
         tYtrhWzYc/bYDI2V3g4C+A40xTH9AHK2RJNbN9eM=
Date:   Tue, 26 Apr 2022 12:19:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 2/5] usb: host: add xhci hooks for xhci-exynos
Message-ID: <YmfHJYu9lIwz8JT5@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092021epcas2p1a8d41039d9b3226f4e00f7d4bded833a@epcas2p1.samsung.com>
 <1650964728-175347-3-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650964728-175347-3-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:18:45PM +0900, Daehwan Jung wrote:
> To enable supporting for USB offload, define "offload" in usb controller
> node of device tree. "offload" value can be used to determine which type
> of offload was been enabled in the SoC.
> 
> For example:
> 
> &usbdrd_dwc3 {
> 	...
> 	/* support usb offloading, 0: disabled, 1: audio */
> 	offload = <1>;
> 	...
> };
> 
> There are several vendor_ops introduced by this patch:
> 
> struct xhci_vendor_ops - function callbacks for vendor specific operations
> {
> 	@vendor_init:
> 		- called for vendor init process during xhci-plat-hcd
> 		  probe.
> 	@vendor_cleanup:
> 		- called for vendor cleanup process during xhci-plat-hcd
> 		  remove.
> 	@is_usb_offload_enabled:
> 		- called to check if usb offload enabled.
> 	@alloc_dcbaa:
> 		- called when allocating vendor specific dcbaa during
> 		  memory initializtion.
> 	@free_dcbaa:
> 		- called to free vendor specific dcbaa when cleanup the
> 		  memory.
> 	@alloc_transfer_ring:
> 		- called when vendor specific transfer ring allocation is required
> 	@free_transfer_ring:
> 		- called to free vendor specific transfer ring
> 	@sync_dev_ctx:
> 		- called when synchronization for device context is required
> }
> 
> The xhci hooks with prefix "xhci_vendor_" on the ops in xhci_vendor_ops.
> For example, vendor_init ops will be invoked by xhci_vendor_init() hook,
> is_usb_offload_enabled ops will be invoked by
> xhci_vendor_is_usb_offload_enabled(), and so on.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> Signed-off-by: J. Avila <elavila@google.com>
> Signed-off-by: Puma Hsu <pumahsu@google.com>
> Signed-off-by: Howard Yen <howardyen@google.com>
> ---
>  drivers/usb/host/xhci-hub.c  |   5 ++
>  drivers/usb/host/xhci-mem.c  | 131 +++++++++++++++++++++++++++++++----
>  drivers/usb/host/xhci-plat.c |  44 +++++++++++-
>  drivers/usb/host/xhci-plat.h |   8 +++
>  drivers/usb/host/xhci.c      |  80 ++++++++++++++++++++-
>  drivers/usb/host/xhci.h      |  46 ++++++++++++
>  6 files changed, 296 insertions(+), 18 deletions(-)

Why do you need to "override" anything?  Why can't these just be added
to the current xhci_plat_priv structure and used that way like the
current xhci platform interface works?

> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 841617952ac7..e07c9c132061 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -535,8 +535,13 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
>  	    cmd->status == COMP_COMMAND_RING_STOPPED) {
>  		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
>  		ret = -ETIME;
> +		goto cmd_cleanup;
>  	}
>  
> +	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
> +	if (ret)
> +		xhci_warn(xhci, "Sync device context failed, ret=%d\n", ret);

Shouldn't the function have spit out an error if there was a problem?

> +
>  cmd_cleanup:
>  	xhci_free_command(xhci, cmd);
>  	return ret;
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 82b9f90c0f27..5ee0ffb676d3 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -365,6 +365,54 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
>  	return 0;
>  }
>  
> +static void xhci_vendor_free_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx)
> +{
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
> +	if (ops && ops->free_container_ctx)
> +		ops->free_container_ctx(xhci, ctx);
> +}
> +
> +static void xhci_vendor_alloc_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
> +					    int type, gfp_t flags)
> +{
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
> +	if (ops && ops->alloc_container_ctx)
> +		ops->alloc_container_ctx(xhci, ctx, type, flags);
> +}
> +
> +static struct xhci_ring *xhci_vendor_alloc_transfer_ring(struct xhci_hcd *xhci,
> +		u32 endpoint_type, enum xhci_ring_type ring_type,
> +		unsigned int max_packet, gfp_t mem_flags)
> +{
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
> +	if (ops && ops->alloc_transfer_ring)
> +		return ops->alloc_transfer_ring(xhci, endpoint_type, ring_type,
> +				max_packet, mem_flags);
> +	return 0;
> +}
> +
> +void xhci_vendor_free_transfer_ring(struct xhci_hcd *xhci,
> +		struct xhci_ring *ring, unsigned int ep_index)
> +{
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
> +	if (ops && ops->free_transfer_ring)
> +		ops->free_transfer_ring(xhci, ring, ep_index);
> +}
> +
> +bool xhci_vendor_is_usb_offload_enabled(struct xhci_hcd *xhci,
> +		struct xhci_virt_device *virt_dev, unsigned int ep_index)
> +{
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
> +	if (ops && ops->is_usb_offload_enabled)
> +		return ops->is_usb_offload_enabled(xhci, virt_dev, ep_index);
> +	return false;
> +}
> +
>  /*
>   * Create a new ring with zero or more segments.
>   *
> @@ -417,7 +465,11 @@ void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
>  		struct xhci_virt_device *virt_dev,
>  		unsigned int ep_index)
>  {
> -	xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
> +	if (xhci_vendor_is_usb_offload_enabled(xhci, virt_dev, ep_index))
> +		xhci_vendor_free_transfer_ring(xhci, virt_dev->eps[ep_index].ring, ep_index);
> +	else
> +		xhci_ring_free(xhci, virt_dev->eps[ep_index].ring);
> +
>  	virt_dev->eps[ep_index].ring = NULL;
>  }
>  
> @@ -475,6 +527,7 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
>  {
>  	struct xhci_container_ctx *ctx;
>  	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
>  
>  	if ((type != XHCI_CTX_TYPE_DEVICE) && (type != XHCI_CTX_TYPE_INPUT))
>  		return NULL;
> @@ -488,7 +541,12 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
>  	if (type == XHCI_CTX_TYPE_INPUT)
>  		ctx->size += CTX_SIZE(xhci->hcc_params);
>  
> -	ctx->bytes = dma_pool_zalloc(xhci->device_pool, flags, &ctx->dma);
> +	if (xhci_vendor_is_usb_offload_enabled(xhci, NULL, 0) &&
> +	    (ops && ops->alloc_container_ctx))
> +		xhci_vendor_alloc_container_ctx(xhci, ctx, type, flags);
> +	else
> +		ctx->bytes = dma_pool_zalloc(xhci->device_pool, flags, &ctx->dma);
> +
>  	if (!ctx->bytes) {
>  		kfree(ctx);
>  		return NULL;
> @@ -499,9 +557,16 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
>  void xhci_free_container_ctx(struct xhci_hcd *xhci,
>  			     struct xhci_container_ctx *ctx)
>  {
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
>  	if (!ctx)
>  		return;
> -	dma_pool_free(xhci->device_pool, ctx->bytes, ctx->dma);
> +	if (xhci_vendor_is_usb_offload_enabled(xhci, NULL, 0) &&
> +	    (ops && ops->free_container_ctx))
> +		xhci_vendor_free_container_ctx(xhci, ctx);
> +	else
> +		dma_pool_free(xhci->device_pool, ctx->bytes, ctx->dma);
> +
>  	kfree(ctx);
>  }
>  
> @@ -894,7 +959,7 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
>  
>  	for (i = 0; i < 31; i++) {
>  		if (dev->eps[i].ring)
> -			xhci_ring_free(xhci, dev->eps[i].ring);
> +			xhci_free_endpoint_ring(xhci, dev, i);
>  		if (dev->eps[i].stream_info)
>  			xhci_free_stream_info(xhci,
>  					dev->eps[i].stream_info);
> @@ -1492,8 +1557,16 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
>  		mult = 0;
>  
>  	/* Set up the endpoint ring */
> -	virt_dev->eps[ep_index].new_ring =
> -		xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
> +	if (xhci_vendor_is_usb_offload_enabled(xhci, virt_dev, ep_index) &&
> +	    usb_endpoint_xfer_isoc(&ep->desc)) {
> +		virt_dev->eps[ep_index].new_ring =
> +			xhci_vendor_alloc_transfer_ring(xhci, endpoint_type, ring_type,
> +							max_packet, mem_flags);
> +	} else {
> +		virt_dev->eps[ep_index].new_ring =
> +			xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
> +	}
> +
>  	if (!virt_dev->eps[ep_index].new_ring)
>  		return -ENOMEM;
>  
> @@ -1837,6 +1910,24 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
>  	erst->entries = NULL;
>  }
>  
> +static struct xhci_device_context_array *xhci_vendor_alloc_dcbaa(
> +		struct xhci_hcd *xhci, gfp_t flags)
> +{
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
> +	if (ops && ops->alloc_dcbaa)
> +		return ops->alloc_dcbaa(xhci, flags);
> +	return 0;
> +}
> +
> +static void xhci_vendor_free_dcbaa(struct xhci_hcd *xhci)
> +{
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
> +	if (ops && ops->free_dcbaa)
> +		ops->free_dcbaa(xhci);
> +}
> +
>  void xhci_mem_cleanup(struct xhci_hcd *xhci)
>  {
>  	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
> @@ -1888,9 +1979,13 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
>  	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>  			"Freed medium stream array pool");
>  
> -	if (xhci->dcbaa)
> -		dma_free_coherent(dev, sizeof(*xhci->dcbaa),
> -				xhci->dcbaa, xhci->dcbaa->dma);
> +	if (xhci_vendor_is_usb_offload_enabled(xhci, NULL, 0)) {
> +		xhci_vendor_free_dcbaa(xhci);
> +	} else {
> +		if (xhci->dcbaa)
> +			dma_free_coherent(dev, sizeof(*xhci->dcbaa),
> +					xhci->dcbaa, xhci->dcbaa->dma);
> +	}
>  	xhci->dcbaa = NULL;
>  
>  	scratchpad_free(xhci);
> @@ -2427,15 +2522,21 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>  	 * xHCI section 5.4.6 - Device Context array must be
>  	 * "physically contiguous and 64-byte (cache line) aligned".
>  	 */
> -	xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa), &dma,
> -			flags);
> -	if (!xhci->dcbaa)
> -		goto fail;
> -	xhci->dcbaa->dma = dma;
> +	if (xhci_vendor_is_usb_offload_enabled(xhci, NULL, 0)) {
> +		xhci->dcbaa = xhci_vendor_alloc_dcbaa(xhci, flags);
> +		if (!xhci->dcbaa)
> +			goto fail;
> +	} else {
> +		xhci->dcbaa = dma_alloc_coherent(dev, sizeof(*xhci->dcbaa), &dma,
> +				flags);
> +		if (!xhci->dcbaa)
> +			goto fail;
> +		xhci->dcbaa->dma = dma;
> +	}
>  	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>  			"// Device context base array address = 0x%llx (DMA), %p (virt)",
>  			(unsigned long long)xhci->dcbaa->dma, xhci->dcbaa);
> -	xhci_write_64(xhci, dma, &xhci->op_regs->dcbaa_ptr);
> +	xhci_write_64(xhci, xhci->dcbaa->dma, &xhci->op_regs->dcbaa_ptr);
>  
>  	/*
>  	 * Initialize the ring segment pool.  The ring must be a contiguous
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 649ffd861b44..a5881ff945a6 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -173,6 +173,41 @@ static const struct of_device_id usb_xhci_of_match[] = {
>  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
>  #endif
>  
> +static struct xhci_plat_priv_overwrite xhci_plat_vendor_overwrite;
> +
> +int xhci_plat_register_vendor_ops(struct xhci_vendor_ops *vendor_ops)
> +{
> +	if (vendor_ops == NULL)
> +		return -EINVAL;
> +
> +	xhci_plat_vendor_overwrite.vendor_ops = vendor_ops;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xhci_plat_register_vendor_ops);
> +
> +static int xhci_vendor_init(struct xhci_hcd *xhci, struct device *dev)
> +{
> +	struct xhci_vendor_ops *ops = NULL;
> +
> +	if (xhci_plat_vendor_overwrite.vendor_ops)
> +		ops = xhci->vendor_ops = xhci_plat_vendor_overwrite.vendor_ops;
> +
> +	if (ops && ops->vendor_init)
> +		return ops->vendor_init(xhci, dev);
> +	return 0;
> +}
> +
> +static void xhci_vendor_cleanup(struct xhci_hcd *xhci)
> +{
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
> +	if (ops && ops->vendor_cleanup)
> +		ops->vendor_cleanup(xhci);
> +
> +	xhci->vendor_ops = NULL;
> +}
> +
>  static int xhci_plat_probe(struct platform_device *pdev)
>  {
>  	const struct xhci_plat_priv *priv_match;
> @@ -185,7 +220,6 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	int			irq;
>  	struct xhci_plat_priv	*priv = NULL;
>  
> -
>  	if (usb_disabled())
>  		return -ENODEV;
>  
> @@ -321,6 +355,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  			goto put_usb3_hcd;
>  	}
>  
> +	ret = xhci_vendor_init(xhci, &pdev->dev);
> +	if (ret)
> +		goto disable_usb_phy;
> +
>  	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
>  	xhci->shared_hcd->tpl_support = hcd->tpl_support;
>  	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
> @@ -393,8 +431,10 @@ static int xhci_plat_remove(struct platform_device *dev)
>  	usb_phy_shutdown(hcd->usb_phy);
>  
>  	usb_remove_hcd(hcd);
> -	usb_put_hcd(shared_hcd);
>  
> +	xhci_vendor_cleanup(xhci);
> +
> +	usb_put_hcd(shared_hcd);
>  	clk_disable_unprepare(clk);
>  	clk_disable_unprepare(reg_clk);
>  	usb_put_hcd(hcd);
> diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
> index 1fb149d1fbce..8c204f3234d8 100644
> --- a/drivers/usb/host/xhci-plat.h
> +++ b/drivers/usb/host/xhci-plat.h
> @@ -17,8 +17,16 @@ struct xhci_plat_priv {
>  	int (*init_quirk)(struct usb_hcd *);
>  	int (*suspend_quirk)(struct usb_hcd *);
>  	int (*resume_quirk)(struct usb_hcd *);
> +	void *vendor_priv;
>  };
>  
>  #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
>  #define xhci_to_priv(x) ((struct xhci_plat_priv *)(x)->priv)
> +
> +struct xhci_plat_priv_overwrite {
> +	struct xhci_vendor_ops *vendor_ops;
> +};
> +
> +int xhci_plat_register_vendor_ops(struct xhci_vendor_ops *vendor_ops);
> +
>  #endif	/* _XHCI_PLAT_H */
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index c06e8b21b724..5ccf1bbe8732 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -2986,6 +2986,14 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
>  			xhci_finish_resource_reservation(xhci, ctrl_ctx);
>  		spin_unlock_irqrestore(&xhci->lock, flags);
>  	}
> +	if (ret)
> +		goto failed;
> +
> +	ret = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
> +	if (ret)
> +		xhci_warn(xhci, "sync device context failed, ret=%d", ret);
> +
> +failed:
>  	return ret;
>  }
>  
> @@ -3129,7 +3137,11 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
>  	for (i = 0; i < 31; i++) {
>  		if (virt_dev->eps[i].new_ring) {
>  			xhci_debugfs_remove_endpoint(xhci, virt_dev, i);
> -			xhci_ring_free(xhci, virt_dev->eps[i].new_ring);
> +			if (xhci_vendor_is_usb_offload_enabled(xhci, virt_dev, i))
> +				xhci_vendor_free_transfer_ring(xhci, virt_dev->eps[i].new_ring, i);
> +			else
> +				xhci_ring_free(xhci, virt_dev->eps[i].new_ring);
> +
>  			virt_dev->eps[i].new_ring = NULL;
>  		}
>  	}
> @@ -3290,6 +3302,13 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
>  
>  	wait_for_completion(stop_cmd->completion);
>  
> +	err = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
> +	if (err) {
> +		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
> +			  __func__, err);
> +		goto cleanup;
> +	}
> +
>  	spin_lock_irqsave(&xhci->lock, flags);
>  
>  	/* config ep command clears toggle if add and drop ep flags are set */
> @@ -3321,6 +3340,11 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
>  
>  	wait_for_completion(cfg_cmd->completion);
>  
> +	err = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
> +	if (err)
> +		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
> +			  __func__, err);
> +
>  	xhci_free_command(xhci, cfg_cmd);
>  cleanup:
>  	xhci_free_command(xhci, stop_cmd);
> @@ -3866,6 +3890,13 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
>  	/* Wait for the Reset Device command to finish */
>  	wait_for_completion(reset_device_cmd->completion);
>  
> +	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
> +	if (ret) {
> +		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
> +			  __func__, ret);
> +		goto command_cleanup;
> +	}
> +
>  	/* The Reset Device command can't fail, according to the 0.95/0.96 spec,
>  	 * unless we tried to reset a slot ID that wasn't enabled,
>  	 * or the device wasn't in the addressed or configured state.
> @@ -4111,6 +4142,14 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
>  		xhci_warn(xhci, "Could not allocate xHCI USB device data structures\n");
>  		goto disable_slot;
>  	}
> +
> +	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
> +	if (ret) {
> +		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
> +			  __func__, ret);
> +		goto disable_slot;
> +	}
> +
>  	vdev = xhci->devs[slot_id];
>  	slot_ctx = xhci_get_slot_ctx(xhci, vdev->out_ctx);
>  	trace_xhci_alloc_dev(slot_ctx);
> @@ -4241,6 +4280,13 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
>  	/* ctrl tx can take up to 5 sec; XXX: need more time for xHC? */
>  	wait_for_completion(command->completion);
>  
> +	ret = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
> +	if (ret) {
> +		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
> +			  __func__, ret);
> +		goto out;
> +	}
> +
>  	/* FIXME: From section 4.3.4: "Software shall be responsible for timing
>  	 * the SetAddress() "recovery interval" required by USB and aborting the
>  	 * command on a timeout.
> @@ -4393,6 +4439,14 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
>  		return -ENOMEM;
>  	}
>  
> +	ret = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
> +	if (ret) {
> +		spin_unlock_irqrestore(&xhci->lock, flags);
> +		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
> +			  __func__, ret);
> +		return ret;
> +	}
> +
>  	xhci_slot_copy(xhci, command->in_ctx, virt_dev->out_ctx);
>  	spin_unlock_irqrestore(&xhci->lock, flags);
>  
> @@ -4420,6 +4474,21 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
>  	return ret;
>  }
>  
> +struct xhci_vendor_ops *xhci_vendor_get_ops(struct xhci_hcd *xhci)
> +{
> +	return xhci->vendor_ops;
> +}
> +EXPORT_SYMBOL_GPL(xhci_vendor_get_ops);
> +
> +int xhci_vendor_sync_dev_ctx(struct xhci_hcd *xhci, unsigned int slot_id)
> +{
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
> +	if (ops && ops->sync_dev_ctx)
> +		return ops->sync_dev_ctx(xhci, slot_id);
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  
>  /* BESL to HIRD Encoding array for USB2 LPM */
> @@ -5144,6 +5213,15 @@ static int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
>  		return -ENOMEM;
>  	}
>  
> +	ret = xhci_vendor_sync_dev_ctx(xhci, hdev->slot_id);
> +	if (ret) {
> +		xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
> +			  __func__, ret);
> +		xhci_free_command(xhci, config_cmd);
> +		spin_unlock_irqrestore(&xhci->lock, flags);
> +		return ret;
> +	}
> +
>  	xhci_slot_copy(xhci, config_cmd->in_ctx, vdev->out_ctx);
>  	ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
>  	slot_ctx = xhci_get_slot_ctx(xhci, config_cmd->in_ctx);
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 473a33ce299e..3a414a2f41f0 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1929,6 +1929,9 @@ struct xhci_hcd {
>  	struct list_head	regset_list;
>  
>  	void			*dbc;
> +
> +	struct xhci_vendor_ops *vendor_ops;
> +
>  	/* platform-specific data -- must come last */
>  	unsigned long		priv[] __aligned(sizeof(s64));
>  };
> @@ -2207,6 +2210,49 @@ static inline struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
>  					urb->stream_id);
>  }
>  
> +/**
> + * struct xhci_vendor_ops - function callbacks for vendor specific operations
> + * @vendor_init: called for vendor init process
> + * @vendor_cleanup: called for vendor cleanup process
> + * @is_usb_offload_enabled: called to check if usb offload enabled
> + * @alloc_dcbaa: called when allocating vendor specific dcbaa
> + * @free_dcbaa: called to free vendor specific dcbaa
> + * @alloc_transfer_ring: called when remote transfer ring allocation is required
> + * @free_transfer_ring: called to free vendor specific transfer ring
> + * @sync_dev_ctx: called when synchronization for device context is required
> + * @alloc_container_ctx: called when allocating vendor specific container context
> + * @free_container_ctx: called to free vendor specific container context
> + */
> +struct xhci_vendor_ops {
> +	int (*vendor_init)(struct xhci_hcd *xhci, struct device *dev);
> +	void (*vendor_cleanup)(struct xhci_hcd *xhci);
> +	bool (*is_usb_offload_enabled)(struct xhci_hcd *xhci,
> +				       struct xhci_virt_device *vdev,
> +				       unsigned int ep_index);
> +
> +	struct xhci_device_context_array *(*alloc_dcbaa)(struct xhci_hcd *xhci,
> +							 gfp_t flags);
> +	void (*free_dcbaa)(struct xhci_hcd *xhci);
> +
> +	struct xhci_ring *(*alloc_transfer_ring)(struct xhci_hcd *xhci,
> +			u32 endpoint_type, enum xhci_ring_type ring_type,
> +			unsigned int max_packet, gfp_t mem_flags);
> +	void (*free_transfer_ring)(struct xhci_hcd *xhci,
> +			struct xhci_ring *ring, unsigned int ep_index);
> +	int (*sync_dev_ctx)(struct xhci_hcd *xhci, unsigned int slot_id);
> +	void (*alloc_container_ctx)(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
> +				    int type, gfp_t flags);
> +	void (*free_container_ctx)(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx);
> +};
> +
> +struct xhci_vendor_ops *xhci_vendor_get_ops(struct xhci_hcd *xhci);
> +
> +int xhci_vendor_sync_dev_ctx(struct xhci_hcd *xhci, unsigned int slot_id);
> +void xhci_vendor_free_transfer_ring(struct xhci_hcd *xhci,
> +		struct xhci_ring *ring, unsigned int ep_index);
> +bool xhci_vendor_is_usb_offload_enabled(struct xhci_hcd *xhci,
> +		struct xhci_virt_device *virt_dev, unsigned int ep_index);

Why the three options here?  Why does ep_index matter?

And no documentiaon for these global function?

thanks,

greg k-h
