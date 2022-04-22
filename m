Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4F50C4E1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiDVXZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiDVXZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:25:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3EC65CC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D88F0B83302
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 23:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5F5C385A0;
        Fri, 22 Apr 2022 23:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650668446;
        bh=EG9Sat3nnlct87XJ7aI6xJ/IJzxF9nLDysqX+nVR4hI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=chdUsvXdzye2ukDSePy0mN4FkH+KKMIU3Nycg5slUUctlXi2Hk1aYXRlJIlnhy3y5
         /E7IR/cJtDDSGBTMVb0qqR21/7RpTMti9lQFp175AjdHQotbT0LUgHKUgkMzRjcTW9
         HQdUEU909dGByOZd+NPKzTpKgzU2A3UI1DjHphnRS9zrbO+SWdg+zbgirJzXDXhaXX
         9S+g84qZB7TdhBayLnzZWRYTxPiEhexK2KxcsIBkayp49QkOLjxZa8RBL5C5So3aBB
         9uEUn8V7vres4ULlqLLJGN2d7pmknP3OQaXPYV/nGhRSDL/a6wZyrRu8cuszTbjEJU
         pcfhqO/x6ocNw==
Date:   Fri, 22 Apr 2022 16:00:45 -0700 (PDT)
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
Subject: Re: [PATCH V1 5/6] xen/grant-dma-ops: Retrieve the ID of backend's
 domain for DT devices
In-Reply-To: <1650646263-22047-6-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204221534080.915916@ubuntu-linux-20-04-desktop>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com> <1650646263-22047-6-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022, Oleksandr Tyshchenko wrote:
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
> ---
> Changes RFC -> V1:
>    - new patch, split required changes from commit:
>     "[PATCH 4/6] virtio: Various updates to xen-virtio DMA ops layer"
>    - update checks in xen_virtio_setup_dma_ops() to only support
>      DT devices for now
>    - remove the "virtio,mmio" check from xen_is_virtio_device()
>    - remane everything according to the new naming scheme:
>      s/virtio/grant_dma
> ---
>  drivers/xen/grant-dma-ops.c | 25 ++++++++++++++++++-------
>  include/xen/xen-ops.h       |  5 +++++
>  2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index 0e69aa8..70d5d77 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -66,11 +66,6 @@ static struct xen_grant_dma_data *find_xen_grant_dma_data(struct device *dev)
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
> @@ -277,6 +272,16 @@ static const struct dma_map_ops xen_grant_dma_ops = {
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
> +EXPORT_SYMBOL_GPL(xen_is_grant_dma_device);
> +
>  void xen_grant_setup_dma_ops(struct device *dev)
>  {
>  	struct xen_grant_dma_data *data;
> @@ -288,8 +293,14 @@ void xen_grant_setup_dma_ops(struct device *dev)
>  		return;
>  	}
>  
> -	/* XXX The dom0 is hardcoded as the backend domain for now */
> -	dev_domid = 0;
> +	/* XXX ACPI and PCI devices unsupported for now */
> +	if (dev_is_pci(dev) || !dev->of_node)
> +		goto err;

I think we can remove the "dev_is_pci" check, right?


> +	if (of_property_read_u32(dev->of_node, "xen,dev-domid", &dev_domid)) {
> +		dev_err(dev, "xen,dev-domid property is not present\n");
> +		goto err;
> +	}
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data) {
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
