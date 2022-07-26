Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88C6580EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiGZIOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiGZIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:14:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E068D2E69B;
        Tue, 26 Jul 2022 01:14:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99EC7373AB;
        Tue, 26 Jul 2022 08:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658823257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trGkxrX/FFrvLPx/HmylFNb0Sv28281B3Ea3/JpyVZE=;
        b=ucRi1YiVSIlC0BwnEOmDabV86UH/gn16P6Ca9eqEHR0wQ2nT8pCHRfBMJyvHL4u39ABRzL
        e1xBnhbap9VvBJ1fft8DFR+RAAcvLgFOS2kp6JTP50YyIEeECngn/5kOVFRkyJljisQdJP
        SuPT6i1M7DZA3CBG1FDJZ7IxZuLCg1w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C39C13322;
        Tue, 26 Jul 2022 08:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UNZ3G1mi32KAAQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 26 Jul 2022 08:14:17 +0000
Date:   Tue, 26 Jul 2022 10:14:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     mm-commits@vger.kernel.org,
        syzbot+2d2aeadc6ce1e1f11d45@syzkaller.appspotmail.com,
        shakeelb@google.com, roman.gushchin@linux.dev, hannes@cmpxchg.org,
        penguin-kernel@i-love.sakura.ne.jp, akpm@linux-foundation.org
Subject: Re: + mm-memcontrol-fix-potential-oom_lock-recursion-deadlock.patch
 added to mm-unstable branch
Message-ID: <Yt+iWGnA06DjsHz9@dhcp22.suse.cz>
References: <20220725220032.B4C30C341C8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725220032.B4C30C341C8@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have concluded there are two issues possible here which would be
great to have reflected in the changelog.

On Mon 25-07-22 15:00:32, Andrew Morton wrote:
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Subject: mm: memcontrol: fix potential oom_lock recursion deadlock
> Date: Fri, 22 Jul 2022 19:45:39 +0900
> 
> syzbot is reporting GFP_KERNEL allocation with oom_lock held when
> reporting memcg OOM [1].  Such allocation request might deadlock the
> system, for __alloc_pages_may_oom() cannot invoke global OOM killer due to
> oom_lock being already held by the caller.

I would phrase it like this:
syzbot is reporting GFP_KERNEL allocation with oom_lock held when
reporting memcg OOM [1]. This is problematic because this creates a
dependency between GFP_NOFS and GFP_KERNEL over oom_lock which could
dead lock the system.

There is another problem here not reflected by the report though. If
memcg oom path happens during the global OOM situation then the system
might livelock as well because the GFP_KERNEL allocation from the
oom_lock context cannot trigger the global OOM killer because that
requires the oom_lock as well.

> Fix this problem by removing the allocation from memory_stat_format()

s@this problem@both issues@

> completely, and pass static buffer when calling from memcg OOM path.
> 
> Link: https://syzkaller.appspot.com/bug?extid=2d2aeadc6ce1e1f11d45 [1]
> Link: https://lkml.kernel.org/r/86afb39f-8c65-bec2-6cfc-c5e3cd600c0b@I-love.SAKURA.ne.jp
> Fixes: c8713d0b23123759 ("mm: memcontrol: dump memory.stat during cgroup OOM")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+2d2aeadc6ce1e1f11d45@syzkaller.appspotmail.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/memcontrol.c |   22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> --- a/mm/memcontrol.c~mm-memcontrol-fix-potential-oom_lock-recursion-deadlock
> +++ a/mm/memcontrol.c
> @@ -1490,14 +1490,12 @@ static const unsigned int memcg_vm_event
>  #endif
>  };
>  
> -static char *memory_stat_format(struct mem_cgroup *memcg)
> +static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
>  {
>  	struct seq_buf s;
>  	int i;
>  
> -	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> -	if (!s.buffer)
> -		return NULL;
> +	seq_buf_init(&s, buf, bufsize);
>  
>  	/*
>  	 * Provide statistics on the state of the memory subsystem as
> @@ -1539,8 +1537,6 @@ static char *memory_stat_format(struct m
>  
>  	/* The above should easily fit into one page */
>  	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
> -
> -	return s.buffer;
>  }
>  
>  #define K(x) ((x) << (PAGE_SHIFT-10))
> @@ -1576,7 +1572,10 @@ void mem_cgroup_print_oom_context(struct
>   */
>  void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  {
> -	char *buf;
> +	/* Use static buffer, for the caller is holding oom_lock. */
> +	static char buf[PAGE_SIZE];
> +
> +	lockdep_assert_held(&oom_lock);
>  
>  	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
>  		K((u64)page_counter_read(&memcg->memory)),
> @@ -1597,11 +1596,8 @@ void mem_cgroup_print_oom_meminfo(struct
>  	pr_info("Memory cgroup stats for ");
>  	pr_cont_cgroup_path(memcg->css.cgroup);
>  	pr_cont(":");
> -	buf = memory_stat_format(memcg);
> -	if (!buf)
> -		return;
> +	memory_stat_format(memcg, buf, sizeof(buf));
>  	pr_info("%s", buf);
> -	kfree(buf);
>  }
>  
>  /*
> @@ -6405,11 +6401,11 @@ static int memory_events_local_show(stru
>  static int memory_stat_show(struct seq_file *m, void *v)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -	char *buf;
> +	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  
> -	buf = memory_stat_format(memcg);
>  	if (!buf)
>  		return -ENOMEM;
> +	memory_stat_format(memcg, buf, PAGE_SIZE);
>  	seq_puts(m, buf);
>  	kfree(buf);
>  	return 0;
> _
> 
> Patches currently in -mm which might be from penguin-kernel@I-love.SAKURA.ne.jp are
> 
> mm-shrinkers-fix-double-kfree-on-shrinker-name.patch
> mm-memcontrol-fix-potential-oom_lock-recursion-deadlock.patch

-- 
Michal Hocko
SUSE Labs
