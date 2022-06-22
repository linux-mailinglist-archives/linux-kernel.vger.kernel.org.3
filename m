Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC7554EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358978AbiFVPFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358934AbiFVPFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 978E23EA9E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655910340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jndzfVF++R7TsK3TV+yk+0zpm8yMa0Qnb1v8H83vdVo=;
        b=H0cdfvo8huFhRnoSl9tTIo+ev6YZEsVj3/QUMxHLNP+Mo/YHyIPPpuZoKVL7nOgS+7ygZL
        iGjPU238ZJuCxvtUEr3UIMeDMry1T/rHfJI44B4FrguG6hu36NPSs0X+HtEzsYm2Q4Z8nr
        5Rixfm9t1UD+nebvl2v106rNOtvgmaA=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-4ro_6ZUQPzKLcCf9ta8v8w-1; Wed, 22 Jun 2022 11:05:39 -0400
X-MC-Unique: 4ro_6ZUQPzKLcCf9ta8v8w-1
Received: by mail-vk1-f200.google.com with SMTP id p185-20020a1fd8c2000000b0036c453f2ea4so1264709vkg.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jndzfVF++R7TsK3TV+yk+0zpm8yMa0Qnb1v8H83vdVo=;
        b=1yGCjGR2+7nVMpDgC434mWFOYp3bJWd9S/hU0NL02mqv5G8bczJDCvK4/FTqbAZv6C
         4xGZjp08bCqfxgb/4DHwHnpKjGOBY3Vsiz2/quwiHQl5NjycM7KaucQbkRe6NQAF0aW8
         bJh5jUDo2Pc1CrKfewZnEBFGD10IM8anC8FavYOY3umG3Ez3s6tHYCDREc5uMf0eZw6m
         HMSJmDdrc6LbVRByXd9ACZ54e6V/wzWGKxqy5NLZrvon1nqx2musPQ2tBMVr20Xjp9QS
         pcBi8AAvkOrUigljAZPq48P14kP72ncVQEY8LJYMPHMsptzhRBgx+oJe1I1CxEtu0V8r
         7jbA==
X-Gm-Message-State: AJIora/88qSxOoOfK+3TcQp2VagFcR6YcM/xf4hOFGSfOP0G0frWm+mm
        v+thZxMpZZQrrTl53adggRQ3ChLtudDdK59bWgbq9VyIUsBWKBKWOGnYLtKp/jJcWIk6uiUj/AG
        FXxf7SVCJvOGyFVJkPE5CU2DLOFew2kRi6TtpKDvd
X-Received: by 2002:a67:ba09:0:b0:354:5d45:67ed with SMTP id l9-20020a67ba09000000b003545d4567edmr1745709vsn.18.1655910338974;
        Wed, 22 Jun 2022 08:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uCzYxtP8zvgG7hdrhhklfXqLiR9sESzuYsH1TCnGyeEZJ57pWTrteDT6pEJcJyySZ/ZdON06zXfSc9hwQVjtU=
X-Received: by 2002:a67:ba09:0:b0:354:5d45:67ed with SMTP id
 l9-20020a67ba09000000b003545d4567edmr1745672vsn.18.1655910338758; Wed, 22 Jun
 2022 08:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com> <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
In-Reply-To: <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Wed, 22 Jun 2022 08:05:12 -0700
Message-ID: <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 7:52 AM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2022/6/16 02:36, Steve Wahl wrote:
> > To support up to 64 sockets with 10 DMAR units each (640), make the
> > value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> > CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> > set.
> >
> > If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> > to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> > allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> > remapping doesn't support X2APIC mode x2apic disabled"; and the system
> > fails to boot properly.
> >
> > Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> > Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> > ---
> >
> > Note that we could not find a reason for connecting
> > DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> > it seemed like the two would continue to match on earlier processors.
> > There doesn't appear to be kernel code that assumes that the value of
> > one is related to the other.
> >
> > v2: Make this value a config option, rather than a fixed constant.  The default
> > values should match previous configuration except in the MAXSMP case.  Keeping the
> > value at a power of two was requested by Kevin Tian.
> >
> > v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.
> >
> >   drivers/iommu/intel/Kconfig | 7 +++++++
> >   include/linux/dmar.h        | 6 +-----
> >   2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > index 39a06d245f12..07aaebcb581d 100644
> > --- a/drivers/iommu/intel/Kconfig
> > +++ b/drivers/iommu/intel/Kconfig
> > @@ -9,6 +9,13 @@ config DMAR_PERF
> >   config DMAR_DEBUG
> >       bool
> >
> > +config DMAR_UNITS_SUPPORTED
> > +     int "Number of DMA Remapping Units supported"
> > +     depends on DMAR_TABLE
> > +     default 1024 if MAXSMP
> > +     default 128  if X86_64
> > +     default 64
>
> With this patch applied, the IOMMU configuration looks like:
>
> [*]   AMD IOMMU support
> <M>     AMD IOMMU Version 2 driver
> [*]     Enable AMD IOMMU internals in DebugFS
> (1024) Number of DMA Remapping Units supported   <<<< NEW
> [*]   Support for Intel IOMMU using DMA Remapping Devices
> [*]     Export Intel IOMMU internals in Debugfs
> [*]     Support for Shared Virtual Memory with Intel IOMMU
> [*]     Enable Intel DMA Remapping Devices by default
> [*]     Enable Intel IOMMU scalable mode by default
> [*]   Support for Interrupt Remapping
> [*]   OMAP IOMMU Support
> [*]     Export OMAP IOMMU internals in DebugFS
> [*]   Rockchip IOMMU Support
>
> The NEW item looks confusing. It looks to be a generic configurable
> value though it's actually Intel DMAR specific. Any thoughts?
>
> Best regards,
> baolu
>

Would moving it under INTEL_IOMMU at least have it show up below
"Support for Intel IOMMU using DMA Remapping Devices"? I'm not sure it
can be better than that, because IRQ_REMAP selects DMAR_TABLE, so we
can't stick it in the if INTEL_IOMMU section.

Regards,
Jerry

