Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF39B5320AA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiEXCGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiEXCGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:06:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA0B66FAB
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:06:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f21so2863161pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GcoAK/Dc6Lr2CBNMcxnRVtIuqLfn0KJuv9uAtwzcgFM=;
        b=iviYe8/yCbLufLwF5HKaBgfNSebNrVe54EcgWOu43UOCMsSLifLq6m1IzNWr/mE5qd
         s4bOY07//26noqeMb3kFLo9RusaiZJP6TK6Ovn9HPideA81o2VFgksX0NjjMxsq4infh
         54T7LCfq86JsGq5ursRMFbkngJPOK6Sb4S/j+OMAEtp9D75oHa+2FgZdfPkW/zavMC76
         x7pCGhCxxtIgxc9ky3SC5Y2SqGV5NqZnANdnjRsOGBInNgO6AUdwdObhRWoN+ncZw9fe
         LpyHK5Gr8FplyZAFVMZjjg2U2YIT5FX68B/eF7wJFcJWO41mpIk2tmBuSKZei2LAP3DV
         q3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GcoAK/Dc6Lr2CBNMcxnRVtIuqLfn0KJuv9uAtwzcgFM=;
        b=6Q7BP0sczpAA4l6+S80YySen2HXOXgxfGzoIoXN8GtyT8n8eAi8TDcQCu5BzY7ejUa
         fSScaP32UAe+81MTNN6B5fG0vATagQpUdqeQOzVZaSo34wQdtrjugGnKhBaqE3QSXSRT
         hWgIUsgwBqF40QVsWlaWVnyeYADt/vzqvL3u7hcfNlwZPOK3TGDmYPldQQv0y20Gyfec
         GicHOG1NN74KVfBpDxLrb14n+1L8DmKxqI5JfUmRE03pHSikAWqayxonFgwb3MJ27l8d
         gj7LTUL7cLc8wJt5OKxubctCFfeylBoV5E1+LOgZYl9WFJLq9jk23h1+2QBPHfiXCBcK
         9nSg==
X-Gm-Message-State: AOAM533X78QHGsyaPh/AxeiXcRhR8Iriv0xp4s811/hiiuQi0c4e/+VI
        2KHMzP50p9v1iBG+WHGjtjeZGg==
X-Google-Smtp-Source: ABdhPJx6R8xh/Dg+nZRFEnS334/JqbYCSoNGBsaFctIYaXVayKA1dhsGykDmMGSEMsa48h2oHJ04dQ==
X-Received: by 2002:a05:6a00:2187:b0:50c:ef4d:ef3b with SMTP id h7-20020a056a00218700b0050cef4def3bmr25806185pfi.83.1653357999656;
        Mon, 23 May 2022 19:06:39 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b0015e8da1f9e8sm6004388plh.77.2022.05.23.19.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:06:39 -0700 (PDT)
Date:   Tue, 24 May 2022 10:06:33 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 2/6] mm: shrinkers: introduce debugfs interface for
 memory shrinkers
Message-ID: <Yow9qVkRyhevkcAW@FVFYT0MHHV2J.googleapis.com>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-3-roman.gushchin@linux.dev>
 <YooSSCnphhuwfOOc@FVFYT0MHHV2J.usts.net>
 <YovRSpbpe5fIYXrK@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YovRSpbpe5fIYXrK@carbon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:24:10AM -0700, Roman Gushchin wrote:
> On Sun, May 22, 2022 at 06:36:56PM +0800, Muchun Song wrote:
> > On Mon, May 09, 2022 at 11:38:16AM -0700, Roman Gushchin wrote:
> > > This commit introduces the /sys/kernel/debug/shrinker debugfs
> > > interface which provides an ability to observe the state of
> > > individual kernel memory shrinkers.
> > > 
> > > Because the feature adds some memory overhead (which shouldn't be
> > > large unless there is a huge amount of registered shrinkers), it's
> > > guarded by a config option (enabled by default).
> > > 
> > > This commit introduces the "count" interface for each shrinker
> > > registered in the system.
> > > 
> > > The output is in the following format:
> > 
> > Hi Roman,
> 
> Hi Muchun!
> 
> Thank you for taking a look!
> 
> > 
> > Shoud we print a title to show what those numbers mean?  In this case,
> > it is more understandable.
> 
> No, I don't think so: this interface is not supposed to be used by
> an average user and those who will be using it can refer to the provided
> documentation. Printing the header each time will add some overhead for
> no good reason.
>

Got it. Make sense.
 
> > > <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> > > <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> > > ...
> > > 
> > > To reduce the size of output on machines with many thousands cgroups,
> > > if the total number of objects on all nodes is 0, the line is omitted.
> > > 
> > > If the shrinker is not memcg-aware or CONFIG_MEMCG is off, 0 is
> > > printed as cgroup inode id. If the shrinker is not numa-aware, 0's are
> > > printed for all nodes except the first one.
> > > 
> > > This commit gives debugfs entries simple numeric names, which are not
> > > very convenient. The following commit in the series will provide
> > > shrinkers with more meaningful names.
> > > 
> > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > ---
> > >  include/linux/shrinker.h |  19 ++++-
> > >  lib/Kconfig.debug        |   9 +++
> > >  mm/Makefile              |   1 +
> > >  mm/shrinker_debug.c      | 171 +++++++++++++++++++++++++++++++++++++++
> > >  mm/vmscan.c              |   6 +-
> > >  5 files changed, 203 insertions(+), 3 deletions(-)
> > >  create mode 100644 mm/shrinker_debug.c
> > > 
> > > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > > index 76fbf92b04d9..2ced8149c513 100644
> > > --- a/include/linux/shrinker.h
> > > +++ b/include/linux/shrinker.h
> > > @@ -72,6 +72,10 @@ struct shrinker {
> > >  #ifdef CONFIG_MEMCG
> > >  	/* ID in shrinker_idr */
> > >  	int id;
> > > +#endif
> > > +#ifdef CONFIG_SHRINKER_DEBUG
> > > +	int debugfs_id;
> > > +	struct dentry *debugfs_entry;
> > >  #endif
> > >  	/* objs pending delete, per node */
> > >  	atomic_long_t *nr_deferred;
> > > @@ -94,4 +98,17 @@ extern int register_shrinker(struct shrinker *shrinker);
> > >  extern void unregister_shrinker(struct shrinker *shrinker);
> > >  extern void free_prealloced_shrinker(struct shrinker *shrinker);
> > >  extern void synchronize_shrinkers(void);
> > > -#endif
> > > +
> > > +#ifdef CONFIG_SHRINKER_DEBUG
> > > +extern int shrinker_debugfs_add(struct shrinker *shrinker);
> > > +extern void shrinker_debugfs_remove(struct shrinker *shrinker);
> > > +#else /* CONFIG_SHRINKER_DEBUG */
> > > +static inline int shrinker_debugfs_add(struct shrinker *shrinker)
> > > +{
> > > +	return 0;
> > > +}
> > > +static inline void shrinker_debugfs_remove(struct shrinker *shrinker)
> > > +{
> > > +}
> > > +#endif /* CONFIG_SHRINKER_DEBUG */
> > > +#endif /* _LINUX_SHRINKER_H */
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 3fd7a2e9eaf1..5fa65a649798 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -733,6 +733,15 @@ config SLUB_STATS
> > >  	  out which slabs are relevant to a particular load.
> > >  	  Try running: slabinfo -DA
> > >  
> > > +config SHRINKER_DEBUG
> > > +	default y
> > > +	bool "Enable shrinker debugging support"
> > > +	depends on DEBUG_FS
> > > +	help
> > > +	  Say Y to enable the shrinker debugfs interface which provides
> > > +	  visibility into the kernel memory shrinkers subsystem.
> > > +	  Disable it to avoid an extra memory footprint.
> > > +
> > >  config HAVE_DEBUG_KMEMLEAK
> > >  	bool
> > >  
> > > diff --git a/mm/Makefile b/mm/Makefile
> > > index 298c9991ab75..8083fa85a348 100644
> > > --- a/mm/Makefile
> > > +++ b/mm/Makefile
> > > @@ -133,3 +133,4 @@ obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
> > >  obj-$(CONFIG_IO_MAPPING) += io-mapping.o
> > >  obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
> > >  obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
> > > +obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
> > > diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> > > new file mode 100644
> > > index 000000000000..fd1f805a581a
> > > --- /dev/null
> > > +++ b/mm/shrinker_debug.c
> > > @@ -0,0 +1,171 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <linux/idr.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/debugfs.h>
> > > +#include <linux/seq_file.h>
> > > +#include <linux/shrinker.h>
> > > +#include <linux/memcontrol.h>
> > > +
> > > +/* defined in vmscan.c */
> > > +extern struct rw_semaphore shrinker_rwsem;
> > > +extern struct list_head shrinker_list;
> > > +
> > > +static DEFINE_IDA(shrinker_debugfs_ida);
> > > +static struct dentry *shrinker_debugfs_root;
> > > +
> > > +static unsigned long shrinker_count_objects(struct shrinker *shrinker,
> > > +					    struct mem_cgroup *memcg,
> > > +					    unsigned long *count_per_node)
> > > +{
> > > +	unsigned long nr, total = 0;
> > > +	int nid;
> > > +
> > > +	for_each_node(nid) {
> > > +		if (nid == 0 || (shrinker->flags & SHRINKER_NUMA_AWARE)) {
> > > +			struct shrink_control sc = {
> > > +				.gfp_mask = GFP_KERNEL,
> > > +				.nid = nid,
> > > +				.memcg = memcg,
> > > +			};
> > > +
> > > +			nr = shrinker->count_objects(shrinker, &sc);
> > > +			if (nr == SHRINK_EMPTY)
> > > +				nr = 0;
> > > +		} else {
> > > +			nr = 0;
> > 
> > For efficiency, we could break here, right?
> 
> Not really, we need to fill count_per_node[] with zeros.
>

I thought count_per_node[] was initialized with zero by the caller
when allocated.  However, I am wrong.  Because it'll be reused
in each loop.  You are right.

> > 
> > > +		}
> > > +
> > > +		count_per_node[nid] = nr;
> > > +		total += nr;
> > > +	}
> > > +
> > > +	return total;
> > > +}
> > > +
> > > +static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
> > > +{
> > > +	struct shrinker *shrinker = (struct shrinker *)m->private;
> > 
> > Maybe we cound drop the cast since m->private is a void * type.
> 
> Ok.
> 
> > 
> > > +	unsigned long *count_per_node = NULL;
> > 
> > Do not need to be initialized, right?
> 
> Right, will fix in v4.
> 
> > 
> > > +	struct mem_cgroup *memcg;
> > > +	unsigned long total;
> > > +	bool memcg_aware;
> > > +	int ret, nid;
> > > +
> > > +	count_per_node = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
> > > +	if (!count_per_node)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = down_read_killable(&shrinker_rwsem);
> > > +	if (ret) {
> > > +		kfree(count_per_node);
> > > +		return ret;
> > > +	}
> > > +	rcu_read_lock();
> > > +
> > > +	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
> > > +
> > > +	memcg = mem_cgroup_iter(NULL, NULL, NULL);
> > > +	do {
> > > +		if (memcg && !mem_cgroup_online(memcg))
> > > +			continue;
> > > +
> > > +		total = shrinker_count_objects(shrinker,
> > > +					       memcg_aware ? memcg : NULL,
> > > +					       count_per_node);
> > > +		if (total) {
> > > +			seq_printf(m, "%lu", mem_cgroup_ino(memcg));
> > > +			for_each_node(nid)
> > > +				seq_printf(m, " %lu", count_per_node[nid]);
> > > +			seq_puts(m, "\n");
> > 
> > seq_putc(m, '\n') is more efficient.
> 
> Ok.
> 
> > 
> > > +		}
> > > +
> > > +		if (!memcg_aware) {
> > > +			mem_cgroup_iter_break(NULL, memcg);
> > > +			break;
> > > +		}
> > > +
> > > +		if (signal_pending(current)) {
> > > +			mem_cgroup_iter_break(NULL, memcg);
> > > +			ret = -EINTR;
> > > +			break;
> > > +		}
> > > +
> > > +		cond_resched();
> > 
> > We are in rcu read lock, cannot be scheduled, right?
> 
> This is a good one, thanks. Fixed.
> 
> > 
> > > +	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> > > +
> > > +	rcu_read_unlock();
> > > +	up_read(&shrinker_rwsem);
> > > +
> > > +	kfree(count_per_node);
> > > +	return ret;
> > > +}
> > > +DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
> > > +
> > > +int shrinker_debugfs_add(struct shrinker *shrinker)
> > > +{
> > > +	struct dentry *entry;
> > > +	char buf[16];
> > > +	int id;
> > > +
> > > +	lockdep_assert_held(&shrinker_rwsem);
> > > +
> > > +	/* debugfs isn't initialized yet, add debugfs entries later. */
> > > +	if (!shrinker_debugfs_root)
> > > +		return 0;
> > > +
> > > +	id = ida_alloc(&shrinker_debugfs_ida, GFP_KERNEL);
> > > +	if (id < 0)
> > > +		return id;
> > > +	shrinker->debugfs_id = id;
> > > +
> > > +	snprintf(buf, sizeof(buf), "%d", id);
> > > +
> > > +	/* create debugfs entry */
> > > +	entry = debugfs_create_dir(buf, shrinker_debugfs_root);
> > > +	if (IS_ERR(entry)) {
> > > +		ida_free(&shrinker_debugfs_ida, id);
> > > +		return PTR_ERR(entry);
> > > +	}
> > > +	shrinker->debugfs_entry = entry;
> > > +
> > > +	debugfs_create_file("count", 0220, entry, shrinker,
> > > +			    &shrinker_debugfs_count_fops);
> > > +	return 0;
> > > +}
> > > +
> > > +void shrinker_debugfs_remove(struct shrinker *shrinker)
> > > +{
> > > +	lockdep_assert_held(&shrinker_rwsem);
> > > +
> > > +	if (!shrinker->debugfs_entry)
> > > +		return;
> > > +
> > > +	debugfs_remove_recursive(shrinker->debugfs_entry);
> > > +	ida_free(&shrinker_debugfs_ida, shrinker->debugfs_id);
> > > +}
> > > +
> > > +static int __init shrinker_debugfs_init(void)
> > > +{
> > > +	struct shrinker *shrinker;
> > > +	int ret;
> > > +
> > > +	if (!debugfs_initialized())
> > > +		return -ENODEV;
> > > +
> > 
> > Redundant check since it is checked in debugfs_create_dir().
> > So I think we could remove this.
> > 
> > > +	shrinker_debugfs_root = debugfs_create_dir("shrinker", NULL);
> > 
> > We should use IS_ERR() to detect the error code.  So the following
> > check is wrong.
> 
> Right, will fix in the next version.
> 
> > 
> > > +	if (!shrinker_debugfs_root)
> > > +		return -ENOMEM;
> > > +
> > > +	/* Create debugfs entries for shrinkers registered at boot */
> > > +	ret = down_write_killable(&shrinker_rwsem);
> > 
> > How could we kill this process?  IIUC, late_initcall() is called
> > from early init process, there is no way to kill this. Right?
> > If yes, I think we could just use down_write().
> 
> Ok, agree.
> 
> Thanks!
> 
