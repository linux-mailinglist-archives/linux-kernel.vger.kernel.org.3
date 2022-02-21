Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D134BDEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380977AbiBUQoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:44:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380940AbiBUQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:44:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A67220E8;
        Mon, 21 Feb 2022 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645461820; x=1676997820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HrHAf6gEsOAhEpFdK8CdrZ0sJZ9UBBtJ6ScL1EPZiy0=;
  b=1SRJSbbTYOY3q9ifajm7BjSJmBvWpraTrmsgqCaYHAZMjQqcmnnAvCha
   +1pijPaBC9I97Mx8TLLBow+LSJlXfl/X24zl2T1bJuGcq7R4SOUZFwIMo
   OcdOmx2qeVAGjrRbtvK8Tjo66+NSk5vywecaEO9AYFiQPMwUD44iuHqAI
   naOHJUGnrYILkKGA784W9gwHxfJASKkM9JBLOFkc5t6qpOsRJD4obnrYA
   IDq4DsTCvc8zttizvDSR9CpOaSbxlL88zi5LSNZfYtwcVeJmMEU2bO5QG
   6wAuKGsq+RadtyEcYOS1qX2sSIWQBJqOv04c8PxNOkyV7SmUA6rlMw24P
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="163022563"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2022 09:43:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Feb 2022 09:43:39 -0700
Received: from [10.12.68.158] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 21 Feb 2022 09:43:38 -0700
Message-ID: <994b754f-a8b0-2504-0803-d12fa9975ff5@microchip.com>
Date:   Mon, 21 Feb 2022 17:43:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: lan966x: Fix linking error
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <kavyasree.kotagiri@microchip.com>,
        kernel test robot <lkp@intel.com>
References: <20220219141536.460812-1-horatiu.vultur@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220219141536.460812-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2022 at 15:15, Horatiu Vultur wrote:
> If the config options HAS_IOMEM is not set then the driver fails to link
> with the following error:
> clk-lan966x.c:(.text+0x950): undefined reference to
> `devm_platform_ioremap_resource'
> 
> Therefor add missing dependencies: HAS_IOMEM and OF.
> 
> Fixes: 54104ee02333 ("clk: lan966x: Add lan966x SoC clock driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 4a8451f61f37..6f03c29c40be 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -232,6 +232,8 @@ config COMMON_CLK_GEMINI
>   
>   config COMMON_CLK_LAN966X
>   	bool "Generic Clock Controller driver for LAN966X SoC"
> +	depends on HAS_IOMEM
> +	depends on OF
>   	help
>   	  This driver provides support for Generic Clock Controller(GCK) on
>   	  LAN966X SoC. GCK generates and supplies clock to various peripherals


-- 
Nicolas Ferre
