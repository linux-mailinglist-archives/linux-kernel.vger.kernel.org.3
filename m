Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D8F4FC51A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349671AbiDKT23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349627AbiDKT13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:27:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB89F140EB;
        Mon, 11 Apr 2022 12:25:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o2so6777068lfu.13;
        Mon, 11 Apr 2022 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UOaY0dvj8Jn2enDiXoZlQyItDDBhGi0Z21ViX26p86o=;
        b=U6kjZXIbUv4b7puIl3hY+AHHqCRrcLP/bQOpqdVlTrqNd5ke6pZelqt6KH5sxiL/xh
         qYdpdzV97YmJLaUUGeBYO8oYSqUcvVrNr8ZDz/i3aFSQtcXtQngT0zZt/G3zSKBtiNOG
         UvyCAsu/NwHmTmMjjqyscuZXLFv/sijhPs3bLZGRwATOnoRbfm1TlNykjwd1+7prXJFJ
         A4mRSnVmKAzM7tRpsCbuaxXyU8iVofSCCoSrlETtaCjAkRE7L8CTaQlQVUsArXR6mUTP
         aNyfhDFLDdkT9og3qXJ/aDaV2z+FkgfhJDXVyR/tUBUNOS4qC2TCeWXT/f68LaLEcLtA
         FF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UOaY0dvj8Jn2enDiXoZlQyItDDBhGi0Z21ViX26p86o=;
        b=5DAxOgoHwQMs7VG+YwOT1U3bXPHchGMYo9ANs8MHXgEGCqP33V+zGC/6XcVLl6Y24h
         WyiCDQ2O5fvqEdyt2GqIuDAKIRMM25PJcunN4NZBN0XA4mUAnhRhFcL5uND0VQHqmgao
         4L4tvHvM6ObKzE3J87yiKQ/YGw/ILzYI+o2U/1/IpjNX7DxWYxwWTcG/Xza7ZkaEtDFm
         06I6E+DqUxndMW08/xw1v/K4pFYEpqfT1SqunEn5YQ8TAZgErVu0t+u5bnzYCWiYfZ1D
         XrfWmIqiL7w4FszwDnORRDogjIV1bOuWZSF3hzlNpFegclQfBsAiB/GmSL0H8CKrQzKm
         X7tw==
X-Gm-Message-State: AOAM532MFOWgGMs/NvObKKnVzGp8NV6NNmmUU3ipEdN3G+p8oObbBJBR
        jP4N/jYYQ1rdZWXq8rqyF9k=
X-Google-Smtp-Source: ABdhPJy4eqh2ZkmCD78meCjWFsinmbRWaCH5CMTmE9vvWebzuCAVfufD3H1i2eU8do0lH/TsVTWDnA==
X-Received: by 2002:ac2:5922:0:b0:46a:2396:f575 with SMTP id v2-20020ac25922000000b0046a2396f575mr13092449lfi.654.1649705111898;
        Mon, 11 Apr 2022 12:25:11 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id u2-20020a2e8542000000b0024b4b8dd24dsm1211010ljj.140.2022.04.11.12.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 12:25:11 -0700 (PDT)
Date:   Mon, 11 Apr 2022 22:25:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 01/21] dt-bindings: ata: sata: Extend number of SATA ports
Message-ID: <20220411192509.odx6vn7kxnfs6mxo@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-2-Sergey.Semin@baikalelectronics.ru>
 <92699f07-0efc-e471-d886-c7d6c83f352e@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92699f07-0efc-e471-d886-c7d6c83f352e@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 05:15:12PM +0900, Damien Le Moal wrote:
> On 3/24/22 09:16, Serge Semin wrote:
> > The denoted in the description upper limit only concerns the Port
> > Multipliers, but not the actual SATA ports. It's an external device
> > attached to a SATA port in order to access more than one SATA-drive. So
> > when it's attached to a SATA port it just extends the port capability
> > while the number of actual SATA ports stays the same. For instance on AHCI
> > controllers the number of actual ports is determined by the CAP.NP field
> > and the PI (Ports Implemented) register. AFAICS in general the maximum
> > number of SATA ports depends on the particular controller implementation.
> > Generic AHCI controller can't have more than 32 ports (since CAP.NP is of
> > 5 bits wide and PI register is 32-bits size), while DWC AHCI SATA
> > controller can't be configured with more than 8 ports activated. So let's
> > discard the SATA ports reg-property restrictions and just make sure that
> > it consists of a single reg-item.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  Documentation/devicetree/bindings/ata/sata-common.yaml | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
> > index 7ac77b1c5850..c619f0ae72fb 100644
> > --- a/Documentation/devicetree/bindings/ata/sata-common.yaml
> > +++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
> > @@ -41,11 +41,10 @@ patternProperties:
> >      properties:
> >        reg:
> >          minimum: 0
> > -        maximum: 14
> 

> Why remove this ? Since AHCI can have up to 32 ports, then change the
> value to 31. As the comment at the top of the file says, this is not
> intended to be a device tree binding spec, but defines properties common
> to most adapters.

Right, but the schema determines the common !SATA! controllers properties,
while you are referring to the AHCI-specific limit. As I said in the patch
log AFAICS in general the SATA controllers may have any number of ports.
The number is determined by the hardware designers needs only. Thus the
actual constraints needs to be specified in the controller-specific
YAML-schema (the one which will $ref to sata-common.yaml).

Though I couldn't find any ATA device driver in the kernel which would
handle a device with even 32 ports, not to mention a greater number.
So replacing it with 31 might be reasonable after all. But me failing
to find any such device doesn't me it can't exist. Thus I've decided to
drop the upper limit completely.

> 
> >          description:
> > -          The ID number of the drive port SATA can potentially use a port
> > -          multiplier making it possible to connect up to 15 disks to a single
> > -          SATA port.
> > +          The ID number of the SATA port. Aside with being directly used
> > +          each port can have a Port Multiplier attached thus allowing to
> > +          access more than one drive by means of a single channel.
> 

> Please add a comma after "Aside with being directly used", otherwise the
> sentence is hard to understand. And replace "channel" with "SATA port" to
> stick with the terms defined here.

Ok.

-Sergey

> 
> >  
> >  additionalProperties: true
> >  
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
