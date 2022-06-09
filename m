Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38836545534
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbiFIT6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiFIT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:58:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE95C31DD9;
        Thu,  9 Jun 2022 12:57:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v14so7559468wra.5;
        Thu, 09 Jun 2022 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qlJmCHU8eZPRqNcWDT80iV/TI1GQeD6B8X83HWoJ/vg=;
        b=glIR/xYU9IlYUCGGKtA6RNjCXBcZLYM2M7nAGqFfXS+3DLCz/yMncz2ahJj19O1UJG
         mLP5ISm4mDCAbv1Ki/0eUhj/HEEMQIKna0ypqpsOcM6phSJl/hjSm/p95TJOscXO3DHL
         FM/Fgle18gBD8vQL0G2quEWusnY15UTOgn9O2H8pDWr9BbVsDYkwrno3elqXDUTnf9AF
         7jSqNBP4KRohOYLEhua3GfUYnbwORMo9EbMTrVQAY/ZctdcFhTEMEhr80/uv729+tnpM
         GmJmrAqrFw20eBb+hVRkKkRU53wuKS7vtrEU8mTVjHiZ54WBWvGqy2f9PRIgY1V6zHML
         dYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qlJmCHU8eZPRqNcWDT80iV/TI1GQeD6B8X83HWoJ/vg=;
        b=53ytuCQlfXedL/Uzk8TUYp1x/xzgfYZsr7b4wiTtIWSs1mQeTpkaJIPMa01kJndW7y
         CoPNRcyywFZE2XtckHvs+BpUbqyQA0rGMZmFVCaNZtvr/yzj+/NMNdSftcpqqR7bD4o1
         i2BFms7w6u5qs0NAJwbWE0GbnHSyUsiyHSOvU+ZqGoeiLUpOz/z89VOX/WpMElKP9QW5
         1PZY6qFCgG/nz7R5FBiyKHnMUy8g2YlC8aeGGFGRamhaswNH5n/PU+SY08WG016ysTN2
         6RxmT8ksGqCtE/SbZPavA6shsfkK6sWPBt+oAUesCo+kGW3lHQPhWAtEl1JYoFvM9bRd
         WJvw==
X-Gm-Message-State: AOAM533P9eVF0Cd0UoIAyTzDfMLemnkiPBLxsUnVyU7Kn273iPQcLsnv
        0iarmraqDx0AXImY9oMDYno=
X-Google-Smtp-Source: ABdhPJwcgQHKiuHlpzcYVAwdddTtbeDElPmTomf/uUKSy/+mCKMqS1iu/CqQlQr4eKf/LDdYtxubVg==
X-Received: by 2002:a5d:4a4c:0:b0:210:27dd:e57 with SMTP id v12-20020a5d4a4c000000b0021027dd0e57mr39235685wrs.655.1654804677269;
        Thu, 09 Jun 2022 12:57:57 -0700 (PDT)
Received: from Ansuel-xps. ([5.171.80.117])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0039c362311d2sm406306wmq.9.2022.06.09.12.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 12:57:56 -0700 (PDT)
Message-ID: <62a250c4.1c69fb81.addd2.0eae@mx.google.com>
X-Google-Original-Message-ID: <YqJQwEoTzgdscpcX@Ansuel-xps.>
Date:   Thu, 9 Jun 2022 21:57:52 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        =?utf-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: mtd: partitions: Support label only
 partition
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
 <20220606151417.19227-2-ansuelsmth@gmail.com>
 <20220609183252.GA4072951-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609183252.GA4072951-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:32:52PM -0600, Rob Herring wrote:
> On Mon, Jun 06, 2022 at 05:14:15PM +0200, Ansuel Smith wrote:
> > Document new partition nodes that declare only the label instead of the
> > reg used to provide an OF node for partition registred at runtime by
> > parsers. This is required for nvmem system to declare and detect
> > nvmem-cells.
> > 
> > With these special partitions, the reg / offset is not required.
> > The label binding is used to match the partition allocated by the
> > parser at runtime and the parser will provide reg and offset of the mtd.
> > 
> > NVMEM will use the data from the parser and provide the NVMEM cells
> > declared in the DTS, "connecting" the dynamic partition with a
> > static declaration of cells in them.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/mtd/partitions/partition.yaml       | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > index e1ac08064425..bff6fb980e6b 100644
> > --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > @@ -11,6 +11,13 @@ description: |
> >    relative offset and size specified. Depending on partition function extra
> >    properties can be used.
> >  
> > +  A partition may be dynamically allocated by a specific parser at runtime.
> > +  In this specific case, the label is required instead of the reg.
> > +  This is used to assign an OF node to the dynamiccally allocated partition
> > +  so that subsystem like NVMEM can provide an OF node and declare NVMEM cells.
> > +  The OF node will be assigned only if the partition label declared match the
> > +  one assigned by the parser at runtime.
> > +
> >  maintainers:
> >    - Rafał Miłecki <rafal@milecki.pl>
> >  
> > @@ -22,6 +29,8 @@ properties:
> >    label:
> >      description: The label / name for this partition. If omitted, the label
> >        is taken from the node name (excluding the unit address).
> > +      With dynamically allocated partition the label is required and won't
> > +      fallback to the node name.
> 
> Generally, label is never required being something for humans rather 
> than the s/w to consume. I don't see any reason why we can't still use 
> the node name (with 'partition-' stripped off).
> 

How to enforce the use of 'partition-'? Should the driver then check the
node name and reject any wrong node name (and return error)?


> If the purpose is to define what the partition contains, then 
> 'compatible' is the right thing for that.
>

Introducing a compatible means creating another scheme I think or we can
add that special compatible in the partition scheme?

> >  
> >    read-only:
> >      description: This parameter, if present, is a hint that this partition
> > @@ -41,7 +50,10 @@ properties:
> >        immune to paired-pages corruptions
> >      type: boolean
> >  
> > -required:
> > -  - reg
> > +if:
> > +  not:
> > +    required: [ reg ]
> > +then:
> > +  required: [ label ]
> >  
> >  additionalProperties: true
> > -- 
> > 2.36.1
> > 
> > 

-- 
	Ansuel
