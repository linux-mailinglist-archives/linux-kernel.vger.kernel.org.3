Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2052CD73
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiESHq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiESHqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:46:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1083BBEC;
        Thu, 19 May 2022 00:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652946384; x=1684482384;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=TEii5T9HYqXIjBsmDz1qAOeqM3Szd1Cen5AKiMTQ3mk=;
  b=ZwzpmSiIeb0gvNe1KdbZBd+s5Rxn+dokYMDMfs1fFB6SgaEC/Co2Pn29
   mteH0UVNM361EqG8J8BrDnM4HdQnL63lwirRFZ2zyVn1Y/O6lZYqVNqvC
   J1ue6/nCXDoIHE45QlCEg/13fok9wdEPkidmunMOOL4XMcklrdA0iSRgy
   8EUy5NW4hSOYUjdeEvoUoeM2b6Yx4o3voKXh0eswU1JN4pb/Q21L6Zrep
   uFmFLO6t5NCnwOa2SxnOaNmG+9863v/qrHDAD94NoOgV6u18d6ovsNeiZ
   cv1dywtxPiTa3vIz/62toGmxnxwfPToXjh4EHknhTPuiqGwUZjZHGva0g
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="335121850"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="335121850"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 00:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598410629"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2022 00:46:06 -0700
Message-ID: <0c40e1ea-a565-2f8d-8460-16576ded3cb3@linux.intel.com>
Date:   Thu, 19 May 2022 10:47:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Content-Language: en-US
To:     Tao Wang <quic_wat@quicinc.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1652926622-85047-1-git-send-email-quic_wat@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: xhci: save hcd_priv memory of shared_hcd
In-Reply-To: <1652926622-85047-1-git-send-email-quic_wat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.5.2022 5.17, Tao Wang wrote:
> The shared_hcd->hcd_priv is not used in xhci, so not
> need to malloc hcd priv memory for shared_hcd.
> 
> Signed-off-by: Tao Wang <quic_wat@quicinc.com>
> ---
>   drivers/usb/host/xhci-plat.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 01dcfd7..a27dd3a 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -336,6 +336,11 @@ static int xhci_plat_probe(struct platform_device *pdev)
>   	device_set_wakeup_capable(&pdev->dev, true);
>   
>   	xhci->main_hcd = hcd;
> +	/*
> +	 * The shared_hcd->hcd_priv is not used in xhci,
> +	 * so not need to malloc hcd priv memory for shared_hcd.
> +	 */
> +	driver->hcd_priv_size = 0;

A change like this will probably come back and bite us later.
We already allocated the additional hcd_priv_size bytes for primary hcd.
Future code can no longer rely on driver->hcd_priv_size being valid after this.

If saving this amount of memory is important then maybe look into
__usb_create_hcd() and avoid allocating the extra bytes if the hcd is not
the primary hcd.

Thanks
-Mathias
