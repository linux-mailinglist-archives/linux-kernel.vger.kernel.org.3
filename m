Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095054E2EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351534AbiCURAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbiCURAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:00:43 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175675D5D2;
        Mon, 21 Mar 2022 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647881958; x=1679417958;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=e5qKp3TccmtB9JB7hc3Gj03ZjUm1y7odox68rTsjaJ8=;
  b=DTYFPJmcpn66SAJ9rp9IZFMuXtKtAz7BKtIsbUyq5mrnQLShJ3YZE6NR
   tW/J4bolfZ9x4RM7F7e6gY60dsvFHELTYpeXw65aF7ufC1PRy5E+QhP28
   jjJf1BZEc3HgpLhrScoGY2YWK8Tj3TIwjauCrJAKYolWeSk2rp8FFwKb5
   uQBh9NQjJznpX+5xQgmutuAavghENe+YWu7CI8eyNdbjf0bWqJ8YaSTHZ
   muTWM9hoRWeaWwwT5wQKLdPGiDi2v/fxm2b0Oriz/SIzUjqYNHNWLCtFd
   jfUcdnyRQbuEwUxFQmhpqufT3vQHIC0QoG2S1Pa5oLB0Qr3AFdi23QK3A
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="318311192"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="318311192"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 09:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="648633203"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2022 09:59:08 -0700
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220321090204epcas2p3b2be5c6b131240e408d12d40c517395c@epcas2p3.samsung.com>
 <1647853194-62147-3-git-send-email-dh10.jung@samsung.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3 2/4] usb: host: add xhci hooks for USB offload
Message-ID: <8f34e9ee-4f50-9028-34ba-444090acf48c@linux.intel.com>
Date:   Mon, 21 Mar 2022 19:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1647853194-62147-3-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.3.2022 10.59, Daehwan Jung wrote:
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

The vendor_init() and vendor_cleanup() aren't really useful.
you are calling them from platform_probe() and platform_remove(),
just modify the probe and remove functions of the xhci-exynos driver directly.


> 	@is_usb_offload_enabled:
> 		- called to check if usb offload enabled.

Looks like this is being used more like a quirk bit.
I think we can get rid of this as well

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
>  drivers/usb/host/xhci-plat.c |  43 +++++++++++-
>  drivers/usb/host/xhci-plat.h |   7 ++
>  drivers/usb/host/xhci.c      |  80 ++++++++++++++++++++-
>  drivers/usb/host/xhci.h      |  46 ++++++++++++
>  6 files changed, 295 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 56546aaa93c7..aea72ffce820 100644
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


Looks suspicious, we always need to free container contexts, why this much checking?


> +
> +static void xhci_vendor_alloc_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
> +					    int type, gfp_t flags)
> +{
> +	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
> +
> +	if (ops && ops->alloc_container_ctx)
> +		ops->alloc_container_ctx(xhci, ctx, type, flags);
> +}

same, there should always be a function to allocate container context..

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

same, looks like a lot of extra code.

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

same.

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

Ok, I see.
So idea is to override some functions that allocate and free DMA memory.
Your vendor_ops structure filled with function callbacks could be a 
mem_ops structure that allows your driver to directly override those
functions.

For example here we would only call

xhci->mem_ops->ring_free(...);
This would set to xhci_ring_free() by default, but your xhci-exonys driver could
set it to xhci_exonys_free_ring(), which would do any needed is_offload_enabled()
checks and custom freeing.

Same goes for most most of the other functions in this patch

If possible see if it's enough to override the existing callbacks in
struct hc_driver instead of creating new function pointers.

-Mathias
