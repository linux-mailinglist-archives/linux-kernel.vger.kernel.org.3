Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A400530EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiEWLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiEWLDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:03:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50B8423BE8;
        Mon, 23 May 2022 04:03:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B352211FB;
        Mon, 23 May 2022 04:03:39 -0700 (PDT)
Received: from [10.57.34.201] (unknown [10.57.34.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575D83F73D;
        Mon, 23 May 2022 04:03:38 -0700 (PDT)
Message-ID: <9a9b40eb-be8d-bf8c-39be-e0abb507820f@arm.com>
Date:   Mon, 23 May 2022 12:03:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: Convert CoreSight bindings to DT
 schema
To:     Rob Herring <robh@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "coresight >> Coresight ML" <coresight@lists.linaro.org>
References: <20220520214416.302127-1-robh@kernel.org>
 <20220520214416.302127-2-robh@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220520214416.302127-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks a lot for converting these to yaml. Some minor comments below.

In general, the "clocks" and "clock-names" are optional (e.g, for
etm4 with system register access).

On 20/05/2022 22:44, Rob Herring wrote:
> Each CoreSight component has slightly different requirements and
> nothing applies to every component, so each CoreSight component has its
> own schema document.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/arm/arm,coresight-catu.yaml      | 101 +++++
>   .../arm/arm,coresight-dynamic-funnel.yaml     | 126 ++++++
>   .../bindings/arm/arm,coresight-etb10.yaml     |  92 ++++
>   .../bindings/arm/arm,coresight-etm.yaml       | 156 +++++++
>   .../arm/arm,coresight-static-replicator.yaml  |  90 ++++
>   .../bindings/arm/arm,coresight-stm.yaml       | 101 +++++
>   .../bindings/arm/arm,coresight-tmc.yaml       | 132 ++++++
>   .../bindings/arm/arm,coresight-tpiu.yaml      |  91 ++++
>   .../devicetree/bindings/arm/coresight.txt     | 402 ------------------
>   9 files changed, 889 insertions(+), 402 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/coresight.txt

...

> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> new file mode 100644
> index 000000000000..ee1ce47225be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/arm,coresight-tmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Arm CoreSight Trace Memory Controller
> +

...

> +  out-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    additionalProperties: false
> +
> +    properties:
> +      port:
> +        description: AXI Master output connection. Used for ETR and ETF
> +          configurations.

nit: This is only for ETRs. Never for ETFs.

Suzuki
