Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA32F530504
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349968AbiEVRnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 13:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiEVRnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 13:43:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781D3968A;
        Sun, 22 May 2022 10:43:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bq30so22058091lfb.3;
        Sun, 22 May 2022 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cXqTZ3cjvi9NXPyDIk9+YjtNXvi3tP5AIRH9jXxAD+A=;
        b=lcaqLRZy2DJWntEBdPcJ4L0Svs1tqhjpMDr6iQYrqxNM41QqdlbiXh2JShtsDEr9Fl
         xxXuiJ2dx+V6yz3ViMK0a24NiZfcY98/PFfuwDIUTYfp3HmHjxtAhiIgP8jZeBcKmGA9
         7Noe3d3Q3aGL3FI4+LRcMieas072dxPqT+lgkADdZYJmVSTQOP7EoB/mLwGA1zzcH/zu
         ht7ZDhpTr4+c9RDspPqdelfxNGEjPeArMeYZDN1IJMhcGzfo3RGBmgJVzuQTk5wlsBuS
         EqfpLtQOlDLCK1fZRDk3+Z/PWYZKfchqdziCxCd6qjQowF0oaeCeff9lGbQJsUl44nLK
         6/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cXqTZ3cjvi9NXPyDIk9+YjtNXvi3tP5AIRH9jXxAD+A=;
        b=n6gkdjiqsTIkoY3xV8Q/t3CTYb6cDHCNPDdmfOEX6/OPAu5AfWB6g5+0XVS0H6FI93
         1sAND21G0aaEdslhXgdWyj+4sC/lVGe0nlGHBMHLpZf8yQ9uehiqYZRv3SOCTaQY+Wum
         xuzlx01QjPy2rT6M3qA2A5bdyMDCbqp9IeImx7b4nZ92JB9yvAEt4uznF64cP4ZkeibE
         54TekBNcHWVADFvgg0wxbrD17gm2rh1F+H0ivUsJrOHtkt+XRQgdcSc57ACyCpNHCU69
         4r6P3AiRN8uBxRlzyzMs0xwL1Z1p8TI3uWj7BuL4Rnk82B9it/eenL8IoQaOM48vL0Jk
         cvig==
X-Gm-Message-State: AOAM531UgnTIM1yvWZpb4aa6gAXw568FpP3MeNDZPdpmFOiva2kHMa/W
        CGHf7DwDOCqloDb1tl49Bzo=
X-Google-Smtp-Source: ABdhPJxJkcvQEApjpLtEssxzt1CwmQVJRIGNPq4QxWNRUeXwBRWyO7FxB9+JGrjYEtV35dgXBfv7Ew==
X-Received: by 2002:a05:6512:6cb:b0:478:6420:67f with SMTP id u11-20020a05651206cb00b004786420067fmr4407736lff.77.1653241417274;
        Sun, 22 May 2022 10:43:37 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e8042000000b00253c4d434a6sm1284273ljg.127.2022.05.22.10.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 10:43:36 -0700 (PDT)
Date:   Sun, 22 May 2022 20:43:34 +0300
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
Subject: Re: [PATCH v3 12/23] dt-bindings: ata: ahci: Add platform capability
 properties
Message-ID: <20220522174334.cnguiyl7u3nhe7mm@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-13-Sergey.Semin@baikalelectronics.ru>
 <20220517192028.GA1453662-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517192028.GA1453662-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:20:28PM -0500, Rob Herring wrote:
> On Thu, May 12, 2022 at 02:17:59AM +0300, Serge Semin wrote:
> > In case if the platform doesn't have BIOS or a comprehensive firmware
> > installed then the HBA capability flags will be left uninitialized. As a
> > good alternative we can define a set AHCI DT-node properties to describe
> > all of HW-init capabilities flags. Luckily there aren't too many of them.
> > SSS - Staggered Spin-up support and MPS - Mechanical Presence Switch
> > support determine the corresponding feature availability for whole HBA by
> > means of the "hba-sss" and "hba-smps" properties.  Each port can have the
> > "hba-{hpcp,mpsp,cpd,esp,fbscp}" defined indicatating that the port
> > supports the next functionality: HPCP - HotPlug capable port, MPSP -
> > Mechanical Presence Switch attached to a port, CPD - Cold Plug detection,
> > ESP - External SATA Port (eSATA), FBSCP - FIS-based switching capable
> > port.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Alternatively we could define them as a bitfield, but having a set of
> > boolean properties seemed a better idea since in that case we can
> > implement a simple inter-dependency rules for them, which can't be done
> > should we take the bitfields path.
> 

> I would just provide a CAP register override and be done with it.
> 
> The boolean fields only let you set a capability, but not unset one. 
> They would need to be tristate.

Ok. I'll convert the boolean properties to the generic (hba-cap) and
per-port (hba-port-cap) properties with CAP-override fields.

-Sergey

> 
> > ---
> >  .../devicetree/bindings/ata/ahci-common.yaml  | 66 +++++++++++++++++++
> >  .../bindings/ata/ahci-platform.yaml           | 11 ++++
> >  2 files changed, 77 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > index a7d1a8353de3..a29edfbb25db 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > @@ -75,6 +75,19 @@ properties:
> >    phy-names:
> >      const: sata-phy
> >  
> > +  hba-sss:
> > +    type: boolean
> > +    description:
> > +      Staggered Spin-up Support. Indicates whether the HBA supports the
> > +      staggered spin-up on its ports, for use in balancing power spikes.
> > +
> > +  hba-smps:
> > +    type: boolean
> > +    description:
> > +      Mechanical Presence Switch Support. Indicates whether the HBA supports
> > +      mechanical presence switches on its ports for use in hot plug
> > +      operations.
> > +
> >    ports-implemented:
> >      $ref: '/schemas/types.yaml#/definitions/uint32'
> >      description:
> > @@ -97,6 +110,40 @@ patternProperties:
> >          minimum: 0
> >          maximum: 31
> >  
> > +      hba-hpcp:
> > +        type: boolean
> > +        description:
> > +          Hot Plug Capable Port. Indicates that this port’s signal and power
> > +          connectors are externally accessible via a joint signal and power
> > +          connector for blindmate device hot plug. It is mutually exclusive
> > +          with the ESP feature.
> > +
> > +      hba-mpsp:
> > +        type: boolean
> > +        description:
> > +          Mechanical Presence Switch Attached to Port. Indicates whether
> > +          the platform an mechanical presence switch attached to this
> > +          port.
> > +
> > +      hba-cpd:
> > +        type: boolean
> > +        description:
> > +          Cold Presence Detection. Indicates whether the platform supports
> > +          cold presence detection on this port.
> > +
> > +      hba-esp:
> > +        type: boolean
> > +        description:
> > +          External SATA Port. Indicates that this port’s signal connector
> > +          is externally accessible on a signal only connector (e.g. eSATA
> > +          connector).
> > +
> > +      hba-fbscp:
> > +        type: boolean
> > +        description:
> > +          FIS-based Switching Capable Port. Indicates whether this port
> > +          supports Port Multiplier FIS-based switching.
> > +
> >        phys:
> >          description: Individual AHCI SATA port PHY
> >          maxItems: 1
> > @@ -111,6 +158,25 @@ patternProperties:
> >      required:
> >        - reg
> >  
> > +    # eSATA can't be enabled together with the HotPlug capability
> > +    oneOf:
> > +      - required:
> > +          - hba-hpcp
> > +      - required:
> > +          - hba-esp
> > +      - not:
> > +          anyOf:
> > +            - required:
> > +                - hba-hpcp
> > +            - required:
> > +                - hba-esp
> > +
> > +    # HotPlug capability must be enabled together with Cold Plug
> > +    # Detection and Mechanical Presence Switching.
> > +    dependencies:
> > +      hba-cpd: ["hba-hpcp"]
> > +      hba-mpsp: ["hba-hpcp"]
> > +
> >      additionalProperties: true
> >  
> >  required:
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > index 76075d3c8987..6cad7e86f3bb 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > @@ -117,14 +117,25 @@ examples:
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> >  
> > +        hba-smps;
> > +
> >          sata0: sata-port@0 {
> >              reg = <0>;
> > +
> > +            hba-fbscp;
> > +            hba-esp;
> > +
> >              phys = <&sata_phy 0>;
> >              target-supply = <&reg_sata0>;
> >          };
> >  
> >          sata1: sata-port@1 {
> >              reg = <1>;
> > +
> > +            hba-fbscp;
> > +            hba-hpcp;
> > +            hba-mpsp;
> > +
> >              phys = <&sata_phy 1>;
> >              target-supply = <&reg_sata1>;
> >          };
> > -- 
> > 2.35.1
> > 
> > 
