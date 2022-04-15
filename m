Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACA6502F49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350932AbiDOTXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350795AbiDOTXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:23:35 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78447DE922;
        Fri, 15 Apr 2022 12:20:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FJKnKc041676;
        Fri, 15 Apr 2022 14:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650050449;
        bh=JqC+H9+Rev8gsZydzoz3H+tEXpC+wEOhrdCkvS2dOfw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MQkcy68uuwxTKnDBByF3zwzmmj16q7syVKm2RMi73i1YlUqr7OX78YlIMqHOzxjI8
         qTt/zRyUwlwSAvheHNjwiDkI0Zj683z66Tc3njTPEqmmZRG0BYJghApnWgIh4hkvtz
         CbeS1mypslJwWBRCTWxmXnT16YD9xcozdcnRcmEA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FJKn36054167
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 14:20:49 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 14:20:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 14:20:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FJKnMX080301;
        Fri, 15 Apr 2022 14:20:49 -0500
Date:   Fri, 15 Apr 2022 14:20:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Georgi Vlaev <g-vlaev@ti.com>
CC:     <ssantosh@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/2] clk: keystone: syscon-clk: Add support for AM62
 epwm-tbclk
Message-ID: <20220415192048.mdkwqfs2ztz6vens@cherub>
References: <20220415190343.6284-1-g-vlaev@ti.com>
 <20220415190343.6284-3-g-vlaev@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220415190343.6284-3-g-vlaev@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:03-20220415, Georgi Vlaev wrote:
> AM62 has 3 instances of EPWM modules. Each EPWM module has
> an EPWM TBCLKEN module input used to individually enable or
> disable its EPWM time-base clock. The EPWM time-base clock
> enable input comes from the CTRLMMR_EPWM_TB_CLKEN register
> bits 0 to 2 in CTRL_MMR0 module (6.1.1.4.1.48 [1]). This
> is virtually the same setup as in AM64 but with 3 instead
> of 9 clock providers on AM62.
> 
> Update the driver with the 3 instances of clocks associated
> to a new compatible: "ti,am62-epwm-tbclk".
> 
> [1] https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> Tested-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/clk/keystone/syscon-clk.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
> index aae1a4076281..19198325b909 100644
> --- a/drivers/clk/keystone/syscon-clk.c
> +++ b/drivers/clk/keystone/syscon-clk.c
> @@ -162,6 +162,13 @@ static const struct ti_syscon_gate_clk_data am64_clk_data[] = {
>  	{ /* Sentinel */ },
>  };
>  
> +static const struct ti_syscon_gate_clk_data am62_clk_data[] = {
> +	TI_SYSCON_CLK_GATE("epwm_tbclk0", 0x0, 0),
> +	TI_SYSCON_CLK_GATE("epwm_tbclk1", 0x0, 1),
> +	TI_SYSCON_CLK_GATE("epwm_tbclk2", 0x0, 2),

Reviewed-by: Nishanth Menon <nm@ti.com>

Thanks for reordering.

> +	{ /* Sentinel */ },
> +};
> +
>  static const struct of_device_id ti_syscon_gate_clk_ids[] = {
>  	{
>  		.compatible = "ti,am654-ehrpwm-tbclk",
> @@ -171,6 +178,10 @@ static const struct of_device_id ti_syscon_gate_clk_ids[] = {
>  		.compatible = "ti,am64-epwm-tbclk",
>  		.data = &am64_clk_data,
>  	},
> +	{
> +		.compatible = "ti,am62-epwm-tbclk",
> +		.data = &am62_clk_data,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ti_syscon_gate_clk_ids);
> -- 
> 2.30.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
