Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A151124F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347148AbiD0H0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiD0H0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:26:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B931C3389C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:23:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651044187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWtbS5lg1a9gM/YQcx7iEZL/3leG2VJ+qMbbrkRFwgE=;
        b=aAUQMbdksTR0gvdDY+Qt2OIL4QBVYOdTBvBWDhAZhxGAOZMQRL6f4JJconDCX4PFYkt+a0
        qBdR8hWwf/HR39Chqy7J3OnutXKJEXnAyhrU0jLSCgX/ir/yREAp0r3SG9LK8d349DkWlH
        gZbmxOf4wAmRYgzczv6A6gqOyPqCvUZQ+ZGyNXCoFXI0tlANvUaQJCYU06O7PDZLLKGe8l
        7OwsYOvu9XLtEYyJECmWMF/BDs2+ffKQQJacZ0tBy6p7Fyew2m+sNHpuD0BAvSf5uo2i1I
        zOPbxZ6rxt3vJW9G29c2f+PFnvkgQPpEcbD44tFuw+O7BUZe3W2zY0hbQF13BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651044187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWtbS5lg1a9gM/YQcx7iEZL/3leG2VJ+qMbbrkRFwgE=;
        b=Et3zD8l3ok5Xr2j3fnO+TSQb0Cuvg4zWjtLZPZ7Rz+tNLnYjrInS/Oc4Qo156HoNF8gjID
        95FKkkl5VMqYzyDQ==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch v12 12/13] mm: vmstat_refresh: avoid queueing work item
 if cpu stats are clean
In-Reply-To: <20220315153314.287031403@fedora.localdomain>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.287031403@fedora.localdomain>
Date:   Wed, 27 Apr 2022 09:23:06 +0200
Message-ID: <874k2fyopx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
>  	/*
>  	 * The regular update, every sysctl_stat_interval, may come later
> @@ -1948,9 +1977,19 @@ int vmstat_refresh(struct ctl_table *tab
>  	 * transiently negative values, report an error here if any of
>  	 * the stats is negative, so we know to go looking for imbalance.
>  	 */
> -	err = schedule_on_each_cpu(refresh_vm_stats);
> -	if (err)
> -		return err;
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		struct work_struct *work = per_cpu_ptr(works, cpu);
> +
> +		INIT_WORK(work, refresh_vm_stats);
> +		if (need_update(cpu) || need_drain_remote_zones(cpu))

Of course that makes sense in general, but now you have two ways of
deciding whether updating this is required.

   1) The above

   2) The per CPU boolean which tells whether vmstats are dirty or not.

Can we have a third method perhaps?

Thanks,

        tglx
