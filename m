Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032F4531CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiEWUyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiEWUyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:54:35 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C616D4FC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:54:33 -0700 (PDT)
Date:   Mon, 23 May 2022 13:54:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653339271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FN1YwUyY/Ur9jxbBZ7Mz6fcXJewUZe6huw2fCdrxp8=;
        b=DIrZ1Md0LDeZFct5DmKDKAV6ugcCp/yMec23pnprLHU4xWKkvJTi0rbL3+Kmefjn4veTVK
        z4E0axcFt0idbmV9D8faIHv/S1Ah79TB8Kp1NXAyzuKKmbzqp7gZNL5kU2lFe88sTbrefw
        zuyPxXTMxa08ckKo0fG4nZUfOXCqxGQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 6/6] mm: shrinkers: add scan interface for shrinker
 debugfs
Message-ID: <Yov0gNdi0+Q3UY2E@carbon>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-7-roman.gushchin@linux.dev>
 <YoogHykrHEdJpqta@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoogHykrHEdJpqta@FVFYT0MHHV2J.usts.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 07:35:59PM +0800, Muchun Song wrote:
> On Mon, May 09, 2022 at 11:38:20AM -0700, Roman Gushchin wrote:
> > Add a scan interface which allows to trigger scanning of a particular
> > shrinker and specify memcg and numa node. It's useful for testing,
> > debugging and profiling of a specific scan_objects() callback.
> > Unlike alternatives (creating a real memory pressure and dropping
> > caches via /proc/sys/vm/drop_caches) this interface allows to interact
> > with only one shrinker at once. Also, if a shrinker is misreporting
> > the number of objects (as some do), it doesn't affect scanning.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >  .../admin-guide/mm/shrinker_debugfs.rst       | 39 +++++++++-
> >  mm/shrinker_debug.c                           | 73 +++++++++++++++++++
> >  2 files changed, 108 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/shrinker_debugfs.rst b/Documentation/admin-guide/mm/shrinker_debugfs.rst
> > index 6783f8190e63..8fecf81d60ee 100644
> > --- a/Documentation/admin-guide/mm/shrinker_debugfs.rst
> > +++ b/Documentation/admin-guide/mm/shrinker_debugfs.rst
> > @@ -5,14 +5,16 @@ Shrinker Debugfs Interface
> >  ==========================
> >  
> >  Shrinker debugfs interface provides a visibility into the kernel memory
> > -shrinkers subsystem and allows to get information about individual shrinkers.
> > +shrinkers subsystem and allows to get information about individual shrinkers
> > +and interact with them.
> >  
> >  For each shrinker registered in the system a directory in **<debugfs>/shrinker/**
> >  is created. The directory's name is composed from the shrinker's name and an
> >  unique id: e.g. *kfree_rcu-0* or *sb-xfs:vda1-36*.
> >  
> > -Each shrinker directory contains the **count** file, which allows to trigger
> > -the *count_objects()* callback for each memcg and numa node (if applicable).
> > +Each shrinker directory contains **count** and **scan** files, which allow to
> > +trigger *count_objects()* and *scan_objects()* callbacks for each memcg and
> > +numa node (if applicable).
> >  
> >  Usage:
> >  ------
> > @@ -43,7 +45,7 @@ Usage:
> >  
> >      $ cd sb-btrfs\:vda2-24/
> >      $ ls
> > -    count
> > +    count            scan
> >  
> >  3. *Count objects*
> >  
> > @@ -98,3 +100,32 @@ Usage:
> >      2877 84 0
> >      293 1 0
> >      735 8 0
> > +
> > +4. *Scan objects*
> > +
> > +  The expected input format::
> > +
> > +    <cgroup inode id> <numa id> <number of objects to scan>
> > +
> > +  For a non-memcg-aware shrinker or on a system with no memory
> > +  cgrups **0** should be passed as cgroup id.
> > +  ::
> > +
> > +    $ cd /sys/kernel/debug/shrinker/
> > +    $ cd sb-btrfs\:vda2-24/
> > +
> > +    $ cat count | head -n 5
> > +    1 212 0
> > +    21 97 0
> > +    55 802 5
> > +    2367 2 0
> > +    225 13 0
> > +
> > +    $ echo "55 0 200" > scan
> > +
> > +    $ cat count | head -n 5
> > +    1 212 0
> > +    21 96 0
> > +    55 752 5
> > +    2367 2 0
> > +    225 13 0
> > diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> > index 28b1c1ab60ef..8f67fef5a643 100644
> > --- a/mm/shrinker_debug.c
> > +++ b/mm/shrinker_debug.c
> > @@ -101,6 +101,77 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
> >  
> > +static int shrinker_debugfs_scan_open(struct inode *inode, struct file *file)
> > +{
> > +	file->private_data = inode->i_private;
> > +	return nonseekable_open(inode, file);
> > +}
> > +
> > +static ssize_t shrinker_debugfs_scan_write(struct file *file,
> > +					   const char __user *buf,
> > +					   size_t size, loff_t *pos)
> > +{
> > +	struct shrinker *shrinker = (struct shrinker *)file->private_data;
> 
> Seems we could drop the cast since ->private_data is void * type.

Yep, fixed. Thanks!

> 
> > +	unsigned long nr_to_scan = 0, ino;
> > +	struct shrink_control sc = {
> > +		.gfp_mask = GFP_KERNEL,
> > +	};
> > +	struct mem_cgroup *memcg = NULL;
> > +	int nid;
> > +	char kbuf[72];
> > +	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
> > +	ssize_t ret;
> > +
> > +	if (copy_from_user(kbuf, buf, read_len))
> > +		return -EFAULT;
> > +	kbuf[read_len] = '\0';
> > +
> > +	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) < 2)
> > +		return -EINVAL;
> > +
> > +	if (nid < 0 || nid >= nr_node_ids)
> > +		return -EINVAL;
> > +
> 
> Should we break here if nr_to_scan is zero?

Not a very likely scenario, but ok.

> 
> > +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> > +		memcg = mem_cgroup_get_from_ino(ino);
> > +		if (!memcg || IS_ERR(memcg))
> 
> Should we drop the check of "!memcg" since mem_cgroup_get_from_ino
> cannot return NULL?

It can if !CONFIG_MEMCG. You might argue that then shrinker can not have
the SHRINKER_MEMCG_AWARE flag, but since it's not a hot path at all,
I'll keep it for extra safety.

> 
> > +			return -ENOENT;
> > +
> > +		if (!mem_cgroup_online(memcg)) {
> > +			mem_cgroup_put(memcg);
> > +			return -ENOENT;
> > +		}
> > +	} else {
> > +		if (ino != 0)
> > +			return -EINVAL;
> > +		memcg = NULL;
> 
> IIUC, memcg is already NULL if we reach here, right?  Then the
> assignment is not necessary.  Or we cound remove the initialization
> of 'memcg' where it is definned.

Right, removed.

> 
> > +	}
> > +
> > +	ret = down_read_killable(&shrinker_rwsem);
> > +	if (ret) {
> > +		mem_cgroup_put(memcg);
> > +		return ret;
> > +	}
> > +
> > +	sc.nid = nid;
> > +	sc.memcg = memcg;
> > +	sc.nr_to_scan = nr_to_scan;
> > +	sc.nr_scanned = nr_to_scan;
> > +
> > +	shrinker->scan_objects(shrinker, &sc);
> > +
> > +	up_read(&shrinker_rwsem);
> > +	mem_cgroup_put(memcg);
> > +
> > +	return ret ? ret : size;
> 
> Seems "ret" is always equal to 0 here, should we simplify this
> to "return size"?

Right.

Thank you for the review!
