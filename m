Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62C4AC3A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382194AbiBGPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352704AbiBGPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:19:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9A6C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:19:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 489BD6149E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214B3C340EF;
        Mon,  7 Feb 2022 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644247157;
        bh=L3uW2uNufpo3EKV0ur61IPhrkAVNojlLjNA4+NNHKZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qElIiEV+pd8BYx2+XIS8xpenzHYU9MeJaDCCmK+WI6usOvYWlNemve1s2o/eStXVR
         QTHYqylbqJL5379V//9CAgUPF/3zyw7YwO8+kBVLP3R//8nmghR02YS+wELhzzAYND
         ryl6RKOD1663xyYP2FhjgP3F33j4owWayiSEIqPK+cADm8wfswzEzFypcGDvN+iIi4
         PniAAeafApW5mXyKLFNcIyuX6IZzf/HLhA9D5dgluC9bcGXZK5NcLqpDMhz4vzH5Pa
         gQCHl27jfPkb0UckOUv8g1y5wrE/DpOovUSMfqTUsXJL14T0izDnGwNf91r1lNRVCq
         qOkk8NL2i2Ogw==
Date:   Mon, 7 Feb 2022 16:19:15 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v11 07/13] task isolation: sync vmstats conditional on
 changes
Message-ID: <20220207151915.GA526112@lothringen>
References: <20220204173537.429902988@fedora.localdomain>
 <20220204173554.763888172@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204173554.763888172@fedora.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:35:44PM -0300, Marcelo Tosatti wrote:
> Rather than syncing VM-stats on every return to userspace
> (or VM-entry), keep track of changes through a per-CPU bool.
> 
> This improves performance when enabling task isolated
> for vcpu VMs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> v11:
> - Add TIF_TASK_ISOL bit to thread info flags and use it
>   to decide whether to perform task isolation work on
>   return to userspace     
> 
>  include/linux/vmstat.h |   13 ++++++++++++-
>  mm/vmstat.c            |   29 ++++++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/include/linux/vmstat.h
> ===================================================================
> --- linux-2.6.orig/include/linux/vmstat.h
> +++ linux-2.6/include/linux/vmstat.h
> @@ -22,7 +22,18 @@ int sysctl_vm_numa_stat_handler(struct c
>  #endif
>  
>  #if defined(CONFIG_SMP) && defined(CONFIG_TASK_ISOLATION)
> -void sync_vmstat(void);
> +DECLARE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +extern struct static_key vmstat_sync_enabled;
> +
> +void __sync_vmstat(void);
> +static inline void sync_vmstat(void)
> +{
> +	if (static_key_false(&vmstat_sync_enabled))
> +		__sync_vmstat();
> +}
> +
> +void init_sync_vmstat(void);
>  #else
>  static inline void sync_vmstat(void)
>  {
> Index: linux-2.6/mm/vmstat.c
> ===================================================================
> --- linux-2.6.orig/mm/vmstat.c
> +++ linux-2.6/mm/vmstat.c
> @@ -334,6 +334,31 @@ void set_pgdat_percpu_threshold(pg_data_
>  	}
>  }
>  
> +#ifdef CONFIG_TASK_ISOLATION
> +struct static_key vmstat_sync_enabled;
> +DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +static inline void mark_vmstat_dirty(void)
> +{
> +	if (!static_key_false(&vmstat_sync_enabled))
> +		return;
> +
> +	raw_cpu_write(vmstat_dirty, true);

Why not __this_cpu_write() ? Shouldn't we make sure we are not
preemptible and not mark the wrong CPU?

Thanks.
