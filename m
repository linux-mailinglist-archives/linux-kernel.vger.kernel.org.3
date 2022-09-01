Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F35C5A9E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiIARlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiIARlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:41:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37223A2A87
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:38:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w139so2033833pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ELrD3y+jSL+zNkjvpLSuxdAfFnXexOL0hrcqk9z9vdQ=;
        b=PkE5TlhA21nrv9CJ/Zm9Rs2uV3ik7o9LA8HGNvHI0jzdwmxgnmn6Vq+JV2MxT40XtG
         1hVm3GsFqCOy81DwrR7EYCM1SYW19DRGGtajv2F0fP6dbqQk/9MOD5oH79q8CNMkJOqY
         W2DVKbvRkMVGC37yZq7wbT7AHa2LXSTklavIs3i24+uIA5lOYK2cqivSmgdV1HYBPwkK
         dxjcIy7DO+JtiW9+koLXtvKb/ALg3IrgB9IqLK6ElPZw74TYZkSffJdrIUHGoDX2kNAQ
         a+Bv0QTElxdiPuDT00S+fS4eJnlOHvlLAia5EcVPaDU3K4QkxGqOz0fQH5jhN1zr1eZN
         xqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ELrD3y+jSL+zNkjvpLSuxdAfFnXexOL0hrcqk9z9vdQ=;
        b=caymUt6/wvWhEZfZxwNhUPFf8Ite4amvbtIzRDPFjYvFerSeV2rGrsQ6GPm1FUiQBF
         lhPCh/5cY9TJr2S6MnQz22kazs87BkZGt2pDUm1Hczvm9YOC2/zLU6FyXMT6IjYPn6M9
         H7FYANTv67BxSzBjTJCGWehmsGODmoXSxXJ+r+I4j/ZvtV+7WQ4gtwVDuCkVaf3szrA6
         QcjNE53Xs3kKm6vFoSC4K3M/PQTGVfoSJXpD/1otAsdXf+cTwXTbF/stiwSta3RQ81Kb
         KbhyCyNe6FAHRv/e8mXgxcevWlziW1k/1jW3lXl/8UzEowCI8BsEvDXAUc88cEwLg9Si
         ALaQ==
X-Gm-Message-State: ACgBeo1Z657G6zcHOxbW/lswNAcQZm58GPf1RzydhtAwXNAiXO8+5yrr
        fWgjX1nzeMwOMVDfmQYh8Z64Yw==
X-Google-Smtp-Source: AA6agR7BALrGcDvmc65dutuHSQ5nWbC//VpRLN94DBHJhl3eg+KvFGY0WG0EcwW7vZesivoiTkPa2w==
X-Received: by 2002:a65:6c10:0:b0:429:4a5:a4d0 with SMTP id y16-20020a656c10000000b0042904a5a4d0mr27577384pgu.614.1662053902795;
        Thu, 01 Sep 2022 10:38:22 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 14-20020a62190e000000b005366696b735sm13575047pfz.77.2022.09.01.10.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 10:38:21 -0700 (PDT)
Date:   Thu, 1 Sep 2022 11:38:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        ben.levinsky@xilinx.com, tanmay.shah@xilinx.com,
        michal.simek@amd.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Message-ID: <20220901173817.GA626605@p14s>
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
 <20220708013955.2340449-2-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708013955.2340449-2-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

I have started reviewing this set.  As usual I will notify you when I am done.

On Thu, Jul 07, 2022 at 06:39:50PM -0700, Tanmay Shah wrote:
> From: Tanmay Shah <tanmay.shah@xilinx.com>
> 
> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
> (cluster).
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>

Any reason for keeping the your Xilinx address in the "From" field?  When
applying your patch I get:

Author: Tanmay Shah <tanmay.shah@xilinx.com>
Date:   Thu Jul 7 18:39:50 2022 -0700

    dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings

    Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
    Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
    (cluster).

    Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
    Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>

Which is cumbersome.  It would be much easier if it was:

Author: Tanmay Shah <tanmay.shah@amd.com>
Date:   Thu Jul 7 18:39:50 2022 -0700

    dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings

    Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
    Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
    (cluster).

    Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>

> ---
> 
> Changes in v9:
>   - remove power-domains property description
>   - fix nitpicks in description of other properties
> 
> Changes in v8:
>   - Add 'items:' for sram property
> 
> Changes in v7:
>   - Add minItems in sram property
> 
> Changes in v6:
>   - Add maxItems to sram and memory-region property
> 
> Changes in v5:
> - Add constraints of the possible values of xlnx,cluster-mode property
> - fix description of power-domains property for r5 core
> - Remove reg, address-cells and size-cells properties as it is not required
> - Fix description of mboxes property
> - Add description of each memory-region and remove old .txt binding link
>   reference in the description
> 
> Changes in v4:
>   - Add memory-region, mboxes and mbox-names properties in example
> 
> Changes in v3:
>   - None
> 
>  .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 135 ++++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>  2 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> new file mode 100644
> index 000000000000..56b4dd1d5088
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx R5F processor subsystem
> +
> +maintainers:
> +  - Ben Levinsky <ben.levinsky@xilinx.com>
> +  - Tanmay Shah <tanmay.shah@xilinx.com>

Here too...  If you are switching to amd.com, please do so everywhere.

More comments to come.

> +
> +description: |
> +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
> +  real-time processing based on the Cortex-R5F processor core from ARM.
> +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
> +  floating-point unit that implements the Arm VFPv3 instruction set.
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-r5fss
> +
> +  xlnx,cluster-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    description: |
> +      The RPU MPCore can operate in split mode (Dual-processor performance), Safety
> +      lock-step mode(Both RPU cores execute the same code in lock-step,
> +      clock-for-clock) or Single CPU mode (RPU core 0 is held in reset while
> +      core 1 runs normally). The processor does not support dynamic configuration.
> +      Switching between modes is only permitted immediately after a processor reset.
> +      If set to  1 then lockstep mode and if 0 then split mode.
> +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
> +      In summary,
> +      0: split mode
> +      1: lockstep mode (default)
> +      2: single cpu mode
> +
> +patternProperties:
> +  "^r5f-[a-f0-9]+$":
> +    type: object
> +    description: |
> +      The RPU is located in the Low Power Domain of the Processor Subsystem.
> +      Each processor includes separate L1 instruction and data caches and
> +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
> +      memory space is non-cacheable.
> +
> +      Each RPU contains one 64KB memory and two 32KB memories that
> +      are accessed via the TCM A and B port interfaces, for a total of 128KB
> +      per processor. In lock-step mode, the processor has access to 256KB of
> +      TCM memory.
> +
> +    properties:
> +      compatible:
> +        const: xlnx,zynqmp-r5f
> +
> +      power-domains:
> +        maxItems: 1
> +
> +      mboxes:
> +        minItems: 1
> +        items:
> +          - description: mailbox channel to send data to RPU
> +          - description: mailbox channel to receive data from RPU
> +
> +      mbox-names:
> +        minItems: 1
> +        items:
> +          - const: tx
> +          - const: rx
> +
> +      sram:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        minItems: 1
> +        maxItems: 8
> +        items:
> +          maxItems: 1
> +        description: |
> +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
> +          the RPU can execute instructions and access data from the OCM memory,
> +          the main DDR memory, and other system memories.
> +
> +          The regions should be defined as child nodes of the respective SRAM
> +          node, and should be defined as per the generic bindings in
> +          Documentation/devicetree/bindings/sram/sram.yaml
> +
> +      memory-region:
> +        description: |
> +          List of phandles to the reserved memory regions associated with the
> +          remoteproc device. This is variable and describes the memories shared with
> +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
> +          vrings, ...). This reserved memory region will be allocated in DDR memory.
> +        minItems: 1
> +        maxItems: 8
> +        items:
> +          - description: region used for RPU firmware image section
> +          - description: vdev buffer
> +          - description: vring0
> +          - description: vring1
> +        additionalItems: true
> +
> +    required:
> +      - compatible
> +      - power-domains
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    r5fss: r5fss {
> +        compatible = "xlnx,zynqmp-r5fss";
> +        xlnx,cluster-mode = <1>;
> +
> +        r5f-0 {
> +            compatible = "xlnx,zynqmp-r5f";
> +            power-domains = <&zynqmp_firmware 0x7>;
> +            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> +            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> +            mbox-names = "tx", "rx";
> +        };
> +
> +        r5f-1 {
> +            compatible = "xlnx,zynqmp-r5f";
> +            power-domains = <&zynqmp_firmware 0x8>;
> +            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
> +            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
> +            mbox-names = "tx", "rx";
> +        };
> +    };
> +...
> diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
> index 0d9a412fd5e0..618024cbb20d 100644
> --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
> +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
> @@ -6,6 +6,12 @@
>  #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>  #define _DT_BINDINGS_ZYNQMP_POWER_H
>  
> +#define		PD_RPU_0	7
> +#define		PD_RPU_1	8
> +#define		PD_R5_0_ATCM	15
> +#define		PD_R5_0_BTCM	16
> +#define		PD_R5_1_ATCM	17
> +#define		PD_R5_1_BTCM	18
>  #define		PD_USB_0	22
>  #define		PD_USB_1	23
>  #define		PD_TTC_0	24
> -- 
> 2.25.1
> 
