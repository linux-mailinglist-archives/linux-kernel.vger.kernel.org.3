Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE71511D76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243565AbiD0QcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbiD0QcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:32:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51373F320;
        Wed, 27 Apr 2022 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651076866; x=1682612866;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CPMjo6U9PUtaGVa14pO3sunqUrDh79MQUPdvmaVu8cw=;
  b=jU0eryoMSnwcYapAxLMjSKRkRC3kQQS7YfZGBMI2pApcKN8IbGoXiG4D
   GB2leEQdH8+jU2kNx06EHwOwbPPcHVtlaEwtTFf0s4cRUeaCFFvlR00lx
   FHHEu9N0aVlSO/fWg1uLD5JnVTJIypV/UvUJqQ0uo2Z5kfhM4qKT37+Jr
   7+FXZpCt53t4awT6mTRekMbAq51f/duCHKJsqZgvJhWf4f63IfP+s6jHd
   9TXyzHc5taI87pG23dgH2KaijOFUOx+XOe8HZ0/rXOgU/Njnj5U/oah1e
   XDO27ggkrHirf4MN3z+cc4sy8hNgLZbPpVW2qlXqkf1LyEkycPgxAxSUA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="253372372"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="253372372"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 09:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="876729017"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2022 09:23:22 -0700
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
 <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <b9fcc518-cc0d-d346-774e-3a9472e664bc@linux.intel.com>
Date:   Wed, 27 Apr 2022 19:25:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.4.2022 12.18, Daehwan Jung wrote:
> This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
> driver mainly and extends some functions by xhci hooks and overrides.
> 
> It supports USB Audio offload with Co-processor. It only cares DCBAA,
> Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> on specific address with xhci hooks. Co-processor could use them directly
> without xhci driver after then.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>

I have to agree with Krzysztof's comments, this is an odd driver stub.

Perhaps open up a bit how the Exynos offloading works so we can figure out
in more detail what the hardware needs from software.  

(...)

> +
> +static void xhci_exynos_alloc_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
> +						int type, gfp_t flags)
> +{
> +	/* Only first Device Context uses URAM */
> +	int i;
> +
> +	ctx->bytes = ioremap(EXYNOS_URAM_DEVICE_CTX_ADDR, EXYNOS_URAM_CTX_SIZE);
> +	if (!ctx->bytes)
> +		return;
> +
> +	for (i = 0; i < EXYNOS_URAM_CTX_SIZE; i++)
> +		ctx->bytes[i] = 0;
> +
> +	ctx->dma = EXYNOS_URAM_DEVICE_CTX_ADDR;

This can't work with more than one USB device.
This hardcodes the same context address for every usb device.


> +static void xhci_exynos_parse_endpoint(struct xhci_hcd *xhci, struct usb_device *udev,
> +		struct usb_endpoint_descriptor *desc, struct xhci_container_ctx *ctx)
> +{
> +	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
> +	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
> +	struct usb_endpoint_descriptor *d = desc;
> +	unsigned int ep_index;
> +	struct xhci_ep_ctx *ep_ctx;
> +
> +	ep_index = xhci_get_endpoint_index(d);
> +	ep_ctx = xhci_get_ep_ctx(xhci, ctx, ep_index);
> +
> +	if ((d->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
> +				USB_ENDPOINT_XFER_ISOC) {
> +		if (d->bEndpointAddress & USB_ENDPOINT_DIR_MASK)
> +			xhci_exynos->in_ep = d->bEndpointAddress;
> +		else
> +			xhci_exynos->out_ep = d->bEndpointAddress;
> +	}

This won't work if more than one device that has isoc endpoints, or even 
if that device has more than one in/out isoc endpoint pair.


> +static int xhci_alloc_segments_for_ring_uram(struct xhci_hcd *xhci,
> +		struct xhci_segment **first, struct xhci_segment **last,
> +		unsigned int num_segs, unsigned int cycle_state,
> +		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
> +		u32 endpoint_type)
> +{
> +	struct xhci_segment *prev;
> +	bool chain_links = false;
> +
> +	while (num_segs > 0) {
> +		struct xhci_segment *next = NULL;
> +
> +		if (!next) {
> +			prev = *first;
> +			while (prev) {
> +				next = prev->next;
> +				xhci_segment_free(xhci, prev);
> +				prev = next;
> +			}
> +			return -ENOMEM;

This always return -ENOMEM

Also this whole function never allocates or remaps any memory.

> +		}
> +		xhci_link_segments(prev, next, type, chain_links);
> +
> +		prev = next;
> +		num_segs--;
> +	}
> +	xhci_link_segments(prev, *first, type, chain_links);
> +	*last = prev;
> +
> +	return 0;
> +}
> +
> +static struct xhci_ring *xhci_ring_alloc_uram(struct xhci_hcd *xhci,
> +		unsigned int num_segs, unsigned int cycle_state,
> +		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
> +		u32 endpoint_type)
> +{
> +	struct xhci_ring	*ring;
> +	int ret;
> +	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> +
> +	ring = kzalloc_node(sizeof(*ring), flags, dev_to_node(dev));
> +	if (!ring)
> +		return NULL;
> +
> +	ring->num_segs = num_segs;
> +	ring->bounce_buf_len = max_packet;
> +	INIT_LIST_HEAD(&ring->td_list);
> +	ring->type = type;
> +	if (num_segs == 0)
> +		return ring;
> +
> +	ret = xhci_alloc_segments_for_ring_uram(xhci, &ring->first_seg,
> +			&ring->last_seg, num_segs, cycle_state, type,
> +			max_packet, flags, endpoint_type);
> +	if (ret)
> +		goto fail;
> +
> +	/* Only event ring does not use link TRB */
> +	if (type != TYPE_EVENT) {
> +		/* See section 4.9.2.1 and 6.4.4.1 */
> +		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
> +			cpu_to_le32(LINK_TOGGLE);

No memory was allocated for trbs

A lot of this code seems to exists just to avoid xhci driver from allocating
dma capable memory, we can refactor the existing xhci_mem_init() and move
dcbaa and event ring allocation and other code to their own overridable
functions.

This way we can probably get rid of a lot of the code in this series.

Thanks
Mathias
