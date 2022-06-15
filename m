Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6439954D3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349646AbiFOVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245104AbiFOVae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:30:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB5B562CD;
        Wed, 15 Jun 2022 14:30:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so20818379lfg.7;
        Wed, 15 Jun 2022 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SNyczBP6qlGicSYiV5R4dK6p317D/hQUgdOSfi3L7vI=;
        b=B0emyKDiwbJH5GIObJjCB48eyskxzdzT+LBRIuQuHmJvWHSXEdGervMc5UkPMDWqyu
         1gyZHo0gtnRK019lZL+fNTSHkN0QKFUfwuEouwHZch6Y9V8l5HznM01NA6yD/x3GLjGJ
         6HjKuJPiGBQXyOEhhGtgeugVH2KiP7IwPv8mxnCoqz9E0f3UOuSbfWMj1NcW0FoCl+qh
         abhtUhDKdFjW3+Gj+RIyTm3U1Gq7UXDJe92hjZBX78Pr6zwe4wUgOZfhKi83LhY7x38x
         w3SzXh49+oxnaCk7QeMfT4rMLoaZHyc9cRlbanvo65DHS8z+wY3eiQGNOwj6btKsUwFr
         YWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SNyczBP6qlGicSYiV5R4dK6p317D/hQUgdOSfi3L7vI=;
        b=XyisrT2acZwY/0kXDxfhGRLGY5hgxvZ0MRVjhDODjmMVbXm8Hai5rLnGRks4qjfjHr
         vHisHfDb5Nx6dYeENeIW2u+0nsU7nvmhPbSVMR0YCLT0DdvGr6gbOap2seOQnxqQiM9T
         9yXeNA6RugZHGFnPNsUmrVtJo4YREIWFsBNVl+QpUlNAyBZ5noxNQOYZfbEsVGnUSqgN
         OXlXwOzQj4S2RwyFk94ieIj1nEnDhQleuH/NuHXgAZt3xXeHv46QEPG41z4iRPA0gkvf
         iGI+dv94fFxSSLE1wNPUupM2aw/lKyAOkhdzFn5PbInWMaaavz8Ic3QB3xTNA3Po2vbF
         71kg==
X-Gm-Message-State: AJIora9ireiJYy3laTkYw4+cvWBS+ocYhP4T5JKExwzU6XT6LAsRkij5
        fghn0OwuTFvSFAV9cm3Dupat3J2iILvAEw==
X-Google-Smtp-Source: AGRyM1v+vEYdCRympQF5EQXPaBBHYEa4r5N08kkFHdHlGwZtJb8PFd0EHPR7JWDnxQ43m760D+QGWQ==
X-Received: by 2002:a05:6512:2607:b0:47d:ad86:2761 with SMTP id bt7-20020a056512260700b0047dad862761mr883630lfb.133.1655328631600;
        Wed, 15 Jun 2022 14:30:31 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id p13-20020ac246cd000000b0047db8b30670sm1924857lfo.136.2022.06.15.14.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:30:30 -0700 (PDT)
Date:   Thu, 16 Jun 2022 00:30:29 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 19/23] ata: ahci: Add DWC AHCI SATA controller support
Message-ID: <20220615213029.3upsmasnnhigqozm@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
 <6c02f8ef-8aea-8f80-590d-343f67a96f8d@infradead.org>
 <20220610215850.ju76kxjquwef6kd3@mobilestation>
 <73716f9f-892c-41c5-89f0-64a1985438aa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73716f9f-892c-41c5-89f0-64a1985438aa@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:34:13PM -0700, Randy Dunlap wrote:
> Hi Serge,
> 
> On 6/10/22 14:58, Serge Semin wrote:
> > On Fri, Jun 10, 2022 at 09:34:46AM -0700, Randy Dunlap wrote:
> >> Hi--
> > 
> > Hi Randy
> > 
> >>
> >> On 6/10/22 01:17, Serge Semin wrote:
> >>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> >>> index bb45a9c00514..95e0e022b5bb 100644
> >>> --- a/drivers/ata/Kconfig
> >>> +++ b/drivers/ata/Kconfig
> >>> @@ -176,6 +176,16 @@ config AHCI_DM816
> >>>  
> >>>  	  If unsure, say N.
> >>>  
> >>> +config AHCI_DWC
> >>> +	tristate "Synopsys DWC AHCI SATA support"
> >>> +	select SATA_HOST
> >>> +	default SATA_AHCI_PLATFORM
> >>
> > 
> >> I don't think this needs to default to SATA_AHCI_PLATFORM.
> >> It might build a driver that isn't needed.
> >> And it's incompatible with "If unsure, say N."
> > 
> > Basically you are right, but this particular setting is connected with
> > the modification I've done in the drivers/ata/ahci_platform.c driver
> > in the framework of this commit. I've moved the "snps,spear-ahci" and
> > "snps,dwc-ahci" compatible devices support to the new driver. Thus
> > should I omit the SATA_AHCI_PLATFORM dependency their default kernel
> > configs will lack the corresponding controllers support. If it's not a
> > problem and we can rely on the kernel build system ability to ask
> > whether the new config needs to be set/cleared, then I would be very
> > happy to drop the default setting. What do you think?
> 

> I'd prefer to try it like that.
> If it becomes a problem, we can go back to this v4 patch.

Agreed then (seeing Damien is silent about your comment).

-Sergey

> 
> >>> +	help
> >>> +	  This option enables support for the Synopsys DWC AHCI SATA
> >>> +	  controller implementation.
> >>> +
> >>> +	  If unsure, say N.
> >>
> >> -- 
> >> ~Randy
> 
> Thanks.
> -- 
> ~Randy
