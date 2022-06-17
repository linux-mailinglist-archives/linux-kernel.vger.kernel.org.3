Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE154FF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381091AbiFQUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350359AbiFQUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:39:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40CD6B029;
        Fri, 17 Jun 2022 13:36:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id be31so8529870lfb.10;
        Fri, 17 Jun 2022 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oISNlUz9ZficuYsPA/Qge/7xO0eNE7k8Vy/EmxWpRmI=;
        b=cPydoDo5WZvGMR5+LSnh4cU2jc/hWCi4BCd0UK//fM7ymk/dflR8sjrxE89dsaE2I0
         TUsmJdTNRYD0rsLiY3DJH1VXacZGP5SqrlYNQXxOCAHCgCyCEr/0nSo1SroaNxcbalMV
         z+JXmlYqa4ApElo1U8JMmSrXirGuKiNO9tVeXwwfP1iU+Y8aRZUMYZkI+NY4gslnwFuQ
         XS/WL9qaHffT6+f2eV2yx1T+F0hm90sG8MIZdmXVpFyBiybpeAXK4CSfRAJRhFAYQoKo
         P1myqMugwjwhykwPB1+Fi1TsHr+sHSx2AAggonGQG6hPcmN+UwIqHSYDow7sE2qt8Eg0
         7G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oISNlUz9ZficuYsPA/Qge/7xO0eNE7k8Vy/EmxWpRmI=;
        b=RS/0oDQ1547YbbMTUC1jZmuD7Cp3iwWNX7eVQ6giLt7L3a7pG5edHCRdOo2NShgwAz
         XS1xlrxeTDo1IZuH5HalwrjoBrkDQs3RhFGC/6vIB6ZNLbWnZaCr3fVJupItSzY8FesH
         sncVVVWFnUYr7y4IuvlT9xWgce46S8u+jevWzXSt5LXn9FugJsO9Repne7rzdifXbYGp
         wgcK1W31jqBBeZhDbFvgguz9DN76uKRSP8qV6kqngNHxxgZQZZsG9wQLoIX1U1tGP0TQ
         +Us3w63In/KvZALz3HZ0LCBytOzh1nq0/cfUG8MKZjv7brXZvoKJfM3gJbh/rJsk8/+o
         U3MQ==
X-Gm-Message-State: AJIora919EvZ0ZbojV9/zSo2tS/Jetd8bFTrZcRXNjNlKXsr48T4Ztgb
        MlLcabjmNwGnW2mUHx5IO4s=
X-Google-Smtp-Source: AGRyM1u3aMO9KEyXbJIiCCbg9Kcfnq5GIbxgvcamCCxYVJoX9MOACf6DU7PZMSrao1T7QShHYxY1NQ==
X-Received: by 2002:a19:a417:0:b0:479:15ef:4ded with SMTP id q23-20020a19a417000000b0047915ef4dedmr6476478lfc.225.1655498211994;
        Fri, 17 Jun 2022 13:36:51 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id o1-20020a2e7301000000b00253bd515f88sm627825ljc.68.2022.06.17.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:36:51 -0700 (PDT)
Date:   Fri, 17 Jun 2022 23:36:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 19/23] ata: ahci: Add DWC AHCI SATA controller support
Message-ID: <20220617203649.wa2b3etx6gpm3s5g@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
 <6c02f8ef-8aea-8f80-590d-343f67a96f8d@infradead.org>
 <20220610215850.ju76kxjquwef6kd3@mobilestation>
 <73716f9f-892c-41c5-89f0-64a1985438aa@infradead.org>
 <20220615213029.3upsmasnnhigqozm@mobilestation>
 <bfaf0208-8416-c159-93f8-8cc31dbc7ef5@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfaf0208-8416-c159-93f8-8cc31dbc7ef5@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:31:30AM +0900, Damien Le Moal wrote:
> On 2022/06/16 6:30, Serge Semin wrote:
> > On Fri, Jun 10, 2022 at 04:34:13PM -0700, Randy Dunlap wrote:
> >> Hi Serge,
> >>
> >> On 6/10/22 14:58, Serge Semin wrote:
> >>> On Fri, Jun 10, 2022 at 09:34:46AM -0700, Randy Dunlap wrote:
> >>>> Hi--
> >>>
> >>> Hi Randy
> >>>
> >>>>
> >>>> On 6/10/22 01:17, Serge Semin wrote:
> >>>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> >>>>> index bb45a9c00514..95e0e022b5bb 100644
> >>>>> --- a/drivers/ata/Kconfig
> >>>>> +++ b/drivers/ata/Kconfig
> >>>>> @@ -176,6 +176,16 @@ config AHCI_DM816
> >>>>>  
> >>>>>  	  If unsure, say N.
> >>>>>  
> >>>>> +config AHCI_DWC
> >>>>> +	tristate "Synopsys DWC AHCI SATA support"
> >>>>> +	select SATA_HOST
> >>>>> +	default SATA_AHCI_PLATFORM
> >>>>
> >>>
> >>>> I don't think this needs to default to SATA_AHCI_PLATFORM.
> >>>> It might build a driver that isn't needed.
> >>>> And it's incompatible with "If unsure, say N."
> >>>
> >>> Basically you are right, but this particular setting is connected with
> >>> the modification I've done in the drivers/ata/ahci_platform.c driver
> >>> in the framework of this commit. I've moved the "snps,spear-ahci" and
> >>> "snps,dwc-ahci" compatible devices support to the new driver. Thus
> >>> should I omit the SATA_AHCI_PLATFORM dependency their default kernel
> >>> configs will lack the corresponding controllers support. If it's not a
> >>> problem and we can rely on the kernel build system ability to ask
> >>> whether the new config needs to be set/cleared, then I would be very
> >>> happy to drop the default setting. What do you think?
> >>
> > 
> >> I'd prefer to try it like that.
> >> If it becomes a problem, we can go back to this v4 patch.
> > 
> > Agreed then (seeing Damien is silent about your comment).
> 

> I have not thought about it :)
> I do not use SATA PLATFORM at all, so I am not familiar with its dependencies.
> Will have a look and do my usual build tests anyway.

Ok. I'll be waiting for you reply in this regard the before
re-submitting the next series version.

-Sergey

> 
> > 
> > -Sergey
> > 
> >>
> >>>>> +	help
> >>>>> +	  This option enables support for the Synopsys DWC AHCI SATA
> >>>>> +	  controller implementation.
> >>>>> +
> >>>>> +	  If unsure, say N.
> >>>>
> >>>> -- 
> >>>> ~Randy
> >>
> >> Thanks.
> >> -- 
> >> ~Randy
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
