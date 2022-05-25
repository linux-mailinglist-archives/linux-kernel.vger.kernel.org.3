Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5E533A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiEYKCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEYKBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:01:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E136B25C46;
        Wed, 25 May 2022 03:01:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c19so22097698lfv.5;
        Wed, 25 May 2022 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UC6SLSEFgFoqdIS2QlBVrr0bcViqmEfbMxaWyDKUl8M=;
        b=F7kl8H1+FaV2Vh1LXn1XnSvsIozWpEd9+HHSz54qJuz2NixS+zjMGe4t5gdVLYHX+z
         3Dr0bRIkAg4SQ8nxeWsa7ZHi/S7+VXvJznj62MD7jv5yYTEUPFWuYnltbYmRWE0LTpsy
         pZq4ahW2vIEOFC+FcsGlVMJAJS4Ok563OjrNQRYxUxPt7zVdB+RZYKGKkFmQkxd+pAIi
         zrF0cLhQCGFXkDrATyxqp9gap3GTe0rj/bV8yBPHjDpctNQUSfm/JvuoZ6HhtuCntvLr
         sYiPSjgNOctc/BQ4P9BV9FOvs29pBYqZp5k1CuYKWcMg7GtDZgg0tVfIZ3fON0iwf9BS
         dF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UC6SLSEFgFoqdIS2QlBVrr0bcViqmEfbMxaWyDKUl8M=;
        b=xBMnXDPhnKjoFTJxndVEwntB3DlTryEm5XGD6cuTWwDiSUPPRvcb5hQ7JJ/2EsIvDZ
         jplp1Ys71Ojy1GCsBlRkyUAKYaCiT646bEpU/noqiRguOTuYgA0OT73maCVcDm3RILOU
         lO0g87xm40huoEqxKxhRirXU/3coH0ASrcEv+ET1eT79RUuOYME4tmp3Fv5FzevxGNM9
         k3I6fN5nEB8CEYWOZIijq/pgrbQLE9xzfs6ESl603E0Ibnx6LY1Iey1OuGah2IFP8v/W
         i5WUzWxAw9oAykVl8LmpEubV/7m0FymTo/AqfsxL+S4Utf7gwWR1lYIS+BQDZFqoC+5N
         sfzA==
X-Gm-Message-State: AOAM533T3yNes5L3jymZrpxv52gyjMwCT5D8lzaJ6qx8ynGdFUo2RcWO
        ZhUXmbIJCZGyoJMwyiIBy/Q=
X-Google-Smtp-Source: ABdhPJyDA6VfNajwGr+/2coU/jEB6iKPlVDHwq7UqcQffVPL8x+i3wPqmtNMsv+3q9fLIfm3Kg5GBA==
X-Received: by 2002:a05:6512:3d13:b0:472:5d8d:5202 with SMTP id d19-20020a0565123d1300b004725d8d5202mr22395092lfv.331.1653472910249;
        Wed, 25 May 2022 03:01:50 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id c38-20020a05651223a600b0047855a54704sm2549547lfv.172.2022.05.25.03.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:01:48 -0700 (PDT)
Date:   Wed, 25 May 2022 13:01:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/23] dt-bindings: ata: ahci-platform: Drop
 dma-coherent property declaration
Message-ID: <20220525100146.3xg3vjj4edizl6yb@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-2-Sergey.Semin@baikalelectronics.ru>
 <20220517185841.GA1388602-robh@kernel.org>
 <20220521092248.7i53lxf3gx26fmi5@mobilestation>
 <20220524145758.GA3730540-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524145758.GA3730540-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 09:57:58AM -0500, Rob Herring wrote:
> On Sat, May 21, 2022 at 12:22:48PM +0300, Serge Semin wrote:
> > On Tue, May 17, 2022 at 01:58:41PM -0500, Rob Herring wrote:
> > > On Thu, May 12, 2022 at 02:17:48AM +0300, Serge Semin wrote:
> > > > It's redundant to have the 'dma-coherent' property explicitly specified in
> > > > the DT schema because it's a generic property described in the core
> > > > DT-schema by which the property is always evaluated.
> > > 
> > 
> > > It is not redundant.
> > > 
> > > The core schema defines the property (as a boolean), but this schema 
> > > defines it being used in this binding. Otherwise, it won't be allowed.
> > 
> > I thought that the generic properties like ranges, dma-ranges, etc
> > including the dma-coherent one due to being defined in the dt-core
> > schema are always evaluated. As such seeing the unevaluatedProperties
> > property is set to false here, they can be used in the DT-nodes with
> > no need to be explicitly specified in the DT node bindings. In
> > addition to that I tested this assumption by dropping the dma-coherent
> > property definition from the AHCI-common schema and executed the
> > DT-bindings check procedure. No error has been spotted:
> 

> Those common properties are always applied, but not at the same time as 
> a device binding. IOW, it's 2 schemas that are applied to an instance 
> (node) independently. For things like 'reg', the common schema does type 
> checks and the device schema does size (number of entries) checks.
> 
> There a few things always allowed like 'status', and those are added to 
> the device schema by the tools.

It makes sense now. Thanks for clarification.

> 
> > 
> > > [fancer@mobilestation] kernel $ cat Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml | grep dma-coherent
> > >        dma-coherent;
> > > [fancer@mobilestation] kernel $ make -j8 DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml dt_binding_check
> > >   LINT    Documentation/devicetree/bindings
> > >   DTEX    Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dts
> > >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > >   DTC     Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dtb
> > >   CHECK   Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dtb
> > > [fancer@mobilestation] kernel $ cat Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dts | grep dma-coherent
> > >           dma-coherent;
> > > [fancer@mobilestation] kernel $ echo $?
> > > 0
> > Due to that here are a few backward questions:
> > 1) Am I doing something wrong in the framework of the DT-bindings
> > evaluation? Really I even tried to specify unknown property in the
> > DT-bindings example like "bla-bla-bla;" and no evaluation error was
> > printed. Anyway If what you are saying was correct I would have got an
> > error during the DT-bindings evaluation, but as you can see there was
> > none.
> 

> I think this is a known issue which has a pending fix. If a referenced 
> schema has 'additionalProperties: true' in it, then the referring schema 
> never has any unevaluated properties. The fix is pending because all 
> the schema examples that start failing have to be fixed and in a base 
> that people work on (i.e. rc1).

Ok. I see. Just to note in case if a non-related schema error is
found the unknown property error is printed too. Like this:

/.../ata/snps,dwc-ahci.example.dtb: sata@122f0000: interrupts: [[0, 115, 4], [0, 116, 4]] is too long
        From schema: /.../ata/snps,dwc-ahci.yaml
/../ata/snps,dwc-ahci.example.dtb: sata@122f0000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'phys', 'phy-names', 'ports-implemented', 'bla-bla-bla' were unexpected)

If I fix the interrupts-property error, the dt-schema check procedure
will work just fine.

> 
> > 2) Am I wrong in thinking that the unevaluatedProperties setting
> > concerns the generic properties defined in the DT-core schema? 
> 
> You are wrong as explained above.
> 
> > If it
> > doesn't concern the generic properties then does it work for the
> > $ref'ed schemas only? 
> 
> Yes, except for the issue making it not work.
> 
> > Getting back to the patch topic. We need to drop the dma-coherent
> > property from the schema anyway. AHCI-specification doesn't
> > regulate the DMA operations coherency. The dma-coherent property is
> > more specific to the particular controller implementation mainly
> > dependent on the platform settings. So I'll change the patch log, but
> > get to keep the patch in the series. What do you think?
> 
> Intel wrote the spec, so they probably assume coherent. In DT, PPC is 
> default coherent and Arm is default non-coherent.
> 

> You'll need to add it to whatever specific device schemas need it if you 
> remove it.

Right. This is what I was going to add to the patch log.

> Personally, I think it is fine where it is. dma-coherent is 
> valid on any DMA capable device and it's not really a property of the 
> device, but the system.

Right. It is mainly the platform property. In particular the DMA
coherency is determined by the system interconnect design. In our case
the l1 and l2 caches are embedded into the CPU cores block while the
DDR and other SoC peripheral devices/controllers are attached to the
cores via a dedicated AXI3 interconnect bus, which has nothing to do
with the caches. That's why none of the system devices are
cache-coherent.

> If we could generically identify DMA capable 
> devices, then dma-coherent would be allowed on them automatically.

Got it. I'll drop this patch then.

-Sergey

> 
> Rob
