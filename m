Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A49A573E47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiGMUyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbiGMUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBA79E0FB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657745635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7w7ot88ijPbnC1AT4LUHy9diGggomsBqgUbIEyfXDts=;
        b=aAqnKGzEGbfUFwFz3FD3AarShVeNFPstDmTQ2ajiCZl3AqGter+cFxwJ7/trAGCvYPTuQk
        MVDV/Ykt330koTSn6QvZ/brnyxmc6e9XlZtvM71YKPZjJ4hgQ9hGHYG+itLAj8hKoVG7gq
        FWN6MWNjzNmT226eFIwEzw5rXqLyn64=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-EoMCL5kLNRer3CF7dfIUOw-1; Wed, 13 Jul 2022 16:53:54 -0400
X-MC-Unique: EoMCL5kLNRer3CF7dfIUOw-1
Received: by mail-ed1-f69.google.com with SMTP id z14-20020a056402274e00b0043ae5c003c1so4774755edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7w7ot88ijPbnC1AT4LUHy9diGggomsBqgUbIEyfXDts=;
        b=IgTR59PAfmbnGhCk4a79cuZr3d6KGvZcDirI8n0+6jsnsqTZjxtWf6K8o8/Wgs4/6c
         TrfoUxfGvRkn2ezvYE7BUFg9/GeoX3WAiST+9x2CZS1f2SOHlFVQYlYWuO8y515WGFQE
         CiSz58C0SRvpFqjZWeHQIdJ31ziIAJvPCsyT9ZFecQwYL//lLescOBBXpFYqqi6vQz2k
         F/sNCGIOStQ0SZevub7QAh2FsVghx3T2ThBfjWKFdr/B0rlSunF7ew2U/ovyrSURrDiw
         sSLva1xRKOFaM1Vxq9PsiUn4LS0PbkP+F6WCf7KSA0XxKck89E2+DbC94/1W8qJprBeR
         4swA==
X-Gm-Message-State: AJIora9aw0rEIMksmhmNH01dZYkfXX9cH1N9qYjo5muDe0qP1wcbEG/n
        btu5QrfmwolhcMqOhgropcVN0EwHVWIuvPO36vhLHT6txV+W5ugDS5wYR4XbtOHWlgXionIS8b4
        2w+aqDJPVf2tZypkaqBBiViGz
X-Received: by 2002:a05:6402:3708:b0:433:2d3b:ed5 with SMTP id ek8-20020a056402370800b004332d3b0ed5mr7479260edb.246.1657745633676;
        Wed, 13 Jul 2022 13:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vlR6EbNyJesEQMqku98sgLM5hgx+Yvs+X+nBn4vuLAei8AgslBbSskvA81sVT/7Kgffh06BA==
X-Received: by 2002:a05:6402:3708:b0:433:2d3b:ed5 with SMTP id ek8-20020a056402370800b004332d3b0ed5mr7479238edb.246.1657745633446;
        Wed, 13 Jul 2022 13:53:53 -0700 (PDT)
Received: from redhat.com ([2.52.24.42])
        by smtp.gmail.com with ESMTPSA id s17-20020a056402037100b00437938c731fsm8578946edw.97.2022.07.13.13.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:53:52 -0700 (PDT)
Date:   Wed, 13 Jul 2022 16:53:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dapeng Mi <dapeng1.mi@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
Message-ID: <20220713165237-mutt-send-email-mst@kernel.org>
References: <20220713082426.850911-1-dapeng1.mi@intel.com>
 <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 07:53:13PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 13, 2022 at 10:21 AM Dapeng Mi <dapeng1.mi@intel.com> wrote:
> >
> > As long as Kconfig ACPI_PROCESSOR is enabled, ACPI_PROCESSOR would
> > select ACPI_PROCESSOR_IDLE and acpi_idle driver is enabled. But
> > in current driver loading order acpi_idle driver is always loaded
> > before cpuidle_haltpoll driver. This leads to cpuidle_hatpoll driver
> > has no chance to be loaded when it's enabled.
> >
> > Thus, move cpuidle driver forward before acpi driver and make
> > cpuidle-hatpoll driver has a chance to be run when it's enabled.
> >
> > Signed-off-by: Dapeng Mi <dapeng1.mi@intel.com>
> > ---
> >  drivers/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 9a30842b22c5..921ed481b520 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -26,6 +26,7 @@ obj-y                         += idle/
> >  # IPMI must come before ACPI in order to provide IPMI opregion support
> >  obj-y                          += char/ipmi/
> >
> > +obj-$(CONFIG_CPU_IDLE)         += cpuidle/
> >  obj-$(CONFIG_ACPI)             += acpi/
> >
> >  # PnP must come after ACPI since it will eventually need to check if acpi
> > @@ -126,7 +127,6 @@ obj-$(CONFIG_EDAC)          += edac/
> >  obj-$(CONFIG_EISA)             += eisa/
> >  obj-$(CONFIG_PM_OPP)           += opp/
> >  obj-$(CONFIG_CPU_FREQ)         += cpufreq/
> > -obj-$(CONFIG_CPU_IDLE)         += cpuidle/
> >  obj-y                          += mmc/
> >  obj-y                          += ufs/
> >  obj-$(CONFIG_MEMSTICK)         += memstick/
> > --
> 
> Well, this change doesn't guarantee loading haltpoll before ACPI idle.
> 
> Also what if haltpoll is enabled, but the user wants ACPI idle?

Exactly. For example while on real boxes BIOS might often present broken
ACPI idle, on VMs I am guessing if ACPI is present one can assume it's
actually correct.

-- 
MST

