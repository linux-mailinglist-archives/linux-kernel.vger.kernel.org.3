Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A450D53341A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbiEXXyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiEXXyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:54:43 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C5C67D12
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:54:41 -0700 (PDT)
Date:   Tue, 24 May 2022 16:54:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653436480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B3ex7fouBs2nWyDrjcuMtV8BsfokIFm1NkzfQJuKMiw=;
        b=VZNDt5rZcr47yLx7LWHhWAcblryVVE4AlHwuRKBn+DyOaoDECsV8BODUN+sYkXDXQkoqDQ
        ZNnzvGZ2U42Z5R4c//nltLM+Vw8OW0ykAJS6Bm0w9w1kZ3NajEjp3NrWByPhfBXxCamyms
        ONIwtgCxfWs/QJWpJrUXkd4pGf9tJcY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 3/6] mm: shrinkers: provide shrinkers with names
Message-ID: <Yo1wNXw8KJd3dnt6@carbon>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-4-roman.gushchin@linux.dev>
 <Yoq1lRlneWj59Mte@rh>
 <YoxAboVWrONJZumm@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoxAboVWrONJZumm@carbon>
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

On Mon, May 23, 2022 at 07:18:27PM -0700, Roman Gushchin wrote:
> On Mon, May 23, 2022 at 08:13:41AM +1000, Dave Chinner wrote:
> > On Mon, May 09, 2022 at 11:38:17AM -0700, Roman Gushchin wrote:
> > > Currently shrinkers are anonymous objects. For debugging purposes they
> > > can be identified by count/scan function names, but it's not always
> > > useful: e.g. for superblock's shrinkers it's nice to have at least
> > > an idea of to which superblock the shrinker belongs.
> > > 
> > > This commit adds names to shrinkers. register_shrinker() and
> > > prealloc_shrinker() functions are extended to take a format and
> > > arguments to master a name.
> > > 
> > > In some cases it's not possible to determine a good name at the time
> > > when a shrinker is allocated. For such cases shrinker_debugfs_rename()
> > > is provided.
> > > 
> > > After this change the shrinker debugfs directory looks like:
> > >   $ cd /sys/kernel/debug/shrinker/
> > >   $ ls
> > >     dqcache-16          sb-hugetlbfs-17  sb-rootfs-2      sb-tmpfs-50
> > >     kfree_rcu-0         sb-hugetlbfs-33  sb-securityfs-6  sb-tracefs-13
> > >     sb-aio-20           sb-iomem-12      sb-selinuxfs-22  sb-xfs:vda1-36
> > >     sb-anon_inodefs-15  sb-mqueue-21     sb-sockfs-8      sb-zsmalloc-19
> > >     sb-bdev-3           sb-nsfs-4        sb-sysfs-26      shadow-18
> > >     sb-bpf-32           sb-pipefs-14     sb-tmpfs-1       thp_deferred_split-10
> > >     sb-btrfs:vda2-24    sb-proc-25       sb-tmpfs-27      thp_zero-9
> > >     sb-cgroup2-30       sb-proc-39       sb-tmpfs-29      xfs_buf-37
> > >     sb-configfs-23      sb-proc-41       sb-tmpfs-35      xfs_inodegc-38
> >                                                             ^^^^^^^^^^^^^^
> > 
> > These XFS shrinkers are also per-block device like the superblock.
> > They need to read like "sb-xfs:vda1-36". and even though it is not
> > in this list, the xfs dquot shrinker will need this as well.
> 
> Sure, will do in v4. Thanks!
> 
> > 
> > 
> > >     sb-dax-11           sb-proc-45       sb-tmpfs-40      zspool-34
> > >     sb-debugfs-7        sb-proc-46       sb-tmpfs-42
> > >     sb-devpts-28        sb-proc-47       sb-tmpfs-43
> > >     sb-devtmpfs-5       sb-pstore-31     sb-tmpfs-44
> > 
> > The proc and tmpfs shrinkers have the same problem - what instance
> > do they actually refer to?
> 
> Any ideas on how to name/identify them?

I've looked a bit into it and realized I've no good idea:
I naively thought that procfs sb's have different pid namespaces,
but it's not true anymore. So I've no idea how to identify them.

The same applies to tmpfs instances, no simple id.

If somebody has any ideas, I'd appreciate. If not, we can enhance it later.

Thanks!
