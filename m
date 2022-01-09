Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AE7488AA4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiAIQnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 11:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiAIQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 11:43:18 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A1C06173F;
        Sun,  9 Jan 2022 08:43:17 -0800 (PST)
Received: from [81.101.6.87] (port=35376 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6bHg-0001en-2k; Sun, 09 Jan 2022 16:43:12 +0000
Date:   Sun, 9 Jan 2022 16:49:03 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     iain@hunterembedded.co.uk
Cc:     Iain Hunter <drhunter95@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Add binding for ti,adc1018. It allows selection
 of channel as a Device Tree property
Message-ID: <20220109164903.4fdd61e3@jic23-huawei>
In-Reply-To: <6839827.31r3eYUQgx@stewarton>
References: <20211231131951.1245508-1-drhunter95@gmail.com>
        <20220109111718.49d2d2cb@jic23-huawei>
        <6839827.31r3eYUQgx@stewarton>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jan 2022 14:29:34 +0000
iain@hunterembedded.co.uk wrote:

> On Sunday, 9 January 2022 11:17:18 GMT Jonathan Cameron wrote:
> > On Fri, 31 Dec 2021 13:19:15 +0000
> > 
> > Iain Hunter <drhunter95@gmail.com> wrote:  
> > > New binding file uses the adc.yaml to define channel selection
> > > 
> > > Signed-off-by: Iain Hunter <drhunter95@gmail.com>  
> > 
> > Hi Iain,
> > 
> > A few comments in addition to those Rob sent.
> > It's worth noting that there is a lot of 'history' in IIO bindings so
> > sometimes copying stuff from an existing binding is no longer the way
> > things should be done.
> > 
> > Jonathan  
> 
> Hi Jonathan and Rob,
> 
> Thanks for your comments. I'd say my fundamental problem is that I am 
> stumbling about in the dark. To be honest I haven't even worked out the benefit 
> of the yaml bindings.

CI is in many ways the biggest one + formality of definition vs the older
text files where to put it likely things were often rather vague.
yaml has it's 'interesting corners' and a rather steep learning curve but
I'm not aware of anything better and we are stuck with it now anyway!

> 
> I identified the stm32adc binding as the most up to date file to use as a 
> reference. If there is a better one then can you let me know.

It's very much a work in progress so best practice is still evolving.
The stm32-adc ones are now quite old and reflect a very complex bit of hardware.
adc/ti-tsc2076.yaml is fairly similar and up to date.

Problem with bindings vs other code is we can't update everything to the
current view on how to do things because of backwards compatibility. Over time
we'll eventually get there as the parts people use in designs are replaced but
that's a lot longer game than for almost anything else.

Sad truth with bindings is they almost always go through a couple of revisions
as a result. Ideally I'd write some docs on what we consider best practice
for IIO drivers as that could at least be kept up to date, but lots of other
things on the todo list :( 

+ today patches are coming in slightly quicker than I review them. *sigh* :)
Jonathan

> 
> I will work through the comments to try to understand and then implement them.
> Thanks, Iain  
> >   
> > > ---
> > > 
> > >  .../bindings/iio/adc/ti,ads1018.yaml          | 126 ++++++++++++++++++
> > >  1 file changed, 126 insertions(+)
> > >  create mode 100644  
> > >  Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml>   
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> > > b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml new file mode
> > > 100644
> > > index 000000000000..a65fee9d83dd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> > > @@ -0,0 +1,126 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TI ADS1018 4 channel I2C analog to digital converter
> > > +
> > > +maintainers:
> > > +  - Iain Hunter <iain@hunterembedded.co.uk>
> > > +
> > > +description: |
> > > +  Datasheet at: https://www.ti.com/lit/gpn/ads1018
> > > +  Supports both single ended and differential channels.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ti,ads1018
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 0
> > > +
> > > +  "#io-channel-cells":
> > > +    const: 1
> > > +
> > > +  spi-max-frequency: true
> > > +  spi-cpol: true
> > > +  spi-cpha: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +  - spi-cpha
> > > +
> > > +additionalProperties: false
> > > +
> > > +patternProperties:
> > > +  "^channel@([0-3])$":
> > > +    $ref: "adc.yaml"
> > > +    type: object
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: |
> > > +            Must be 0, actual channel selected in ti,adc-channels for
> > > single ended +            or ti-adc-channels-diff for differential
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        enum: [0]  
> > 
> > No.  Should be some sort of index value. If I recall correctly, existing use
> > is reg == channel number when single ended and more loosely defined for
> > differential.  In many cases first of the pair, but that's not always
> > guaranteed to be unique (e.g. 0-1 and 0-3 in this case).  
> > > +
> > > +      ti,adc-channels:
> > > +        description: |
> > > +          List of single-ended channels muxed for this ADC. It can have
> > > up to 4 +          channels numbered 0-3  
> > 
> > This is a new binding, so how can we have deprecated properties?
> > Also seems very odd indeed to have a list of channels defined inside a per
> > channel node.  
> > > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +        deprecated: true
> > > +  
> 
> As you can guess, it's because I don't understand it properly :)
> 
> >   
> > > +      ti,adc-diff-channels:  
> > Can this use diff-channels in the standard adc binding:
> > Documentation/devicetree/bindings/iio/adc/adc.yaml
> >   
> > > +        description: |
> > > +          List of differential channels muxed for this ADC between the
> > > pins vinp +          and vinn. The 4 possible options are:
> > > +          vinp=0, vinn=1
> > > +          vinp=0, vinn=3
> > > +          vinp=1, vinn=3
> > > +          vinp=2, vinn=3
> > > +
> > > +          They are listed in a pair <vinp vinn>.
> > > +
> > > +          Note: At least one of "ti,adc-channels" or
> > > "ti,adc-diff-channels" is +          required.
> > > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +        items:
> > > +          items:
> > > +            - description: |
> > > +                "vinp" indicates positive input number
> > > +              minimum: 0
> > > +              maximum: 2
> > > +            - description: |
> > > +                "vinn" indicates negative input number
> > > +              minimum: 1
> > > +              maximum: 3  
> > 
> > This should be a pair based constraint as not all options possible.
> > Something like oneOf:
> >             - items:
> >                 - const: 0
> >                 - const: 1
> >             - items:
> >                 - enum: [0, 1, 2]
> > 		- const: 3
> >   
> > > +
> > > +
> > > +    required:
> > > +      - reg
> > > +
> > > +examples:
> > > +  - |
> > > +    // example on SPI1 with single ended channel 1
> > > +    spi {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        adc@1 {
> > > +            compatible = "ti,ads1018";
> > > +            reg = <0x0>;
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +            spi-cpha;
> > > +            ti,adc-channels = <1>;  
> > 
> > More recent approach to this is the one you've used for differential
> > channels - 1 child node per channel.
> >   
> > > +        };
> > > +    };
> > > +  - |
> > > +    // example on SPI0 with differential between inputs 0 and 3  
> > 
> > The SPI0 vs 1 is correctly not part of this example, so drop that from
> > the comment.
> >   
> > > +    spi {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        adc@0 {
> > > +            compatible = "ti,ads1018";
> > > +            reg = <0x0>;
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +            spi-cpha;
> > > +            ti,adc-diff-channels = <0 3>;  
> > 
> > This doesn't obey the schema you have above at all. Would looks something
> > like channel@0 {
> >                  diff-channels = <0 3>;
> >                }
> >   
> > > +        };
> > > +    };
> > > +
> > > +...  
> 
> 
> 
> 

