Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC853B020
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiFAVYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiFAVX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B47121CD3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97886137F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5328C385B8;
        Wed,  1 Jun 2022 21:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654118633;
        bh=baI/1cZI79/wp6OfnaSzJG6jkPfaG7SAvX2xPJStV0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S1JHdwp5rwuGpJRGBvPvtFKqIeTSaxNjhiQeKUhjBQ0l9XOrcbEdVMcGFelZSB8fr
         bR2+KBh0DUkUOw0zdTKPklwQvNK116WN2NT3TDNQCOPaQ6uNNkUNE8AuPddKmzkpu2
         mlqDg99/N3K5r6hozbYudcjal27ZOi/rQWoSg1xI=
Date:   Wed, 1 Jun 2022 14:23:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v5 6/6] mm: shrinkers: add scan interface for shrinker
 debugfs
Message-Id: <20220601142351.5e04fea5586ca51898d8785f@linux-foundation.org>
In-Reply-To: <20220601032227.4076670-7-roman.gushchin@linux.dev>
References: <20220601032227.4076670-1-roman.gushchin@linux.dev>
        <20220601032227.4076670-7-roman.gushchin@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 20:22:27 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> Add a scan interface which allows to trigger scanning of a particular
> shrinker and specify memcg and numa node. It's useful for testing,
> debugging and profiling of a specific scan_objects() callback.
> Unlike alternatives (creating a real memory pressure and dropping
> caches via /proc/sys/vm/drop_caches) this interface allows to interact
> with only one shrinker at once. Also, if a shrinker is misreporting
> the number of objects (as some do), it doesn't affect scanning.
> 
> ..
>
> --- a/mm/shrinker_debug.c
> +++ b/mm/shrinker_debug.c
> @@ -99,6 +99,78 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
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
> +	struct shrinker *shrinker = file->private_data;
> +	unsigned long nr_to_scan = 0, ino;
> +	struct shrink_control sc = {
> +		.gfp_mask = GFP_KERNEL,
> +	};
> +	struct mem_cgroup *memcg = NULL;
> +	int nid;
> +	char kbuf[72];
> +	int read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);

size_t or ulong would be more appropriate.

> +	ssize_t ret;
> +
> +	if (copy_from_user(kbuf, buf, read_len))
> +		return -EFAULT;
> +	kbuf[read_len] = '\0';
> +
> +	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) < 2)

Was it intentional to permit more than three args?

> +		return -EINVAL;
> +
> +	if (nid < 0 || nid >= nr_node_ids)
> +		return -EINVAL;
> +
> +	if (nr_to_scan == 0)
> +		return size;
> +
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> +		memcg = mem_cgroup_get_from_ino(ino);
> +		if (!memcg || IS_ERR(memcg))
> +			return -ENOENT;
> +
> +		if (!mem_cgroup_online(memcg)) {
> +			mem_cgroup_put(memcg);
> +			return -ENOENT;
> +		}
> +	} else if (ino != 0) {
> +		return -EINVAL;
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
> +	return size;
> +}

