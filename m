Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890CB50C605
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 03:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiDWBck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 21:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDWBch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 21:32:37 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D1E135380
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:29:41 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:29:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650677379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4qea+G2OSnqbAdlcf7z/vDW8HV22tC7bSj+qRlRW10=;
        b=lMpzTXiocJhjAPVsqiSLvlntUWmOoI2celepVOD6jajqaFFzIhZY/AEMqFhdEREv9yM04h
        H514Xd8bbOwWAgZmXkWEdRlmTC34D8XKhbSo1GS8URYYBl3TeLYK/KFCIsTp2qzuC5IkoG
        CzWKDimPS+sTQMFef7hWY/OQsjDGY4E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] mm: introduce memcg interfaces for shrinker
 debugfs
Message-ID: <YmNWfgh5/WEwUkFi@carbon>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
 <20220423003552.2914-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423003552.2914-1-hdanton@sina.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 08:35:52AM +0800, Hillf Danton wrote:
> On Fri, 22 Apr 2022 13:26:40 -0700 Roman Gushchin wrote:
> > This commit introduces "count_memcg" and "scan_memcg" interfaces
> > for memcg-aware shrinkers.
> > 
> > Count_memcg using the following format:
> > <cgroup inode number1> <count2>
> > <cgroup inode number2> <count2>
> > ...
> > 
> > Memory cgroups with 0 associated objects are skipped.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >  mm/shrinker_debug.c | 186 +++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 139 insertions(+), 47 deletions(-)
> > 
> > diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> > index 4df7382a0737..002d44d6ad56 100644
> > --- a/mm/shrinker_debug.c
> > +++ b/mm/shrinker_debug.c
> > @@ -1,8 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/idr.h>
> > +#include <linux/slab.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/shrinker.h>
> > +#include <linux/memcontrol.h>
> >  
> >  /* defined in vmscan.c */
> >  extern struct rw_semaphore shrinker_rwsem;
> > @@ -11,25 +13,25 @@ extern struct list_head shrinker_list;
> >  static DEFINE_IDA(shrinker_debugfs_ida);
> >  static struct dentry *shrinker_debugfs_root;
> >  
> > -static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
> > +static unsigned long shrinker_count_objects(struct shrinker *shrinker,
> > +					    struct mem_cgroup *memcg,
> > +					    unsigned long *count_per_node)
> >  {
> > -	struct shrinker *shrinker = (struct shrinker *)m->private;
> >  	unsigned long nr, total = 0;
> > -	int ret, nid;
> > -
> > -	ret = down_read_killable(&shrinker_rwsem);
> > -	if (ret)
> > -		return ret;
> > +	int nid;
> >  
> >  	for_each_node(nid) {
> >  		struct shrink_control sc = {
> >  			.gfp_mask = GFP_KERNEL,
> >  			.nid = nid,
> > +			.memcg = memcg,
> >  		};
> >  
> >  		nr = shrinker->count_objects(shrinker, &sc);
> >  		if (nr == SHRINK_EMPTY)
> >  			nr = 0;
> > +		if (count_per_node)
> > +			count_per_node[nid] = nr;
> >  		total += nr;
> >  
> >  		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > @@ -37,32 +39,17 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
> >  
> >  		cond_resched();
> 
> Nit, add a line in response to signal before schedule, given the
> killable above.

Good point, thanks!

> 
> >  	}
> > -	up_read(&shrinker_rwsem);
> > -
> > -	seq_printf(m, "%lu\n", total);
> >  
> > -	return ret;
> > +	return total;
> >  }
> > -DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
> >  
> > -static ssize_t shrinker_debugfs_scan_write(struct file *file,
> > -					   const char __user *buf,
> > -					   size_t size, loff_t *pos)
> > +static int shrinker_scan_objects(struct shrinker *shrinker,
> > +				 struct mem_cgroup *memcg,
> > +				 unsigned long nr_to_scan)
> >  {
> > -	struct shrinker *shrinker = (struct shrinker *)file->private_data;
> > -	unsigned long nr, total = 0, nr_to_scan;
> > -	unsigned long *count_per_node = NULL;
> > -	int nid;
> > -	char kbuf[24];
> > -	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
> > -	ssize_t ret;
> > -
> > -	if (copy_from_user(kbuf, buf, read_len))
> > -		return -EFAULT;
> > -	kbuf[read_len] = '\0';
> > -
> > -	if (kstrtoul(kbuf, 10, &nr_to_scan))
> > -		return -EINVAL;
> > +	unsigned long *count_per_node;
> > +	unsigned long total, nr;
> > +	int ret, nid;
> >  
> >  	ret = down_read_killable(&shrinker_rwsem);
> >  	if (ret)
> > @@ -80,20 +67,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
> >  			goto out;
> >  		}
> >  
> > -		for_each_node(nid) {
> > -			struct shrink_control sc = {
> > -				.gfp_mask = GFP_KERNEL,
> > -				.nid = nid,
> > -			};
> > -
> > -			nr = shrinker->count_objects(shrinker, &sc);
> > -			if (nr == SHRINK_EMPTY)
> > -				nr = 0;
> > -			count_per_node[nid] = nr;
> > -			total += nr;
> > -
> > -			cond_resched();
> > -		}
> > +		total = shrinker_count_objects(shrinker, memcg, count_per_node);
> >  	}
> >  
> >  	for_each_node(nid) {
> > @@ -102,13 +76,13 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
> >  			.nid = nid,
> >  		};
> >  
> > -		if (shrinker->flags & SHRINKER_NUMA_AWARE) {
> > +		if (count_per_node) {
> >  			sc.nr_to_scan = nr_to_scan * count_per_node[nid] /
> >  				(total ? total : 1);
> >  			sc.nr_scanned = sc.nr_to_scan;
> >  		} else {
> >  			sc.nr_to_scan = nr_to_scan;
> > -			sc.nr_scanned = sc.nr_to_scan;
> > +			sc.nr_scanned = nr_to_scan;
> >  		}
> >  
> >  		nr = shrinker->scan_objects(shrinker, &sc);
> > @@ -119,15 +93,51 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
> >  			break;
> >  
> >  		cond_resched();
> > -
> >  	}
> > -	ret = size;
> >  out:
> >  	up_read(&shrinker_rwsem);
> >  	kfree(count_per_node);
> >  	return ret;
> >  }
> >  
> > +static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
> > +{
> > +	struct shrinker *shrinker = (struct shrinker *)m->private;
> > +	int ret;
> > +
> > +	ret = down_read_killable(&shrinker_rwsem);
> > +	if (!ret) {
> > +		unsigned long total = shrinker_count_objects(shrinker, NULL, NULL);
> > +
> > +		up_read(&shrinker_rwsem);
> > +		seq_printf(m, "%lu\n", total);
> > +	}
> > +	return ret;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
> > +
> > +static ssize_t shrinker_debugfs_scan_write(struct file *file,
> > +					   const char __user *buf,
> > +					   size_t size, loff_t *pos)
> > +{
> > +	struct shrinker *shrinker = (struct shrinker *)file->private_data;
> > +	unsigned long nr_to_scan;
> > +	char kbuf[24];
> > +	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
> > +	ssize_t ret;
> > +
> > +	if (copy_from_user(kbuf, buf, read_len))
> > +		return -EFAULT;
> > +	kbuf[read_len] = '\0';
> > +
> > +	if (kstrtoul(kbuf, 10, &nr_to_scan))
> > +		return -EINVAL;
> > +
> > +	ret = shrinker_scan_objects(shrinker, NULL, nr_to_scan);
> > +
> > +	return ret ? ret : size;
> > +}
> > +
> >  static int shrinker_debugfs_scan_open(struct inode *inode, struct file *file)
> >  {
> >  	file->private_data = inode->i_private;
> > @@ -140,6 +150,78 @@ static const struct file_operations shrinker_debugfs_scan_fops = {
> >  	.write	 = shrinker_debugfs_scan_write,
> >  };
> >  
> > +#ifdef CONFIG_MEMCG
> > +static int shrinker_debugfs_count_memcg_show(struct seq_file *m, void *v)
> > +{
> > +	struct shrinker *shrinker = (struct shrinker *)m->private;
> > +	struct mem_cgroup *memcg;
> > +	unsigned long total;
> > +	int ret;
> > +
> > +	ret = down_read_killable(&shrinker_rwsem);
> > +	if (ret)
> > +		return ret;
> > +	rcu_read_lock();
> 
> A minute ... things like cond_resched() or mutex in individual shrinker
> implementation can ruin your nice work within two seconds. The bigger
> pain is can we rule them out from coming shrinkers?

Hm, why? Isn't it the same path as in reclaim? Can you, please, elaborate?
