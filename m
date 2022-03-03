Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072F54CBD5B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiCCMJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiCCMJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:09:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E3A014867B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646309315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FVo3ViTZUW6ofnwoe9MTRIS/HG/vD2Qlpvy0+GMEH0=;
        b=P+6bMkRrpfpWY7cAdD4In/p3cmNa1Xvi92P+RA8bu9DSYhBg4+lgy4OGd3SwfIv036Zkiz
        a9YyDf0cjqcEeTab98uxJXA7GpuR39URb/OXJLlu0famKogJg2uyRgIWRn6DjSQwsE6SD3
        uqmKyrmnPCII7KMsF9qev2ePfWi7tec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-yfodNQ-FPXiNnjgREpipoQ-1; Thu, 03 Mar 2022 07:08:32 -0500
X-MC-Unique: yfodNQ-FPXiNnjgREpipoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C8391006AA8;
        Thu,  3 Mar 2022 12:08:30 +0000 (UTC)
Received: from localhost (ovpn-13-148.pek2.redhat.com [10.72.13.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDF19838C5;
        Thu,  3 Mar 2022 12:08:04 +0000 (UTC)
Date:   Thu, 3 Mar 2022 20:08:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 02/10] crash hp: Introduce CRASH_HOTPLUG configuration
 options
Message-ID: <YiCvomsNsTrx0dhR@MiWiFi-R3L-srv>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-3-eric.devolder@oracle.com>
 <YhWpF/Cj/V+Cx6+d@MiWiFi-R3L-srv>
 <10d67f14-c5fe-0a17-e8b5-97702823cc1c@oracle.com>
 <f23efdc0-20c8-ccfd-f54d-69a9b4ee531f@redhat.com>
 <YiCW8gEb3n1CpI6x@MiWiFi-R3L-srv>
 <5b0a9bac-cd00-35df-8e55-44624729015f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0a9bac-cd00-35df-8e55-44624729015f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/22 at 12:36pm, David Hildenbrand wrote:
> On 03.03.22 11:22, Baoquan He wrote:
> > On 03/02/22 at 10:20am, David Hildenbrand wrote:
> >> On 01.03.22 21:04, Eric DeVolder wrote:
> >>>
> >>>
> >>> On 2/22/22 21:25, Baoquan He wrote:
> >>>> On 02/09/22 at 02:56pm, Eric DeVolder wrote:
> >>>>> Support for CPU and memory hotplug for crash is controlled by the
> >>>>> CRASH_HOTPLUG configuration option, introduced by this patch.
> >>>>>
> >>>>> The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
> >>>>> also introduced with this patch.
> >>>>>
> >>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> >>>>> ---
> >>>>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
> >>>>>   1 file changed, 26 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >>>>> index ebe8fc76949a..4e3374edab02 100644
> >>>>> --- a/arch/x86/Kconfig
> >>>>> +++ b/arch/x86/Kconfig
> >>>>> @@ -2060,6 +2060,32 @@ config CRASH_DUMP
> >>>>>   	  (CONFIG_RELOCATABLE=y).
> >>>>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
> >>>>>   
> >>>>> +config CRASH_HOTPLUG
> >>>>> +	bool "kernel updates of crash elfcorehdr"
> >>>>> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
> >>>>> +	help
> >>>>> +	  Enable the kernel to update the crash elfcorehdr (which contains
> >>>>> +	  the list of CPUs and memory regions) directly when hot plug/unplug
> >>>>> +	  of CPUs or memory. Otherwise userspace must monitor these hot
> >>>>> +	  plug/unplug change notifications via udev in order to
> >>>>> +	  unload-then-reload the crash kernel so that the list of CPUs and
> >>>>> +	  memory regions is kept up-to-date. Note that the udev CPU and
> >>>>> +	  memory change notifications still occur (however, userspace is not
> >>>>> +	  required to monitor for crash dump purposes).
> >>>>> +
> >>>>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
> >>>>> +	depends on CRASH_HOTPLUG
> >>>>> +	int
> >>>>> +	default 131072
> >>>>> +	help
> >>>>> +	  Specify the maximum size of the elfcorehdr buffer/segment.
> >>>>> +	  The 128KiB default is sized so that it can accommodate 2048
> >>>>> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
> >>>>> +	  region of memory.
> >>>>> +	  For example, this size can accommodate hotplugging a machine
> >>>>> +	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
> >>>>> +	  with 1024 1GiB memory DIMMs).
> >>>>
> >>>> This example of memory could be a little misleading. The memory regions
> >>>> may not be related to memory DIMMs. System could split them into many
> >>>> smaller regions during bootup.
> >>>
> >>> I changed "with 1024 1GiB memory DIMMs" to "with 1024 1GiB hotplug memories".
> >>> eric
> >>
> >> It's still not quite precise. Essentially it's the individual "System
> >> RAM" entries in /proc/iomem
> >>
> >> Boot memory (i.e., a single DIMM) might be represented by multiple
> >> entries due to rearranged holes (by the BIOS).
> >>
> >> While hoplugged DIMMs (under virt!) are usually represented using a
> >> single range, it can be different on physical machines. Last but not
> >> least, dax/kmem and virtio-mem behave in a different way.
> > 
> > Right. How about only mentioning the 'System RAM' entries in /proc/iomem
> > as below? It's just giving an example, talking about the details of
> > memory regions from each type may not be necessry here. People
> > interested can refer to code or document related to get it.
> > 
> > 
> > + default 131072
> > + help
> > +   Specify the maximum size of the elfcorehdr buffer/segment.
> > +   The 128KiB default is sized so that it can accommodate 2048
> > +   Elf64_Phdr, where each Phdr represents either a CPU or a
> > +   region of memory.
> > +   For example, this size can accommodate hotplugging a machine
> > +   with up to 1024 CPUs and up to 1024 memory regions which are
> >     represented by 'System RAM' entries in /proc/iomem.
> 
> Maybe changing the last paragraph to:
> 
> "For example, this size can accommodate a machine with up to 1024 CPUs
> and up to 1024 memory regions, for example, as represented by 'System
> RAM' entries in /proc/iomem."

Yeah, this looks good. Can the 2nd 'for example' be removed or replaced
with 'e.g'? Please ignore it if it's normal to have two 'for example' in
one sentence, just gentlely ask.

