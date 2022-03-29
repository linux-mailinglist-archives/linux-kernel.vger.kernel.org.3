Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F24EB017
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbiC2PWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiC2PWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05FC97CB02
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648567215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OLZFkHPd84+mMxkqVvITeO3JzREE8dZrviAJPbx3+4I=;
        b=AXq1IUaNJxTCUm5PrXXl/AxbxZYRPmQFblPyyvIQQIT/t+PwYuCvyfx+XNW3SWaAXyg39e
        6rJzDVDDM9bQ3w0PqESPWio3/+8Kn0WayVRX2kxAaJhNrwCYQpt1hQZxe8o134JzYYdZJL
        a5oLBSfMT6RHJbyrYaKKwY4fG3GEw84=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-W1OjL56oN_2guaUe-84Avw-1; Tue, 29 Mar 2022 11:20:12 -0400
X-MC-Unique: W1OjL56oN_2guaUe-84Avw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78BC2296A62D;
        Tue, 29 Mar 2022 15:20:11 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30A34400F24;
        Tue, 29 Mar 2022 15:20:11 +0000 (UTC)
Date:   Tue, 29 Mar 2022 11:20:09 -0400
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
Message-ID: <YkMjqfBSyT3NOrWB@lorien.usersys.redhat.com>
References: <20220322160304.26229-1-pauld@redhat.com>
 <1a546197-872b-7762-68ac-d5e6bb6d19aa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a546197-872b-7762-68ac-d5e6bb6d19aa@arm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 04:02:22PM +0200 Dietmar Eggemann wrote:
> On 22/03/2022 17:03, Phil Auld wrote:
> > Some arm64 rely on store_cpu_topology() to setup the real topology.
> > This needs to be done before the call to notify_cpu_starting() which
> > tell the scheduler about the cpu otherwise the core scheduling data
> > structures are setup in a way that does not match the actual topology.
> > 
> > Without this change stress-ng (which enables core scheduling in its prctl 
> > tests) causes a warning and then a crash (trimmed for legibility):
> > 
> > [ 1853.805168] ------------[ cut here ]------------
> > [ 1853.809784] task_rq(b)->core != rq->core
> > [ 1853.809792] WARNING: CPU: 117 PID: 0 at kernel/sched/fair.c:11102 cfs_prio_less+0x1b4/0x1c4
> > ...
> > [ 1854.015210] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> > ...
> > [ 1854.231256] Call trace:
> > [ 1854.233689]  pick_next_task+0x3dc/0x81c
> > [ 1854.237512]  __schedule+0x10c/0x4cc
> > [ 1854.240988]  schedule_idle+0x34/0x54
> > 
> > Fixes: 9edeaea1bc45 ("sched: Core-wide rq->lock")
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > ---
> > This is a similar issue to 
> >   f2703def339c ("MIPS: smp: fill in sibling and core maps earlier") 
> > which fixed it for MIPS.
> 
> I assume this is for a machine which relies on MPIDR-based setup
> (package_id == -1)? I.e. it doesn't have proper ACPI/(DT) data for
> topology setup.

Yes, that's my understanding. No PPTT.

> 
> Tried on a ThunderX2 by disabling parse_acpi_topology() but then I end
> up with a machine w/o SMT, so `stress-ng --prctl N` doesn't show this issue.
>
> Which machine were you using?

This instance is an HPE Apollo 70 set to smt-4.  I believe it's ThunderX2
chips.

ARM (CN9980-2200LG4077-Y21-G) 


Thanks,
Phil

> 
> >  arch/arm64/kernel/smp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 27df5c1e6baa..3b46041f2b97 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -234,6 +234,7 @@ asmlinkage notrace void secondary_start_kernel(void)
> >  	 * Log the CPU info before it is marked online and might get read.
> >  	 */
> >  	cpuinfo_store_cpu();
> > +	store_cpu_topology(cpu);
> >  
> >  	/*
> >  	 * Enable GIC and timers.
> > @@ -242,7 +243,6 @@ asmlinkage notrace void secondary_start_kernel(void)
> >  
> >  	ipi_setup(cpu);
> >  
> > -	store_cpu_topology(cpu);
> >  	numa_add_cpu(cpu);
> >  
> >  	/*
> 

-- 

