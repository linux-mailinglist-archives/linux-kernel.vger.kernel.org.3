Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C280A529CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243814AbiEQIyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240734AbiEQIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:54:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2885C3D1DE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D1E7B817CA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBCCC385B8;
        Tue, 17 May 2022 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652777665;
        bh=vGqNEA3mJP04TZ99mkPuPdUYdn2xE37AGeZ05E/n764=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iixZ5UiAAr+bLKFBvILoVzPeqe44u28ygJ/iGHWGsWmT63JPqY54DBRZTiPbXTKDp
         4I59bSfRiVp4VrWsJY43IgOETMFH4dRooDl9+uUkTG+es8CdlEstsQigJeIk5hB1dQ
         Ab1KvFUoZEB1eZEkyBBKwMQ4Tdgp1fv4LfsbNdphndOcrXG+oXcJ8+KdRc03L4ah03
         BINoyD8uOCBRaDz2I3DEGEYr4gFvqKCW9hLVKqzEuMpdkTiCojrj5G3sx2IMFZ7FBp
         16KM0Ewr6Qsz1YBruKiG+2jJLo/L/RtSG3MSAOIIwT316WMFQiIO/gSmhjhxfiL78I
         vAbgy6ZkunonA==
Date:   Tue, 17 May 2022 09:54:18 +0100
From:   Will Deacon <will@kernel.org>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Juergen Gross <jgross@suse.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Murali Nalajala <quic_mnalajal@quicinc.com>
Subject: Re: [PATCH v3] arm64: paravirt: Use RCU read locks to guard
 stolen_time
Message-ID: <20220517085418.GA3169@willie-the-truck>
References: <20220513174654.362169-1-quic_eberman@quicinc.com>
 <c24e405e-b5f9-d2f7-a629-1ee1beab3681@csail.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c24e405e-b5f9-d2f7-a629-1ee1beab3681@csail.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 04:32:53PM -0700, Srivatsa S. Bhat wrote:
> On 5/13/22 10:46 AM, Elliot Berman wrote:
> > From: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> > 
> > During hotplug, the stolen time data structure is unmapped and memset.
> > There is a possibility of the timer IRQ being triggered before memset
> > and stolen time is getting updated as part of this timer IRQ handler. This
> > causes the below crash in timer handler -
> > 
> >   [ 3457.473139][    C5] Unable to handle kernel paging request at virtual address ffffffc03df05148
> >   ...
> >   [ 3458.154398][    C5] Call trace:
> >   [ 3458.157648][    C5]  para_steal_clock+0x30/0x50
> >   [ 3458.162319][    C5]  irqtime_account_process_tick+0x30/0x194
> >   [ 3458.168148][    C5]  account_process_tick+0x3c/0x280
> >   [ 3458.173274][    C5]  update_process_times+0x5c/0xf4
> >   [ 3458.178311][    C5]  tick_sched_timer+0x180/0x384
> >   [ 3458.183164][    C5]  __run_hrtimer+0x160/0x57c
> >   [ 3458.187744][    C5]  hrtimer_interrupt+0x258/0x684
> >   [ 3458.192698][    C5]  arch_timer_handler_virt+0x5c/0xa0
> >   [ 3458.198002][    C5]  handle_percpu_devid_irq+0xdc/0x414
> >   [ 3458.203385][    C5]  handle_domain_irq+0xa8/0x168
> >   [ 3458.208241][    C5]  gic_handle_irq.34493+0x54/0x244
> >   [ 3458.213359][    C5]  call_on_irq_stack+0x40/0x70
> >   [ 3458.218125][    C5]  do_interrupt_handler+0x60/0x9c
> >   [ 3458.223156][    C5]  el1_interrupt+0x34/0x64
> >   [ 3458.227560][    C5]  el1h_64_irq_handler+0x1c/0x2c
> >   [ 3458.232503][    C5]  el1h_64_irq+0x7c/0x80
> >   [ 3458.236736][    C5]  free_vmap_area_noflush+0x108/0x39c
> >   [ 3458.242126][    C5]  remove_vm_area+0xbc/0x118
> >   [ 3458.246714][    C5]  vm_remove_mappings+0x48/0x2a4
> >   [ 3458.251656][    C5]  __vunmap+0x154/0x278
> >   [ 3458.255796][    C5]  stolen_time_cpu_down_prepare+0xc0/0xd8
> >   [ 3458.261542][    C5]  cpuhp_invoke_callback+0x248/0xc34
> >   [ 3458.266842][    C5]  cpuhp_thread_fun+0x1c4/0x248
> >   [ 3458.271696][    C5]  smpboot_thread_fn+0x1b0/0x400
> >   [ 3458.276638][    C5]  kthread+0x17c/0x1e0
> >   [ 3458.280691][    C5]  ret_from_fork+0x10/0x20
> > 
> > As a fix, introduce rcu lock to update stolen time structure.
> > 
> > Suggested-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > ---
> 
> Looks good to me, but one quick question though (see below).
> 
> Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

Cheers.

> >  static int stolen_time_cpu_down_prepare(unsigned int cpu)
> >  {
> > +	struct pvclock_vcpu_stolen_time *kaddr = NULL;
> >  	struct pv_time_stolen_time_region *reg;
> >  
> >  	reg = this_cpu_ptr(&stolen_time_region);
> >  	if (!reg->kaddr)
> >  		return 0;
> >  
> > -	memunmap(reg->kaddr);
> > -	memset(reg, 0, sizeof(*reg));
> > +	kaddr = rcu_replace_pointer(reg->kaddr, NULL, true);
> > +	synchronize_rcu();
> > +	memunmap(kaddr);
> >  
> 
> The original code used to memset the stolen time region, but this
> patch seems to drop it. Was that change intentional?

'struct pv_time_stolen_time_region' only has one field ('kaddr'), which
we're now clearing with rcu_replace_pointer() so the memset doesn't make
sense.

Will
