Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE04675EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380274AbhLCLLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:11:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44168 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380216AbhLCLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:11:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3B7aYA125397;
        Fri, 3 Dec 2021 05:07:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638529656;
        bh=o2/3Sb6TDRH3rx8TWLvMcNFdX2xi3fcTYplGH9IWqHA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GNan/2Tu/yS8xqEBljoRMaFvSzhkOt5UfYKHw2PtOcbnIN887LoX0bCgb8GViyxTX
         kueOSL5EJNO7DACmjTiR4OdP+uSSnRVTT7gJriKEaMgg23MXSfHZtkCG129h1nSDUb
         eYejbVRm/gFI0pn51ggwO3eu6kRWHbLT39weFcE4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3B7aKK052803
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 05:07:36 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 05:07:36 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 05:07:36 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3B7ZQm019521;
        Fri, 3 Dec 2021 05:07:36 -0600
Date:   Fri, 3 Dec 2021 16:37:34 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix the L2 cache sets
Message-ID: <20211203110734.23e2t356s45ux5mu@ti.com>
References: <20211113043638.4358-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211113043638.4358-1-nm@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21 10:36PM, Nishanth Menon wrote:
> A72's L2 cache[1] on J7200[2] is 1MB. A53's L2 is fixed line length of
                                        ^^^

Same as previous patch, do you mean A72? J7200 does not have an A53 core 
and this cache node is for A72 cores anyway.

With this fixed,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> 64 bytes and 16-way set-associative cache structure.
> 
> 1MB of L2 / 64 (line length) = 16384 ways
> 16384 ways / 16 = 1024 sets
> 
> Fix the l2 cache-sets.
> 
> [1] https://developer.arm.com/documentation/100095/0003/Level-2-Memory-System/About-the-L2-memory-system
> [2] https://www.ti.com/lit/pdf/spruiu1
> 
> Fixes: d361ed88455f ("arm64: dts: ti: Add support for J7200 SoC")
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> index 958587d3a33d..64fef4e67d76 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> @@ -86,7 +86,7 @@ L2_0: l2-cache0 {
>  		cache-level = <2>;
>  		cache-size = <0x100000>;
>  		cache-line-size = <64>;
> -		cache-sets = <2048>;
> +		cache-sets = <1024>;
>  		next-level-cache = <&msmc_l3>;
>  	};
>  

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
