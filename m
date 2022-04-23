Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E351D50CAA3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiDWNdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiDWNdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:33:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC48039B8C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:30:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e642be1a51so92138137b3.21
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Aem2PdHshEukZ4FbitCFbjtHLa6kiNwj57G3fxoNlVk=;
        b=XMNhXPfkwDK4e/banSthnWhXs9a5a1aYvMVU0NMfybXNvVEmGdmNtMSK5oZ++QlHWR
         V3ufPwN5hRsYkM5z7ddo0Hd5/C0+X86gdeDg/EcbOv27ChnnE88NajcxBj4l6hUotTKL
         6tfKwnl6G2aAPMEmhO1Yt7R0ge16i+pGXVJ2xPTzPY66OOpXaSAgdxQEYnybzB9GAExs
         VtlV4OYLzO1vWnYGB9iH8I6VOegPQXleK6VLBFgcWRkY7enBxEw+MDSDLoh5bF3WVyfH
         FqpESvZE7ugxZsVz8I+JwrKaWP6J3N54HEMtZksvV6fAOOhKYCeurqhF2C19tTrZ6OiL
         0y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Aem2PdHshEukZ4FbitCFbjtHLa6kiNwj57G3fxoNlVk=;
        b=kOtWv2VFk+nMSg8aIQYX/z0gAHnhXcXEun77OyeDWgjKiVfhkg4T5ds5gFbccji2xb
         ZF+c9nNCfDdWl9NCaw3/9ZJNEFrFG7p1e4rSPObZN3B/aUPqPQ7iv7ZJAbdKqbH+AFT2
         6Ze48pKBnx737oLEVHAT76NzL41AohBlxAZJ4AeAJ/NIxE0l5xqxezfpD9NUioheWrJR
         TlebbF8EAjQ+xHbsViXVQHpmBlRNjIRDFZxmnWCBh/Gqm46nhJPXkJnilAP9AT/0q2AE
         WvpGDsgTuK1p4ZSC5z1A+BBsOM1TAp9N+/l4/V6tS/pg4qIBLMT/N781rHVHB9S7RFWl
         gZQg==
X-Gm-Message-State: AOAM530KTkf6JOv4cO3rn+WsfOfj1dAsU6GUNrk0VxSxvEhZKG8A9t3s
        ys11lYnGeNkT75I/1ZUsto0hL7MwOpw+2A==
X-Google-Smtp-Source: ABdhPJx7g+b3t+7TTJeJC7GYl+CeuU3UNtFktcnoCl3pUuWnyLkIOPvBkq8XTsd2INy154YtYRsMI9zJBpyJaA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:1349:b0:645:d63b:2751 with SMTP
 id g9-20020a056902134900b00645d63b2751mr6582268ybu.165.1650720637980; Sat, 23
 Apr 2022 06:30:37 -0700 (PDT)
Date:   Sat, 23 Apr 2022 13:30:35 +0000
In-Reply-To: <20220421234426.3494842-2-yosryahmed@google.com>
Message-Id: <20220423133035.b6iz6vzhzlym3m4w@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com> <20220421234426.3494842-2-yosryahmed@google.com>
Subject: Re: [PATCH v4 1/4] memcg: introduce per-memcg reclaim interface
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:44:23PM +0000, Yosry Ahmed wrote:
> From: Shakeel Butt <shakeelb@google.com>
[...]
> 
> [yosryahmed@google.com: refreshed to current master, updated commit
> message based on recent discussions and use cases]
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

You should add "Co-developed-by" tag for yourself here.

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Wei Xu <weixugc@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  
[...]
> +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> +			      size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +	int err;
> +
> +	buf = strstrip(buf);
> +	err = page_counter_memparse(buf, "", &nr_to_reclaim);
> +	if (err)
> +		return err;
> +
> +	while (nr_reclaimed < nr_to_reclaim) {
> +		unsigned long reclaimed;
> +
> +		if (signal_pending(current))
> +			return -EINTR;
> +
> +		/* This is the final attempt, drain percpu lru caches in the

Fix the comment format. "/*" should be on its own line.

> +		 * hope of introducing more evictable pages for
> +		 * try_to_free_mem_cgroup_pages().
> +		 */

No need to send a new version if Andrew can fix these in the mm tree.
