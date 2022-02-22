Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998274BFEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiBVQgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiBVQgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:36:44 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8009316043D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:36:17 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d17so12635673pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cGfg7SzK60hTzPzU6ehbR2PDv3GsZi0qKrZOQnAODkU=;
        b=AUIIco/2inR+8I7aH+Pyg4fwYdkiolcG213TdJ0X5lweNW9bSX+pZoB4IHeg8VVZd6
         JzRhgAdx4ZGoQ6qso0qo/w3jYB3T9jM4M/Urf8xD2FdBsJypiLSkVzkmsGnzXkD5bsp9
         fDAVAhndI5qICDB4mdVkNFleEj8N5asKSb6quR9pZrzXJH5sAMotwIVQuME9nqwtbae+
         mn8fcl/QddnMYHtkUy6edmuZQL24BloTQT9qakNHl3otil5KwlCnkfic89nO6ix3T4Wm
         AF8XVy+nCrpzSiFK4UVaInuCalMFuRgXnBhfEjo5fwxiDSn0M1CCG01/bOq/ZCZLYTdf
         klfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cGfg7SzK60hTzPzU6ehbR2PDv3GsZi0qKrZOQnAODkU=;
        b=FgdLvVDYYMHGeNFHH4GMF3mDHDJCjhykTiRQW/Pk0z8P7Ubw+aOWImI9VQZVQpGwCr
         cjou4TWGniIyl2lhSZgkkPKXaNfeB+QngL6sLpfbAn4u3HmYB/o1we3q8zT1ZHwkrEmn
         /bZnwyO5wo6CSk5D9qzoVdhOgAPhWuByuNTbGeHhRX5Vjv9iPhqlLd/2qUm7giyWQLBB
         Mf3gFsMgBSZYYHGElN5lIaUzzx53sxxinBdNT5NwuwcqrkXSiNExz3Hv8vptaFjd8s7+
         zRKJV1AliKs9lz27oZAUs0LqkcEUPI9ie9vjBd7SufOfDg8xV+8ao4RLqwAS5eqpqzi/
         3JjQ==
X-Gm-Message-State: AOAM5300sUmE3spH2AjZ0E6sZc/IM60OQTB4OAV6ohxQhPkWKr53NSHt
        jFsKzeoyJMmRsf/glqQG21VMpw==
X-Google-Smtp-Source: ABdhPJxOBQmir6IdwffJxdtp5EScm5kselNJW4g3MGWY6cnK67KAGdSSIM12h28f6yt/WrFs98gghQ==
X-Received: by 2002:a05:6a00:7c6:b0:4e1:799:7a2 with SMTP id n6-20020a056a0007c600b004e1079907a2mr25306856pfu.25.1645547776950;
        Tue, 22 Feb 2022 08:36:16 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 142sm18356534pfy.11.2022.02.22.08.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:36:15 -0800 (PST)
Date:   Tue, 22 Feb 2022 09:36:13 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@xilinx.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, laurent.pinchart@ideasonboard.com,
        ben.levinsky@xilinx.com, bill.mills@linaro.org,
        sergei.korneichuk@xilinx.com, arun.balaji.kannan@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Message-ID: <20220222163613.GA923552@p14s>
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
 <20220210112824.2084724-2-tanmay.shah@xilinx.com>
 <20220214182208.GA101373@p14s>
 <f383cd27-9757-7b56-4ebc-1227b28f51f7@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f383cd27-9757-7b56-4ebc-1227b28f51f7@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 05:58:15PM -0800, Tanmay Shah wrote:
> Hi Mathieu,
> 
> Thanks for reviews.
> 
> Please find my comments below.
> 
> On 2/14/22 10:22 AM, Mathieu Poirier wrote:
> > On Thu, Feb 10, 2022 at 03:28:19AM -0800, Tanmay Shah wrote:
> > > Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
> > > Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem (cluster).
> > > 
> > > Signed-off-by: Tanmay Shah<tanmay.shah@xilinx.com>
> > > ---
> > > 
> > > Changes in v3:
> > >    - None
> > > 
> > >   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 139 ++++++++++++++++++
> > >   include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
> > >   2 files changed, 145 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> > > new file mode 100644
> > > index 000000000000..d43f0b16ad7f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> > > @@ -0,0 +1,139 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
> > > +$schema:http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Xilinx R5F processor subsystem
> > > +
> > > +maintainers:
> > > +  - Ben Levinsky<ben.levinsky@xilinx.com>
> > > +  - Tanmay Shah<tanmay.shah@xilinx.com>
> > > +
> > > +description: |
> > > +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
> > > +  real-time processing based on the Cortex-R5F processor core from ARM.
> > > +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
> > > +  floating-point unit that implements the Arm VFPv3 instruction set.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: xlnx,zynqmp-r5fss
> > > +
> > > +  xlnx,cluster-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
> > > +      lock-step mode(Both RPU cores execute the same code in lock-step,
> > > +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
> > > +      core 1 runs normally). The processor does not support dynamic configuration.
> > > +      Switching between modes is only permitted immediately after a processor reset.
> > > +      If set to  1 then lockstep mode and if 0 then split mode.
> > > +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 1
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: RPU subsystem status and control registers
> > > +
> > > +patternProperties:
> > > +  "^r5f-[a-f0-9]+$":
> > > +    type: object
> > > +    description: |
> > > +      The RPU is located in the Low Power Domain of the Processor Subsystem.
> > > +      Each processor includes separate L1 instruction and data caches and
> > > +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
> > > +      memory space is non-cacheable.
> > > +
> > > +      Each RPU contains one 64KB memory and two 32KB memories that
> > > +      are accessed via the TCM A and B port interfaces, for a total of 128KB
> > > +      per processor. In lock-step mode, the processor has access to 256KB of
> > > +      TCM memory.
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: xlnx,zynqmp-r5f
> > > +
> > > +      power-domains:
> > > +        description: |
> > > +          phandle to a PM domain provider node and an args specifier containing
> > > +          the r5f0 and r5f1 node id value.
> > > +
> > > +      reg:
> > > +        items:
> > > +          - description: RPU0 and RPU1 control and status registers
> > > +
> > > +      mboxes:
> > > +        items:
> > > +          - description: |
> > > +              Bi-directional channel to send data to RPU and receive ack from RPU.
> > > +              Request and response message buffers are available and each buffer is 32 bytes.
> > > +          - description: |
> > > +              Bi-directional channel to receive data from RPU and send ack from RPU.
> > > +              Request and response message buffers are available and each buffer is 32 bytes.
> > > +        minItems: 1
> > > +
> > > +      mbox-names:
> > > +        items:
> > > +          - const: tx
> > > +          - const: rx
> > > +        minItems: 1
> > > +
> > > +      sram:
> > > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +        minItems: 1
> > > +        description: |
> > > +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
> > > +          the RPU can execute instructions and access data from, the OCM memory,
> > > +          the main DDR memory, and other system memories.
> > > +
> > > +          The regions should be defined as child nodes of the respective SRAM
> > > +          node, and should be defined as per the generic bindings in,
> > > +          Documentation/devicetree/bindings/sram/sram.yaml
> > > +
> > > +      memory-region:
> > > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +        description: |
> > > +          List of phandles to the reserved memory regions associated with the
> > > +          remoteproc device. This is variable and describes the memories shared with
> > > +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
> > > +          vrings, ...). This reserved memory region will be allocated on DDR memory.
> > > +          See Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > 
> > Aside from "compatible" and "power-domains", none of the above properties appear
> > in the example below, making this patchset harder to review.
> > 
> > I am pretty sure to have commented on this earlier...
> 
> In example, I have included only required property nodes.
> 
> If you want, I can include other properties as well. However, some of the
> properties needs new bindings for example "sram".
> 
> So, I can't include it as I don't know how bindings for them will look like.
> 

I'm fine with that part.

> In next revision, I can include mboxes, mbox-names and memory-region
> properties. Is that fine?
> 
> Also, should I add those nodes in actual device-tree now or later?
> 
> For example, mboxes and mbox-names are not needed for driver as of now.
> 
> So should I include them in dts now or later when I send rpmsg related
> patches?

Include in the example the properties currently supported by the driver.  Not
all of them have to be in the DTS though.

> 
> > More comments to come later or tomorrow.
> > 
> > Thanks,
> > Mathieu
> > 
> > > +    required:
> > > +      - compatible
> > > +      - power-domains
> > > +
> > > +    unevaluatedProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    r5fss: r5fss@ff9a0000 {
> > > +        compatible = "xlnx,zynqmp-r5fss";
> > > +        xlnx,cluster-mode = <1>;
> > > +
> > > +        #address-cells = <1>;
> > > +        #size-cells = <1>;
> > > +        reg = <0xff9a0000 0x228>;
> > > +
> > > +        r5f-0 {
> > > +            compatible = "xlnx,zynqmp-r5f";
> > > +            power-domains = <&zynqmp_firmware 0x7>;
> > > +        };
> > > +
> > > +        r5f-1 {
> > > +            compatible = "xlnx,zynqmp-r5f";
> > > +            power-domains = <&zynqmp_firmware 0x8>;
> > > +        };
> > > +    };
> > > +...
> > > diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
> > > index 0d9a412fd5e0..618024cbb20d 100644
> > > --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
> > > +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
> > > @@ -6,6 +6,12 @@
> > >   #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
> > >   #define _DT_BINDINGS_ZYNQMP_POWER_H
> > > +#define		PD_RPU_0	7
> > > +#define		PD_RPU_1	8
> > > +#define		PD_R5_0_ATCM	15
> > > +#define		PD_R5_0_BTCM	16
> > > +#define		PD_R5_1_ATCM	17
> > > +#define		PD_R5_1_BTCM	18
> > >   #define		PD_USB_0	22
> > >   #define		PD_USB_1	23
> > >   #define		PD_TTC_0	24
> > > -- 
> > > 2.25.1
> > > 
