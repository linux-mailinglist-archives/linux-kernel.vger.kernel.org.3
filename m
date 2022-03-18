Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7EC4DDCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiCRP1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiCRP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7585B91A0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647617157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgcqHRxTmDCbGkiSAVOP1j9BkIjlIyVpT+jmLkaAADU=;
        b=cNV2o/LG+1LpZ5MTmmssHJBDtAQQ2GXeeVUdjQ0rUYy6WVqkIkTMaYYrxwVSmNVRWVtOtn
        MzxfjE3hV2YsVf7kUXDKj0yTO5mKkJD8ngq1D7BqotEHY4fgLLQR6V9CenuoODT2qdrkE7
        YQmad2lRCqTWlN6j5AuOH+Xds7fQFk8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-5F1U-UC8MgO2IfZR1lsAww-1; Fri, 18 Mar 2022 11:25:56 -0400
X-MC-Unique: 5F1U-UC8MgO2IfZR1lsAww-1
Received: by mail-il1-f199.google.com with SMTP id s7-20020a92cc07000000b002c7ca805128so4672556ilp.16
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=YgcqHRxTmDCbGkiSAVOP1j9BkIjlIyVpT+jmLkaAADU=;
        b=3PRFaEwD4iQ11GW+QoCOgZ89y8zeg87aRestSiqRY6attmAqHKKmZRZa6eDyQgvR/S
         HPob/xCtFwL9W4cQAZ4C2CWTmpaYIGcZkh1tbJRcJCeA1FfotQBR73pAs1g9ttKNlsi+
         ICM3jY7CZNXv77IHHD98euIRts7dtRRI/Weq3LKG7e28xv39y9dE2jjITl5s3Bi6wDeK
         sJZZ/S3hctsMHZ73XDOwIYWAE0y8tui9kfxycalPBgmmDdFEfcN04ACdzRtElW8IagcA
         GR2QsxbHi/tIlNVSzAD88VFmbl6kJ3o3JgbUppnSd5yDu2QVN6MNf4P1mhsJ2vlGPI97
         5n0A==
X-Gm-Message-State: AOAM530UvrjG2E08sHurFOopM6tWnooeVyyuaDAXw0ovONuyB6Bt+g8k
        V+mUQgQJCjcW8RJRIHQNBzR4wr3KjPMo2F+ebqcrPes/JdYj3OEJpq7Oye8e2KpOVfKMs2opMf9
        mrBJ9P7qUO9MfTJEjCqva1P+C
X-Received: by 2002:a5d:8714:0:b0:636:13bb:bc89 with SMTP id u20-20020a5d8714000000b0063613bbbc89mr4675379iom.126.1647617155690;
        Fri, 18 Mar 2022 08:25:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcyHxS7oTYC5euABr1WRzoAYAf/D3IPiqrWGqWvUPQt0yOjkh75RYfZwdgiryk5BgacuoZcA==
X-Received: by 2002:a5d:8714:0:b0:636:13bb:bc89 with SMTP id u20-20020a5d8714000000b0063613bbbc89mr4675361iom.126.1647617155387;
        Fri, 18 Mar 2022 08:25:55 -0700 (PDT)
Received: from redhat.com ([98.55.18.59])
        by smtp.gmail.com with ESMTPSA id 201-20020a6b14d2000000b00640df82a01csm4447795iou.3.2022.03.18.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 08:25:55 -0700 (PDT)
Date:   Fri, 18 Mar 2022 09:25:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        James Turner <linuxkernel.foss@dmarc-none.turner.link>,
        Xinhui Pan <Xinhui.Pan@amd.com>, regressions@lists.linux.dev,
        kvm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Lijo Lazar <lijo.lazar@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <Christian.Koenig@amd.com>
Subject: Re: [REGRESSION] Too-low frequency limit for AMD GPU
 PCI-passed-through to Windows VM
Message-ID: <20220318092552.518a50ef.alex.williamson@redhat.com>
In-Reply-To: <CADnq5_OE7JpffYggKsu92DAjur1CCSqZQ7LbMqcfmAk68FerDA@mail.gmail.com>
References: <87ee57c8fu.fsf@turner.link>
        <87sftfqwlx.fsf@dmarc-none.turner.link>
        <BYAPR12MB4614E2CFEDDDEAABBAB986A0975E9@BYAPR12MB4614.namprd12.prod.outlook.com>
        <87ee4wprsx.fsf@turner.link>
        <4b3ed7f6-d2b6-443c-970e-d963066ebfe3@amd.com>
        <87pmo8r6ob.fsf@turner.link>
        <5a68afe4-1e9e-c683-e06d-30afc2156f14@leemhuis.info>
        <CADnq5_MCKTLOfWKWvi94Q9-d5CGdWBoWVxEYL3YXOpMiPnLOyg@mail.gmail.com>
        <87pmnnpmh5.fsf@dmarc-none.turner.link>
        <CADnq5_NG_dQCYwqHM0umjTMg5Uud6zC4=MiscH91Y9v7mW9bJA@mail.gmail.com>
        <092b825a-10ff-e197-18a1-d3e3a097b0e3@leemhuis.info>
        <877d96to55.fsf@dmarc-none.turner.link>
        <87lexdw8gd.fsf@turner.link>
        <d541b534-8b83-b566-56eb-ea8baa7c998e@leemhuis.info>
        <40b3084a-11b8-0962-4b33-34b56d3a87a3@molgen.mpg.de>
        <bc714e87-d1dc-cdda-5a29-25820faaff40@leemhuis.info>
        <20220318084625.27d42a51.alex.williamson@redhat.com>
        <CADnq5_OE7JpffYggKsu92DAjur1CCSqZQ7LbMqcfmAk68FerDA@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 11:06:00 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> On Fri, Mar 18, 2022 at 10:46 AM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Fri, 18 Mar 2022 08:01:31 +0100
> > Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> >  
> > > On 18.03.22 06:43, Paul Menzel wrote:  
> > > >
> > > > Am 17.03.22 um 13:54 schrieb Thorsten Leemhuis:  
> > > >> On 13.03.22 19:33, James Turner wrote:  
> > > >>>  
> > > >>>> My understanding at this point is that the root problem is probably
> > > >>>> not in the Linux kernel but rather something else (e.g. the machine
> > > >>>> firmware or AMD Windows driver) and that the change in f9b7f3703ff9
> > > >>>> ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)") simply
> > > >>>> exposed the underlying problem.  
> > > >>
> > > >> FWIW: that in the end is irrelevant when it comes to the Linux kernel's
> > > >> 'no regressions' rule. For details see:
> > > >>
> > > >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/reporting-regressions.rst
> > > >>
> > > >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/process/handling-regressions.rst
> > > >>
> > > >>
> > > >> That being said: sometimes for the greater good it's better to not
> > > >> insist on that. And I guess that might be the case here.  
> > > >
> > > > But who decides that?  
> > >
> > > In the end afaics: Linus. But he can't watch each and every discussion,
> > > so it partly falls down to people discussing a regression, as they can
> > > always decide to get him involved in case they are unhappy with how a
> > > regression is handled. That obviously includes me in this case. I simply
> > > use my best judgement in such situations. I'm still undecided if that
> > > path is appropriate here, that's why I wrote above to see what James
> > > would say, as he afaics was the only one that reported this regression.
> > >  
> > > > Running stuff in a virtual machine is not that uncommon.  
> > >
> > > No, it's about passing through a GPU to a VM, which is a lot less common
> > > -- and afaics an area where blacklisting GPUs on the host to pass them
> > > through is not uncommon (a quick internet search confirmed that, but I
> > > might be wrong there).  
> >
> > Right, interference from host drivers and pre-boot environments is
> > always a concern with GPU assignment in particular.  AMD GPUs have a
> > long history of poor behavior relative to things like PCI secondary bus
> > resets which we use to try to get devices to clean, reusable states for
> > assignment.  Here a device is being bound to a host driver that
> > initiates some sort of power control, unbound from that driver and
> > exposed to new drivers far beyond the scope of the kernel's regression
> > policy.  Perhaps it's possible to undo such power control when
> > unbinding the device, but it's not necessarily a given that such a
> > thing is possible for this device without a cold reset.
> >
> > IMO, it's not fair to restrict the kernel from such advancements.  If
> > the use case is within a VM, don't bind host drivers.  It's difficult
> > to make promises when dynamically switching between host and userspace
> > drivers for devices that don't have functional reset mechanisms.
> > Thanks,  
> 
> Additionally, operating the isolated device in a VM on a constrained
> environment like a laptop may have other adverse side effects.  The
> driver in the guest would ideally know that this is a laptop and needs
> to properly interact with APCI to handle power management on the
> device.  If that is not the case, the driver in the guest may end up
> running the device out of spec with what the platform supports.  It's
> also likely to break suspend and resume, especially on systems which
> use S0ix since the firmware will generally only turn off certain power
> rails if all of the devices on the rails have been put into the proper
> state.  That state may vary depending on the platform requirements.

Good point, devices with platform dependencies to manage thermal
budgets, etc. should be considered "use at your own risk" relative to
device assignment currently.  Thanks,

Alex

