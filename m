Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4668C4675F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380300AbhLCLQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:16:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54210 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbhLCLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:16:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3BDBdN112705;
        Fri, 3 Dec 2021 05:13:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638529991;
        bh=GrKJIZ02eZdfcKmB7j5fDaxR+HIVNYkC4fwMiMR4Wcg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QQdZnqOolvTlErih4CD/hmoZgB90kqaHKWV8juSA+kWFsFf3ssQUcUITkcNF5ntFl
         rb5Djz6TdiW7A/+qvMP9S0PUwQCPpJ9twuRe97x7aB/nOdFdo95mTn173T0sew31Hq
         oa1BnsgFFo7RDAzL/7EBj+2N/dkLVdTnzRjcD4Ew=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3BDBBE022837
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 05:13:11 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 05:13:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 05:13:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3BDAwd093223;
        Fri, 3 Dec 2021 05:13:11 -0600
Date:   Fri, 3 Dec 2021 16:43:10 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642: Fix the L2 cache sets
Message-ID: <20211203111308.zfxczgywmjzplbha@ti.com>
References: <20211113043635.4296-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211113043635.4296-1-nm@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21 10:36PM, Nishanth Menon wrote:
> A53's L2 cache[1] on AM642[2] is 256KB. A53's L2 is fixed line length
> of 64 bytes and 16-way set-associative cache structure.

This time the commit message is correct :-)

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> 
> 256KB of L2 / 64 (line length) = 4096 ways
> 4096 ways / 16 = 256 sets
> 
> Fix the l2 cache-sets.
> 
> [1] https://developer.arm.com/documentation/ddi0500/j/Level-2-Memory-System/About-the-L2-memory-system?lang=en
> [2] https://www.ti.com/lit/pdf/spruim2
> 
> Fixes: 8abae9389bdb ("arm64: dts: ti: Add support for AM642 SoC")
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am642.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642.dtsi b/arch/arm64/boot/dts/ti/k3-am642.dtsi
> index e2b397c88401..8a76f4821b11 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am642.dtsi
> @@ -60,6 +60,6 @@ L2_0: l2-cache0 {
>  		cache-level = <2>;
>  		cache-size = <0x40000>;
>  		cache-line-size = <64>;
> -		cache-sets = <512>;
> +		cache-sets = <256>;
>  	};
>  };

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
