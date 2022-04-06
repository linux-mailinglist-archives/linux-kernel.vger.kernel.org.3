Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60F74F6C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiDFVMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiDFVLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:11:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3B1C5914;
        Wed,  6 Apr 2022 12:54:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 17so4726285lji.1;
        Wed, 06 Apr 2022 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5AEyBQ/fkD+4YcH36kR38+Vd1KiTSJXqroTAkp4sV4o=;
        b=S3QfcpCoflBUlICt6eJ562gH8+uYjJ9gkROd3N6RRC8XI78tKT9hjXQPzMbsdU8Cst
         ABHjPWWyP/klB7u0HRQNSCr0IjWQOtx9cphsvyb9g9MSVgcW69esDKdZBVXvPJHAs2FR
         y8Iok8Qu0GFe2muHjlw7WXB+b1P5CkW07p/0VRynrgTb6GiRprZzmaj1ukshDlB4FGLV
         gA5plpqkXAJpwEY0HQE1YenCIWdcfNGAaTiAB37jveNPyBLCrIBpfriUxDC2o0aE0UzB
         8xjMCJPRe0ik9zmlcGBzWxaoU4yzvv3+F/JMapMzAYj1ylQdI/FiEU6TfpA+nWD66mPd
         7JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5AEyBQ/fkD+4YcH36kR38+Vd1KiTSJXqroTAkp4sV4o=;
        b=4YJuiVrUg+mhVNpdDF3W+zppFY5wS+OIJ1XhMPUCC1ErYVflMZbXzMt1cKuOwASbVm
         OGUt/u5aPNhbw6VQbUuyIWfcWVXkr42QylqFAeLLKKZHvzx7mSYKjiXHKWyGOjhYrd6p
         K8YwDXvfk3WzWZrAB2PK+Epq8pBH+B1lQsprnOZSH/rWVqA3pxNu934cq98JWZKTSIEm
         //JbrN5D9wAtHp6eDC8JGRSaggKI30GOpb6eh+9KuuOc4zusv3RabADXawXoK+GLpCzi
         Iu0R9AfkT9DypadELdGzPMLSy5KS7bb83HX4Ib7kGDpQxMKJaBW9ATDI9EgN3qlvKB5z
         DAZQ==
X-Gm-Message-State: AOAM5335xssWj1AZvZaVSr1crh9jPKAN9QbpyVwXIzgVUObop29S3oxx
        icCtT53MWxtjrR4XxfnUxuA=
X-Google-Smtp-Source: ABdhPJxD9JUTwIt9g1W1CEh2r3RZIPTJhl2RG4YDkZlxhbpZKkrl7FqwdjOjD+2D8CTcL7ebcdIy9w==
X-Received: by 2002:a2e:2f1c:0:b0:249:3319:fc6b with SMTP id v28-20020a2e2f1c000000b002493319fc6bmr6510718ljv.246.1649274878454;
        Wed, 06 Apr 2022 12:54:38 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id h12-20020ac24dac000000b0044a9a22cb5csm1926117lfe.263.2022.04.06.12.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:54:37 -0700 (PDT)
Date:   Wed, 6 Apr 2022 22:54:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 00/21] ata: ahci: Add DWC/Baikal-T1 AHCI SATA support
Message-ID: <20220406195436.4mp22n5pjw73jr2i@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <382eecca-f225-5272-b9d7-134c7baae4ae@opensource.wdc.com>
 <1d6824b6-a2ef-e076-12ce-6c2fe3fda959@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d6824b6-a2ef-e076-12ce-6c2fe3fda959@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Damien

On Tue, Mar 29, 2022 at 05:30:43PM +0900, Damien Le Moal wrote:
> On 3/29/22 05:06, Damien Le Moal wrote:
> > On 3/24/22 09:16, Serge Semin wrote:
> > [...]
> >> After the denoted above functionality is added we can finally introduce
> >> the Baikal-T1 AHCI SATA controller support into the DWC AHCI SATA driver.
> >> The controller is based on the DWC AHCI SATA IP-core v4.10a and can work
> >> well with the generic DWC AHCI driver. The only peculiarity of it is
> >> connected with the SATA Ports reference clock source. It can be supplied
> >> either from the internal SoC PLL or from the chip pads. Currently we have
> >> to prefer selecting the signal coming from the pads if the corresponding
> >> clock source is specified because the link doesn't get stably established
> >> when the internal clock signal is activated. In addition the platform has
> >> trigger-based reset signals so the corresponding flag must be passed to
> >> the generic AHCI-resource getter.
> >>
> > 

> > I am assuming this is "v2" of your patches. Please add this version number
> > to your patch titles ("[PATCH v2]") and add a changelog here in the cover
> > letter.
> 
> Sorry. It looks like I received again the same patch series. Not sure why.
> I assumed it was a V2, but it is not.

Most likely you've received the series released by the mailing list
service.  I've sent four patchsets at a time then, and I guess the
spam-filter was unhappy about that. So all the series were sustained
for some time and were unavailable in the lore and patchwork. In after
about four days they turned to be finally available. At least I
finally was able to see my patchsets there after getting your messages
above, which made me to re-check the series status.

-Sergey

> 
> > 
> >> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> >> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: linux-ide@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: devicetree@vger.kernel.org
> >>
> >> Serge Semin (21):
> >>   dt-bindings: ata: sata: Extend number of SATA ports
> >>   dt-bindings: ata: Convert AHCI-bindings to DT schema
> >>   ata: libahci_platform: Explicitly set rc on devres_alloc failure
> >>   ata: libahci_platform: Convert to using handy devm-ioremap methods
> >>   ata: libahci_platform: Convert to using devm bulk clocks API
> >>   ata: libahci_platform: Add function returning a clock-handle by id
> >>   ata: libahci_platform: Sanity check the DT child nodes number
> >>   ata: libahci_platform: Parse ports-implemented property in resources
> >>     getter
> >>   ata: libahci_platform: Introduce reset assertion/deassertion methods
> >>   dt-bindings: ata: ahci: Add platform capability properties
> >>   ata: libahci: Extend port-cmd flags set with port capabilities
> >>   ata: libahci: Discard redundant force_port_map parameter
> >>   ata: libahci: Don't read AHCI version twice in the save-config method
> >>   ata: ahci: Convert __ahci_port_base to accepting hpriv as arguments
> >>   ata: ahci: Introduce firmware-specific caps initialization
> >>   dt-bindings: ata: ahci: Add DWC AHCI SATA controller DT schema
> >>   ata: ahci: Add DWC AHCI SATA controller support
> >>   dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA controller DT schema
> >>   ata: ahci-dwc: Add platform-specific quirks support
> >>   ata: ahci-dwc: Add Baikal-T1 AHCI SATA interface support
> >>   MAINTAINERS: Add maintainers for DWC AHCI SATA driver
> >>
> >>  .../devicetree/bindings/ata/ahci-common.yaml  | 176 ++++++
> >>  .../devicetree/bindings/ata/ahci-platform.txt |  79 ---
> >>  .../bindings/ata/baikal,bt1-ahci.yaml         | 132 +++++
> >>  .../devicetree/bindings/ata/generic-ahci.yaml |  98 ++++
> >>  .../devicetree/bindings/ata/sata-common.yaml  |   7 +-
> >>  .../bindings/ata/snps,dwc-ahci.yaml           | 121 ++++
> >>  MAINTAINERS                                   |   9 +
> >>  drivers/ata/Kconfig                           |  11 +
> >>  drivers/ata/Makefile                          |   1 +
> >>  drivers/ata/ahci.c                            |   4 +-
> >>  drivers/ata/ahci.h                            |  21 +-
> >>  drivers/ata/ahci_dwc.c                        | 525 ++++++++++++++++++
> >>  drivers/ata/ahci_mtk.c                        |   2 -
> >>  drivers/ata/ahci_platform.c                   |   5 -
> >>  drivers/ata/ahci_st.c                         |   3 -
> >>  drivers/ata/libahci.c                         |  63 ++-
> >>  drivers/ata/libahci_platform.c                | 234 +++++---
> >>  include/linux/ahci_platform.h                 |   8 +-
> >>  18 files changed, 1321 insertions(+), 178 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
> >>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
> >>  create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/ata/generic-ahci.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> >>  create mode 100644 drivers/ata/ahci_dwc.c
> >>
> > 
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
