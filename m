Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F96754F819
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382428AbiFQNFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiFQNFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:05:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C6C13F06;
        Fri, 17 Jun 2022 06:05:17 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25HD5B4Y052750;
        Fri, 17 Jun 2022 08:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655471111;
        bh=83xtz1/73dFHdQEN52Ku2e+yWx9+jRf0I8+LtJ4Z8kc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LI329KpcByztJSleej6kTw8cyiV2wXS3SUVrecr1Z7vYk91bgz2h6umKPv76d6kfb
         R8aMpyNsNCBRktRibkPlsul7zJl6d47oluwMkBHf+KEKtJovYqFj/9wxMsowMIo9QN
         imQ7Jqn4aXL1bQETUJrZJbVYrJAG9+EGdM5wM/P8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25HD5BaW044817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 08:05:11 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 08:05:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 08:05:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25HD5BsW032350;
        Fri, 17 Jun 2022 08:05:11 -0500
Date:   Fri, 17 Jun 2022 08:05:11 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Matt Ranostay <mranostay@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: fix overlapping GICD memory
 region
Message-ID: <20220617130511.kvyofnv4a75kmcns@ultimate>
References: <20220616105112.289719-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220616105112.289719-1-mranostay@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matt,

	please cc linux-arm-kernel mailing list as well

On 03:51-20220616, Matt Ranostay wrote:
> GICD region was overlapping with GICR causing the latter to not map
> successfully, and in turn the gic-v3 driver would fail to initialize.
> 
> This issue was hidden till commit 2b2cd74a06c3 ("irqchip/gic-v3: Claim iomem resources")
> replaced of_iomap() calls with of_io_request_and_map() that internally
> called request_mem_region().
> 
> Respective console output before this patchset:
> 
> [    0.000000] GICv3: /bus@100000/interrupt-controller@1800000: couldn't map region 0
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>

Thank you for root causing the bug, BUT, please add a Fixes: tag as
well. this needs to go into stable as well.

> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index be7f39299894..19966f72c5b3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -33,7 +33,7 @@ gic500: interrupt-controller@1800000 {
>  		ranges;
>  		#interrupt-cells = <3>;
>  		interrupt-controller;
> -		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
> +		reg = <0x00 0x01800000 0x00 0x100000>, /* GICD */
>  		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
>  		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
>  		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */
> -- 
> 2.36.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
