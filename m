Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786AF4FC528
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349642AbiDKThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiDKThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:37:13 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9D13DF0;
        Mon, 11 Apr 2022 12:34:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q14so21387682ljc.12;
        Mon, 11 Apr 2022 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XY09aeNDdy27g5n+8mYaLZ8aj3jA8D4AuzY9qvArx2Y=;
        b=CrlPTJex9uZcReUMpaZU7pxCR8yfOYmc1UesawMhw3OHzLO3nhD4MtyyGqTLRQun92
         w/oUwekNwIFJksydrkmzxZw8nifCnSw88KZJ45HK0jXwSI6HLS1O89g85wikMFrxz7Ts
         woa4jo3U3vTRwFbS76kmGntwceTn9Gt/SY44tilQSVVguaZ1bo1oIqcdg7Mnf59c8mht
         istLkdHCy+HHuMVr+C3KpAVOKu4e3EYr5t/9dxO2aCyeTPkSzFKGJdL4sehHeK/eqdcw
         EKEKpwcPQAqm0dtBZA56jN+HAIOJc6qlY4PvEBFbm37AOMe3AgWyoxfPAjsLD7ykkJTa
         V77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XY09aeNDdy27g5n+8mYaLZ8aj3jA8D4AuzY9qvArx2Y=;
        b=yB4IYJdoeWSBJNzv8B2GwfTsmDMBEPvUdxEwzIvHv9va4io+Vh8H87wZyWFwNqKjpB
         GosMBtxJGA21FsyDN2Ae+L36H8IM9ahvbRagt59rLtrjQZCxXQy6nmqm48o+k7x/JXvz
         lwUrJ0aPRJWjX6LcPyuIqpnXBztoEEkoNFIsK2ZF3x4nLajEfeAQ4wOeJlESC0gVzy4V
         yknbUAfZOcr1pjSWrHLs9le8ib/gfaV73vsFVpvj6CnFmQJTgyOJGVzmGwEjZNgDCOTY
         ccqqybMEReXweSwAu4yT8pdT10Cv2xMVPxX0LWXJCkAmrUU93DxV3rpifPifwieGcA5C
         Tt0A==
X-Gm-Message-State: AOAM531qWBiRtEpPN0i1lChQdP/kxHpLHO/e9HtTRt0bZJWjzm3YBHr6
        BdxdQKgvtOwgEJ0d2xzTZmE=
X-Google-Smtp-Source: ABdhPJwJBcYSp3wS5Fc7wegOZL6c9MK/lTd1t4do8unXY4u8Wb3a0eTUmWFglVDnwAbwwcc/qnIDGw==
X-Received: by 2002:a2e:b94b:0:b0:249:6181:468a with SMTP id 11-20020a2eb94b000000b002496181468amr21543188ljs.113.1649705695909;
        Mon, 11 Apr 2022 12:34:55 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id a7-20020a19fc07000000b0046b90a9f0f9sm889004lfi.1.2022.04.11.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 12:34:53 -0700 (PDT)
Date:   Mon, 11 Apr 2022 22:34:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 02/21] dt-bindings: ata: Convert AHCI-bindings to DT
 schema
Message-ID: <20220411193452.tfs5x2b3ol6dtpwv@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-3-Sergey.Semin@baikalelectronics.ru>
 <CAL_JsqKnnVKmCA6he_A-OAgu1xD1bjHBy4_eXf64q2LJ9+L3_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKnnVKmCA6he_A-OAgu1xD1bjHBy4_eXf64q2LJ9+L3_g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 02:32:06PM -0500, Rob Herring wrote:
> On Wed, Mar 23, 2022 at 7:16 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > Currently the DT bindings of Generic AHCI Controllers are described by
> > means of the legacy text file. Since such format is deprecated in favor of
> > the DT schema. Let's convert the Generic AHCI Controllers bindings file
> > then to the corresponding yaml files. There will be two of them: a DT
> > schema with a set of properties applied to all AHCI-compatible devices,
> > and a DT schema validating an AHCI-controller on a generic platform. So if
> > a controller conforms to the Serial ATA AHCI interface specification with
> > just peculiar platform environment settings like clock sources, PHYs,
> > power regulators or resets, then the generic AHCI bindings should work for
> > it. Otherwise a dedicated DT-schema needs to be created.
> >
> > So a common AHCI SATA controller DT-node is supposed to be equipped with
> > at least compatible, reg and interrupts properties. It can optionally
> > contain clocks, resets, {ahci,target,phy}-supply and phys phandles. In
> > addition the property "ports-implemented" can be specified in order to
> > define the number of implemented SATA ports. An AHCI SATA controller
> > DT-node can also have a set of sub-nodes representing its ports, for each
> > of which an individual power source and PHY phandle can be specified.
> >
> > Note we have omitted the next compatible strings
> > "marvell,armada-380-ahci", "marvell,armada-3700-ahci", "snps,dwc-ahci",
> > "snps,spear-ahci" since the corresponding controllers are handled by the
> > dedicated drivers now, thus are supposed to have their own DT-schema
> > defined. dma-coherent has also been discarded since it's a generic
> > property and is evaluated by the dt-schema parser.
> >
> > Also note that if there is the "reg-names" property specified for a AHCI
> > DT-node then it is supposed to at least have the "ahci" sub-string as an
> > indicator of the AHCI-compatible registers space.
> >
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  .../devicetree/bindings/ata/ahci-common.yaml  | 110 ++++++++++++++++++
> >  .../devicetree/bindings/ata/ahci-platform.txt |  79 -------------
> >  .../devicetree/bindings/ata/generic-ahci.yaml |  89 ++++++++++++++
> >  3 files changed, 199 insertions(+), 79 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
> >  create mode 100644 Documentation/devicetree/bindings/ata/generic-ahci.yaml
> 

> This has already been converted and is in Linus' tree now for v5.18.

Too bad.( I'll have to rebase this patch on top of that schema now
seeing it hasn't been split up into the common and platform-specific
parts.

-Sergey

> 
> Rob
