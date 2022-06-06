Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EC253EA9F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiFFKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiFFKjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 601411EED7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654511954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vrelzPu29G5H09jtTZEwLxLwvFgbNRNQUR/RMZob9kk=;
        b=BIfFdbG3STvzThfuh0xqouXiH5CIpSAFJlN9h6yOEvp9nQyJb+0XbGsX7EVH+CmPbQ0WES
        aGULMAhZ77qkhY++ryQpMWZtpeDGo2Pj8LsZZE31VY+4B7Hd+H+KUWzSQRsSXGsmtEeo67
        U5Y4ChdEnjq9yAGnY8gFw6kJzEqUfqo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-e2akaoG_N_mVW5u3BpvpCA-1; Mon, 06 Jun 2022 06:39:06 -0400
X-MC-Unique: e2akaoG_N_mVW5u3BpvpCA-1
Received: by mail-wr1-f70.google.com with SMTP id r13-20020adff10d000000b002160e9d64f8so1192343wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vrelzPu29G5H09jtTZEwLxLwvFgbNRNQUR/RMZob9kk=;
        b=wMqaM+Oiq+rNcyXLQcwHPW0U4z4rhuTVZt8i6zwSwul5p25S9i04T805ffxtmXjsJL
         FX9LwRnH2LjKbcd7PlpIcPhDofJVSFjkDNyKQ2A/AWbzVP9W1nSjJ1XZA50OGjnAkpa2
         Mp7DkZ9rMMpn0PtIobv+vIh5zE4sFvwtu/AcM/dtrctBBqFNx2JC6Qkntleb/SA8OCH4
         mb5E1SuUz8E+Xwj7NkKadeqShT15rPGbt7haKWT7Ek8qSW5Wt7LY1GlmESul8Puuepz0
         ujQfWemYxmNCv7rb+tRUW4SWHNv6k8UYsL85443DCsd3tVhoztprXYGVDG45OVJd1MYZ
         6aeQ==
X-Gm-Message-State: AOAM532QRW6060tZrSn7Sf65MrwLBeriRfgHKxQ/1DEdL4z7y/n45UzU
        M3XUpbOWbBDDDy32hmuJ8LINJ6zJLmBeIGS2EJ/DDa/w1PIHEWFjHgT4uill/2V7HWlXW0XKCht
        NQAq1m/TLw9F0smBLaJ4lTfe83U7bZ/VX+7oVJioWQR44QUaMDMuBnER1kfZUQ8j9w2nKWAclKy
        LW
X-Received: by 2002:a05:600c:2e47:b0:39c:37f5:cd74 with SMTP id q7-20020a05600c2e4700b0039c37f5cd74mr18196261wmf.32.1654511944525;
        Mon, 06 Jun 2022 03:39:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKoafeR6mqNgLozfLvahQVvFhW4YmdK2FcEIvL5i0RBy3RtCAsfQHJzdnGyZ8saZMekwvLwQ==
X-Received: by 2002:a05:600c:2e47:b0:39c:37f5:cd74 with SMTP id q7-20020a05600c2e4700b0039c37f5cd74mr18196226wmf.32.1654511944174;
        Mon, 06 Jun 2022 03:39:04 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c35d300b0039c2e2d0502sm14335927wmq.4.2022.06.06.03.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 03:39:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] sched: Fix the check of nr_running at queue
 wakelist
In-Reply-To: <20220602040645.275555-2-dtcccc@linux.alibaba.com>
References: <20220602040645.275555-1-dtcccc@linux.alibaba.com>
 <20220602040645.275555-2-dtcccc@linux.alibaba.com>
Date:   Mon, 06 Jun 2022 11:39:02 +0100
Message-ID: <xhsmh4k0y84ah.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/22 12:06, Tianchen Ding wrote:
> The commit 2ebb17717550 ("sched/core: Offload wakee task activation if it
> the wakee is descheduling") checked nr_running <= 1 to avoid task
> stacking when WF_ON_CPU. Consider the order of p->on_rq and p->on_cpu,
> if we have WF_ON_CPU here then we must have !p->on_rq, so the deactivate
> has happened, thus the task being alone on the rq implies nr_running==0.
> Change the check to !cpu_rq(cpu)->nr_running to fix it.
>

I'd flesh this out a bit as in the below:

"""
The commit 2ebb17717550 ("sched/core: Offload wakee task activation if it
the wakee is descheduling") checked rq->nr_running <= 1 to avoid task
stacking when WF_ON_CPU.

Per the ordering of writes to p->on_rq and p->on_cpu, observing p->on_cpu
(WF_ON_CPU) in ttwu_queue_cond() implies !p->on_rq, IOW p has gone through
the deactivate_task() in __schedule(), thus p has been accounted out of
rq->nr_running. As such, the task being the only runnable task on the rq
implies reading rq->nr_running == 0 at that point.

Change the check to !cpu_rq(cpu)->nr_running.
"""

Also, this is lacking some mention of tests that have been run to verify
this isn't causing a regression. This does however make sense to me, so as
long as nothing gets hurt by the change:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bfa7452ca92e..a9efe134fbe5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3830,7 +3830,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>  	 * the soon-to-be-idle CPU as the current CPU is likely busy.
>  	 * nr_running is checked to avoid unnecessary task stacking.
>  	 */
> -	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
> +	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)
>  		return true;
>  
>  	return false;
> -- 
> 2.27.0

