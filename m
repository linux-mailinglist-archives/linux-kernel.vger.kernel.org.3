Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4A84EB44D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbiC2Twq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiC2Twj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53DC618B25D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648583454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMHVx+pB9tah50DD606tJEjOnhTtHzPvegXbqsW7veU=;
        b=YfBRRlSPt9hHeN7mPgu74imovO31o9BMxophFZPgpcezD36/8itdN8ef2JXXOeRvJDjdDn
        aEg0msnmkc+40Vj83kxk5wT+vJ9VEMTtdCxpvJ4j5Q5YDWszMLeLrpqWkI19km+wOlpIt3
        UqwPR4keFgDbPr2wQkfjZbdU0zse7M4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-wsmEjG4qMViHPx8jGylg4A-1; Tue, 29 Mar 2022 15:50:50 -0400
X-MC-Unique: wsmEjG4qMViHPx8jGylg4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5DD185A5A8;
        Tue, 29 Mar 2022 19:50:49 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B9EC1121314;
        Tue, 29 Mar 2022 19:50:49 +0000 (UTC)
Date:   Tue, 29 Mar 2022 15:50:48 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arch/arm64: Fix topology initialization for core
 scheduling
Message-ID: <YkNjGOtG6eb4N8mI@lorien.usersys.redhat.com>
References: <20220322160304.26229-1-pauld@redhat.com>
 <1a546197-872b-7762-68ac-d5e6bb6d19aa@arm.com>
 <YkMjqfBSyT3NOrWB@lorien.usersys.redhat.com>
 <5a5381cd-813d-7cef-9948-01c3e5e910ef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5381cd-813d-7cef-9948-01c3e5e910ef@arm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 08:55:08PM +0200 Dietmar Eggemann wrote:
> On 29/03/2022 17:20, Phil Auld wrote:
> > On Tue, Mar 29, 2022 at 04:02:22PM +0200 Dietmar Eggemann wrote:
> >> On 22/03/2022 17:03, Phil Auld wrote:
> 
> [...]
> 
> >> I assume this is for a machine which relies on MPIDR-based setup
> >> (package_id == -1)? I.e. it doesn't have proper ACPI/(DT) data for
> >> topology setup.
> > 
> > Yes, that's my understanding. No PPTT.
> > 
> >>
> >> Tried on a ThunderX2 by disabling parse_acpi_topology() but then I end
> >> up with a machine w/o SMT, so `stress-ng --prctl N` doesn't show this issue.
> >>
> >> Which machine were you using?
> > 
> > This instance is an HPE Apollo 70 set to smt-4.  I believe it's ThunderX2
> > chips.
> > 
> > ARM (CN9980-2200LG4077-Y21-G) 
> I'm using the same processor just with ACPI/PPTT.
>

Maybe I'm misinformed about these systems having no PPTT...  

I'm reclaiming the system. Is there a way I can tell from userspace?


> # sudo dmidecode -t 4 | grep "Part Number"
> 	Part Number: CN9980-2200LG4077-21-Y-G
> 	Part Number: CN9980-2200LG4077-21-Y-G
> 
> # cat /sys/devices/system/cpu/cpu0/topology/thread_siblings
> 0,32,64,96
> 
> # cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
> SMT
> MC
> NUMA
> 
> But no matter whether I disable parse_acpi_topology() or just force
> `cpu_topology[cpu].package_id = -1` in this function, I always end up with:
> 
> # cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
> MC
> NUMA
> 
> # cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list
> 0
> 
> so no SMT sched domain. The MPIDR-based topology fallback code in
> store_cpu_topology() forces `cpuid_topo->thread_id  = -1`.

Right. So since I'm getting SMT it must not have package_id == -1.
In which case you should be able to reproduce it because it must
be that the call the update_siblings_masks() is required.  That
appears to only be called from store_cpu_topology() which is
after the scheduler has already setup the core pointers.

The fix could be the same but I should reword the commit message
since it should effect all SMT arm systems I'd think.

Or maybe the ACPI topology code should call update_sibling_masks().


> 
> IMHO this is why on my machine I don't see this issue while running:
> 
> root@oss-apollo7007:~# stress-ng --prctl 256 -t 60
> stress-ng: info:  [2388042] dispatching hogs: 256 prctl
> 
> Is there something I miss in my setup to provoke this issue?
>

Make sure you have a stress-ng that is new enough and built against
headers that have the CORE_SCHED prctls defined.


BTW, thanks for taking a look.


Cheers,
Phil

> [...]
> 

-- 

