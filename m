Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0209B4F4DE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiDEXxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455462AbiDEQAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D3C57485;
        Tue,  5 Apr 2022 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649171743; x=1680707743;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3lIdhrvOWJSsLIjp6xNITFKNThnKqW6h1bviJyyMAjg=;
  b=XMsqnVXGGgjbW6EuHpdbyhCpKFuITO/nxpf3iEkNb6e+6NDE80pQECpw
   cZNO8EQGS6nPdT6oyYasZBtkuvRn2bYm/CaRVb0lHu2t/tM11hg5UoFSx
   5UESQwr7rZnaXioNiarXLzKpcwkUINi569qkSGNha9xtXL7Ry2BSOt5Ps
   qFVlu3cdSRQrUj5Q5iI6eGRmBm/OBbKQHAt4xRpTDGmq+aTx9NU+dBSm1
   CLh722SWKlXDr2PK+YgW53l4ASy2tQ/vr5Y1pveszMYif/8jzHOQWxlJW
   wRtjkHqA3FbWSTU9isMETkTGZawc1SYlVqGLVaUpTS7oGEwM5INF/n9N7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260765093"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260765093"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="657974108"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 05 Apr 2022 08:13:39 -0700
Subject: Re: [PATCH] xhci: stop polling roothubs after shutdown
To:     Henry Lin <henryl@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220401115916.104527-1-henryl@nvidia.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <e4796a11-7571-b54e-cb82-87bb749709f1@linux.intel.com>
Date:   Tue, 5 Apr 2022 18:15:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220401115916.104527-1-henryl@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.4.2022 14.59, Henry Lin wrote:
> While rebooting, XHCI controller and its bus device will be shut down
> in order by .shutdown callback. Stopping roothubs polling in
> xhci_shutdown() can prevent XHCI driver from accessing port status
> after its bus device shutdown.
> 
> Take PCIe XHCI controller as example, if XHCI driver doesn't stop roothubs
> polling, XHCI driver may access PCIe BAR register for port status after
> parent PCIe root port driver is shutdown and cause PCIe bus error.
> 
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> ---
>  drivers/usb/host/xhci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 2d378543bc3a..e7ae6766220e 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -780,6 +780,14 @@ void xhci_shutdown(struct usb_hcd *hcd)
>  	if (xhci->quirks & XHCI_SPURIOUS_REBOOT)
>  		usb_disable_xhci_ports(to_pci_dev(hcd->self.sysdev));
>  
> +	/* Don't poll the roothubs after shutdown. */
> +	xhci_dbg(xhci, "%s: stopping usb%d port polling.\n",
> +			__func__, hcd->self.busnum);
> +	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
> +	del_timer_sync(&hcd->rh_timer);
> +	clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
> +	del_timer_sync(&xhci->shared_hcd->rh_timer);
> +
>  	spin_lock_irq(&xhci->lock);
>  	xhci_halt(xhci);
>  	/* Workaround for spurious wakeups at shutdown with HSW */
> 

Thanks, adding to queue

-Mathias
