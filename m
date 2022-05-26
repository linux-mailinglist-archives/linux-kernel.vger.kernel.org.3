Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF2D534BED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346759AbiEZItW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiEZItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:49:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F3C1AF337;
        Thu, 26 May 2022 01:49:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EFF51474;
        Thu, 26 May 2022 01:49:18 -0700 (PDT)
Received: from [10.1.37.22] (e122027.cambridge.arm.com [10.1.37.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2930D3F70D;
        Thu, 26 May 2022 01:49:14 -0700 (PDT)
Message-ID: <226e48d3-5772-bed5-443b-db9acd1365b8@arm.com>
Date:   Thu, 26 May 2022 09:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/9] dt-bindings: Add compatible for Mali Valhall (JM)
Content-Language: en-GB
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
 <20220525145754.25866-2-alyssa.rosenzweig@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220525145754.25866-2-alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2022 15:57, Alyssa Rosenzweig wrote:
> From the kernel's perspective, (pre-CSF, "Job Manager") Valhall is more
> or less compatible with Bifrost, although they differ to userspace. Add
> a compatible for Valhall to the existing Bifrost bindings documentation.
> 
> As the first SoC with a Valhall GPU receiving mainline support, add a
> specific compatible for the MediaTek MT8192, which instantiates a
> Mali-G57.
> 
> v2: Change compatible to arm,mali-valhall-jm (Daniel Stone).
> 
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> CC: devicetree@vger.kernel.org

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 25 +++++++++++--------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 85f8d4764740..78964c140b46 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -14,16 +14,21 @@ properties:
>      pattern: '^gpu@[a-f0-9]+$'
>  
>    compatible:
> -    items:
> -      - enum:
> -          - amlogic,meson-g12a-mali
> -          - mediatek,mt8183-mali
> -          - realtek,rtd1619-mali
> -          - renesas,r9a07g044-mali
> -          - renesas,r9a07g054-mali
> -          - rockchip,px30-mali
> -          - rockchip,rk3568-mali
> -      - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,meson-g12a-mali
> +              - mediatek,mt8183-mali
> +              - realtek,rtd1619-mali
> +              - renesas,r9a07g044-mali
> +              - renesas,r9a07g054-mali
> +              - rockchip,px30-mali
> +              - rockchip,rk3568-mali
> +          - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> +      - items:
> +          - enum:
> +              - mediatek,mt8192-mali
> +          - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
>  
>    reg:
>      maxItems: 1

