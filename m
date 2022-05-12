Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E38524C10
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353422AbiELLsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353424AbiELLsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:48:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF9D527CC;
        Thu, 12 May 2022 04:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652356083; x=1683892083;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6kvMfpZvWFSrqwLIvmdaXHccIdQ6zO56Yt3VrJlydlc=;
  b=V7dUrkL0ct+UBWXUKa4CIOVq6ZCuFSy8YLRwRfQhHlz+VYxQiEIzzHjk
   HzfwfG0ldrju3k9GuvWgGDqOJev7GrP6uH1eBFMexOCsIh1a2owLLQ/lR
   v4+VIYxiRfIFKFvjyyR4ezJNCx+Wq4xs5kj+uazpIt+/sOhPglsh+ZocQ
   CQ0WcRv/YkvunPTq6g3uNbdQbmzOBGnV64cK7zcro/Rf+m+cKS80anBUi
   gRm2P8c1tpXsqxg2cjzk5TcrlG4rlgWU2j3/Y/5rjM73Zk2YmGJZKbDzW
   KKLmDCUAzv7Zs8tWrNR3MJsVJr7i+68CMtQXFPtyiWwsrx2kUh/7FPbNY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="257523219"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="257523219"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 04:48:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="594630549"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.215])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 04:48:00 -0700
Message-ID: <e502c03a-3ac4-b660-40d5-944d52a31655@intel.com>
Date:   Thu, 12 May 2022 14:47:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add NULL check for data field
Content-Language: en-US
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com,
        saikrishna12468@gmail.com, sgoud@xilinx.com
References: <1652339993-27280-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1652339993-27280-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/22 10:19, Sai Krishna Potthuri wrote:
> Add NULL check for data field retrieved from of_device_get_match_data()
> before dereferencing the data.
> Addresses-coverity: CID 305057:Dereference null return value (NULL_RETURNS)
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 6a2e5a468424..757801dfc308 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1577,6 +1577,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	const struct sdhci_arasan_of_data *data;
>  
>  	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +
>  	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
>  
>  	if (IS_ERR(host))

