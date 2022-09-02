Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B545AA86B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiIBG65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiIBG6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C5BBA7E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DAE162045
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7ECC433C1;
        Fri,  2 Sep 2022 06:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662101930;
        bh=EbCrk796rcIWl6oYp0x0apSH+wARfAzmCrDmoWXP5vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ioISn01lAH47kxusb/wvXPpGv1iIMIBgGSM800yecTNVRCzTGFRW0A+w0m+Kd0XsQ
         aUIj/OC88nHVDLfUAg35MMzl2ftwsCfYhJYUb8yUNdDbrKvQ0l//HvKqMdbdm9IZeL
         bUZbHMfMuWADGj372JYLEo4YnDG0BrDXf1J7GJwY=
Date:   Fri, 2 Sep 2022 08:58:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kuyo Chang <kuyo.chang@mediatek.com>
Cc:     major.chen@samsung.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, hongfei.tang@samsung.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] sched/debug: fix dentry leak in
 update_sched_domain_debugfs
Message-ID: <YxGpp/+lWSzwpVLZ@kroah.com>
References: <20220902031518.1116-1-kuyo.chang@mediatek.com>
 <YxGUBzp9C7kcNgps@kroah.com>
 <5ce45c874d6a05ca69abed3961d413c4a4360e79.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce45c874d6a05ca69abed3961d413c4a4360e79.camel@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 02:40:59PM +0800, Kuyo Chang wrote:
> On Fri, 2022-09-02 at 07:26 +0200, Greg Kroah-Hartman wrote:
> > On Fri, Sep 02, 2022 at 11:15:15AM +0800, Kuyo Chang wrote:
> > > From: kuyo chang <kuyo.chang@mediatek.com>
> > > 
> > > [Syndrome]
> > > Lowmemorykiller triggered while doing hotplug stress test as below
> > > cmd:
> > > echo [0/1] > /sys/devices/system/cpu/cpu${index}/online
> > > 
> > > Rootcause:
> > > Call trace of the slab owner & usage as below after hotplug stress
> > > test(4hr).
> > > There exists dentry leak at update_sched_domain_debugfs.
> > > 
> > > Total size : 322000KB
> > > <prep_new_page+44>:
> > > <get_page_from_freelist+672>:
> > > <__alloc_pages+304>:
> > > <allocate_slab+144>:
> > > <___slab_alloc+404>:
> > > <__slab_alloc+60>:
> > > <kmem_cache_alloc+1204>:
> > > <alloc_inode+100>:
> > > <new_inode+40>:
> > > <__debugfs_create_file+172>:
> > > <update_sched_domain_debugfs+824>:
> > > <partition_sched_domains_locked+1292>:
> > > <rebuild_sched_domains_locked+576>:
> > > <cpuset_hotplug_workfn+1052>:
> > > <process_one_work+584>:
> > > <worker_thread+1008>:
> > > 
> > > [Solution]
> > > Provided by Major Chen <major.chen@samsung.com> as below link.
> > > 
> https://lore.kernel.org/lkml/20220711030341epcms5p173848e98b13c09eb2fcdf2fd7287526a@epcms5p1/
> > > update_sched_domain_debugfs() uses debugfs_lookup() to find wanted
> > > dentry(which has
> > > been created by debugfs_create_dir() before), but not call dput()
> > > to return this dentry
> > > back. This result in dentry leak even debugfs_remove() is called.
> > > 
> > > [Test result]
> > > Using below commands to check inode_cache & dentry leak.
> > > cat /proc/slabinfo | grep -w inode_cache
> > > cat /proc/slabinfo | grep -w dentry
> > > 
> > > With the patch, the inode_cache & dentry stays consistent
> > > so the lowmemorykiller will not triggered anymore.
> > > 
> > > Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
> > > 
> > > Signed-off-by: Major Chen <major.chen@samsung.com>
> > > Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> > > Tested-by: kuyo chang <kuyo.chang@mediatek.com>
> > > 
> > > ---
> > >  kernel/sched/debug.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > > index bb3d63bdf4ae..4ffea2dc01da 100644
> > > --- a/kernel/sched/debug.c
> > > +++ b/kernel/sched/debug.c
> > > @@ -412,11 +412,14 @@ void update_sched_domain_debugfs(void)
> > >  
> > >  	for_each_cpu(cpu, sd_sysctl_cpus) {
> > >  		struct sched_domain *sd;
> > > -		struct dentry *d_cpu;
> > > +		struct dentry *d_cpu, *d_lookup;
> > >  		char buf[32];
> > >  
> > >  		snprintf(buf, sizeof(buf), "cpu%d", cpu);
> > > -		debugfs_remove(debugfs_lookup(buf, sd_dentry));
> > > +		d_lookup = debugfs_lookup(buf, sd_dentry);
> > > +		debugfs_remove(d_lookup);
> > > +		if (!IS_ERR_OR_NULL(d_lookup))
> > > +			dput(d_lookup);
> > 
> > That's odd, and means that something else is removing this file right
> > after we looked it up?  Is there a missing lock here that should be
> > used
> > instead?
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> While doing cpu hotlug, the cpu_active_mask is changed, 
> so it need to update_sched_domain_debugfs.
> 
> The original design is to recreate sd_dentry, so it doing
> debugfs_remove and then debugfs_create_dir.
> However, by debugfs_lookup function usage.
> The returned dentry must be passed to dput() when it is no longer
> needed to avoid dentry leak.

Eeeek, nice find!  I've been adding this pattern:
	debugfs_remove(debugfs_lookup(...));
all over the place, and as you point out, that's wrong!

It's as if I didn't even read the documentation I wrote.

{sigh}

Ok, as this is going to be a very common pattern, how about we create:
	debugfs_lookup_and_remove()
function that does the above logic all in one place and then we don't
have to put that logic everywhere in the kernel.  My goal is for users
of debugfs to never have to worry about anything about 'struct dentry'
at all, and I really failed that goal here in a major way.

I can work on that this afternoon after I get some other things done,
unless you want to do it now?

Again, very nice find, thank you for this.

greg k-h
