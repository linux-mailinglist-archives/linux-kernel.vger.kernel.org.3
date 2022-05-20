Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F6552F12B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351936AbiETQ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbiETQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:58:18 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A717CC8F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:58:16 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id s5x6nCvSAWo1ms5x6nwSpM; Fri, 20 May 2022 18:58:15 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 20 May 2022 18:58:15 +0200
X-ME-IP: 86.243.180.246
Message-ID: <d938e52e-3704-d095-cafe-a6218701896a@wanadoo.fr>
Date:   Fri, 20 May 2022 18:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/6] mm: shrinkers: introduce debugfs interface for
 memory shrinkers
Content-Language: fr
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-3-roman.gushchin@linux.dev>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220509183820.573666-3-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/05/2022 à 20:38, Roman Gushchin a écrit :
> This commit introduces the /sys/kernel/debug/shrinker debugfs
> interface which provides an ability to observe the state of
> individual kernel memory shrinkers.
> 
> Because the feature adds some memory overhead (which shouldn't be
> large unless there is a huge amount of registered shrinkers), it's
> guarded by a config option (enabled by default).
> 
> This commit introduces the "count" interface for each shrinker
> registered in the system.
> 
> The output is in the following format:
> <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> ...
> 
> To reduce the size of output on machines with many thousands cgroups,
> if the total number of objects on all nodes is 0, the line is omitted.
> 
> If the shrinker is not memcg-aware or CONFIG_MEMCG is off, 0 is
> printed as cgroup inode id. If the shrinker is not numa-aware, 0's are
> printed for all nodes except the first one.
> 
> This commit gives debugfs entries simple numeric names, which are not
> very convenient. The following commit in the series will provide
> shrinkers with more meaningful names.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>   include/linux/shrinker.h |  19 ++++-
>   lib/Kconfig.debug        |   9 +++
>   mm/Makefile              |   1 +
>   mm/shrinker_debug.c      | 171 +++++++++++++++++++++++++++++++++++++++
>   mm/vmscan.c              |   6 +-
>   5 files changed, 203 insertions(+), 3 deletions(-)
>   create mode 100644 mm/shrinker_debug.c
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 76fbf92b04d9..2ced8149c513 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -72,6 +72,10 @@ struct shrinker {
>   #ifdef CONFIG_MEMCG
>   	/* ID in shrinker_idr */
>   	int id;
> +#endif
> +#ifdef CONFIG_SHRINKER_DEBUG
> +	int debugfs_id;
> +	struct dentry *debugfs_entry;
>   #endif
>   	/* objs pending delete, per node */
>   	atomic_long_t *nr_deferred;
> @@ -94,4 +98,17 @@ extern int register_shrinker(struct shrinker *shrinker);
>   extern void unregister_shrinker(struct shrinker *shrinker);
>   extern void free_prealloced_shrinker(struct shrinker *shrinker);
>   extern void synchronize_shrinkers(void);
> -#endif
> +
> +#ifdef CONFIG_SHRINKER_DEBUG
> +extern int shrinker_debugfs_add(struct shrinker *shrinker);
> +extern void shrinker_debugfs_remove(struct shrinker *shrinker);
> +#else /* CONFIG_SHRINKER_DEBUG */
> +static inline int shrinker_debugfs_add(struct shrinker *shrinker)
> +{
> +	return 0;
> +}
> +static inline void shrinker_debugfs_remove(struct shrinker *shrinker)
> +{
> +}
> +#endif /* CONFIG_SHRINKER_DEBUG */
> +#endif /* _LINUX_SHRINKER_H */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3fd7a2e9eaf1..5fa65a649798 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -733,6 +733,15 @@ config SLUB_STATS
>   	  out which slabs are relevant to a particular load.
>   	  Try running: slabinfo -DA
>   
> +config SHRINKER_DEBUG
> +	default y

The previous version of the serie had default 'n'.
Is it intentional to have it now activated by default? It looked more 
like a tuning functionality when fine grained mangement of shrinker is 
needed.


> +	bool "Enable shrinker debugging support"
> +	depends on DEBUG_FS
> +	help
> +	  Say Y to enable the shrinker debugfs interface which provides
> +	  visibility into the kernel memory shrinkers subsystem.
> +	  Disable it to avoid an extra memory footprint.
> +

[...]
