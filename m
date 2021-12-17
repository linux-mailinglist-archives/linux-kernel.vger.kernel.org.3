Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61139478B67
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhLQMdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:33:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:2609 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236284AbhLQMdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:33:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="238488180"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="238488180"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 04:33:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="465108799"
Received: from jvowlesx-mobl.amr.corp.intel.com ([10.212.181.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 04:33:07 -0800
Message-ID: <4d8308f4a3249b662536371e14e6cd6ef723f5a9.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Specify no cache snooping on
 TGL and ADL
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ye Xiang <xiang.ye@intel.com>, jikos@kernel.org, jic23@kernel.org
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Dec 2021 04:33:07 -0800
In-Reply-To: <20211217074541.4705-1-xiang.ye@intel.com>
References: <20211217074541.4705-1-xiang.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-17 at 15:45 +0800, Ye Xiang wrote:
> Specify that both TGL and ADL don't support DMA cache snooping.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ipc/ipc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-
> ish-hid/ipc/ipc.c
> index 45e0c7b1c9ec..8ccb246b0114 100644
> --- a/drivers/hid/intel-ish-hid/ipc/ipc.c
> +++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
> @@ -909,7 +909,11 @@ static uint32_t ish_ipc_get_header(struct
> ishtp_device *dev, int length,
>   */
>  static bool _dma_no_cache_snooping(struct ishtp_device *dev)
>  {
> -       return dev->pdev->device == EHL_Ax_DEVICE_ID;
> +       return (dev->pdev->device == EHL_Ax_DEVICE_ID ||
> +               dev->pdev->device == TGL_LP_DEVICE_ID ||
> +               dev->pdev->device == TGL_H_DEVICE_ID ||
> +               dev->pdev->device == ADL_S_DEVICE_ID ||
> +               dev->pdev->device == ADL_P_DEVICE_ID);
>  }
>  
>  static const struct ishtp_hw_ops ish_hw_ops = {


