Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1915C524C49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353495AbiELMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbiELMBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:01:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89AB377C1;
        Thu, 12 May 2022 05:01:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p10so8592802lfa.12;
        Thu, 12 May 2022 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ki8Z7TUnUuDhm9/3QHrPzjbPsX1q3SF+4ubhMDYxBeQ=;
        b=XG+YBrrDszCrRcy9TfNEI1fUYxCJmZCMNt+NFNc7v/XQhWueUHPInOjaZ6uD64K5fU
         6EQ6cHtKvAquib+niNYFPYRY22uuzu7ok6rUTHNUMS8B2qdmroqk4eUAfWP54TBn25qf
         Gg+j6zK1x6Ufq4ZaUhaQEQQKsgkFpUF+bk9TPOCfWJOdwhVOex1SF61g7Ct0RvOTixpZ
         N09TyVXg9bCjHK3iMSWPQ5SC4pkVZA4xVBHZTHMgCB3Xx5m5evbB+k5xMKj0e2tJASfX
         Gdapja7ZNe0ey7tiajTudxf5wGQ/x9VcQbj0UGG7afBYmnN/bsVtztTvBjYA8Lggo9xA
         stSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ki8Z7TUnUuDhm9/3QHrPzjbPsX1q3SF+4ubhMDYxBeQ=;
        b=Jf7iPhU9RgFLc9RfO6M0Un8x6I/oaKo7G+6SyJuz8/FnRN6xCthyIC5JhylBmVy0Ms
         Ht6XYjSxpiQLIDYdwL0btMpYw2PBiroIRt0npP6kvpW3yghoHzeS7QlJqw8rNULlFJJC
         fXu4fXMb6HPvFr3bRSQKG75uG03ixaDY5hGK4tIXTqOUzSfZ+2LkZC/HsbJYGrwm9Wj4
         823/Y+5ZgTuSX7Wf8z5eL88306pEUNHfFhrREuAaOOTpXm2MJG7O3C/s2B4D6hK/XhdY
         7G7kgTk/clFV5wEvKoFs9TFKCW9SSeSuR3ncDYcLQa7+C9s05hiPyqokjcIRkqbrfm9s
         1icA==
X-Gm-Message-State: AOAM531J3OYuU9MVd2M9n1rX/rqT/JZLDb49HxElriv/3hvrxwUTWokW
        rW4ROYxLGjeQT5yH8JlnMDQ=
X-Google-Smtp-Source: ABdhPJy2jPbbUaC1tbwx5RgY+9vJHyi7k0zFqm/NWacgyu/xNVJYR7Wvx29a/YZjbsyff47nDyUn5w==
X-Received: by 2002:a05:6512:2514:b0:472:59b7:9523 with SMTP id be20-20020a056512251400b0047259b79523mr23217383lfb.147.1652356867068;
        Thu, 12 May 2022 05:01:07 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id b23-20020a196717000000b0047255d211f9sm748589lfc.296.2022.05.12.05.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:01:06 -0700 (PDT)
Date:   Thu, 12 May 2022 15:01:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 03/23] dt-bindings: ata: ahci-platform: Clarify common
 AHCI props constraints
Message-ID: <20220512120103.bybyg7e3f6wsd2wl@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-4-Sergey.Semin@baikalelectronics.ru>
 <d73f45d3-171f-a704-e479-411a54699d3b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d73f45d3-171f-a704-e479-411a54699d3b@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:21:42AM +0200, Hannes Reinecke wrote:
> On 5/12/22 01:17, Serge Semin wrote:
> > Indeed in accordance with what is imeplemtned in the AHCI paltform driver
> 

> Spelling; 'imeplemtned' and 'paltform'

Ok. I'll fix it in v3.

> 
> > and the way the AHCI DT nodes are defined in the DT files we can add the
> > next AHCI DT properties constraints: AHCI CSR ID is fixed to 'ahci', PHY
> > name is fixed to 'sata-phy', AHCI controller can't have more than 32 ports
> > by design.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Changelog v2:
> > - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> > ---
> >   .../devicetree/bindings/ata/ahci-common.yaml      | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > index 620042ca12e7..a7d1a8353de3 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > @@ -31,6 +31,8 @@ properties:
> >     reg-names:
> >       description: CSR space IDs
> > +    contains:
> > +      const: ahci
> >     interrupts:
> >       description:
> > @@ -71,14 +73,13 @@ properties:
> >       maxItems: 1
> >     phy-names:
> > -    maxItems: 1
> > +    const: sata-phy
> >     ports-implemented:
> >       $ref: '/schemas/types.yaml#/definitions/uint32'
> >       description:
> >         Mask that indicates which ports the HBA supports. Useful if PI is not
> >         programmed by the BIOS, which is true for some embedded SoC's.
> > -    maximum: 0x1f
> >   patternProperties:
> >     "^sata-port@[0-9a-f]+$":
> > @@ -89,8 +90,12 @@ patternProperties:
> >       properties:
> >         reg:
> > -        description: AHCI SATA port identifier
> > -        maxItems: 1
> > +        description:
> > +          AHCI SATA port identifier. By design AHCI controller can't have
> > +          more than 32 ports due to the CAP.NP fields and PI register size
> > +          constraints.
> > +        minimum: 0
> > +        maximum: 31
> >         phys:
> >           description: Individual AHCI SATA port PHY
> > @@ -98,7 +103,7 @@ patternProperties:
> >         phy-names:
> >           description: AHCI SATA port PHY ID
> > -        maxItems: 1
> > +        const: sata-phy
> >         target-supply:
> >           description: Power regulator for SATA port target device
> 

> Other than that it looks okay.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Thanks.

-Sergey

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke		           Kernel Storage Architect
> hare@suse.de			                  +49 911 74053 688
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
> HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
