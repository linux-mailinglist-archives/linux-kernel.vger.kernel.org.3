Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B7552F6C3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 02:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354207AbiEUA1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 20:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbiEUA1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 20:27:14 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C585C764
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 17:27:10 -0700 (PDT)
Date:   Fri, 20 May 2022 17:27:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653092828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1FEu8HyQRjr/eREuqJXaUmbStCzspnGbiQi4WtGL3w=;
        b=qKSKeHCl6hkSBNjsqCznu21xVrYZJ0XVtlXQHrL8SApWHg+Gg+2YyVIem9SHmVww3pjnYk
        hRFZe3JS97iQjr+WB1JD9TPzBfW5Qyke4oBGQ4GhSQSvV1jXDjOtuHnzzVoK/eSu7XFufG
        6dMrln8QIXI9i7ie2PfornX+LlV/OPk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v3 2/6] mm: shrinkers: introduce debugfs interface for
 memory shrinkers
Message-ID: <Yogx2BzID3JXm8sn@carbon>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-3-roman.gushchin@linux.dev>
 <d938e52e-3704-d095-cafe-a6218701896a@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d938e52e-3704-d095-cafe-a6218701896a@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 06:58:12PM +0200, Christophe JAILLET wrote:
> Le 09/05/2022 à 20:38, Roman Gushchin a écrit :
> > This commit introduces the /sys/kernel/debug/shrinker debugfs
> > interface which provides an ability to observe the state of
> > individual kernel memory shrinkers.
> > 
> > Because the feature adds some memory overhead (which shouldn't be
> > large unless there is a huge amount of registered shrinkers), it's
> > guarded by a config option (enabled by default).
> > 
> > This commit introduces the "count" interface for each shrinker
> > registered in the system.
> > 
> > The output is in the following format:
> > <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> > <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> > ...
> > 
> > To reduce the size of output on machines with many thousands cgroups,
> > if the total number of objects on all nodes is 0, the line is omitted.
> > 
> > If the shrinker is not memcg-aware or CONFIG_MEMCG is off, 0 is
> > printed as cgroup inode id. If the shrinker is not numa-aware, 0's are
> > printed for all nodes except the first one.
> > 
> > This commit gives debugfs entries simple numeric names, which are not
> > very convenient. The following commit in the series will provide
> > shrinkers with more meaningful names.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >   include/linux/shrinker.h |  19 ++++-
> >   lib/Kconfig.debug        |   9 +++
> >   mm/Makefile              |   1 +
> >   mm/shrinker_debug.c      | 171 +++++++++++++++++++++++++++++++++++++++
> >   mm/vmscan.c              |   6 +-
> >   5 files changed, 203 insertions(+), 3 deletions(-)
> >   create mode 100644 mm/shrinker_debug.c
> > 
> > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > index 76fbf92b04d9..2ced8149c513 100644
> > --- a/include/linux/shrinker.h
> > +++ b/include/linux/shrinker.h
> > @@ -72,6 +72,10 @@ struct shrinker {
> >   #ifdef CONFIG_MEMCG
> >   	/* ID in shrinker_idr */
> >   	int id;
> > +#endif
> > +#ifdef CONFIG_SHRINKER_DEBUG
> > +	int debugfs_id;
> > +	struct dentry *debugfs_entry;
> >   #endif
> >   	/* objs pending delete, per node */
> >   	atomic_long_t *nr_deferred;
> > @@ -94,4 +98,17 @@ extern int register_shrinker(struct shrinker *shrinker);
> >   extern void unregister_shrinker(struct shrinker *shrinker);
> >   extern void free_prealloced_shrinker(struct shrinker *shrinker);
> >   extern void synchronize_shrinkers(void);
> > -#endif
> > +
> > +#ifdef CONFIG_SHRINKER_DEBUG
> > +extern int shrinker_debugfs_add(struct shrinker *shrinker);
> > +extern void shrinker_debugfs_remove(struct shrinker *shrinker);
> > +#else /* CONFIG_SHRINKER_DEBUG */
> > +static inline int shrinker_debugfs_add(struct shrinker *shrinker)
> > +{
> > +	return 0;
> > +}
> > +static inline void shrinker_debugfs_remove(struct shrinker *shrinker)
> > +{
> > +}
> > +#endif /* CONFIG_SHRINKER_DEBUG */
> > +#endif /* _LINUX_SHRINKER_H */
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 3fd7a2e9eaf1..5fa65a649798 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -733,6 +733,15 @@ config SLUB_STATS
> >   	  out which slabs are relevant to a particular load.
> >   	  Try running: slabinfo -DA
> > +config SHRINKER_DEBUG
> > +	default y
> 
> The previous version of the serie had default 'n'.
> Is it intentional to have it now activated by default? It looked more like a
> tuning functionality when fine grained mangement of shrinker is needed.

Yes, it is intentional.
The overhead is small, so I don't think we have a good reason to hide it
by default behind a config option. In my opinion, enabling it be default
will increase the chances to gather a useful data.
It was the feedback I've received for one of the previous versions of
the patchset, and I think it's totally valid.
And preserving the config option allows to have a zero overhead for
really constrained systems.

Thanks!
