Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5B8479110
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbhLQQOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:14:25 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44924 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbhLQQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:14:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BHGEILp054920;
        Fri, 17 Dec 2021 10:14:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639757658;
        bh=QNfovKNIzVYkSpNQyydNLxn4hq4rEdgFphcPrHDTV5s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WvptG5c0dnY9oi4J5g+k8JM/DJUh2vEmkPr24rg6Kp9iXILBGTH/vxTrf8yCrLJD4
         OBlz4H6dTq8KLYT/I+ghyDRRO/L8bgA0LEk8VUAynBlxDModcPR9QkWhKJlq0vs4ov
         spJuZffP8JeJC9yMHICMxOBcqN0Ix1TmBWwbXtbQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BHGEHAS102109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Dec 2021 10:14:18 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Dec 2021 10:14:17 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Dec 2021 10:14:17 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BHGEHD1101479;
        Fri, 17 Dec 2021 10:14:17 -0600
Date:   Fri, 17 Dec 2021 10:14:17 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <krzysztof.kozlowski@canonical.com>, <tony@atomide.com>,
        <robh@kernel.org>, <kishon@ti.com>, <vigneshr@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: arch_k3: Select GPMC device driver
Message-ID: <20211217161417.q2qwwlki7oieqzjd@headlock>
References: <20211217102945.17432-1-rogerq@kernel.org>
 <20211217102945.17432-5-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217102945.17432-5-rogerq@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:29-20211217, Roger Quadros wrote:
> The GPMC controller is present on some K3 SoCs.
> It provides access to NOR/NAND flashes and asynchronous
> SRAM-like memories and ASICs.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 1aa8b7073218..f447b120f863 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -122,6 +122,7 @@ config ARCH_K3
>  	select TI_SCI_INTR_IRQCHIP
>  	select TI_SCI_INTA_IRQCHIP
>  	select TI_K3_SOCINFO
> +	select OMAP_GPMC
I dont think GPMC should be part of the select list here. instead
defconfig patch is prefered. the existance and usage of the same are
limited and it is NOT a core functional component required to boot up a
K3 platform.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
