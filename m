Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A489F5616DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiF3J4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiF3J4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:56:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23797366AC;
        Thu, 30 Jun 2022 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656582981; x=1688118981;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=CHD3dptFN/arpsZ+SxMW13WySF1j6NyJGYBigahJd1I=;
  b=RizkZqoD/wB9Xl7MJl9NIfpAZk9uz18R5I5Ubbl7Kpj6TN62WmDa+JIn
   M7IHEi1je/lgPKwdTlImHzPiOE9CmzR24kgGcgzCautBj/BYVw3/pphmt
   oSysC+xdctLlfllrh+LiIMv6MXL216/DDS2mTx5XCqeeNdxbWqK06g2lY
   r8d+tf3RG5Luvbd0sX8pS5QcNdgJF+NFNsrrZfBB2a41+Qhv0rA0S4cf0
   LV5mcJTpZtNMv1DRH8opNtFcUIPm11YCQH+FyuUrD/VPBHFvkBi16x5fu
   hr+D1O/3MMZmJUkk/EUjjfXVGu4MwE2UYh9VBDgSaw+chnB2zGP4DTGLi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="368619627"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="368619627"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="837545374"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2022 02:56:19 -0700
Message-ID: <bcf4d8db-317f-f0c9-0e9e-5edf25e0c7e8@linux.intel.com>
Date:   Thu, 30 Jun 2022 12:57:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Content-Language: en-US
To:     Jianglei Nie <niejianglei2021@163.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220630011008.2167298-1-niejianglei2021@163.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: host: xhci: Fix potential memory leak in
 xhci_alloc_stream_info()
In-Reply-To: <20220630011008.2167298-1-niejianglei2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.6.2022 4.10, Jianglei Nie wrote:
> xhci_alloc_stream_info() allocates stream context array for stream_info
> ->stream_ctx_array with xhci_alloc_stream_ctx(). When some error occurs,
> stream_info->stream_ctx_array is not released, which will lead to a
> memory leak.

Nice catch, thanks

> 
> We can fix it by releasing the stream_info->stream_ctx_array with
> xhci_free_stream_ctx() on the error path to avoid the potential memory
> leak.
> 

Looks like the goto labels were a bit messed up from the beginning.
There are a couple "goto cleanup_ctx" lines in the code, but
cleanup_ctx never freed the ctx.

> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>   drivers/usb/host/xhci-mem.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 8c19e151a945..a71d3a873467 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -648,8 +648,13 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
>   	/* Allocate everything needed to free the stream rings later */
>   	stream_info->free_streams_command =
>   		xhci_alloc_command_with_ctx(xhci, true, mem_flags);
> -	if (!stream_info->free_streams_command)
> +	if (!stream_info->free_streams_command) {
> +		xhci_free_stream_ctx(xhci,
> +			stream_info->num_stream_ctxs,
> +			stream_info->stream_ctx_array,
> +			stream_info->ctx_array_dma);
>   		goto cleanup_ctx;
> +	}
>   
>   	INIT_RADIX_TREE(&stream_info->trb_address_map, GFP_ATOMIC);
>   
> @@ -700,6 +705,10 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
>   			stream_info->stream_rings[cur_stream] = NULL;
>   		}
>   	}
> +	xhci_free_stream_ctx(xhci,
> +			stream_info->num_stream_ctxs,
> +			stream_info->stream_ctx_array,
> +			stream_info->ctx_array_dma);
>   	xhci_free_command(xhci, stream_info->free_streams_command);
>   cleanup_ctx:
>   	kfree(stream_info->stream_rings);

How about:

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 8c19e151a945..f7cac1af51c5 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -641,7 +641,7 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
                         num_stream_ctxs, &stream_info->ctx_array_dma,
                         mem_flags);
         if (!stream_info->stream_ctx_array)
-               goto cleanup_ctx;
+               goto cleanup_rings;
         memset(stream_info->stream_ctx_array, 0,
                         sizeof(struct xhci_stream_ctx)*num_stream_ctxs);
  
@@ -702,6 +702,10 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
         }
         xhci_free_command(xhci, stream_info->free_streams_command);
  cleanup_ctx:
+       xhci_free_stream_ctx(xhci, stream_info->num_stream_ctxs,
+                            stream_info->stream_ctx_array,
+                            stream_info->ctx_array_dma);
+cleanup_rings:
         kfree(stream_info->stream_rings);
  cleanup_info:
