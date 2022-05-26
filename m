Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763CF53547E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbiEZUfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbiEZUfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:35:31 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDC3DFF5B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:35:28 -0700 (PDT)
Date:   Thu, 26 May 2022 13:35:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653597326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtEaIxsw5G8XbzZIdfhwIUxQJQ2YrDlSK/U8opLS5VE=;
        b=uJmYv7HWNHzyySdL3Ivc7VcwtzGR77/g/JslvuNg6Kjyo8jmBw/xmbL/rilyPqWHd7qihF
        u31SUyLUZ67z01O6iul5OQokizMSNpy7CjROd5lMbm+Xd5EypugvQAxfvaD8pg7eKQiWgY
        KTIv1nPHYAM9BE8qCSThUxGyYqN9C24=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v4 4/6] mm: docs: document shrinker debugfs
Message-ID: <Yo/kiMysyj1DMbf7@carbon>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
 <20220525202600.2910982-5-roman.gushchin@linux.dev>
 <Yo7lK1wp9fXi4obF@FVFYT0MHHV2J.googleapis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo7lK1wp9fXi4obF@FVFYT0MHHV2J.googleapis.com>
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

On Thu, May 26, 2022 at 10:25:47AM +0800, Muchun Song wrote:
> On Wed, May 25, 2022 at 01:25:58PM -0700, Roman Gushchin wrote:
> > Add a document describing the shrinker debugfs interface.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >  Documentation/admin-guide/mm/index.rst        |   1 +
> >  .../admin-guide/mm/shrinker_debugfs.rst       | 100 ++++++++++++++++++
> >  2 files changed, 101 insertions(+)
> >  create mode 100644 Documentation/admin-guide/mm/shrinker_debugfs.rst
> > 
> > diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> > index c21b5823f126..1bd11118dfb1 100644
> > --- a/Documentation/admin-guide/mm/index.rst
> > +++ b/Documentation/admin-guide/mm/index.rst
> > @@ -36,6 +36,7 @@ the Linux memory management.
> >     numa_memory_policy
> >     numaperf
> >     pagemap
> > +   shrinker_debugfs
> >     soft-dirty
> >     swap_numa
> >     transhuge
> > diff --git a/Documentation/admin-guide/mm/shrinker_debugfs.rst b/Documentation/admin-guide/mm/shrinker_debugfs.rst
> > new file mode 100644
> > index 000000000000..2033d696aa59
> > --- /dev/null
> > +++ b/Documentation/admin-guide/mm/shrinker_debugfs.rst
> > @@ -0,0 +1,100 @@
> > +.. _shrinker_debugfs:
> > +
> > +==========================
> > +Shrinker Debugfs Interface
> > +==========================
> > +
> > +Shrinker debugfs interface provides a visibility into the kernel memory
> > +shrinkers subsystem and allows to get information about individual shrinkers.
> > +
> > +For each shrinker registered in the system a directory in **<debugfs>/shrinker/**
> > +is created. The directory's name is composed from the shrinker's name and an
> > +unique id: e.g. *kfree_rcu-0* or *sb-xfs:vda1-36*.
> > +
> > +Each shrinker directory contains the **count** file, which allows to trigger
> > +the *count_objects()* callback for each memcg and numa node (if applicable).
> > +
> > +Usage:
> > +------
> > +
> > +1. *List registered shrinkers*
> > +
> > +  ::
> > +
> > +    $ cd /sys/kernel/debug/shrinker/
> > +    $ ls
> > +    dqcache-16          sb-hugetlbfs-17  sb-rootfs-2      sb-tmpfs-49
> > +    kfree_rcu-0         sb-hugetlbfs-33  sb-securityfs-6  sb-tracefs-13
> > +    sb-aio-20           sb-iomem-12      sb-selinuxfs-22  sb-xfs:vda1-36
> > +    sb-anon_inodefs-15  sb-mqueue-21     sb-sockfs-8      sb-zsmalloc-19
> > +    sb-bdev-3           sb-nsfs-4        sb-sysfs-26      shadow-18
> > +    sb-bpf-32           sb-pipefs-14     sb-tmpfs-1       thp_deferred_split-10
> > +    sb-btrfs:vda2-24    sb-proc-25       sb-tmpfs-27      thp_zero-9
> > +    sb-cgroup2-30       sb-proc-39       sb-tmpfs-29      xfs_buf-vda1-37
> > +    sb-configfs-23      sb-proc-41       sb-tmpfs-35      xfs_inodegc-vda1-38
> > +    sb-dax-11           sb-proc-45       sb-tmpfs-40      zspool-zram0-34
> > +    sb-debugfs-7        sb-proc-46       sb-tmpfs-42
> > +    sb-devpts-28        sb-proc-47       sb-tmpfs-43
> > +    sb-devtmpfs-5       sb-pstore-31     sb-tmpfs-44
> > +
> > +2. *Get information about a specific shrinker*
> > +
> > +  ::
> > +
> > +    $ cd sb-btrfs\:vda2-24/
> > +    $ ls
> > +    count
> > +
> > +3. *Count objects*
> > +
> > +  Each line in the output has the following format::
> > +
> > +    <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1> ...
> > +    <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1> ...
> > +    ...
> > +
> > +  If there are no objects on all numa nodes, a line is omitted. If there
> > +  are no objects at all, the output might be empty.
> 
> Should we add the following lines into here?
> 
> "
> If the shrinker is not memcg-aware or CONFIG_MEMCG is off, 0 is
> printed as cgroup inode id. If the shrinker is not numa-aware, 0's are
> printed for all nodes except the first one.
> "

Yes, it sounds like a great addition.
I hope Andrew can merge this in if there will be no v5. Or I'll
add it by myself otherwise. Thanks!

And thank you for reviewing the patches!
