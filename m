Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DA5070E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353666AbiDSOrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352966AbiDSOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:46:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9233AA41;
        Tue, 19 Apr 2022 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650379434; x=1681915434;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GwM+DgH8oZbX2+k4dVfjkTJ+j6PIjW/gXCWsMBhCD78=;
  b=CSi6jZFAAqwe4eSgfcVFWhKFG/eiOQuovTKtaMn2kusSx5APg055CkM8
   WjYBvDmfn6f0/1jzK1KqCsSlVNSuuGEUq1PDfKcvCxdxACcAQoP7t2yrV
   qHNb3MA9zjaufoFbZtCz2KqTAi5S1iij6OTrxBC0rRj4f1wK3YrOWfWK5
   Y+EppsUeEQVImqOibpeozRy7iSGNfLWxZLSCFv7TXSdwYaGroGU2k5Q6n
   mHDbbKv1nQkr1RrbAjDMDS2tCsfe7iyEzzl7WmKmvl/tCdHiVzBbTBkWC
   JiP0gKwwXqB7L/atPSEFVkmvzvA7fvxqsC0BtfsgyfX6IK8EONLlAiPml
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="243713020"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="243713020"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="727090766"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2022 07:43:52 -0700
To:     Surong Pang <surong.pang@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220412122524.26966-1-surong.pang@gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH V1 1/1] usb/host: Let usb phy shutdown later
Message-ID: <610871b2-1707-dfba-868f-4ddecc4d554d@linux.intel.com>
Date:   Tue, 19 Apr 2022 17:45:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220412122524.26966-1-surong.pang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.4.2022 15.25, Surong Pang wrote:
> From: Surong Pang <surong.pang@unisoc.com>
> 
> Let usb phy shutdown later in xhci_plat_remove function.
> Some phy driver doesn't divide 3.0/2.0 very clear.
> If calls usb_phy_shutdown earlier than usb_remove_hcd(hcd),
> It will case 10s cmd timeout issue.
> 
> Call usb phy shutdown later has better compatibility.
> 
> Signed-off-by: Surong Pang <surong.pang@unisoc.com>
> ---
>  drivers/usb/host/xhci-plat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 649ffd861b44..dc73a81cbe9b 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -390,7 +390,6 @@ static int xhci_plat_remove(struct platform_device *dev)
>  
>  	usb_remove_hcd(shared_hcd);
>  	xhci->shared_hcd = NULL;
> -	usb_phy_shutdown(hcd->usb_phy);
>  
>  	usb_remove_hcd(hcd);
>  	usb_put_hcd(shared_hcd);
> @@ -398,6 +397,7 @@ static int xhci_plat_remove(struct platform_device *dev)
>  	clk_disable_unprepare(clk);
>  	clk_disable_unprepare(reg_clk);
>  	usb_put_hcd(hcd);
> +	usb_phy_shutdown(hcd->usb_phy);

hcd might be freed already here.
maybe call usb_phy_shutdown(hcd->usb_phy) before usb_put_hcd(hcd)

-Mathias


