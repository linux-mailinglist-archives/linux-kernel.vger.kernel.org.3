Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5618A530D32
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiEWJqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiEWJoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:44:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BBDED75;
        Mon, 23 May 2022 02:44:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D44B911FB;
        Mon, 23 May 2022 02:44:40 -0700 (PDT)
Received: from [10.57.34.201] (unknown [10.57.34.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AA513F73D;
        Mon, 23 May 2022 02:44:38 -0700 (PDT)
Message-ID: <beba5968-3115-3c09-cda6-67095ca55226@arm.com>
Date:   Mon, 23 May 2022 10:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v7 08/10] dt-bindings: arm: Adds CoreSight TPDA hardware
 definitions
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
 <20220509133947.20987-9-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220509133947.20987-9-quic_jinlmao@quicinc.com>
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

Cc: Rob Herring



On 09/05/2022 14:39, Mao Jinlong wrote:
> Adds new coresight-tpda.yaml file describing the bindings required
> to define tpda in the device trees.
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   .../bindings/arm/coresight-tpda.yaml          | 119 ++++++++++++++++++
>   MAINTAINERS                                   |   1 +
>   2 files changed, 120 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> new file mode 100644
> index 000000000000..4948ac13e7f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/coresight-tpda.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Trace, Profiling and Diagnostics Aggregator - TPDA
> +
> +description: |
> +  TPDAs are responsible for packetization and timestamping of data sets
> +  utilizing the MIPI STPv2 packet protocol. Pulling data sets from one or
> +  more attached TPDM and pushing the resultant (packetized) data out a
> +  master ATB interface. Performing an arbitrated ATB interleaving (funneling)
> +  task for free-flowing data from TPDM (i.e. CMB and DSB data set flows).
> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Tao Zhang <quic_taozha@quicinc.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^tpda(@[0-9a-f]+)$"
> +  compatible:
> +    items:
> +      - const: qcom,coresight-tpda
> +      - const: arm,primecell
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb_pclk
> +
> +  in-ports:
> +    type: object
> +    description: |
> +      Input connections from TPDM to TPDA
> +    $ref: /schemas/graph.yaml#/properties/ports
> +

--->8---
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^port@[0-9a-f]+$":
> +        type: object
> +        required:
> +          - reg
> +
> +    required:
> +      - '#size-cells'
> +      - '#address-cells'

---8<---

I believe the above snippet is not needed and is covered by the generic
ports.


> +
> +  out-ports:
> +    type: object
> +    description: |
> +      Output connections from the TPDA to legacy CoreSight trace bus.
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +     port:
> +       description:
> +         Output connection from the TPDA to legacy CoreSight Trace bus.
> +       $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +    - compatible
> +    - reg
> +    - clocks
> +    - clock-names
> +    - in-ports
> +    - out-ports
> +
> +additionalProperties: false
> +
> +examples:
> +  # minimum tpda definition.
> +  - |
> +    tpda@6004000 {
> +       compatible = "qcom,coresight-tpda", "arm,primecell";
> +       reg = <0x6004000 0x1000>;
> +
> +       qcom,tpda-atid = <65>;
> +
> +       clocks = <&aoss_qmp>;
> +       clock-names = "apb_pclk";
> +
> +       in-ports {
> +         #address-cells = <1>;
> +         #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +          tpda_qdss_0_in_tpdm_dcc: endpoint {
> +            remote-endpoint =
> +              <&tpdm_dcc_out_tpda_qdss_0>;
> +            };
> +        };
> +      };
> +
> +       out-ports {
> +         port {
> +                 tpda_qdss_out_funnel_in0: endpoint {
> +                    remote-endpoint =
> +                    <&funnel_in0_in_tpda_qdss>;
> +                  };
> +          };
> +       };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28d32b3f3f5c..5d2d8c0ee340 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1978,6 +1978,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
>   F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
>   F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
>   F:	Documentation/devicetree/bindings/arm/coresight-cti.yaml
> +F:	Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>   F:	Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>   F:	Documentation/devicetree/bindings/arm/coresight.txt
>   F:	Documentation/devicetree/bindings/arm/ete.yaml

Otherwise looks good to me.

Suzuki
