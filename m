Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5BF514218
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354332AbiD2GCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbiD2GB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:01:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2984D6FF74;
        Thu, 28 Apr 2022 22:58:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23T5wZTg052873;
        Fri, 29 Apr 2022 00:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651211915;
        bh=7ub+1jFKXKC1WMcZ3JRJEud9/CWYRZVayyMkec2wbXo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IJtbuOBwcsyZ326bj2xk/+6YZ9+tL33antxuEEC0gYWLkgxONT4dxCYpZSFwYZ5AM
         fXiOSzum1nemXAsfPHJF+MO9bChKjPVExRYqOypp5OGk7gX+F2cTsBU74GBc9SH5Pc
         aVN05ZWetVt8XiclPJggwz3CUkPixopvj8w5pgXo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23T5wZA0108388
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Apr 2022 00:58:35 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 29
 Apr 2022 00:58:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 29 Apr 2022 00:58:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23T5wXd6068304;
        Fri, 29 Apr 2022 00:58:34 -0500
Date:   Fri, 29 Apr 2022 11:28:33 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Ian Abbott <abbotti@mev.co.uk>
CC:     <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cadence-quadspi: fix Direct Access Mode disable for
 SoCFPGA
Message-ID: <20220429055833.ahgioqdjwgshpylk@ti.com>
References: <20220427153446.10113-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220427153446.10113-1-abbotti@mev.co.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/22 04:34PM, Ian Abbott wrote:
> The Cadence QSPI compatible string required for the SoCFPGA platform
> changed from the default "cdns,qspi-nor" to "intel,socfpga-qspi" with
> the introduction of an additional quirk in
> commit 98d948eb8331 ("spi: cadence-quadspi: fix write completion support").
> However, that change did not preserve the previously used
> quirk for this platform.  Reinstate the `CQSPI_DISABLE_DAC_MODE` quirk
> for the SoCFPGA platform.
> 
> Fixes: 98d948eb8331 ("spi: cadence-quadspi: fix write completion support")
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> ---
>  drivers/spi/spi-cadence-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 41922a5ea1f4..30307392c75a 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1781,7 +1781,7 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
>  };
>  
>  static const struct cqspi_driver_platdata socfpga_qspi = {
> -	.quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
> +	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION,
>  };
>  
>  static const struct cqspi_driver_platdata versal_ospi = {
> -- 
> 2.35.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
