Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65F15AACBE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiIBKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIBKrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:47:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74CDBD4D9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:47:25 -0700 (PDT)
X-UUID: 6db3584d56ed4ffdb3f7d5d147f1e2a9-20220902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ystxL6pMmDZFW2oA6gSJwS1ksWBAoar/81XZlM0jgkg=;
        b=ZSIk8RGdJr6QFaOblc1vGslFd5j9HylS8+ft8Nw0T4sSexpOFQEnHbSZ4y8xyOUjscG+x4sl+A+E8mvoRAaVNuJvfi7GzYH61yxp990nz/iKmS14nn0xbksuLXJOV6XPYErMMKOb9p61v5vpUdqlvPCjV5hsceKC5qPn4qhkhF8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:1bbaf81a-7ffa-4582-9732-71f80de8af69,OB:0,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:51
X-CID-INFO: VERSION:1.1.10,REQID:1bbaf81a-7ffa-4582-9732-71f80de8af69,OB:0,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:51
X-CID-META: VersionHash:84eae18,CLOUDID:680075d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:fd12fd4c9141,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 6db3584d56ed4ffdb3f7d5d147f1e2a9-20220902
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 828968842; Fri, 02 Sep 2022 18:47:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 2 Sep 2022 18:47:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 2 Sep 2022 18:47:18 +0800
Message-ID: <d893a66ee388f2f2f03e1e903efe84e85475a673.camel@mediatek.com>
Subject: Re: [PATCH 1/1] sched/debug: fix dentry leak in
 update_sched_domain_debugfs
From:   Kuyo Chang <kuyo.chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <major.chen@samsung.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <wsd_upstream@mediatek.com>, <hongfei.tang@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 2 Sep 2022 18:47:18 +0800
In-Reply-To: <YxHI2sRgF2gqYcHk@kroah.com>
References: <20220902031518.1116-1-kuyo.chang@mediatek.com>
         <YxGUBzp9C7kcNgps@kroah.com>
         <5ce45c874d6a05ca69abed3961d413c4a4360e79.camel@mediatek.com>
         <YxGpp/+lWSzwpVLZ@kroah.com>
         <f14e71182ebf1520aeede06afb44af49ec6128a0.camel@mediatek.com>
         <YxHI2sRgF2gqYcHk@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-02 at 11:11 +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 02, 2022 at 03:36:08PM +0800, Kuyo Chang wrote:
> > On Fri, 2022-09-02 at 08:58 +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Sep 02, 2022 at 02:40:59PM +0800, Kuyo Chang wrote:
> > > > On Fri, 2022-09-02 at 07:26 +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Sep 02, 2022 at 11:15:15AM +0800, Kuyo Chang wrote:
> > > > > > From: kuyo chang <kuyo.chang@mediatek.com>
> > > > > > 
> > > > > > [Syndrome]
> > > > > > Lowmemorykiller triggered while doing hotplug stress test
> > > > > > as
> > > > > > below
> > > > > > cmd:
> > > > > > echo [0/1] > /sys/devices/system/cpu/cpu${index}/online
> > > > > > 
> > > > > > Rootcause:
> > > > > > Call trace of the slab owner & usage as below after hotplug
> > > > > > stress
> > > > > > test(4hr).
> > > > > > There exists dentry leak at update_sched_domain_debugfs.
> > > > > > 
> > > > > > Total size : 322000KB
> > > > > > <prep_new_page+44>:
> > > > > > <get_page_from_freelist+672>:
> > > > > > <__alloc_pages+304>:
> > > > > > <allocate_slab+144>:
> > > > > > <___slab_alloc+404>:
> > > > > > <__slab_alloc+60>:
> > > > > > <kmem_cache_alloc+1204>:
> > > > > > <alloc_inode+100>:
> > > > > > <new_inode+40>:
> > > > > > <__debugfs_create_file+172>:
> > > > > > <update_sched_domain_debugfs+824>:
> > > > > > <partition_sched_domains_locked+1292>:
> > > > > > <rebuild_sched_domains_locked+576>:
> > > > > > <cpuset_hotplug_workfn+1052>:
> > > > > > <process_one_work+584>:
> > > > > > <worker_thread+1008>:
> > > > > > 
> > > > > > [Solution]
> > > > > > Provided by Major Chen <major.chen@samsung.com> as below
> > > > > > link.
> > > > > > 
> > > > 
> > > > 
> > 
> > 
https://lore.kernel.org/lkml/20220711030341epcms5p173848e98b13c09eb2fcdf2fd7287526a@epcms5p1/
> > > > > > update_sched_domain_debugfs() uses debugfs_lookup() to find
> > > > > > wanted
> > > > > > dentry(which has
> > > > > > been created by debugfs_create_dir() before), but not call
> > > > > > dput()
> > > > > > to return this dentry
> > > > > > back. This result in dentry leak even debugfs_remove() is
> > > > > > called.
> > > > > > 
> > > > > > [Test result]
> > > > > > Using below commands to check inode_cache & dentry leak.
> > > > > > cat /proc/slabinfo | grep -w inode_cache
> > > > > > cat /proc/slabinfo | grep -w dentry
> > > > > > 
> > > > > > With the patch, the inode_cache & dentry stays consistent
> > > > > > so the lowmemorykiller will not triggered anymore.
> > > > > > 
> > > > > > Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to
> > > > > > debugfs")
> > > > > > 
> > > > > > Signed-off-by: Major Chen <major.chen@samsung.com>
> > > > > > Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> > > > > > Tested-by: kuyo chang <kuyo.chang@mediatek.com>
> > > > > > 
> > > > > > ---
> > > > > >  kernel/sched/debug.c | 7 +++++--
> > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > > > > > index bb3d63bdf4ae..4ffea2dc01da 100644
> > > > > > --- a/kernel/sched/debug.c
> > > > > > +++ b/kernel/sched/debug.c
> > > > > > @@ -412,11 +412,14 @@ void
> > > > > > update_sched_domain_debugfs(void)
> > > > > >  
> > > > > >  	for_each_cpu(cpu, sd_sysctl_cpus) {
> > > > > >  		struct sched_domain *sd;
> > > > > > -		struct dentry *d_cpu;
> > > > > > +		struct dentry *d_cpu, *d_lookup;
> > > > > >  		char buf[32];
> > > > > >  
> > > > > >  		snprintf(buf, sizeof(buf), "cpu%d", cpu);
> > > > > > -		debugfs_remove(debugfs_lookup(buf, sd_dentry));
> > > > > > +		d_lookup = debugfs_lookup(buf, sd_dentry);
> > > > > > +		debugfs_remove(d_lookup);
> > > > > > +		if (!IS_ERR_OR_NULL(d_lookup))
> > > > > > +			dput(d_lookup);
> > > > > 
> > > > > That's odd, and means that something else is removing this
> > > > > file
> > > > > right
> > > > > after we looked it up?  Is there a missing lock here that
> > > > > should
> > > > > be
> > > > > used
> > > > > instead?
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > 
> > > > While doing cpu hotlug, the cpu_active_mask is changed, 
> > > > so it need to update_sched_domain_debugfs.
> > > > 
> > > > The original design is to recreate sd_dentry, so it doing
> > > > debugfs_remove and then debugfs_create_dir.
> > > > However, by debugfs_lookup function usage.
> > > > The returned dentry must be passed to dput() when it is no
> > > > longer
> > > > needed to avoid dentry leak.
> > > 
> > > Eeeek, nice find!  I've been adding this pattern:
> > > 	debugfs_remove(debugfs_lookup(...));
> > > all over the place, and as you point out, that's wrong!
> > > 
> > > It's as if I didn't even read the documentation I wrote.
> > > 
> > > {sigh}
> > > 
> > > Ok, as this is going to be a very common pattern, how about we
> > > create:
> > > 	debugfs_lookup_and_remove()
> > > function that does the above logic all in one place and then we
> > > don't
> > > have to put that logic everywhere in the kernel.  My goal is for
> > > users
> > > of debugfs to never have to worry about anything about 'struct
> > > dentry'
> > > at all, and I really failed that goal here in a major way.
> > > 
> > > I can work on that this afternoon after I get some other things
> > > done,
> > > unless you want to do it now?
> > > 
> > > Again, very nice find, thank you for this.
> > > 
> > 
> > Thanks for your kindly support !
> > Please help to add debugfs_lookup_and_remove() and then we can use
> > this api to fix this denrty leak issue.
> 
> Ok, can you test the patch below with your reproducer to see if it is
> fixed or not?  If this resolves the issue, I'll split it up into the
> proper set of patches and sweep the whole tree as every user of
> debugfs_lookup() that I've found so far got it wrong :(
> 
> thanks again!
> 
> greg k-h
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 3dcf0b8b4e93..87ccd6280a9b 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -744,6 +744,28 @@ void debugfs_remove(struct dentry *dentry)
>  }
>  EXPORT_SYMBOL_GPL(debugfs_remove);
>  
> +/**
> + * debugfs_lookup_and_remove - lookup a directory or file and
> recursively remove it
> + * @name: a pointer to a string containing the name of the item to
> look up.
> + * @parent: a pointer to the parent dentry of the item.
> + *
> + * This is the equlivant of doing something like
> + * debugfs_remove(debugfs_lookup(..)) but with the proper reference
> counting
> + * handled for the directory being looked up.
> + */
> +void debugfs_lookup_and_remove(const char *name, struct dentry
> *parent)
> +{
> +	struct dentry *dentry;
> +
> +	dentry = debugfs_lookup(name, parent);
> +	if (IS_ERR_OR_NULL(dentry))
> +		return;
> +
> +	debugfs_remove(dentry);
> +	dput(dentry);
> +}
> +EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
> +
>  /**
>   * debugfs_rename - rename a file/directory in the debugfs
> filesystem
>   * @old_dir: a pointer to the parent dentry for the renamed object.
> This
> diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
> index c869f1e73d75..f60674692d36 100644
> --- a/include/linux/debugfs.h
> +++ b/include/linux/debugfs.h
> @@ -91,6 +91,8 @@ struct dentry *debugfs_create_automount(const char
> *name,
>  void debugfs_remove(struct dentry *dentry);
>  #define debugfs_remove_recursive debugfs_remove
>  
> +void debugfs_lookup_and_remove(const char *name, struct dentry
> *parent);
> +
>  const struct file_operations *debugfs_real_fops(const struct file
> *filp);
>  
>  int debugfs_file_get(struct dentry *dentry);
> @@ -225,6 +227,10 @@ static inline void debugfs_remove(struct dentry
> *dentry)
>  static inline void debugfs_remove_recursive(struct dentry *dentry)
>  { }
>  
> +static inline void debugfs_lookup_and_remove(const char *name,
> +					     struct dentry *parent)
> +{ }
> +
>  const struct file_operations *debugfs_real_fops(const struct file
> *filp);
>  
>  static inline int debugfs_file_get(struct dentry *dentry)
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index bb3d63bdf4ae..667876da8382 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -416,7 +416,7 @@ void update_sched_domain_debugfs(void)
>  		char buf[32];
>  
>  		snprintf(buf, sizeof(buf), "cpu%d", cpu);
> -		debugfs_remove(debugfs_lookup(buf, sd_dentry));
> +		debugfs_lookup_and_remove(buf, sd_dentry);
>  		d_cpu = debugfs_create_dir(buf, sd_dentry);
>  
>  		i = 0;

The lowmemorykiller triggered issue while doing hotplug stress is fixed
after applying your patch.
Thanks for your kindly support !


