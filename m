Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC215133AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346233AbiD1MaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346227AbiD1MaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:30:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13F17CB0B;
        Thu, 28 Apr 2022 05:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651148817; x=1682684817;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uWpsrfMCGcdP4sBCZpdV/K9nXsH6L4kQovbP/bC7oiM=;
  b=EtEZL6LXBy5f+wWZaMasunOM0ZkDPJVe26PdJxpW6Ke7x3KrOo/fQdiP
   U1vUnm+KSUGocnqZP71JDY7K0P+xvsZa8tpLJvxKh5SxNwmNJLAlSMPsl
   aYr7ng9e4jBJEXn57YGdKeb6vlQwk4b/OWBcvjWIn22+nPIwAnqIkEONq
   gDJ2MsiqLlzHZ3FVA3OPs1onbt8UStmtYVBm5x1MfCrzuo54IHJXHom0O
   GM0ABBMYmDZvlZFgdMR/pY0jjiCYba8mLDFDZE9/j26PMu1EtsZqv0/tS
   dwUuKMJYJ3jdJcb9kSkUAYhDXdwjjGopxayR701qVKrGeS9bcj460Azjg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="246832536"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="246832536"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 05:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="878583949"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 28 Apr 2022 05:26:49 -0700
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
 <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
 <b9fcc518-cc0d-d346-774e-3a9472e664bc@linux.intel.com>
 <20220428030319.GA139938@ubuntu>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <0f84e8d4-451f-693a-d098-517dc6235a0f@linux.intel.com>
Date:   Thu, 28 Apr 2022 15:28:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220428030319.GA139938@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.4.2022 6.03, Jung Daehwan wrote:
> On Wed, Apr 27, 2022 at 07:25:21PM +0300, Mathias Nyman wrote:
>> On 26.4.2022 12.18, Daehwan Jung wrote:
>>> This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
>>> driver mainly and extends some functions by xhci hooks and overrides.
>>>
>>> It supports USB Audio offload with Co-processor. It only cares DCBAA,
>>> Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
>>> on specific address with xhci hooks. Co-processor could use them directly
>>> without xhci driver after then.
>>>
>>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
>>
>> I have to agree with Krzysztof's comments, this is an odd driver stub.
>>
>> Perhaps open up a bit how the Exynos offloading works so we can figure out
>> in more detail what the hardware needs from software.  
>>
>> (...)
> 
>>> +static int xhci_alloc_segments_for_ring_uram(struct xhci_hcd *xhci,
>>> +		struct xhci_segment **first, struct xhci_segment **last,
>>> +		unsigned int num_segs, unsigned int cycle_state,
>>> +		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
>>> +		u32 endpoint_type)
>>> +{
>>> +	struct xhci_segment *prev;
>>> +	bool chain_links = false;
>>> +
>>> +	while (num_segs > 0) {
>>> +		struct xhci_segment *next = NULL;
>>> +
>>> +		if (!next) {
>>> +			prev = *first;
>>> +			while (prev) {
>>> +				next = prev->next;
>>> +				xhci_segment_free(xhci, prev);
>>> +				prev = next;
>>> +			}
>>> +			return -ENOMEM;
>>
>> This always return -ENOMEM
> 
> Yes. it's right to return error here.
> 

Still don't think that is the case.

So if the num_segs value passed to a function named
xhci_alloc_segments_for_ring_uram() is anything else than 0, it will 
automatically return -ENOMEM?

>>
>> Also this whole function never allocates or remaps any memory.
> 
> This fuctions is for link segments. Right below function(xhci_ring_alloc_uram)
> allocates.

Still doesn't allocate any ring segments.
Below function only allocates memory for the
ring structure that contains pointers to segments.

> 
>>
>>> +		}
>>> +		xhci_link_segments(prev, next, type, chain_links);
>>> +
>>> +		prev = next;
>>> +		num_segs--;
>>> +	}
>>> +	xhci_link_segments(prev, *first, type, chain_links);
>>> +	*last = prev;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct xhci_ring *xhci_ring_alloc_uram(struct xhci_hcd *xhci,
>>> +		unsigned int num_segs, unsigned int cycle_state,
>>> +		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
>>> +		u32 endpoint_type)
>>> +{
>>> +	struct xhci_ring	*ring;
>>> +	int ret;
>>> +	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>>> +
>>> +	ring = kzalloc_node(sizeof(*ring), flags, dev_to_node(dev));
>>> +	if (!ring)
>>> +		return NULL;
>>> +
>>> +	ring->num_segs = num_segs;
>>> +	ring->bounce_buf_len = max_packet;
>>> +	INIT_LIST_HEAD(&ring->td_list);
>>> +	ring->type = type;
>>> +	if (num_segs == 0)
>>> +		return ring;
>>> +
>>> +	ret = xhci_alloc_segments_for_ring_uram(xhci, &ring->first_seg,
>>> +			&ring->last_seg, num_segs, cycle_state, type,
>>> +			max_packet, flags, endpoint_type);
>>> +	if (ret)
>>> +		goto fail;
>>> +
>>> +	/* Only event ring does not use link TRB */
>>> +	if (type != TYPE_EVENT) {
>>> +		/* See section 4.9.2.1 and 6.4.4.1 */
>>> +		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
>>> +			cpu_to_le32(LINK_TOGGLE);
>>
>> No memory was allocated for trbs
> 
> Allcation function for trbs are missed. It's done by ioremap.
> I will add it on next submission. Thanks for the comment.
> 
>>
>> A lot of this code seems to exists just to avoid xhci driver from allocating
>> dma capable memory, we can refactor the existing xhci_mem_init() and move
>> dcbaa and event ring allocation and other code to their own overridable
>> functions.
>>
>> This way we can probably get rid of a lot of the code in this series.
> 
> Yes right. I think it's proper. Do you agree with it or have better way
> to do it?

Could be, but I don't have a good picture of how this Exynos audio offloading
works, so it's hard to guess.

Thanks
-Mathias
