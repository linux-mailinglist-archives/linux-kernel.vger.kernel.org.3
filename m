Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50D353066F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiEVWNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 18:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiEVWNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 18:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE6AE39801
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653257629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yU2XfsDjCtdrDw8W5toQdlsk8PLZ6ATYBVmHKqIDMSE=;
        b=YB9z2rD6R0wprKfTsXWcaXL00jmSHJoOty3EIf5DXVvRJBK/ebvtBL1w9vjvv2OPzZoluY
        lVXq9QK4wYALYOqObk867ZoHy3ORgS53aVlLCY26i4Ch4ZDxetCW5HHD5k7ar1j1g380tf
        tKknjUcucj5m1/Pj9FTDDHnveSL1u1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-m1jielg5OUinKFJIkXxFFg-1; Sun, 22 May 2022 18:13:47 -0400
X-MC-Unique: m1jielg5OUinKFJIkXxFFg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37E3380A0AD;
        Sun, 22 May 2022 22:13:47 +0000 (UTC)
Received: from rh (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91997492C3B;
        Sun, 22 May 2022 22:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dchinner@redhat.com>)
        id 1nstpX-003lyw-8n; Mon, 23 May 2022 08:13:43 +1000
Date:   Mon, 23 May 2022 08:13:41 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 3/6] mm: shrinkers: provide shrinkers with names
Message-ID: <Yoq1lRlneWj59Mte@rh>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-4-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509183820.573666-4-roman.gushchin@linux.dev>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:38:17AM -0700, Roman Gushchin wrote:
> Currently shrinkers are anonymous objects. For debugging purposes they
> can be identified by count/scan function names, but it's not always
> useful: e.g. for superblock's shrinkers it's nice to have at least
> an idea of to which superblock the shrinker belongs.
> 
> This commit adds names to shrinkers. register_shrinker() and
> prealloc_shrinker() functions are extended to take a format and
> arguments to master a name.
> 
> In some cases it's not possible to determine a good name at the time
> when a shrinker is allocated. For such cases shrinker_debugfs_rename()
> is provided.
> 
> After this change the shrinker debugfs directory looks like:
>   $ cd /sys/kernel/debug/shrinker/
>   $ ls
>     dqcache-16          sb-hugetlbfs-17  sb-rootfs-2      sb-tmpfs-50
>     kfree_rcu-0         sb-hugetlbfs-33  sb-securityfs-6  sb-tracefs-13
>     sb-aio-20           sb-iomem-12      sb-selinuxfs-22  sb-xfs:vda1-36
>     sb-anon_inodefs-15  sb-mqueue-21     sb-sockfs-8      sb-zsmalloc-19
>     sb-bdev-3           sb-nsfs-4        sb-sysfs-26      shadow-18
>     sb-bpf-32           sb-pipefs-14     sb-tmpfs-1       thp_deferred_split-10
>     sb-btrfs:vda2-24    sb-proc-25       sb-tmpfs-27      thp_zero-9
>     sb-cgroup2-30       sb-proc-39       sb-tmpfs-29      xfs_buf-37
>     sb-configfs-23      sb-proc-41       sb-tmpfs-35      xfs_inodegc-38
                                                            ^^^^^^^^^^^^^^

These XFS shrinkers are also per-block device like the superblock.
They need to read like "sb-xfs:vda1-36". and even though it is not
in this list, the xfs dquot shrinker will need this as well.


>     sb-dax-11           sb-proc-45       sb-tmpfs-40      zspool-34
>     sb-debugfs-7        sb-proc-46       sb-tmpfs-42
>     sb-devpts-28        sb-proc-47       sb-tmpfs-43
>     sb-devtmpfs-5       sb-pstore-31     sb-tmpfs-44

The proc and tmpfs shrinkers have the same problem - what instance
do they actually refer to?

> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index e1afb9e503e1..5645e92df0c9 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1986,7 +1986,7 @@ xfs_alloc_buftarg(
>  	btp->bt_shrinker.scan_objects = xfs_buftarg_shrink_scan;
>  	btp->bt_shrinker.seeks = DEFAULT_SEEKS;
>  	btp->bt_shrinker.flags = SHRINKER_NUMA_AWARE;
> -	if (register_shrinker(&btp->bt_shrinker))
> +	if (register_shrinker(&btp->bt_shrinker, "xfs_buf"))
>  		goto error_pcpu;
>  	return btp;
>  
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index bffd6eb0b298..d0c4e74ff763 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -2198,5 +2198,5 @@ xfs_inodegc_register_shrinker(
>  	shrink->flags = SHRINKER_NONSLAB;
>  	shrink->batch = XFS_INODEGC_SHRINKER_BATCH;
>  
> -	return register_shrinker(shrink);
> +	return register_shrinker(shrink, "xfs_inodegc");
>  }
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index f165d1a3de1d..93ded9e81f49 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -686,7 +686,7 @@ xfs_qm_init_quotainfo(
>  	qinf->qi_shrinker.seeks = DEFAULT_SEEKS;
>  	qinf->qi_shrinker.flags = SHRINKER_NUMA_AWARE;
>  
> -	error = register_shrinker(&qinf->qi_shrinker);
> +	error = register_shrinker(&qinf->qi_shrinker, "xfs_qm");
>  	if (error)
>  		goto out_free_inos;

Yeah, these all have a xfs_mount passed to them, so the superblock is
easily accessible here (mp->m_super)....

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com

