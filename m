Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359A8486516
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbiAFNTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:19:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48488 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiAFNTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:19:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F29DFB8211F;
        Thu,  6 Jan 2022 13:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D50C36AE3;
        Thu,  6 Jan 2022 13:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641475139;
        bh=tepdy+1j5GIZ0ojpCuV1iH/4KprtlF2RyOjNRn/ORjs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fHQ8rJ0KNM0Z7GZViDoEmsD3I0xCUSPIJsFLEWPONB1x3LNSxFZWB/fXke8ZJGrOh
         375jO9vqOO4dHgLfHUymeRGNoXurB75kRrWg0v4ksOIlLO+RRL/+DO44ll/jhoA2tN
         ZqTO2swAGV9CSWNKBbblMl+ZLtA0/FNuMPUgdwksptrZKCLTM500a+XXKuyT9qVXKW
         EUjXx6GGFXZYqobROik0Ij5tjTPpztI2qRrdWv2WYGHeFkhCTQB0TVBwBlhrbtXPk7
         g/dbuF5nN7pD/P9GeZZsLlm3tKSCBkdL4yDHACgd/YIEOYlp7R8Q5UDSJ3y3c59622
         nvwqHULjlfUyg==
Date:   Thu, 6 Jan 2022 14:18:56 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
cc:     jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Specify no cache snooping on
 TGL and ADL
In-Reply-To: <20211217074541.4705-1-xiang.ye@intel.com>
Message-ID: <nycvar.YFH.7.76.2201061418460.16505@cbobk.fhfr.pm>
References: <20211217074541.4705-1-xiang.ye@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021, Ye Xiang wrote:

> Specify that both TGL and ADL don't support DMA cache snooping.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> ---
>  drivers/hid/intel-ish-hid/ipc/ipc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
> index 45e0c7b1c9ec..8ccb246b0114 100644
> --- a/drivers/hid/intel-ish-hid/ipc/ipc.c
> +++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
> @@ -909,7 +909,11 @@ static uint32_t ish_ipc_get_header(struct ishtp_device *dev, int length,
>   */
>  static bool _dma_no_cache_snooping(struct ishtp_device *dev)
>  {
> -	return dev->pdev->device == EHL_Ax_DEVICE_ID;
> +	return (dev->pdev->device == EHL_Ax_DEVICE_ID ||
> +		dev->pdev->device == TGL_LP_DEVICE_ID ||
> +		dev->pdev->device == TGL_H_DEVICE_ID ||
> +		dev->pdev->device == ADL_S_DEVICE_ID ||
> +		dev->pdev->device == ADL_P_DEVICE_ID);
>  }

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

