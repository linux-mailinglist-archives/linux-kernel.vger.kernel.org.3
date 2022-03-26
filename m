Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FDA4E8159
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiCZOLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiCZOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:11:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E864ECEE;
        Sat, 26 Mar 2022 07:09:36 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22QE9QOk106943;
        Sat, 26 Mar 2022 09:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648303766;
        bh=9FhBa4d6c/E7NyUvf6hFNi3X7f1RjP2z+g6onY7Oo34=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=svklQovqXzG5eh2Wu31ryXLdYNIC/kSyceQQxupnU4dkJUNEgEK8QCIu5vztPNmpD
         qijLcC42GIayTSD7flGODn54AedQYFBSJhzY8MK4ZUweOoxtMsvXoRusjXQXEXPvmP
         0tPVQqn8Ll9maAqiFo3+MwNn6xFQPs/DgTqpfYKk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22QE9Q5r000685
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 26 Mar 2022 09:09:26 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 26
 Mar 2022 09:09:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 26 Mar 2022 09:09:26 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22QE9N0g020357;
        Sat, 26 Mar 2022 09:09:24 -0500
Message-ID: <e28524f0-7251-afc3-4237-58994659f0d3@ti.com>
Date:   Sat, 26 Mar 2022 19:39:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] memory: omap-gpmc: Make OMAP_GPMC config visible and
 selectable
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, <krzk@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <tony@atomide.com>, <kishon@ti.com>,
        <nm@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220326084331.28310-1-rogerq@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220326084331.28310-1-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 26/03/22 2:13 pm, Roger Quadros wrote:
> So far for armv7 TI platforms, GPMC was being selected by
> arch/arm/mach-* architecture Kconfig files.
> 
> For K3 platforms, GPMC is no longer required for basic boot
> and cannot be always enabled by default by mach- Kconfig.
> 
> We need a way for user (or board defconfig) to enable
> it if required so ake OMAP_GPMC Kconfig option always visible.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/memory/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 30bff6cb1b8d..da2af9c38fe3 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -103,8 +103,8 @@ config TI_EMIF
>  	  temperature changes
>  
>  config OMAP_GPMC
> -	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
> -	depends on OF_ADDRESS
> +	bool "Texas Instruments OMAP SoC GPMC driver"
> +	depends on OF_ADDRESS || COMPILE_TEST

Can we make this tristate now, so that driver can be built as module?

>  	select GPIOLIB
>  	help
>  	  This driver is for the General Purpose Memory Controller (GPMC)
