Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD674675C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380216AbhLCK7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:59:39 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35548 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380219AbhLCK7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:59:37 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3Au2CG121511;
        Fri, 3 Dec 2021 04:56:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638528962;
        bh=pS2+InnzRVzOvRIisVrMRLbxcrHyVrEVRCTgfcnS+Js=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=k796jzwZzu5I/sNcJPAmvhkES0j6FPP/pdUNIQ479q+EzY0P4bI7PRzaoDZ2GEDMu
         3z7nKc+OAXvdhgaT2VYCC+1TfDHcXB5LJ1sZy+ifwb1W8eul+SpTNzxWIgkGayKRRQ
         GqOGujSSd4qeRPDyaSMo+vHp009dn2tj4Ime71jw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3Au2vh000447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 04:56:02 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 04:56:02 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 04:56:02 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3Au1el122028;
        Fri, 3 Dec 2021 04:56:01 -0600
Date:   Fri, 3 Dec 2021 16:26:00 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e: Fix the L2 cache sets
Message-ID: <20211203105558.eibfd2hamyjl2b6f@ti.com>
References: <20211113043639.4413-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211113043639.4413-1-nm@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21 10:36PM, Nishanth Menon wrote:
> A72's L2 cache[1] on J721e[2] is 1MB. A53's L2 is fixed line length of
                                        ^^^

Do you mean A72? J721E does not have an A53 core, and this cache node is 
for A72 cores anyway.

Other than this,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> 64 bytes and 16-way set-associative cache structure.
> 
> 1MB of L2 / 64 (line length) = 16384 ways
> 16384 ways / 16 = 1024 sets
> 
> Fix the l2 cache-sets.
> 
> [1] https://developer.arm.com/documentation/100095/0003/Level-2-Memory-System/About-the-L2-memory-system
> [2] http://www.ti.com/lit/pdf/spruil1
> 
> Fixes: 2d87061e70de ("arm64: dts: ti: Add Support for J721E SoC")
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index 214359e7288b..0f674bc8f1c7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> @@ -88,7 +88,7 @@ L2_0: l2-cache0 {
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
