Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067E1528183
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242324AbiEPKIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242337AbiEPKH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:07:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C865DB7F5;
        Mon, 16 May 2022 03:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89EE5B81059;
        Mon, 16 May 2022 10:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A17C385AA;
        Mon, 16 May 2022 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652695648;
        bh=mJA6rH2uOwpy6kEmoE1DbK00kFgB/tAwaaqw91pYlkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eE4yaugpdDHU0zxrfSNyKk/ili8tz80jdULz7A/ZOJ9UI0NGfn7Uwt5KhEo/K/oDy
         xg5dGH/ys6lWSfczp9YDF8FhYD5gUaluWSDAuem1uyzEHQ6Dn3smDXQlC7Jgu7Ex9+
         7cm3P3psGx34ta0T4ZlLQQzUncEVj7p8JmGOhwsM1yH668wjXxI4V/WvJUpeA/WceH
         VLYp26GHftdCVu7epf9xBTf/VMqtVkMwexcS0cGDqCCsKg/y514NowmtBdr2L5+5mG
         8lvqDLI4+bjaXObb1A2eR9fDtMATQrMAZAfxpQB6ELCSRpRpm0d/dPtq6bSUl8pErq
         nkhwFrw4D/TJw==
Date:   Mon, 16 May 2022 11:07:21 +0100
From:   Will Deacon <will@kernel.org>
To:     cyndis@kapsi.fi
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu: Attach to host1x context device
 bus
Message-ID: <20220516100721.GA1927@willie-the-truck>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
 <20220516085258.1227691-6-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516085258.1227691-6-cyndis@kapsi.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:52:54AM +0300, cyndis@kapsi.fi wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Set itself as the IOMMU for the host1x context device bus, containing
> "dummy" devices used for Host1x context isolation.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 568cce590ccc..9ff54eaecf81 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -39,6 +39,7 @@
>  
>  #include <linux/amba/bus.h>
>  #include <linux/fsl/mc.h>
> +#include <linux/host1x_context_bus.h>
>  
>  #include "arm-smmu.h"
>  
> @@ -2053,8 +2054,20 @@ static int arm_smmu_bus_init(struct iommu_ops *ops)
>  			goto err_reset_pci_ops;
>  	}
>  #endif
> +#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
> +	if (!iommu_present(&host1x_context_device_bus_type)) {
> +		err = bus_set_iommu(&host1x_context_device_bus_type, ops);
> +		if (err)
> +			goto err_reset_fsl_mc_ops;
> +	}
> +#endif
> +
>  	return 0;
>  
> +err_reset_fsl_mc_ops: __maybe_unused;
> +#ifdef CONFIG_FSL_MC_BUS
> +	bus_set_iommu(&fsl_mc_bus_type, NULL);
> +#endif

bus_set_iommu() is going away:

https://lore.kernel.org/r/cover.1650890638.git.robin.murphy@arm.com

Will
> 
