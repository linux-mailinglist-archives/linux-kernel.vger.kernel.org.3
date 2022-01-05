Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F49E485178
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbiAEKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbiAEKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:53:16 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650BC061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:53:15 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y70so47921784iof.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 02:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u91RUSIYT5p0XTVAkEJuiBed73+WwWLBIzad/kDfbek=;
        b=E4nEpcuzA0T/R6uxEioFi0RrB2az7KwqsGwFdMCjOZXcSUO1B6wruAm0MmbllUEzIb
         mAadOdJFnrBnnz+0N9HwUakmLRlhq96+51MdFDPf1n7fHMPWEt+4PGZ+zwZ2OOD84eIK
         7sdmkeao9NtFW7hfR4+ij7ori7FNJv3QsYKEvlUmabA52HzKGs+iMmA5rAMVkaUje1rR
         YBVte7h87V/qre6UqtrMX/jJxGrbuYGHJhC8hFG6cNb5HjfAKT3mqwzUzZbh7hWDZJ0b
         9YHlA+R1X3uMV81Ni3PdMJvmm6bGD4+NynyM7urgZGiE/9c8DhIRX6aBIDLS6/dMg2UF
         iRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u91RUSIYT5p0XTVAkEJuiBed73+WwWLBIzad/kDfbek=;
        b=06DHsLNh33h06RrfJKMVkPJC2aLxiN7MkyGyn44sgVdkA3E5QI/6bkpimPqicKhDXx
         nb2BRNNftCRdhDABu1jZ3paLC4upYE/grLjdmQxcs9SEEiUJiL9+Hysxa2GEFUOowCB+
         teCWyfu5u3QhMdzLDA2LUuljd+9QkAFCWGnl04oTQJ4446uSk+9/xq6w1EbP+V8wk7FL
         PKVnoWUlvMyBu3/nuHFDmfXY+rfL4AS+zYRI0qIEnB9FyXl2/nY5ppZiXBll3wcVdtze
         k7DN5y4peNmtkDC/kqLUz+mDIoWlBd/QHWtAkpsDsfS8fMyxniNJT/WEmqk2XjL+LLop
         fqkg==
X-Gm-Message-State: AOAM532Elo9X8Ju+QfG9V1kvPdZOuZX3bH06cUzdTDPFbv9bsu0h/6g/
        VMDMB7IGScqzaz+L/l/pHDqyWw==
X-Google-Smtp-Source: ABdhPJzs+sAfmI2Gp6IGVCopvN0kL6sh3lpkuMa1O7dzJPwnmBMMPnj+98RQ5sR5sKBemYkMpYjM9g==
X-Received: by 2002:a05:6602:2a44:: with SMTP id k4mr25896072iov.43.1641379994997;
        Wed, 05 Jan 2022 02:53:14 -0800 (PST)
Received: from google.com ([2620:15c:183:200:6c8c:5506:7ca2:9dfd])
        by smtp.gmail.com with ESMTPSA id f14sm19073576ila.0.2022.01.05.02.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 02:53:14 -0800 (PST)
Date:   Wed, 5 Jan 2022 03:53:07 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <YdV4k1+zEbtzmUkK@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220105085534.22981-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105085534.22981-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 08:55:34AM +0000, SeongJae Park wrote:
> Hi Yu,
> 
> On Tue, 4 Jan 2022 13:22:19 -0700 Yu Zhao <yuzhao@google.com> wrote:
> 
> > TLDR
> > ====
> > The current page reclaim is too expensive in terms of CPU usage and it
> > often makes poor choices about what to evict. This patchset offers an
> > alternative solution that is performant, versatile and
> > straightforward.
> >  
> [...]
> > Summery
> > =======
> > The facts are:
> > 1. The independent lab results and the real-world applications
> >    indicate substantial improvements; there are no known regressions.
> 
> So impressive results!
> 
> > 2. Thrashing prevention, working set estimation and proactive reclaim
> >    work out of the box; there are no equivalent solutions.
> 
> I think similar works are already available out of the box with the latest
> mainline tree, though it might be suboptimal in some cases.

Ok, I will sound harsh because I hate it when people challenge facts
while having no idea what they are talking about.

Our jobs are help the leadership make best decisions by providing them
with facts, not feeding them crap.

Don't get me wrong -- you are welcome to start another thread and have
a casual discussion with me. But this thread is not for that; it's for
the leadership and stakeholder to make a decision. Check who are in
"To" and "Cc" and what my request is.

> I didn't read this patchset thoroughly yet, so I might missing many things.  If
> so, please feel free to let me know.

Yes, apparently you didn't read this patchset thoroughly, and you have
missed all things that matter to this thread.

> First, you can do thrashing prevention using DAMON-based Operation Scheme
> (DAMOS)[1] with MADV_COLD action.

Here is thrashing prevention really means, from patch 8:
  +Personal computers
  +------------------
  +:Thrashing prevention: Write ``N`` to
  + ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to prevent the working set of
  + ``N`` milliseconds from getting evicted. The OOM killer is invoked if
  + this working set can't be kept in memory. Based on the average human
  + detectable lag (~100ms), ``N=1000`` usually eliminates intolerable
  + lags due to thrashing. Larger values like ``N=3000`` make lags less
  + noticeable at the cost of more OOM kills.

It's about when to trigger OOM kills. Got it? Or probably you don't
understand what MADV_COLD is either?

> Second, for working set estimation, you can either use the DAMOS
> again with statistics action, or the damon_aggregated tracepoint[2].

This is you are suggesting:
  TRACE_EVENT(damon_aggregated,
    TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u",
              __entry->target_id, __entry->nr_regions,
              __entry->start, __entry->end, __entry->nr_accesses)

Now read my doc again:
  +Data centers
  +------------
  +:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
  + format:
  +   memcg  memcg_id  memcg_path
  +     node  node_id

Have you heard of something called memcg? And NUMA node? How exactly
can this tracepoint provide information about different memcgs and
NUMA node?

> The DAMON user space tool[3] helps the tracepoint analysis and
> visualization.

What does "work out of box" mean? Should every Linux desktop, laptop
and phone user install this tool?

> Finally, for the proactive reclaim, you can again use the DAMOS
> with MADV_PAGEOUT action

How exactly does MADV_PAGEOUT find pages that are NOT mapped in page
tables? Let me tell you another fact: they are usually the cheapest to
reclaim.

> or simply the DAMON-based proactive reclaim module (DAMON_RECLAIM)[4].
> [4] https://docs.kernel.org/admin-guide/mm/damon/reclaim.html

How many knob does DAMON_RECLAIM have? 14? I lost count.

> Of course, the integration might not be so simple as seems to me now.

Look, I'm open to your suggestion. I probably should have been nicer.
So I'm sorry. I just don't appreciate alternative facts.
