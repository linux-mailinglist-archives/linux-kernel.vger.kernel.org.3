Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0580E46E646
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhLIKLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:11:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42224 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhLIKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:11:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 01818CE252A;
        Thu,  9 Dec 2021 10:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EEEC004DD;
        Thu,  9 Dec 2021 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639044492;
        bh=fxfEda0QHoOs56ah6JYqDrFjYIxSB69gHj84oAncbcg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H3AwZ9rvVx4HsutFaDRDbX5GWJfhfhQfTxngas3kvNyG9jttXJyhLRlF5f+HLAXh/
         LPlZ8nRSKQ0tqMYZPKMpU1RlguoB7tsMwTVUgcnT7DVpQimunQ0xRyuTXsdhG2kIZA
         7J888oWMTNo6UnoS9Y9r5q7Ijsq5kjQv9KVJrUqaZCPBOsjV77BD8FmRRWc9f55ntr
         UeQYjYROn1K4poQrz3virYYl8A5eQpfJ6TUhUstT5ivQaudtH84u1wfrfdmEnatQSg
         WwhdisqcOz3Nbl2ewDnA1HJU2Lq4d/vjnbAkXNzJkXTTHgfl1RCWWnqccL9Idvwvd2
         0iUvhdGojJQ7Q==
Subject: Re: [PATCH] dt-bindings: mtd: ti,gpmc-nand: Add missing 'rb-gpios'
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211206174209.2297565-1-robh@kernel.org>
 <20211209104224.41d42cca@xps13>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <bebef734-d0d3-e78e-e07a-9160ead1f673@kernel.org>
Date:   Thu, 9 Dec 2021 12:08:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209104224.41d42cca@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 09/12/2021 11:42, Miquel Raynal wrote:
> Hi Rob,
> 
> robh@kernel.org wrote on Mon,  6 Dec 2021 11:42:09 -0600:
> 
>> With 'unevaluatedProperties' support implemented, the TI GPMC example
>> has a warning:
>>
>> Documentation/devicetree/bindings/memory-controllers/ti,gpmc.example.dt.yaml: nand@0,0: Unevaluated properties are not allowed ('rb-gpios' was unexpected)
>>
>> Add the missing definition for 'rb-gpios'.
> 
> rb-gpios is already defined in nand-controller.yaml. I seems like the
> real problem is that this file does not refer to it. Can you update the
> fix?

I don't think we can refer to nand-controller.yaml right now as we are not
fully compatible with it yet. Please see examples below.

ti,gpmc-nand example:

      nand@0,0 {
        compatible = "ti,omap2-nand";
        reg = <0 0 4>;          /* device IO registers */
        interrupt-parent = <&gpmc>;
        interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
                     <1 IRQ_TYPE_NONE>; /* termcount */
        ti,nand-xfer-type = "prefetch-dma";
        ti,nand-ecc-opt = "bch16";
        ti,elm-id = <&elm>;
        #address-cells = <1>;
        #size-cells = <1>;

        /* NAND generic properties */
        nand-bus-width = <8>;
        rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>;  /* gpmc_wait0 */

        /* GPMC properties*/
        gpmc,device-width = <1>;

        partition@0 {
          label = "NAND.SPL";
          reg = <0x00000000 0x00040000>;
        };
        partition@1 {
          label = "NAND.SPL.backup1";
          reg = <0x00040000 0x00040000>;
        };
      };


nand-controller example:

    nand-controller {
      #address-cells = <1>;
      #size-cells = <0>;
      cs-gpios = <0>, <&gpioA 1>; /* A single native CS is available */

      /* controller specific properties */

      nand@0 {
        reg = <0>; /* Native CS */
        nand-use-soft-ecc-engine;
        nand-ecc-algo = "bch";

        /* controller specific properties */
      };

      nand@1 {
        reg = <1>; /* GPIO CS */
      };
    };


> 
> While at it you might also want to drop the rb-gpios property from
> ingenic,nand.yaml, which also defines it a second time.
> 
>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Roger Quadros <rogerq@kernel.org>
>> Cc: linux-mtd@lists.infradead.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
>> index beb26b9bcfb2..1c280f52baa0 100644
>> --- a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
>> @@ -53,6 +53,11 @@ properties:
>>      enum: [8, 16]
>>      default: 8
>>  
>> +  rb-gpios:
>> +    description:
>> +      GPIO connection to R/B signal from NAND chip
>> +    maxItems: 1
>> +
>>  patternProperties:
>>    "@[0-9a-f]+$":
>>      $ref: "/schemas/mtd/partitions/partition.yaml"
> 
> Thanks,
> Miquèl
> 

cheers,
-roger

