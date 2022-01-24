Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA74983DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbiAXPx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiAXPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:53:26 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0536DC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:53:26 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id w8so7284055qkw.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5kW/9SXiovCXkW3uTKPS+tUBIUOqvG4jszJhTXEHiHs=;
        b=e8OGTjrTE+gIW7oKMoEUAmJef11dU2wUDdCIAaqgypBhHISzFrBaRKol3kYHikbvYo
         EzHVTnnXGZNh2qbzSH6vWY5xlXsttvHcRNQ2pnxkujOR7x51vUra6VCYNFpY0Pn/L7LC
         jqK/8G/mBtas/iZ3FH0iCqd5IO6rQuY040KQ1oSD3cLWdcdYD1eRuAQnrmvXBvW1C+Nx
         IsC+SbRy9UPZZTOOmTl4SiXJESYhaD7NgAOCp9M67eb0wK3Rc3kRZlpIyRzG623HJlH9
         Rwu0Zd2Q+Wvb9QnQDtGgDHpa2iCrCebFaZfVA9MCCpUaWN6b3A4t1UcIf3SvoTX/K+rT
         ICNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5kW/9SXiovCXkW3uTKPS+tUBIUOqvG4jszJhTXEHiHs=;
        b=b5LnkELtK5jUsvJPmKLhZdTgaDg6kHLEFvk9Zz6GoxvP2pvh14tEei92ZAmreeEXHo
         qj8trbmXRpFzEv6CMPAXDqk1Dhqn99ZApf93vgH/SVM00jounrX8+f4QfM9Xi3oo0sOA
         oaUQTR/cly1IO+wr5myEsNwdbqxWqV14Rc3rJohL/w3jJZbmtXjhU55vkk8oomPUzu3x
         d8kun7p8aWAsqnH12pqUueGGugu2m8pxjWS6lnsab1iJTP7WRgYuCuxHggPW3XzDkXPg
         WO2cSvVul6vXM6t/4LISzxKp6fS9Hl/2ujXeahs+UbOTQA92M6aSZa+AMqqzkRkywYX4
         mcIw==
X-Gm-Message-State: AOAM532B6ZT1Xebim/LI9DFWxJmW6ZbRmvkQDp3buHqLIN7HMZXAeWPz
        nvx6j5lM9DVMVh9LZ0/tTUFWPQ==
X-Google-Smtp-Source: ABdhPJxji/utSHe1RitivbiagK3oDItR8C7yOgTCJNmg8n1G0uP3RluZUYEGbg/l01s3xcX/E8f+xQ==
X-Received: by 2002:a05:620a:1474:: with SMTP id j20mr3388902qkl.77.1643039605159;
        Mon, 24 Jan 2022 07:53:25 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id f9sm6038831qkp.94.2022.01.24.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 07:53:24 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:53:23 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Resend PATCH v3] psi: fix possible trigger missing in the window
Message-ID: <Ye7Lc1vIVwICZQet@cmpxchg.org>
References: <1642649516-15076-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642649516-15076-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 11:31:56AM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> When a new threshold breaching stall happens after a psi event was
> generated and within the window duration, the new event is not
> generated because the events are rate-limited to one per window. If
> after that no new stall is recorded then the event will not be
> generated even after rate-limiting duration has passed. This is
> happening because with no new stall, window_update will not be called
> even though threshold was previously breached. To fix this, record
> threshold breaching occurrence and generate the event once window
> duration is passed.
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Good catch. The change makes sense to me.

However, I had to re-read the discussion to understand *why*
triggering once per window can be a practical problem. Could you
please include the lkmd scenario you mentioned?

Suren, even though it's your suggested code, can you please also add
ack/review tags? Thanks!

Some minor inline comments:

> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index 0a23300..87b694a 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -132,6 +132,8 @@ struct psi_trigger {
>  
>  	/* Refcounting to prevent premature destruction */
>  	struct kref refcount;
> +
> +	bool threshold_breach;

Something like bool pending_event would be more descriptive, IMO.

Also please remember to add a short comment like we have for the other
struct members. For example:

	/* Deferred event(s) from previous ratelimit window */

> @@ -524,24 +524,29 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>  	 */
>  	list_for_each_entry(t, &group->triggers, node) {
>  		u64 growth;
> +		bool trigger_stalled =
> +			group->polling_total[t->state] != total[t->state];

Triggers don't stall, they trigger on stalls. How about this:

		bool new_stall;
		u64 growth;

		new_stall = group->polling_total[t->state] != total[t->state];

(order local declarations by length, avoid line wraps where possible)

> -		/* Check for stall activity */
> -		if (group->polling_total[t->state] == total[t->state])
> -			continue;
> -
> -		/*
> -		 * Multiple triggers might be looking at the same state,
> -		 * remember to update group->polling_total[] once we've
> -		 * been through all of them. Also remember to extend the
> -		 * polling time if we see new stall activity.
> -		 */
> -		new_stall = true;
> -
> -		/* Calculate growth since last update */
> -		growth = window_update(&t->win, now, total[t->state]);
> -		if (growth < t->threshold)
> +		/* Check for stall activity or a previous threshold breach */
> +		if (!trigger_stalled && !t->threshold_breach)
>  			continue;

This could use a bit more explanation imo:

		/*
		 * Check for new stall activity, as well as deferred
		 * events that occurred in the last window after the
		 * trigger had already fired (we want to ratelimit
		 * events without dropping any).
		 */
		if (!new_stall && !t->pending_event)
			continue;

> +		if (trigger_stalled) {
> +			/*
> +			 * Multiple triggers might be looking at the same state,
> +			 * remember to update group->polling_total[] once we've
> +			 * been through all of them. Also remember to extend the
> +			 * polling time if we see new stall activity.
> +			 */
> +			new_stall = true;

and then rename this flag `update_total'.

> +			/* Calculate growth since last update */
> +			growth = window_update(&t->win, now, total[t->state]);
> +			if (growth < t->threshold)
> +				continue;
> +
> +			t->threshold_breach = true;
> +		}
>  		/* Limit event signaling to once per window */
>  		if (now < t->last_event_time + t->win.size)
>  			continue;
> @@ -550,6 +555,8 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>  		if (cmpxchg(&t->event, 0, 1) == 0)
>  			wake_up_interruptible(&t->event_wait);
>  		t->last_event_time = now;
> +		/* Reset threshold breach flag once event got generated */
> +		t->threshold_breach = false;
>  	}
>  
>  	if (new_stall)
> @@ -1152,6 +1159,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  	t->last_event_time = 0;
>  	init_waitqueue_head(&t->event_wait);
>  	kref_init(&t->refcount);
> +	t->threshold_breach = false;
>  
>  	mutex_lock(&group->trigger_lock);

Thanks!
