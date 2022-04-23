Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5150C81B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiDWHys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 03:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiDWHyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 03:54:36 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A34B62
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 00:51:40 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1niAYM-0000UQ-LR
        for linux-kernel@vger.kernel.org; Sat, 23 Apr 2022 09:51:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 1/7] mm: introduce debugfs interface for kernel memory
 shrinkers
Date:   Sat, 23 Apr 2022 09:51:31 +0200
Message-ID: <0c64fd49-4ca3-1f5e-a69c-bb1d65f2263c@wanadoo.fr>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
 <20220422202644.799732-2-roman.gushchin@linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: fr
In-Reply-To: <20220422202644.799732-2-roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/04/2022 à 22:26, Roman Gushchin a écrit :
> This commit introduces the /sys/kernel/debug/shrinker debugfs
> interface which provides an ability to observe the state and interact
> with individual kernel memory shrinkers.
> 
> Because the feature is oriented on kernel developers and adds some
> memory overhead (which shouldn't be large unless there is a huge
> amount of registered shrinkers), it's guarded by a config option
> (disabled by default).
> 
> This commit introduces "count" and "scan" interfaces for each
> shrinker registered in the system.
> 
> Basic usage:
>    1) Get the number of objects
>      $ cat count
> 
>    2) Try to reclaim 500 objects
>      $ echo "500" > scan
> 
> Following commits in the series will add memcg- and numa-specific
> features.
> 
> This commit gives debugfs entries simple numeric names, which are not
> very convenient. The following commit in the series will provide
> shrinkers with more meaningful names.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>   include/linux/shrinker.h |  19 +++-
>   lib/Kconfig.debug        |   9 ++
>   mm/Makefile              |   1 +
>   mm/shrinker_debug.c      | 214 +++++++++++++++++++++++++++++++++++++++
>   mm/vmscan.c              |   6 +-
>   5 files changed, 246 insertions(+), 3 deletions(-)
>   create mode 100644 mm/shrinker_debug.c

[...]

> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> new file mode 100644
> index 000000000000..4df7382a0737
> --- /dev/null
> +++ b/mm/shrinker_debug.c

[...]

> +int shrinker_debugfs_add(struct shrinker *shrinker)
> +{
> +	struct dentry *entry;
> +	char buf[256];
Later, this buffer is filled with a "%s-%d". (patch 5/7)
The %s is generated out of a max 64 bytes long string.

To be consistent with the 2 buffers sizes, maybe this one could be 
reduced a bit to save some stack?

CJ

> +	int id;
> +
> +	lockdep_assert_held(&shrinker_rwsem);
> +
> +	/* debugfs isn't initialized yet, add debugfs entries later. */
> +	if (!shrinker_debugfs_root)
> +		return 0;
> +
> +	id = ida_alloc(&shrinker_debugfs_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return id;
> +	shrinker->debugfs_id = id;
> +
> +	snprintf(buf, sizeof(buf), "%d", id);
> +
> +	/* create debugfs entry */
> +	entry = debugfs_create_dir(buf, shrinker_debugfs_root);
> +	if (IS_ERR(entry)) {
> +		ida_free(&shrinker_debugfs_ida, id);
> +		return PTR_ERR(entry);
> +	}

[...]

