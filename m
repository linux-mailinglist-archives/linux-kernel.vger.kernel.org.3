Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCC15302AC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbiEVLgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245185AbiEVLgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:36:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9B1A041
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 04:36:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p8so11362039pfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1DagZPBgDWrl49UJTEr0NPzqbGJyTk30uyxoJVE9jI=;
        b=ZCP+8ncQ+rGCAQLAVdWW5Bey0kg5AfsF02qmNtL6iFU5m47YwfYRmwWyGPONqDrJbV
         jpiNqAUw8bcV9KPyFZghAIb307mbf/gB3+9xSk2al2amqxUjY+I2v/BE1IGugZAn12Ru
         XZ+/wgw0MbWS+PxzC2Ria8spC+v5dWcpNdorUOw0GZNEjFGc7wm3Ia/X2VU4aRvRdXEx
         y6V+EEzXkbSTk+4i6SJEbhNlfTUsdw3PLQWU2FdBmnH+wPnwGO0VSzcH9pyszBae+oSh
         bAmOMhLebG8rDDilq3SjnBkHeO9IxDVlaXB/zcQiIZTeselSyapmcMLKRPe/fm7vgFUO
         vBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1DagZPBgDWrl49UJTEr0NPzqbGJyTk30uyxoJVE9jI=;
        b=a8clwSSyuy9P6eNCAURlJyz7PxoxzhglMy/PEXHP8Q8LP6krxh4ddXNscswJSfAZxz
         hwmN69osKUCI6ma6KY20Ck0AlonlR0NLs1KnWywkFNWlnKHEA4hc+cM15TItGVLTsZoo
         L6iFGK7V1pMkLfNSskbeivm7PlmmPvKC37kCWYhgL5hYihhHqmGOc1wkCLiwe6QnTO6w
         ofWy3rQ3XdVz08pkYOnF9IpWnyvIyaPmQ4Xsgj4rEe/pSGPC7AW69cO0Jqco6FiZZRnK
         t+0Zl3L+Ou5MLeDc5D4Fs19nKFdcf0le95Zeqe0twZbsE7uDO1VKlmLg94orOzKUS9yg
         CEuQ==
X-Gm-Message-State: AOAM5316wkEshioR4WXXO8AtDyKuPKVEsRAJ+dwUdDHGqIvqJmO49C4n
        LC9HaXNr1kQmlG05z8p9KNw+wQ==
X-Google-Smtp-Source: ABdhPJyJjcP4uAvoY/tyyGGUJ09riMdHe4JpfifWJpaVLpwDE976FtDngElZyxgt9D14sQftfRgWSQ==
X-Received: by 2002:a65:66ca:0:b0:3f6:2e7b:7d1a with SMTP id c10-20020a6566ca000000b003f62e7b7d1amr15986168pgw.165.1653219362668;
        Sun, 22 May 2022 04:36:02 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id l24-20020a637018000000b003f67294ed87sm2825445pgc.70.2022.05.22.04.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 04:36:02 -0700 (PDT)
Date:   Sun, 22 May 2022 19:35:59 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 6/6] mm: shrinkers: add scan interface for shrinker
 debugfs
Message-ID: <YoogHykrHEdJpqta@FVFYT0MHHV2J.usts.net>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-7-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509183820.573666-7-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:38:20AM -0700, Roman Gushchin wrote:
> Add a scan interface which allows to trigger scanning of a particular
> shrinker and specify memcg and numa node. It's useful for testing,
> debugging and profiling of a specific scan_objects() callback.
> Unlike alternatives (creating a real memory pressure and dropping
> caches via /proc/sys/vm/drop_caches) this interface allows to interact
> with only one shrinker at once. Also, if a shrinker is misreporting
> the number of objects (as some do), it doesn't affect scanning.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  .../admin-guide/mm/shrinker_debugfs.rst       | 39 +++++++++-
>  mm/shrinker_debug.c                           | 73 +++++++++++++++++++
>  2 files changed, 108 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/shrinker_debugfs.rst b/Documentation/admin-guide/mm/shrinker_debugfs.rst
> index 6783f8190e63..8fecf81d60ee 100644
> --- a/Documentation/admin-guide/mm/shrinker_debugfs.rst
> +++ b/Documentation/admin-guide/mm/shrinker_debugfs.rst
> @@ -5,14 +5,16 @@ Shrinker Debugfs Interface
>  ==========================
>  
>  Shrinker debugfs interface provides a visibility into the kernel memory
> -shrinkers subsystem and allows to get information about individual shrinkers.
> +shrinkers subsystem and allows to get information about individual shrinkers
> +and interact with them.
>  
>  For each shrinker registered in the system a directory in **<debugfs>/shrinker/**
>  is created. The directory's name is composed from the shrinker's name and an
>  unique id: e.g. *kfree_rcu-0* or *sb-xfs:vda1-36*.
>  
> -Each shrinker directory contains the **count** file, which allows to trigger
> -the *count_objects()* callback for each memcg and numa node (if applicable).
> +Each shrinker directory contains **count** and **scan** files, which allow to
> +trigger *count_objects()* and *scan_objects()* callbacks for each memcg and
> +numa node (if applicable).
>  
>  Usage:
>  ------
> @@ -43,7 +45,7 @@ Usage:
>  
>      $ cd sb-btrfs\:vda2-24/
>      $ ls
> -    count
> +    count            scan
>  
>  3. *Count objects*
>  
> @@ -98,3 +100,32 @@ Usage:
>      2877 84 0
>      293 1 0
>      735 8 0
> +
> +4. *Scan objects*
> +
> +  The expected input format::
> +
> +    <cgroup inode id> <numa id> <number of objects to scan>
> +
> +  For a non-memcg-aware shrinker or on a system with no memory
> +  cgrups **0** should be passed as cgroup id.
> +  ::
> +
> +    $ cd /sys/kernel/debug/shrinker/
> +    $ cd sb-btrfs\:vda2-24/
> +
> +    $ cat count | head -n 5
> +    1 212 0
> +    21 97 0
> +    55 802 5
> +    2367 2 0
> +    225 13 0
> +
> +    $ echo "55 0 200" > scan
> +
> +    $ cat count | head -n 5
> +    1 212 0
> +    21 96 0
> +    55 752 5
> +    2367 2 0
> +    225 13 0
> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> index 28b1c1ab60ef..8f67fef5a643 100644
> --- a/mm/shrinker_debug.c
> +++ b/mm/shrinker_debug.c
> @@ -101,6 +101,77 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
>  }
>  DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
>  
> +static int shrinker_debugfs_scan_open(struct inode *inode, struct file *file)
> +{
> +	file->private_data = inode->i_private;
> +	return nonseekable_open(inode, file);
> +}
> +
> +static ssize_t shrinker_debugfs_scan_write(struct file *file,
> +					   const char __user *buf,
> +					   size_t size, loff_t *pos)
> +{
> +	struct shrinker *shrinker = (struct shrinker *)file->private_data;

Seems we could drop the cast since ->private_data is void * type.

> +	unsigned long nr_to_scan = 0, ino;
> +	struct shrink_control sc = {
> +		.gfp_mask = GFP_KERNEL,
> +	};
> +	struct mem_cgroup *memcg = NULL;
> +	int nid;
> +	char kbuf[72];
> +	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
> +	ssize_t ret;
> +
> +	if (copy_from_user(kbuf, buf, read_len))
> +		return -EFAULT;
> +	kbuf[read_len] = '\0';
> +
> +	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) < 2)
> +		return -EINVAL;
> +
> +	if (nid < 0 || nid >= nr_node_ids)
> +		return -EINVAL;
> +

Should we break here if nr_to_scan is zero?

> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> +		memcg = mem_cgroup_get_from_ino(ino);
> +		if (!memcg || IS_ERR(memcg))

Should we drop the check of "!memcg" since mem_cgroup_get_from_ino
cannot return NULL?

> +			return -ENOENT;
> +
> +		if (!mem_cgroup_online(memcg)) {
> +			mem_cgroup_put(memcg);
> +			return -ENOENT;
> +		}
> +	} else {
> +		if (ino != 0)
> +			return -EINVAL;
> +		memcg = NULL;

IIUC, memcg is already NULL if we reach here, right?  Then the
assignment is not necessary.  Or we cound remove the initialization
of 'memcg' where it is definned.

> +	}
> +
> +	ret = down_read_killable(&shrinker_rwsem);
> +	if (ret) {
> +		mem_cgroup_put(memcg);
> +		return ret;
> +	}
> +
> +	sc.nid = nid;
> +	sc.memcg = memcg;
> +	sc.nr_to_scan = nr_to_scan;
> +	sc.nr_scanned = nr_to_scan;
> +
> +	shrinker->scan_objects(shrinker, &sc);
> +
> +	up_read(&shrinker_rwsem);
> +	mem_cgroup_put(memcg);
> +
> +	return ret ? ret : size;

Seems "ret" is always equal to 0 here, should we simplify this
to "return size"?

Thanks.

> +}
> +
> +static const struct file_operations shrinker_debugfs_scan_fops = {
> +	.owner	 = THIS_MODULE,
> +	.open	 = shrinker_debugfs_scan_open,
> +	.write	 = shrinker_debugfs_scan_write,
> +};
> +
>  int shrinker_debugfs_add(struct shrinker *shrinker)
>  {
>  	struct dentry *entry;
> @@ -130,6 +201,8 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
>  
>  	debugfs_create_file("count", 0220, entry, shrinker,
>  			    &shrinker_debugfs_count_fops);
> +	debugfs_create_file("scan", 0440, entry, shrinker,
> +			    &shrinker_debugfs_scan_fops);
>  	return 0;
>  }
>  
> -- 
> 2.35.3
> 
> 
