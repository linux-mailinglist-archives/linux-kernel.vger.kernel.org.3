Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD42654F8F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381281AbiFQONJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382409AbiFQONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:13:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4714A22B3B;
        Fri, 17 Jun 2022 07:13:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D5E71474;
        Fri, 17 Jun 2022 07:13:07 -0700 (PDT)
Received: from [10.57.84.65] (unknown [10.57.84.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFD203F7D8;
        Fri, 17 Jun 2022 07:13:05 -0700 (PDT)
Message-ID: <3d35c330-acfe-c6d1-8963-4b9b6d44dbb5@arm.com>
Date:   Fri, 17 Jun 2022 15:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721s2: fix overlapping GICD memory
 region
Content-Language: en-GB
To:     Matt Ranostay <mranostay@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Nishanth Menon <nm@ti.com>
References: <20220617140207.444298-1-mranostay@ti.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220617140207.444298-1-mranostay@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-17 15:02, Matt Ranostay wrote:
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
> Fixes: 2b2cd74a06c3 ("irqchip/gic-v3: Claim iomem resources")

I think that should be b8545f9d3a54 ("arm64: dts: ti: Add initial 
support for J721S2 SoC") - the GIC change is the point at which Linux 
started *noticing* that the DT was wrong, but it's not what made the DT 
wrong.

Thanks,
Robin.

> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Changes from v1:
> * Add missing Fixes: in commit messages
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index be7f39299894..19966f72c5b3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -33,7 +33,7 @@ gic500: interrupt-controller@1800000 {
>   		ranges;
>   		#interrupt-cells = <3>;
>   		interrupt-controller;
> -		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
> +		reg = <0x00 0x01800000 0x00 0x100000>, /* GICD */
>   		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
>   		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
>   		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */
