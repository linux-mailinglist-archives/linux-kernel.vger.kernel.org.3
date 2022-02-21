Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED14B4BE78C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379044AbiBUPYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:24:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379046AbiBUPYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:24:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D773D220D9;
        Mon, 21 Feb 2022 07:23:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 841F11042;
        Mon, 21 Feb 2022 07:23:36 -0800 (PST)
Received: from [10.57.40.147] (unknown [10.57.40.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B26153F70D;
        Mon, 21 Feb 2022 07:23:34 -0800 (PST)
Message-ID: <48ac567b-37e8-1fa2-c389-536e276fdd2c@arm.com>
Date:   Mon, 21 Feb 2022 15:23:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/9] dt-bindings: host1x: Add memory-contexts property
Content-Language: en-GB
To:     Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-2-mperttunen@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220218113952.3077606-2-mperttunen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-18 11:39, Mikko Perttunen via iommu wrote:
> Add schema information for the memory-contexts property used to
> specify context stream IDs. This uses the standard iommu-map property
> inside a child node.

Couldn't you simply make "iommu-map" an allowed property on the host1x 
node itself? From a DT perspective I'm not sure the intermediate node 
really fits meaningfully, and I can't see that it serves much purpose in 
practice either, other than perhaps defeating fw_devlink.

Robin.

> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v3:
> * New patch
> ---
>   .../bindings/display/tegra/nvidia,tegra20-host1x.yaml  | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> index 4fd513efb0f7..3ac0fde54a16 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> @@ -144,6 +144,16 @@ allOf:
>           reset-names:
>             maxItems: 1
>   
> +        memory-contexts:
> +          type: object
> +          properties:
> +            iommu-map:
> +              description: Specification of stream IDs available for memory context device
> +                use. Should be a mapping of IDs 0..n to IOMMU entries corresponding to
> +                usable stream IDs.
> +          required:
> +            - iommu-map
> +
>         required:
>           - reg-names
>   
