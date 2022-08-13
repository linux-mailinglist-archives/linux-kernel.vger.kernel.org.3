Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D06E591C42
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbiHMSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbiHMSZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 14:25:38 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EFBB85F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 11:25:35 -0700 (PDT)
Date:   Sat, 13 Aug 2022 11:25:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660415133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUntDoq6qvPLJTm4y2LJbJzniYTSAJV/ID1PGirdRME=;
        b=vzG9hIxcAzC9gUhXqZmVr1fpAZMj5VjzVHDH7re4vpbMtGtHrs2a+sV832UNhxrFvHfhRz
        kSWdkd1sM1LVAZYQ8CJFC9KVbnu4HRwLtgRdhX5y78pdTYQs7meCLXT825/JHwRYtGKQxg
        QMNSqPeFvHbffcoOwtwffks+9fk1uhk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slab_common: Deleting kobject in
 kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock
Message-ID: <YvfsmNxDYp9Pz/+P@P9FQF9L96D.corp.robot.car>
References: <20220812183033.346425-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812183033.346425-1-longman@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:30:33PM -0400, Waiman Long wrote:
> A circular locking problem is reported by lockdep due to the following
> circular locking dependency.
> 
>   +--> cpu_hotplug_lock --> slab_mutex --> kn->active --+
>   |                                                     |
>   +-----------------------------------------------------+
> 
> The forward cpu_hotplug_lock ==> slab_mutex ==> kn->active dependency
> happens in
> 
>   kmem_cache_destroy():	cpus_read_lock(); mutex_lock(&slab_mutex);
>   ==> sysfs_slab_unlink()
>       ==> kobject_del()
>           ==> kernfs_remove()
> 	      ==> __kernfs_remove()
> 	          ==> kernfs_drain(): rwsem_acquire(&kn->dep_map, ...);
> 
> The backward kn->active ==> cpu_hotplug_lock dependency happens in
> 
>   kernfs_fop_write_iter(): kernfs_get_active();
>   ==> slab_attr_store()
>       ==> cpu_partial_store()
>           ==> flush_all(): cpus_read_lock()
> 
> One way to break this circular locking chain is to avoid holding
> cpu_hotplug_lock and slab_mutex while deleting the kobject in
> sysfs_slab_unlink() which should be equivalent to doing a write_lock
> and write_unlock pair of the kn->active virtual lock.
> 
> Since the kobject structures are not protected by slab_mutex or the
> cpu_hotplug_lock, we can certainly release those locks before doing
> the delete operation.
> 
> Move sysfs_slab_unlink() and sysfs_slab_release() to the newly
> created kmem_cache_release() and call it outside the slab_mutex &
> cpu_hotplug_lock critical sections. There will be a slight delay
> in the deletion of sysfs files if kmem_cache_release() is called
> indirectly from a work function.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you, Waiman!
