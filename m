Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645EB4624A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhK2WXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhK2WVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:21:54 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0CFC21885B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 12:13:14 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso16519780pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 12:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8kKuma19DoqzJ6QAXbY90QDUkkq9MPNT/HcFRm8bmRg=;
        b=HFz5zG0dzzFQmfT6iG5mC35PnwMndF/W86P5u8+xxJ1DltPKn/4Y0auSUFjws1mfAG
         8y9FeIIUhctb1hvuFb99P8grFz3yZdwDRommevmGAVLhbdY1e4xyFO9+BGWzIywxbSv9
         ibCun9EqnWmQkd6c3aSWJB/rJooYrNXHF8AClkrc8w5JsytSNgjO1kFfEK23oLv0Dbww
         iWVe+KXTTNfp4D/4CcSLj467oqoAFH8+SrHgAXjdSPrl9UIll0tNe7cshTglxqzy7JuE
         dvHVE2KYsp0Ucd8/i+y6ZpyR6AzpM5bORmkRzAFBnbjspY3y+kbuhzSIQonEbxbm1k2W
         wivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=8kKuma19DoqzJ6QAXbY90QDUkkq9MPNT/HcFRm8bmRg=;
        b=bn20QD71agKPSklzT9TNTbMQnAdehw9GyGUjJDjWpQnlAP34pxlpj7S21IUrBOEu/b
         a+Yf7L5jQQ/D8KeKFHk8hF/cGjsz+LYRTqEJJspUaPFOs8ti+wgdI7yvoZ9GACPpsdeQ
         AyQvlliAuqZ71bKC7l8v8y2Xl4rmcfMyF9OLHgTrBexNuoZnKzOFyqGaT4OWhmrEE09C
         9906CRnl65OVy5ukPJMs3patc6rTcbZLIrpB2z+PfxwCu4IL5bA2igyDmMqIaOpT2+ZW
         I/MKW/zoSMTBoYXhbhpRwbBvIDaFBAKQJifOvxgpKgedhi0i1/i610DlhTh9mIvsmEf4
         FZCw==
X-Gm-Message-State: AOAM531nyeF938fMuAN11469n4kifKV9eG7z6XJmgs0kJxx2rykH04UA
        VZbom0sL42S+ZfGsZUWp6K1lJw==
X-Google-Smtp-Source: ABdhPJxJGlP2y8vm6IffHIAEPUn0GxzUipHLBwUCVb75Wz1QBpaxqnv8PF6Lt0mIf4wHViDBeZW4iA==
X-Received: by 2002:a17:90a:d3c3:: with SMTP id d3mr278723pjw.209.1638216793987;
        Mon, 29 Nov 2021 12:13:13 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id gc22sm153123pjb.57.2021.11.29.12.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:13:12 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     Honglei Wang <wanghonglei@didichuxing.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>, <jameshongleiwang@126.com>
Subject: Re: [PATCH] sched/fair: prevent cpu burst too many periods
References: <20211129162807.21966-1-wanghonglei@didichuxing.com>
Date:   Mon, 29 Nov 2021 12:13:02 -0800
In-Reply-To: <20211129162807.21966-1-wanghonglei@didichuxing.com> (Honglei
        Wang's message of "Tue, 30 Nov 2021 00:28:07 +0800")
Message-ID: <xm26mtlmpvox.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honglei Wang <wanghonglei@didichuxing.com> writes:

> Tasks might get more cpu than quota in persistent periods due to the
> cpu burst introduced by commit f4183717b370 ("sched/fair: Introduce the
> burstable CFS controller"). For example, one task group whose quota is
> 100ms per period and can get 100ms burst, and its avg utilization is
> around 105ms per period. Once this group gets a free period which
> leaves enough runtime, it has a chance to get computting power more
> than its quota for 10 periods or more in common bandwidth configuration
> (say, 100ms as period). It means tasks can 'steal' the bursted power to
> do daily jobs because all tasks could be scheduled out or sleep to help
> the group get free periods.
>
> I believe the purpose of cpu burst is to help handling bursty worklod.
> But if one task group can get computting power more than its quota for
> persistent periods even there is no bursty workload, it's kinda broke.
>
> This patch limits the burst to one period so that it won't break the
> quota limit for long. With this, we can give task group more cpu burst
> power to handle the real bursty workload and don't worry about the
> 'stealing'.

CC ing the burst patch author.

Whether or not burst is useful only for burst, or also for a bit of
long-term-only fairness is not entirely clear to me. Assuming we want it
only for burst, cutting off this sharply has a bit of additional
downside because it means that if a period refresh lands in the middle
of a burst then you lose the burst runtime. Permitting only two periods
in a row to make use of burst should be doable but it's yet another
piece of state added to cfs_b for this, and given typical ~100ms periods
that may be low enough odds that we don't care.

>
> Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
> ---
>  kernel/sched/fair.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e476f6d9435..cc2c4567fc81 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4640,14 +4640,17 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>  	if (unlikely(cfs_b->quota == RUNTIME_INF))
>  		return;
>  
> -	cfs_b->runtime += cfs_b->quota;
> -	runtime = cfs_b->runtime_snap - cfs_b->runtime;
> +	runtime = cfs_b->runtime_snap - cfs_b->quota - cfs_b->runtime;
> +
>  	if (runtime > 0) {
>  		cfs_b->burst_time += runtime;
>  		cfs_b->nr_burst++;
> +		cfs_b->runtime = cfs_b->quota;
> +	} else {
> +		cfs_b->runtime += cfs_b->quota;
> +		cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
>  	}
>  
> -	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
>  	cfs_b->runtime_snap = cfs_b->runtime;
>  }

If we do this, it should also be mentioned in
Documentation/scheduler/sched-bwc.rst, since the straightforward
description of burst as extra max runtime is no longer enough.
