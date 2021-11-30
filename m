Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15C463FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbhK3VUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:20:02 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55164 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244219AbhK3VTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:19:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AULGTUt091322;
        Tue, 30 Nov 2021 15:16:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638306989;
        bh=+QhSIZOFVUHp0MyvoYXMGcs3TJVZFT/Qu9FLdEIbL5Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cG84+YnkfTLOHlDRhWO7ZeTvanLXZPX9p7VbGl1yEOtOSnBEdGKtXZWJeX0RunK/b
         gaIJYVBjLd0AYqE/oNnwgKr34WTa9Z5uxuCzbhqQNvjYY13POrSF+neri0wWsSdBg0
         dHvhj/CZ24H5CuY/XB7igfsZ1i0zlsdPvqry4Nkg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AULGToU030514
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Nov 2021 15:16:29 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 30
 Nov 2021 15:16:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 30 Nov 2021 15:16:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AULGS7s124635;
        Tue, 30 Nov 2021 15:16:28 -0600
Date:   Tue, 30 Nov 2021 15:16:28 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jason Kridner <jkridner@beagleboard.org>
CC:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] counter: ti-eqep: Enable for TDA4VM/J721E
Message-ID: <20211130211628.3zxkixf6bu3mcfnx@brook>
References: <20211130193346.678544-1-jkridner@beagleboard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211130193346.678544-1-jkridner@beagleboard.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:33-20211130, Jason Kridner wrote:
> Counter TI-EQEP was tested on TDA4VM/J721E SoC.
> 
Thanks for doing this patch,
You could drop the example - This is an example which is probably
better addressed in Documentation/devicetree/bindings/counter/ti-eqep.yaml
or in the actual device tree for j721e itself.

Instead, I would suggest to keep the commit message short:

Enable TI-QEP for TI's K3 architecture as the driver is reusable
or something of that form.

The actual devicetree dts patch should be separate and posted once the
driver support is enabled.

> Overlay used for testing EQEP0 and EQEP1:
> 
>     &cbass_main {
> 	#address-cells = <2>;
> 	#size-cells = <2>;
> 
> 	eqep0: qep@3200000 {

	[...]

> 	};
>     };
> 
> Signed-off-by: Jason Kridner <jkridner@beagleboard.org>
> ---
>  drivers/counter/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2de53ab0dd25..453490059c88 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -51,7 +51,7 @@ config STM32_LPTIMER_CNT
>  
>  config TI_EQEP
>  	tristate "TI eQEP counter driver"
> -	depends on (SOC_AM33XX || COMPILE_TEST)
> +	depends on (SOC_AM33XX || ARCH_K3 || COMPILE_TEST)
>  	select REGMAP_MMIO
>  	help
>  	  Select this option to enable the Texas Instruments Enhanced Quadrature
> -- 
> 2.30.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
