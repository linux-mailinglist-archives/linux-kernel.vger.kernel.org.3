Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CAA4EC94C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348582AbiC3QJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiC3QJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D56723D760
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648656480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NI8QrfZLscN2JjuLOs2lOv/NiQshgCTnf9s4dBqvuvY=;
        b=QFFIA+CWMAqFy9S0zTCOPr7UmFZ+NbHt4TOKoMeS+PYJ9rWdhi2RAWR3G6CPcLi4puK2qn
        Bcu0Os4AbXzdJH+KOG9gP1E/QN9CcGQ3Kpx1eLQQSpybl0u1h9d3OANGVyBbJW/XQeNShC
        UNczGlqYB66LXx0e23UvgEVAPw3gGzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-oWzPjiWbMviNabh8l__c2A-1; Wed, 30 Mar 2022 12:07:55 -0400
X-MC-Unique: oWzPjiWbMviNabh8l__c2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EA2680352D;
        Wed, 30 Mar 2022 16:07:55 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BB39C202CA;
        Wed, 30 Mar 2022 16:07:55 +0000 (UTC)
Date:   Wed, 30 Mar 2022 12:07:53 -0400
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
Message-ID: <20220330160753.GA17246@pauld.bos.csb>
References: <20220322160304.26229-1-pauld@redhat.com>
 <1a546197-872b-7762-68ac-d5e6bb6d19aa@arm.com>
 <YkMjqfBSyT3NOrWB@lorien.usersys.redhat.com>
 <5a5381cd-813d-7cef-9948-01c3e5e910ef@arm.com>
 <YkNjGOtG6eb4N8mI@lorien.usersys.redhat.com>
 <5dc3a40e-f071-3ac8-4bf0-f555b9d94ff1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc3a40e-f071-3ac8-4bf0-f555b9d94ff1@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 05:48:34PM +0200 Dietmar Eggemann wrote:
> On 29/03/2022 21:50, Phil Auld wrote:
> > On Tue, Mar 29, 2022 at 08:55:08PM +0200 Dietmar Eggemann wrote:
> >> On 29/03/2022 17:20, Phil Auld wrote:
> >>> On Tue, Mar 29, 2022 at 04:02:22PM +0200 Dietmar Eggemann wrote:
> >>>> On 22/03/2022 17:03, Phil Auld wrote:
> 
> [...]
> 
> >>> This instance is an HPE Apollo 70 set to smt-4.  I believe it's ThunderX2
> >>> chips.
> >>>
> >>> ARM (CN9980-2200LG4077-Y21-G) 
> >> I'm using the same processor just with ACPI/PPTT.
> >>
> > 
> > Maybe I'm misinformed about these systems having no PPTT...  
> > 
> > I'm reclaiming the system. Is there a way I can tell from userspace?
> 
> # cat /sys/firmware/acpi/tables/PPTT > pptt.dat
> # iasl -d pptt.dat
> # vim pptt.dsl
> 

I don't have iasl but 

# strings pptt.dat 
PPTT
ServerCL
 CAVM


So that looks like it has a PPTT entry.  


Cheers,
Phil


> [...]
> 
> >> so no SMT sched domain. The MPIDR-based topology fallback code in
> >> store_cpu_topology() forces `cpuid_topo->thread_id  = -1`.
> > 
> > Right. So since I'm getting SMT it must not have package_id == -1.
> > In which case you should be able to reproduce it because it must
> > be that the call the update_siblings_masks() is required.  That
> > appears to only be called from store_cpu_topology() which is
> > after the scheduler has already setup the core pointers.
> > 
> > The fix could be the same but I should reword the commit message
> > since it should effect all SMT arm systems I'd think.
> > 
> > Or maybe the ACPI topology code should call update_sibling_masks(). 
> >>
> >> IMHO this is why on my machine I don't see this issue while running:
> >>
> >> root@oss-apollo7007:~# stress-ng --prctl 256 -t 60
> >> stress-ng: info:  [2388042] dispatching hogs: 256 prctl
> >>
> >> Is there something I miss in my setup to provoke this issue?
> >>
> > 
> > Make sure you have a stress-ng that is new enough and built against
> > headers that have the CORE_SCHED prctls defined.
> 
> Ah, I was using a pretty old version 0.11.07. Now I switched to 0.13.12
> which includes:
> 
>   9038e442b92d - stress-prctl: add Linux 5.14 PR_SCHED_CORE prctl
> 
> To get SCHED_CORE activated in stress-prctl.c, as a quick hack, I had to
> add the definitions of PR_SCHED_CORE, PR_SCHED_CORE_GET, etc. to this file.
> 
> Now the issue you described triggers on this machine immediately.
> 

-- 

