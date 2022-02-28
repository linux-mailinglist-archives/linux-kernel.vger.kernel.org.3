Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352A04C6911
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiB1K6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiB1K6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:58:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFF2723C2;
        Mon, 28 Feb 2022 02:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646045707; x=1677581707;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nTPJQ5QTBlr7AzpXXeV/4UbsOZe72fsxzA/yIzwnKdM=;
  b=nICViPDrsuq4Rm7zfrJMyGGPj3l8Xbj9ZUQyQVEbwZrD2g05afmMub0F
   5+7iIpTrLPmIADfvWXYqJ5UH2MJWjr0YneURPTHeaMElHuDIj+bJ/HhRt
   2ziWkQfmMNhovaDSASeL76rZMvzeVXFjObftgnZivAng0/UU2MmmMeVQY
   TXayxsp34t46Rpuvaw1NKZEXRVKxTheeow/PAnQIcK6WHkKYi7rC456yi
   ySZQqzQAEijtBLcTqy0UEsYK2MJJ+z7xVf/NX7UKGRHa+XuO1zErUz+k+
   Z1HAFc0CaHlW31dlgIM5QQ/0G6KUDdlA2LNi8Y38+3pI77vhthi85avpM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="316072124"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="316072124"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 02:54:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="575278658"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2022 02:54:57 -0800
To:     Henry Lin <henryl@nvidia.com>, gregkh@linuxfoundation.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220225055311.92447-1-henryl@nvidia.com>
 <20220225071506.22012-1-henryl@nvidia.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Message-ID: <2ef7da52-d8ad-05ca-bcb6-06bd6bb6f9d3@linux.intel.com>
Date:   Mon, 28 Feb 2022 12:56:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220225071506.22012-1-henryl@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.2.2022 9.15, Henry Lin wrote:
> USB2 resume starts with usb_hcd_start_port_resume() in port status
> change handling for RESUME link state. usb_hcd_end_port_resume() call is
> needed to keep runtime PM balance.

For normal usb2 port resume the usb_hcd_end_port_resume() is called when resume
has been signaled for long enough in xhci_handle_usb2_port_link_resume().
 
This is also where driver directs the port to go from Resume state to U0.
Port can't do this without driver directing it.

If there's a failure during resume signaling (disconnect, reset, error) then
stale resume variables are detected in xhci_get_port_status() and 
usb_hcd_end_port_resume() is called.

I do now see a231ec41e6f6 ("xhci: refactor U0 link state handling in get_port_status") 
does change order of checking and clearing stale resume variables, but this should
only happen if the first port state we read is a fully enabled functional U0 state after
a failed resume.

Could you expand a bit how this was detected? 

> 
> Fixes: a231ec41e6f6 ("xhci: refactor U0 link state handling in get_port_status")
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> ---
>  drivers/usb/host/xhci-hub.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index df3522dab31b..4a8b07b8ee01 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -1090,6 +1090,8 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
>  		if (link_state == XDEV_U0) {
>  			bus_state->resume_done[portnum] = 0;
>  			clear_bit(portnum, &bus_state->resuming_ports);
> +			usb_hcd_end_port_resume(&port->rhub->hcd->self,
> +						portnum);

This will call usb_hcd_end_port_resume() every time port is in normal enabled U0 state
even if resume was never signaled, or port suspended.

-Mathias
