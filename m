Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4F5127FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiD1A2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiD1A2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:28:40 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C15D18D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:25:25 -0700 (PDT)
Date:   Wed, 27 Apr 2022 17:25:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651105523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Pm4XrPDDu3/pHy6817BFFDAkWHD9YST6CisfBpK9OM=;
        b=awylVQzqR1tHTFsw9QqqmT7Tqx9CedX2bZefrOBoh3iFq76HUk5uateMmNJQkhWx34JY6p
        yqIsxY1vpWY3tsxKnHHIAQ/rM6Vl1rCbFiLFoma3ialbJye1lr9a7qx7j1cjhHhYSmZNgc
        Dk3aeJ707PsdTzlfmdax89EL0wOs6ps=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2 5/7] mm: provide shrinkers with names
Message-ID: <Ymne7kO27PUxa5eL@carbon>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
 <20220422202644.799732-6-roman.gushchin@linux.dev>
 <5272f8f0-7624-141b-076c-e8de08e595f5@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5272f8f0-7624-141b-076c-e8de08e595f5@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 09:46:25AM +0200, Christophe JAILLET wrote:
> Hi,
> 
> Le 22/04/2022 à 22:26, Roman Gushchin a écrit :
> > Currently shrinkers are anonymous objects. For debugging purposes they
> > can be identified by count/scan function names, but it's not always
> > useful: e.g. for superblock's shrinkers it's nice to have at least
> > an idea of to which superblock the shrinker belongs.
> > 
> > This commit adds names to shrinkers. register_shrinker() and
> > prealloc_shrinker() functions are extended to take a format and
> > arguments to master a name. If CONFIG_SHRINKER_DEBUG is on,
> > the name is saved until the corresponding debugfs object is created,
> > otherwise it's simple ignored.
> > 
> > After this change the shrinker debugfs directory looks like:
> >    $ cd /sys/kernel/debug/shrinker/
> >    $ ls
> >      dqcache-16          sb-cgroup2-30    sb-hugetlbfs-33  sb-proc-41       sb-selinuxfs-22  sb-tmpfs-40    sb-zsmalloc-19
> >      kfree_rcu-0         sb-configfs-23   sb-iomem-12      sb-proc-44       sb-sockfs-8      sb-tmpfs-42    shadow-18
> >      sb-aio-20           sb-dax-11        sb-mqueue-21     sb-proc-45       sb-sysfs-26      sb-tmpfs-43    thp_deferred_split-10
> >      sb-anon_inodefs-15  sb-debugfs-7     sb-nsfs-4        sb-proc-47       sb-tmpfs-1       sb-tmpfs-46    thp_zero-9
> >      sb-bdev-3           sb-devpts-28     sb-pipefs-14     sb-pstore-31     sb-tmpfs-27      sb-tmpfs-49    xfs_buf-37
> >      sb-bpf-32           sb-devtmpfs-5    sb-proc-25       sb-rootfs-2      sb-tmpfs-29      sb-tracefs-13  xfs_inodegc-38
> >      sb-btrfs-24         sb-hugetlbfs-17  sb-proc-39       sb-securityfs-6  sb-tmpfs-35      sb-xfs-36      zspool-34
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> 
> [...]
> 
> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> > index 59f91e392a2a..1b326b93155c 100644
> > --- a/drivers/md/raid5.c
> > +++ b/drivers/md/raid5.c
> > @@ -7383,7 +7383,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
> >   	conf->shrinker.count_objects = raid5_cache_count;
> >   	conf->shrinker.batch = 128;
> >   	conf->shrinker.flags = 0;
> > -	if (register_shrinker(&conf->shrinker)) {
> > +	if (register_shrinker(&conf->shrinker, "md")) {
> 
> Based on pr_warn below, does it make sense to have something like:
>   register_shrinker(&conf->shrinker, "md-%s", mdname(mddev))
> 
> >   		pr_warn("md/raid:%s: couldn't register shrinker.\n",
> >   			mdname(mddev));
> >   		goto abort;

Good idea, will do, thanks!

> 
> [...]
> 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 121a54a1602b..6025cfda4932 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -613,7 +613,7 @@ static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
> >   /*
> >    * Add a shrinker callback to be called from the vm.
> >    */
> > -int prealloc_shrinker(struct shrinker *shrinker)
> > +static int __prealloc_shrinker(struct shrinker *shrinker)
> >   {
> >   	unsigned int size;
> >   	int err;
> > @@ -637,6 +637,34 @@ int prealloc_shrinker(struct shrinker *shrinker)
> >   	return 0;
> >   }
> > +#ifdef CONFIG_SHRINKER_DEBUG
> > +int prealloc_shrinker(struct shrinker *shrinker, const char *fmt, ...)
> > +{
> > +	int err;
> > +	char buf[64];
> > +	va_list ap;
> > +
> > +	va_start(ap, fmt);
> > +	vscnprintf(buf, sizeof(buf), fmt, ap);
> > +	va_end(ap);
> > +
> > +	shrinker->name = kstrdup(buf, GFP_KERNEL);
> > +	if (!shrinker->name)
> > +		return -ENOMEM;
> 
> use kvasprintf_const() (and kfree_const() elsewhere) to simplify code and
> take advantage of kstrdup_const() in most cases?

Sure, good point.

> 
> > +
> > +	err = __prealloc_shrinker(shrinker);
> > +	if (err)
> > +		kfree(shrinker->name);
> > +
> > +	return err;
> > +}
> > +#else
> > +int prealloc_shrinker(struct shrinker *shrinker, const char *fmt, ...)
> > +{
> > +	return __prealloc_shrinker(shrinker);
> > +}
> > +#endif
> > +
> >   void free_prealloced_shrinker(struct shrinker *shrinker)
> >   {
> >   	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> > @@ -648,6 +676,9 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
> >   	kfree(shrinker->nr_deferred);
> >   	shrinker->nr_deferred = NULL;
> > +#ifdef CONFIG_SHRINKER_DEBUG
> > +	kfree(shrinker->name);
> > +#endif
> >   }
> >   void register_shrinker_prepared(struct shrinker *shrinker)
> > @@ -659,15 +690,38 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> >   	up_write(&shrinker_rwsem);
> >   }
> > -int register_shrinker(struct shrinker *shrinker)
> > +static int __register_shrinker(struct shrinker *shrinker)
> >   {
> > -	int err = prealloc_shrinker(shrinker);
> > +	int err = __prealloc_shrinker(shrinker);
> >   	if (err)
> >   		return err;
> >   	register_shrinker_prepared(shrinker);
> >   	return 0;
> >   }
> > +
> > +#ifdef CONFIG_SHRINKER_DEBUG
> > +int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
> > +{
> > +	char buf[64];
> > +	va_list ap;
> > +
> > +	va_start(ap, fmt);
> > +	vscnprintf(buf, sizeof(buf), fmt, ap);
> > +	va_end(ap);
> > +
> > +	shrinker->name = kstrdup(buf, GFP_KERNEL);
> > +	if (!shrinker->name)
> > +		return -ENOMEM;
> > +
> 
> same as above.
> 
> > +	return __register_shrinker(shrinker);
> 
> Missing error handling and freeing of shrinker->name as done in
> prealloc_shrinker()?

Will check in the next version.

Thank you for taking a look!

Roman
