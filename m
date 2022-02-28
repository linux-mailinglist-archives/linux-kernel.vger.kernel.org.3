Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA84C712F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbiB1QCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiB1QCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:02:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC483038
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:01:41 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nOiSy-0000BH-1e; Mon, 28 Feb 2022 17:01:40 +0100
Message-ID: <58a0e791-9573-99c2-0cc5-3920a1048113@pengutronix.de>
Date:   Mon, 28 Feb 2022 17:01:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20211028140009.23331-1-etienne.carriere@linaro.org>
Content-Language: en-US
In-Reply-To: <20211028140009.23331-1-etienne.carriere@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Etienne,

On 28.10.21 16:00, Etienne Carriere wrote:
> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> based on an OP-TEE service invocation. The compatible mandates a
> channel ID defined with property "linaro,optee-channel-id".

I just found this thread via the compatible in the STM32MP131 patch set:
https://lore.kernel.org/all/20220225133137.813919-1-gabriel.fernandez@foss.st.com/

Linux doesn't care whether PSCI is provided by TF-A, OP-TEE or something
else, so there is just the arm,psci* compatible.

What's different about SCMI that this is not possible? Why couldn't the
existing binding and driver be used to communicate with OP-TEE as secure
monitor as well?

Cheers,
Ahmad

> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v6:
>  - Remove maxItems from linaro,optee-channel-id description
> 
> No change since v5
> 
> Changes since v4:
>  - Fix sram node name in DTS example: s/-shm-/-sram-/
> 
> Changes since v3:
>  - Add description for linaro,optee-channel-id in patternProperties
>    specifying protocol can optionaly define a dedicated channel id.
>  - Fix DTS example (duplicated phandles issue, subnodes ordering)
>  - Fix typo in DTS example and description comments.
> 
> Changes since v2:
>  - Define mandatory property linaro,optee-channel-id
>  - Rebased on yaml description file
> 
> Changes since v1:
>  - Removed modification regarding mboxes property description.
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 5c4c6782e052..eae15df36eef 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -38,6 +38,9 @@ properties:
>                       The virtio transport only supports a single device.
>          items:
>            - const: arm,scmi-virtio
> +      - description: SCMI compliant firmware with OP-TEE transport
> +        items:
> +          - const: linaro,scmi-optee
>  
>    interrupts:
>      description:
> @@ -83,6 +86,11 @@ properties:
>      description:
>        SMC id required when using smc or hvc transports
>  
> +  linaro,optee-channel-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Channel specifier required when using OP-TEE transport.
> +
>    protocol@11:
>      type: object
>      properties:
> @@ -195,6 +203,12 @@ patternProperties:
>          minItems: 1
>          maxItems: 2
>  
> +      linaro,optee-channel-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Channel specifier required when using OP-TEE transport and
> +          protocol has a dedicated communication channel.
> +
>      required:
>        - reg
>  
> @@ -226,6 +240,16 @@ else:
>        - arm,smc-id
>        - shmem
>  
> +  else:
> +    if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: linaro,scmi-optee
> +    then:
> +      required:
> +        - linaro,optee-channel-id
> +
>  examples:
>    - |
>      firmware {
> @@ -340,7 +364,48 @@ examples:
>                  reg = <0x11>;
>                  #power-domain-cells = <1>;
>              };
> +        };
> +    };
> +
> +  - |
> +    firmware {
> +        scmi {
> +            compatible = "linaro,scmi-optee";
> +            linaro,optee-channel-id = <0>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            scmi_dvfs1: protocol@13 {
> +                reg = <0x13>;
> +                linaro,optee-channel-id = <1>;
> +                shmem = <&cpu_optee_lpri0>;
> +                #clock-cells = <1>;
> +            };
> +
> +            scmi_clk0: protocol@14 {
> +                reg = <0x14>;
> +                #clock-cells = <1>;
> +            };
> +        };
> +    };
>  
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        sram@51000000 {
> +            compatible = "mmio-sram";
> +            reg = <0x0 0x51000000 0x0 0x10000>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0 0x0 0x51000000 0x10000>;
> +
> +            cpu_optee_lpri0: optee-sram-section@0 {
> +                compatible = "arm,scmi-shmem";
> +                reg = <0x0 0x80>;
> +            };
>          };
>      };
>  


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
