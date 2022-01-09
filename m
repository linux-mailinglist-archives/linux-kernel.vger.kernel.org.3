Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED7B488983
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 14:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiAINNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 08:13:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230321AbiAINNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641733994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uT7cy64aDIsHt4e4i1Tq/qdXkCDa411a5WZTTwRDOSM=;
        b=G+5+MRVIwvBT3Nu4jqedZqkeDvnzYi1uRL+n2NJtvfxYG7Cah/2qTEYz0CF+1hiX76uxO/
        +tL0So0xCKTaheSF9HNl8GHj3UgJ9K5XplpmfAiQuyY0UX0ccAAXIncjlJz3l/VdopdSh1
        88EDDZgLr/Je9IvFLbUWDjeXDk+060w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-MRnG9wKKMj6-47ck9oQwBw-1; Sun, 09 Jan 2022 08:13:13 -0500
X-MC-Unique: MRnG9wKKMj6-47ck9oQwBw-1
Received: by mail-wm1-f72.google.com with SMTP id b9-20020a7bc249000000b00347c5699809so3047043wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 05:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uT7cy64aDIsHt4e4i1Tq/qdXkCDa411a5WZTTwRDOSM=;
        b=UgmqGsTOaYPs9DKH+XlKQDLfjE+n2dBQfu5asGw9ea9jcEtEVr6WOOU1srbob4oy/P
         8AGEuWKWMHR/rkVDZ949o7hn9qxpDm2mpHH2AF0GrtYqQ4z8IizDdz0+ypHHq8EzQpLL
         x5uM8tMs8tjyinbZYkBQ96H8DBrqJn6I//9LtkOlClJKg9/5WtO5j4lmkSDMAgIjBpTW
         Z67aHkfbAF3/MjRi0RojAK7kiCYjeddpL3v5t+dpRtiS5NWF2Xbjr8F9XwaocYU7i3ts
         f7WSgwGgjmx7mCNOOfBRU3VmUu3EnvXXRyy4TzAAGCWqS7LVnwO15TrQgVSGtMDOJyaG
         WvQA==
X-Gm-Message-State: AOAM5331eR6R/zGTAd3JqNoE1FqWhIZYazxykcqICGvHnC6HrYHbcLQQ
        HAICuJtFSVf5wj+7AXNCBUCfTI90oDHBxTcCmu0VpmbVzindWHVFvfQzuN5clJZlhiKm5syuoNL
        AMt2hRcim2cuBard7CWEagGvx
X-Received: by 2002:a05:6000:1c05:: with SMTP id ba5mr12496668wrb.298.1641733991954;
        Sun, 09 Jan 2022 05:13:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoP2envJRbVrD9D80dEN5ERud2buziDFACuAgsR5G8+LrxxePNhYWW7/2hkTgk9aFdwn1nyA==
X-Received: by 2002:a05:6000:1c05:: with SMTP id ba5mr12496653wrb.298.1641733991717;
        Sun, 09 Jan 2022 05:13:11 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id b13sm4189181wrh.32.2022.01.09.05.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 05:13:11 -0800 (PST)
Date:   Sun, 9 Jan 2022 14:13:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET 0/6] perf lock: Random updates for the locking
 analysis (v1)
Message-ID: <YdrfZViFXdGF+3vc@krava>
References: <20220104182054.25009-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104182054.25009-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 10:20:48AM -0800, Namhyung Kim wrote:

SNIP

> With -c option, the hrtimer_bases.lock would be combined into a single
> entry.  Also note that the lock names are correctly displayed now.
> 
>   # perf lock report -c
>                   Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns) 
>   
>          rcu_read_lock     251225          0               0               0               0               0 
>     hrtimer_bases.lock      39449          0               0               0               0               0 
>    &sb->s_type->i_l...      10301          1             662             662             662             662 
>       ptlock_ptr(page)      10173          2             701            1402             760             642 
>    &(ei->i_block_re...       8732          0               0               0               0               0 
>            &base->lock       6705          0               0               0               0               0 
>            &p->pi_lock       5549          0               0               0               0               0 
>    &dentry->d_lockr...       5010          4            1274            5097            1844             789 
>              &ep->lock       2750          0               0               0               0               0 
>    &(__futex_data.q...       2331          0               0               0               0               0 
>                 (null)       1878          0               0               0               0               0 
>       cpu_hotplug_lock       1350          0               0               0               0               0 
>       &____s->seqcount       1349          0               0               0               0               0 
>       &newf->file_lock       1001         15            1025           15388            2279             618 
>   ...
> 
> Maybe we can make it default later (with a config and --no-combine-locks).
> 
> You can get it from 'perf/lock-combine-v1' branch at
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (6):
>   perf lock: Convert lockhash_table to use hlist
>   perf lock: Change type of lock_stat->addr to u64
>   perf lock: Sort map info based on class name
>   perf lock: Fix lock name length check for printing
>   perf lock: Add -c/--combine-locks option
>   perf lock: Carefully combine lock stats for discarded entries
> 
>  tools/perf/Documentation/perf-lock.txt |   4 +
>  tools/perf/builtin-lock.c              | 155 +++++++++++++++++++------
>  2 files changed, 124 insertions(+), 35 deletions(-)

LGTM

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> 
> base-commit: b9f6fbb3b2c29736970ae9fcc0e82b0bd459442b
> -- 
> 2.34.1.448.ga2b2bfdf31-goog
> 

