Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BF554D404
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343736AbiFOV4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbiFOV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:56:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755A244A3A;
        Wed, 15 Jun 2022 14:56:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h23so14780985ljl.3;
        Wed, 15 Jun 2022 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fj3idR9ITxtyBkLb8C2yMHLKLG7IMAyqge6auz8Xoso=;
        b=geZQgQBfPs0gt1EhAThZmGnVf/B3qlss07EEfs+bWEivxL+jVVax1x5tGlhx01mFYw
         DbKXjki82pi2wpCiZI+fzhyvX/0mfO7O01D1Qo0d30opmIYIiyRlN3lD4YEz/2wKN4N2
         g6nCcz1iKJXIMmgAazAi8u7IQZaZi3Fd8hbp8n0C2QnAcdXxPHdVpd4+Tw3P1HCyN8NK
         4hgwx6/fkgc3JYyTW6RuaxBsZET5mbscooRHtEIfkEuLppcEdcSRcaJ9OeKoW8kkAW3v
         3xhbgd39xeFzTnlX5YN5eonge/RAqdoy4ToKN+fiJfs06Hi+kAhg84bFRnHnuE2zwfW1
         4J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fj3idR9ITxtyBkLb8C2yMHLKLG7IMAyqge6auz8Xoso=;
        b=eXSn6lx13dW59tiWuYkqg1GB5Wzq2msQj5GU0fATLfyHIuqOIYpb21BjqAtEbWg6w3
         zv94r64VxEPoK+DZPcVdEsbrjEMSSxwC1bgkGq5Ilf2KrxXIS+m+rerwm5BCGfTXcnuX
         dCTg450gLrxNmUM5XQT82NfLtCXz1cJXz5yJgyyrCVEb6IbNM+DM2Jsa3A8RCD1a7BPa
         wCHXoGcUIfhLcN6QeFF8uaoeZ0kdaPfGZp59yDryzXDLhdN+Rlr1qxARyAdTJ8///3sG
         0pK+bgQZTZGn5tDO1hu2GMX0cR3IU0zoMIZ1Bb7iUK/gDI/LUyZtnfvYrSbvPCJi7/mZ
         cQCQ==
X-Gm-Message-State: AJIora8bpLUVNoOlqB678vRcA7l9wn7QcWEQRsaKVimoVZb68gxJp4v3
        jOyvuQABxz2oejKfzeUs2fQ=
X-Google-Smtp-Source: AGRyM1ssSQMkRSYZ0vv7iOqWHBgvY/2JNmKnl/GQF59+6dI9uvS6E33ao5FwJXCzISRaT6udDukahg==
X-Received: by 2002:a2e:508:0:b0:255:66fb:9fce with SMTP id 8-20020a2e0508000000b0025566fb9fcemr950322ljf.171.1655330190775;
        Wed, 15 Jun 2022 14:56:30 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id b13-20020a2eb90d000000b0025587b872cesm2516ljb.70.2022.06.15.14.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:56:30 -0700 (PDT)
Date:   Thu, 16 Jun 2022 00:56:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 11/23] dt-bindings: ata: ahci: Add platform capability
 properties
Message-ID: <20220615215628.m5pgnys7acmkhslg@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-12-Sergey.Semin@baikalelectronics.ru>
 <20220614221917.GA2824584-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614221917.GA2824584-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 04:19:17PM -0600, Rob Herring wrote:
> On Fri, Jun 10, 2022 at 11:17:49AM +0300, Serge Semin wrote:
> > In case if the platform doesn't have BIOS or a comprehensive firmware
> > installed then the HBA capability flags will be left uninitialized. As a
> > good alternative we suggest to define the DT-properties with the AHCI
> > platform capabilities describing all the HW-init flags of the
> > corresponding capability register. Luckily there aren't too many of them.
> > SSS - Staggered Spin-up support and MPS - Mechanical Presence Switch
> > support determine the corresponding feature availability for the whole HBA
> > by means of the "hba-cap" property. Each port can have the "hba-port-cap"
> > property initialized indicating that the port supports some of the next
> > functionalities: HPCP - HotPlug capable port, MPSP - Mechanical Presence
> > Switch attached to a port, CPD - Cold Plug detection, ESP - External SATA
> > Port (eSATA), FBSCP - FIS-based switching capable port.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v4:
> > - Fix some misspelling in the patch log.
> > - Convert the boolean properties to the bitfield properties. (@Rob)
> > - Remove Hannes' rb tag due to the patch content change.
> > ---
> >  .../devicetree/bindings/ata/ahci-common.yaml  | 16 +++++++++++++++
> >  .../bindings/ata/ahci-platform.yaml           | 10 ++++++++++
> >  include/dt-bindings/ata/ahci.h                | 20 +++++++++++++++++++
> >  3 files changed, 46 insertions(+)
> >  create mode 100644 include/dt-bindings/ata/ahci.h
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > index 12a97b56226f..94d72aeaad0f 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > @@ -58,6 +58,14 @@ properties:
> >    phy-names:
> >      const: sata-phy
> >  
> > +  hba-cap:
> > +    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    description:
> > +      Bitfield of the HBA generic platform capabilities like Staggered
> > +      Spin-up or Mechanical Presence Switch support. It can be used to
> > +      appropriately initialize the HWinit fields of the HBA CAP register
> > +      in case if the system firmware hasn't done it.
> > +
> >    ports-implemented:
> >      $ref: '/schemas/types.yaml#/definitions/uint32'
> >      description:
> > @@ -101,6 +109,14 @@ $defs:
> >        target-supply:
> >          description: Power regulator for SATA port target device
> >  
> > +      hba-port-cap:
> > +        $ref: '/schemas/types.yaml#/definitions/uint32'
> > +        description:
> > +          Bitfield of the HBA port-specific platform capabilities like Hot
> > +          plugging, eSATA, FIS-based Switching, etc (see AHCI specification
> > +          for details). It can be used to initialize the HWinit fields of
> > +          the PxCMD register in case if the system firmware hasn't done it.
> > +
> >      required:
> >        - reg
> >  
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > index 15be98e0385b..e19cf9828e68 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > @@ -111,6 +111,8 @@ examples:
> >    - |
> >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> >      #include <dt-bindings/clock/berlin2q.h>
> > +    #include <dt-bindings/ata/ahci.h>
> > +
> >      sata@f7e90000 {
> >          compatible = "marvell,berlin2q-ahci", "generic-ahci";
> >          reg = <0xf7e90000 0x1000>;
> > @@ -119,15 +121,23 @@ examples:
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> >  
> > +        hba-cap = <HBA_SMPS>;
> > +
> >          sata0: sata-port@0 {
> >              reg = <0>;
> > +
> >              phys = <&sata_phy 0>;
> >              target-supply = <&reg_sata0>;
> > +
> > +            hba-port-cap = <(HBA_PORT_FBSCP | HBA_PORT_ESP)>;
> >          };
> >  
> >          sata1: sata-port@1 {
> >              reg = <1>;
> > +
> >              phys = <&sata_phy 1>;
> >              target-supply = <&reg_sata1>;
> > +
> > +            hba-port-cap = <(HBA_PORT_HPCP | HBA_PORT_MPSP | HBA_PORT_FBSCP)>;
> >          };
> >      };
> > diff --git a/include/dt-bindings/ata/ahci.h b/include/dt-bindings/ata/ahci.h
> > new file mode 100644
> > index 000000000000..6841caebcedf
> > --- /dev/null
> > +++ b/include/dt-bindings/ata/ahci.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 

> Dual license.

Ok.

> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks.

-Sergey

> 
> > +/*
> > + * This header provides constants for most AHCI bindings.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_ATA_AHCI_H
> > +#define _DT_BINDINGS_ATA_AHCI_H
> > +
> > +/* Host Bus Adapter generic platform capabilities */
> > +#define HBA_SSS		(1 << 27)
> > +#define HBA_SMPS	(1 << 28)
> > +
> > +/* Host Bus Adapter port-specific platform capabilities */
> > +#define HBA_PORT_HPCP	(1 << 18)
> > +#define HBA_PORT_MPSP	(1 << 19)
> > +#define HBA_PORT_CPD	(1 << 20)
> > +#define HBA_PORT_ESP	(1 << 21)
> > +#define HBA_PORT_FBSCP	(1 << 22)
> > +
> > +#endif
> > -- 
> > 2.35.1
> > 
> > 
