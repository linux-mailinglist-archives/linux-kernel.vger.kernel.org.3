Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28752549F72
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbiFMUfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiFMUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:35:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946AC39813;
        Mon, 13 Jun 2022 12:25:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v14so8351921wra.5;
        Mon, 13 Jun 2022 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P8UEDHDMT+jpQAXSUmhS5cnDmYTJqZrHS8auMDkB9iM=;
        b=S1sqEUWptAMoNsL/yZl9X9liiQgbDSLBMK1KkPHulgqqQnYj7jDHIUdfDSG42r6P9p
         kzOLpvQ0N2CVfDlTb+IqemtVyiTJOD7iZaE0mzCaDdqWnEoydjpxqhpMR+ZEYOYN2rjS
         5MANGV2gGUT+ARXhNV9G4YAWhuDkG+egcnvDcAs+KWj/0IV8tssuoH7vuby+7ujFGbcl
         hX9QRVGjS+amsgARu8kxWYe8ApJ4Y0lbtlc5Z6NFw5ZnSq1uZiTkgCiYVhZ1m/tSsJzH
         rcfC9uAZWa/9KPdNOe/dLgIp4yLgPSKqmw+IRtuOWmxVs/8KpVqO2nWfCsQyEv195TSg
         pTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P8UEDHDMT+jpQAXSUmhS5cnDmYTJqZrHS8auMDkB9iM=;
        b=2607QojOAg1/UwUXqDixX/b3VLu2TNIUJ0Gc/kd5nfSit3oGPjibVoQ7+EtgQH4iII
         feTDaiGaC1Ymg2IK57W6wA+BmblhukSWeqkqPlJHeE++TFqavjEF5hQhoK4XA3NubiiS
         HFjSHDLwhZwDRO9c2AInIs727a0vzLkdyiWPIguzNlI4dMUDdoSWYHhsyptQzYQMnzpI
         KaaDvOGhracgK/9LzpifQeisjkiOTBRzYMAy51PrA+rZnktWSdiB8XW1fsSR/E6DC4Nl
         W5DyKkCiZLH+6cJe8+tVQQ2TY+eo/37ECpzp6CjldFk2SdqlfaxxnHp+I0cdesDSV6O5
         mtIQ==
X-Gm-Message-State: AJIora+qnUeeZfiFxzmVAu0c5qTaaqQs22hd/pBqxykZFZTO+ocV1Y2C
        0YhlN+WGU6eb+OgsQvybCuI=
X-Google-Smtp-Source: AGRyM1slSf3w814vQAIijwzMlXdNSr5rvAEgtNAg31xiBcBaLcqPq/W4p4cZy7cnhYm/OEWTOpEJWQ==
X-Received: by 2002:a05:6000:1f8b:b0:219:bee5:6b77 with SMTP id bw11-20020a0560001f8b00b00219bee56b77mr1244672wrb.658.1655148301948;
        Mon, 13 Jun 2022 12:25:01 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id a4-20020adff7c4000000b0021033caa332sm9669422wrq.42.2022.06.13.12.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:25:01 -0700 (PDT)
Message-ID: <62a78f0d.1c69fb81.574dd.13b8@mx.google.com>
X-Google-Original-Message-ID: <YqePGfEbLTutoYrN@Ansuel-xps.>
Date:   Mon, 13 Jun 2022 21:25:13 +0200
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
 <62a250c4.1c69fb81.addd2.0eae@mx.google.com>
 <20220610170205.GD1787330-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610170205.GD1787330-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:02:05AM -0600, Rob Herring wrote:
> On Thu, Jun 09, 2022 at 09:57:52PM +0200, Ansuel Smith wrote:
> > On Thu, Jun 09, 2022 at 12:32:52PM -0600, Rob Herring wrote:
> > > On Mon, Jun 06, 2022 at 05:14:15PM +0200, Ansuel Smith wrote:
> > > > Document new partition nodes that declare only the label instead of the
> > > > reg used to provide an OF node for partition registred at runtime by
> > > > parsers. This is required for nvmem system to declare and detect
> > > > nvmem-cells.
> > > > 
> > > > With these special partitions, the reg / offset is not required.
> > > > The label binding is used to match the partition allocated by the
> > > > parser at runtime and the parser will provide reg and offset of the mtd.
> > > > 
> > > > NVMEM will use the data from the parser and provide the NVMEM cells
> > > > declared in the DTS, "connecting" the dynamic partition with a
> > > > static declaration of cells in them.
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >  .../bindings/mtd/partitions/partition.yaml       | 16 ++++++++++++++--
> > > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > > > index e1ac08064425..bff6fb980e6b 100644
> > > > --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > > > @@ -11,6 +11,13 @@ description: |
> > > >    relative offset and size specified. Depending on partition function extra
> > > >    properties can be used.
> > > >  
> > > > +  A partition may be dynamically allocated by a specific parser at runtime.
> > > > +  In this specific case, the label is required instead of the reg.
> > > > +  This is used to assign an OF node to the dynamiccally allocated partition
> > > > +  so that subsystem like NVMEM can provide an OF node and declare NVMEM cells.
> > > > +  The OF node will be assigned only if the partition label declared match the
> > > > +  one assigned by the parser at runtime.
> > > > +
> > > >  maintainers:
> > > >    - Rafał Miłecki <rafal@milecki.pl>
> > > >  
> > > > @@ -22,6 +29,8 @@ properties:
> > > >    label:
> > > >      description: The label / name for this partition. If omitted, the label
> > > >        is taken from the node name (excluding the unit address).
> > > > +      With dynamically allocated partition the label is required and won't
> > > > +      fallback to the node name.
> > > 
> > > Generally, label is never required being something for humans rather 
> > > than the s/w to consume. I don't see any reason why we can't still use 
> > > the node name (with 'partition-' stripped off).
> > > 
> > 
> > How to enforce the use of 'partition-'? Should the driver then check the
> > node name and reject any wrong node name (and return error)?
> 
> The schema can do it either in the parent (of partition nodes) schema or 
> with $nodename 'property'.
> 
> $nodename:
>   oneOf:
>     - pattern: '^.*@.*$'
>     - pattern: '^partition-.*$'
> 
> or:
> 
> if:
>   not:
>     required:
>       - reg
> then:
>   properties:
>     $nodename:
>       pattern: '^partition-.*$'
> 
> 
> The latter is a bit clearer on the intent I think.
>

Hi, I'm testing this but I'm having some difficulties.
I put your second solution in partition.yaml

But I notice that if for example qcom,smem-part.yaml have

patternProperties:
  "^partition3-[0-9a-z]+$":
    $ref: partition.yaml#

Then the $nodename is ignored (or overwtitten?). Can't find a correct
way to declare a patternProperties that ref another schema.

I'm trying and searching a way to ref the partition.yaml but I can't
find anything. Can you help with this? It does seem uselss putting a
limitation in partition.yaml if then someone can just set a different
one in the parser Documentation.

> > > If the purpose is to define what the partition contains, then 
> > > 'compatible' is the right thing for that.
> > >
> > 
> > Introducing a compatible means creating another scheme I think or we can
> > add that special compatible in the partition scheme?
> 
> It would be another schema. You could make 'compatible' required here 
> perhaps, but maybe there's a use for an empty node?
> 
> Rob

-- 
	Ansuel
