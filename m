Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE15303C3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347785AbiEVPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiEVPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:08:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F90D3A5E3;
        Sun, 22 May 2022 08:08:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so21663807lfg.7;
        Sun, 22 May 2022 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7g33WtJZnwYfTwI509SCQTLTp308sKh4zxrRwkR1M1s=;
        b=c9godQeu8vT6tVI38R1L6EOrm/QCt0Dhf+GHnwxRq87S+8EkI8WDYvJwOpXYMmqTfU
         NVFnu/NyWq6zD2OV9YQliMk56QUSHyaAAGRdCOnTJEhcyvnJKRrhy1n1RmMu30OdR4LE
         oMus8NGN3R7ajDoZ9C3RaELEvF2upqn/8EEhXd8P05R6qtDCuSbACIca1sgo+7xwkS7L
         OYImqumpCGnmWr4y7RQgQ6LjgSSSmB6jMPFOc1Vok/xV9KSS6UqU7VZ1WwCU2SCmkRuh
         R65o4FbSOdvbgkLdlVUWtxYLnqnw08OCVETFf1s7ba+ireDyLj9HebRVvBUe5iH2q+qB
         +bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7g33WtJZnwYfTwI509SCQTLTp308sKh4zxrRwkR1M1s=;
        b=6/K5ADP226pLqU/xcpo26cIiKIQNna2aeqT9F54QuQXfzVozYzctG3ZAhuD1QTEexL
         C9caK1rHctgjDWR1vPAY3hbvlBPBtzL05VsHpYX+qJ6Irf8+tXXz0AO2S8r8r6jqipKq
         4Gjp0q3DBrgCeMPqFKGlSgFRbT7eriERjdgQdAXBDDYIHM6I6+msNjQD2e5et0bI/5ra
         lamvT8IpT2xFGeejUBGAy8HPBdvmUBZM4vR+HEGgGaUkJSulPbpQLGJZydfegP/8x9TG
         iFHpLjpQCOAKE0Llo2ariQ6foZeEYUYoA4vMy4QIsMvC6NoD3TOXI6H4dHnw+H3XenbJ
         8/wQ==
X-Gm-Message-State: AOAM530kAFlM6fVtOh3hvz+X6mCbCSBKb3eSvQTGGRtSgpGCZf4BkkxA
        VtDeusGH+9LCoknwoeRw021wBLB23C4=
X-Google-Smtp-Source: ABdhPJxzA2qZom1Ij7EyzIN6/ZFfQuqaXx91/vip/JYRQgoWg6l/FagtzgXOmgXgUFQGvHDMHRth7Q==
X-Received: by 2002:ac2:4289:0:b0:477:b3eb:f2f with SMTP id m9-20020ac24289000000b00477b3eb0f2fmr14069215lfh.386.1653232134406;
        Sun, 22 May 2022 08:08:54 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id i22-20020a2e8096000000b00250664c906asm1224927ljg.133.2022.05.22.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 08:08:53 -0700 (PDT)
Date:   Sun, 22 May 2022 18:08:51 +0300
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
Subject: Re: [PATCH v3 03/23] dt-bindings: ata: ahci-platform: Clarify common
 AHCI props constraints
Message-ID: <20220522150851.x4unzszwd3lh52qt@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-4-Sergey.Semin@baikalelectronics.ru>
 <20220517191409.GA1445438-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517191409.GA1445438-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:14:09PM -0500, Rob Herring wrote:
> On Thu, May 12, 2022 at 02:17:50AM +0300, Serge Semin wrote:
> > Indeed in accordance with what is imeplemtned in the AHCI paltform driver
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
> >  .../devicetree/bindings/ata/ahci-common.yaml      | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > index 620042ca12e7..a7d1a8353de3 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > @@ -31,6 +31,8 @@ properties:
> >  
> >    reg-names:
> >      description: CSR space IDs
> > +    contains:
> > +      const: ahci
> 

> Okay, with this it makes sense to keep. The others still should go.

Ok.

-Sergey

> 
> >  
> >    interrupts:
> >      description:
> > @@ -71,14 +73,13 @@ properties:
> >      maxItems: 1
> >  
> >    phy-names:
> > -    maxItems: 1
> > +    const: sata-phy
> >  
> >    ports-implemented:
> >      $ref: '/schemas/types.yaml#/definitions/uint32'
> >      description:
> >        Mask that indicates which ports the HBA supports. Useful if PI is not
> >        programmed by the BIOS, which is true for some embedded SoC's.
> > -    maximum: 0x1f
> >  
> >  patternProperties:
> >    "^sata-port@[0-9a-f]+$":
> > @@ -89,8 +90,12 @@ patternProperties:
> >  
> >      properties:
> >        reg:
> > -        description: AHCI SATA port identifier
> > -        maxItems: 1
> > +        description:
> > +          AHCI SATA port identifier. By design AHCI controller can't have
> > +          more than 32 ports due to the CAP.NP fields and PI register size
> > +          constraints.
> > +        minimum: 0
> > +        maximum: 31
> >  
> >        phys:
> >          description: Individual AHCI SATA port PHY
> > @@ -98,7 +103,7 @@ patternProperties:
> >  
> >        phy-names:
> >          description: AHCI SATA port PHY ID
> > -        maxItems: 1
> > +        const: sata-phy
> >  
> >        target-supply:
> >          description: Power regulator for SATA port target device
> > -- 
> > 2.35.1
> > 
> > 
