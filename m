Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F104F9B87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiDHRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbiDHRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:23:50 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24926393D4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:21:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t13so8310582pgn.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iM6uzIK2cRc6kF+XG8vLt5tKa+TcH20c4ZrUE/qi6/w=;
        b=lhsl/nELK+CjK9EjiqEgxM40CNFrd8O33D5yScOZeEFmN2mtYBl1RRyh7teoVon061
         kj8aY6QVT/NAOTigSUu8Y7225f3BAoDTOIFbFJkqfikA4nBu9W5zKfjzNjscVbUZpCEL
         TOfbFvs9CWUtBubunb4AJlZmBb5dRqOf9Yk4pxiGSjBWmoRGBB5QRajWXj9az8Q251gb
         crS7qVsWxwVcQFaYZGkjAOUYH9TaUrXMqf5Y/wuhESvfTMT3NyPb+tqY6eFtedGk1kHC
         uNhWX+utb/ZtxKPlsJceIR3VICKbc1+Hr9yOvb7P/hl/5YSRR9rMdsoD2qOcmmo91tnf
         ktpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iM6uzIK2cRc6kF+XG8vLt5tKa+TcH20c4ZrUE/qi6/w=;
        b=Ds1UittaIGyhKD7OVQMwlFcGCcXKYiGap9sgiEvHfwW02oh/pE50EV3lzJTKK1bODS
         vILvzHdODqkDgoqW0PO/+YO2RB7a+X45riw7e0GRUhK+RJ+83nbnjSahveKKd3nb2Jm9
         R8X3szlutgKZFI7+bkpMMKIjHGtfhriKVXLFHQ8kPUCtjQfRlgH7Z4gTdCYpq0oOkOoO
         G5BFnhTifO26Q8avoXyZrHSzLQdDmAY7Xs2mNJogzuT0HslEX1jc1LneMJRVUC/+7qcq
         pvXdF2bu97wuvoQhuqwxzcvtaEq5flj32sdxdKvtjrwy/Sen3fNhHHTGxdybyK4S1sQI
         t2QA==
X-Gm-Message-State: AOAM530zOk0gaYrB/cxrBkJzdD1+oV0nqAz+ubyEnTSKdJ6acjhBleao
        G+UFKHeSHWheGoMvMw5yZp/4nvGtxwknroe86gasPA==
X-Google-Smtp-Source: ABdhPJyC7OqfNQfRa6C4f4USe56Z81wNzno+TIeM/lYp3ZM7PQEnEsoenRPgyb0yZY/kqYDC5BKIP2jJs8oo5ma2nH0=
X-Received: by 2002:a62:e815:0:b0:505:8dbb:2f33 with SMTP id
 c21-20020a62e815000000b005058dbb2f33mr3189854pfi.68.1649438505432; Fri, 08
 Apr 2022 10:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045743.1432968-1-yosryahmed@google.com>
 <20220408045743.1432968-2-yosryahmed@google.com> <YlA754XNFAmWQcm6@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
In-Reply-To: <YlA754XNFAmWQcm6@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 8 Apr 2022 10:21:09 -0700
Message-ID: <CAJD7tkY8NwjOVeZX30Fc72kp5zRESBWRgXW3Ji-Owp0jjDuEbw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] memcg: introduce per-memcg reclaim interface
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
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
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 6:43 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> On Fri, Apr 08, 2022 at 04:57:40AM +0000, Yosry Ahmed wrote:
> > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > +                           size_t nbytes, loff_t off)
> > +{
> > +     struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > +     unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > +     unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > +     int err;
> > +
> > +     buf = strstrip(buf);
> > +     err = page_counter_memparse(buf, "", &nr_to_reclaim);
>
> Is there a reason not to support "max"? Empty string seems odd to me
> here.

We can certainly support "max" to reclaim as much as we can with
MAX_RECLAIM_RETRIES, if there are no objections from the maintainers.

>
> > +     if (err)
> > +             return err;
> > +
> > +     while (nr_reclaimed < nr_to_reclaim) {
> > +             unsigned long reclaimed;
> > +
> > +             if (signal_pending(current))
> > +                     break;
>
> I think this should be `return -EINTR;`

Yes this makes more sense. I think this was modeled after the if block
in memory_high_write(), but maybe it makes sense there to just report
success as the new high limit was set anyway.
Will change it in the next version.

>
> > +
> > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > +                                             nr_to_reclaim - nr_reclaimed,
> > +                                             GFP_KERNEL, true);
> > +
> > +             if (!reclaimed && !nr_retries--)
> > +                     break;
>
> Here you can just `return -EAGAIN;`

Will do.
>
> > +
> > +             nr_reclaimed += reclaimed;
> > +     }
> > +
> > +     return nr_reclaimed < nr_to_reclaim ? -EAGAIN : nbytes;
>
> Then this can just be `return nbytes;`

Will do.

>
> I'm very much in favor of this new interface. Thanks for working on
> it!

Thanks so much for reviewing it!
