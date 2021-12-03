Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE99467653
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhLCLaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:30:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55748 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243778AbhLCL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:29:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3BQEjh116115;
        Fri, 3 Dec 2021 05:26:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638530774;
        bh=MLDGzhyWOPSqm2Rn9xtPA1jXg00wCieQBnRv7tftYVk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wlG65fTBnLRj+CTKXhlFC0EWu1X9bIz8qr0XJigTQgnprtz76D3fQ0iPMVa4118Ue
         atJKlq0/NjKphwlP3u60AilWBbsbWKE647De7QKLbg6AjTAF7E/h4L5gycBImZ/zfC
         xeJa5BPwOb8976RCPoBGEwuxCOs2Bu8DfhVEa+V0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3BQEYf030960
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 05:26:14 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 05:26:14 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 05:26:14 -0600
Received: from [10.250.234.139] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3BQA2E109248;
        Fri, 3 Dec 2021 05:26:11 -0600
Subject: Re: [PATCH] arm64: dts: k3-j7200: Correct the d-cache-sets info
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
References: <20211113024348.29257-1-nm@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e7ce36b5-0b0e-e22c-3074-5a1ba49e1540@ti.com>
Date:   Fri, 3 Dec 2021 16:56:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211113024348.29257-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/11/21 8:13 am, Nishanth Menon wrote:
> A72 Cluster (chapter 1.3,1 [1]) has 48KB Icache, 32KB Dcache and 1MB L2 Cache
>  - ICache is 3-way set-associative
>  - Dcache is 2-way set-associative
>  - Line size are 64bytes
> 
> 32KB (Dcache)/64 (fixed line length of 64 bytes) = 512 ways
> 512 ways / 2 (Dcache is 2-way per set) = 256 sets.
> 
> So, correct the d-cache-sets info.
> 
> [1] https://www.ti.com/lit/pdf/spruiu1
> 
> Fixes: d361ed88455f ("arm64: dts: ti: Add support for J7200 SoC")
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> index 47567cb260c2..958587d3a33d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> @@ -62,7 +62,7 @@ cpu0: cpu@0 {
>  			i-cache-sets = <256>;
>  			d-cache-size = <0x8000>;
>  			d-cache-line-size = <64>;
> -			d-cache-sets = <128>;
> +			d-cache-sets = <256>;
>  			next-level-cache = <&L2_0>;
>  		};
>  
> @@ -76,7 +76,7 @@ cpu1: cpu@1 {
>  			i-cache-sets = <256>;
>  			d-cache-size = <0x8000>;
>  			d-cache-line-size = <64>;
> -			d-cache-sets = <128>;
> +			d-cache-sets = <256>;
>  			next-level-cache = <&L2_0>;
>  		};
>  	};
> 
