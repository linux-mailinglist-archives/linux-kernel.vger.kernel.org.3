Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778EC53C4E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbiFCGd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiFCGdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:33:25 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3552BC4;
        Thu,  2 Jun 2022 23:33:22 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9FCC1E0008;
        Fri,  3 Jun 2022 06:33:14 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1nx0rx-00AQdY-D4; Fri, 03 Jun 2022 08:33:13 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Tanmay Shah <tanmay.shah@xilinx.com>
Cc:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <openamp-system-reference@lists.openampproject.org>
Subject: Re: [PATCH v8 1/6] dt-bindings: remoteproc: Add Xilinx RPU
 subsystem bindings
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
        <20220602203834.3675160-2-tanmay.shah@xilinx.com>
Date:   Fri, 03 Jun 2022 08:33:13 +0200
In-Reply-To: <20220602203834.3675160-2-tanmay.shah@xilinx.com> (Tanmay Shah's
        message of "Thu, 2 Jun 2022 13:38:29 -0700")
Message-ID: <87tu921ck6.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tanmay" == Tanmay Shah <tanmay.shah@xilinx.com> writes:

Hi,

 > Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
 > Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
 > (cluster).

 > Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
 > ---

 > Changes in v8:
 >   - Add 'items:' for sram property

 > Changes in v7:
 >   - Add minItems in sram property

 > Changes in v6:
 >   - Add maxItems to sram and memory-region property

 > Changes in v5:
 > - Add constraints of the possible values of xlnx,cluster-mode property
 > - fix description of power-domains property for r5 core
 > - Remove reg, address-cells and size-cells properties as it is not required
 > - Fix description of mboxes property
 > - Add description of each memory-region and remove old .txt binding link
 >   reference in the description

 > Changes in v4:
 >   - Add memory-region, mboxes and mbox-names properties in example

 > Changes in v3:
 >   - None

 >  .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 130 ++++++++++++++++++
 >  include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
 >  2 files changed, 138 insertions(+)
 >  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml

 > diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
 > new file mode 100644
 > index 000000000000..adfe05ff157a
 > --- /dev/null
 > +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
 > @@ -0,0 +1,132 @@
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

A textual mode ("dual", "lock-step", "single") would be more readable.


 > +    description: |
 > +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety

space missing before "(Dual-processor"


 > +      lock-step mode(Both RPU cores execute the same code in lock-step,
 > +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while

"can be" sounds a bit weak, perhaps "is"


 > +      core 1 runs normally). The processor does not support dynamic configuration.
 > +      Switching between modes is only permitted immediately after a processor reset.
 > +      If set to  1 then lockstep mode and if 0 then split mode.
 > +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.

This looks a bit confusing. If you decide to stick to the numerical
modes, then at least list them in numerical order, E.G.:

 0: split
 1: lockstep
 2: single


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
 > +        description: RPU core PM domain specifier
 > +        maxItems: 1

A bit more detail would be good, E.G. something like arm/cpus.yaml does:

      List of phandles and PM domain specifiers, as defined by bindings of the
      PM domain provider (see also ../power_domain.txt).

And the phandle-array ref.


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

And here as well for mailbox/mailbox.txt


 > +
 > +      sram:
 > +        $ref: /schemas/types.yaml#/definitions/phandle-array
 > +        minItems: 1
 > +        maxItems: 8
 > +        items:
 > +          maxItems: 1
 > +        description: |
 > +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
 > +          the RPU can execute instructions and access data from, the OCM memory,
 > +          the main DDR memory, and other system memories.

Drop the comma after "from"


 > +
 > +          The regions should be defined as child nodes of the respective SRAM
 > +          node, and should be defined as per the generic bindings in,

Drop the comma after "in"


 > +          Documentation/devicetree/bindings/sram/sram.yaml
 > +
 > +      memory-region:
 > +        description: |
 > +          List of phandles to the reserved memory regions associated with the
 > +          remoteproc device. This is variable and describes the memories shared with
 > +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
 > +          vrings, ...). This reserved memory region will be allocated on DDR memory.

s/on DDR/in DDR/

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


-- 
Bye, Peter Korsgaard
