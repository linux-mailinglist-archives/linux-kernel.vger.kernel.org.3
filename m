Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1A852406F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348931AbiEKW5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348903AbiEKW5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:57:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DDD2497D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:57:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i24so3204109pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9yXJvnjx/o79AbzLsEFrXFeMDWpjXjlNcwmtm1szoOU=;
        b=UtGQ4/CAfCeH/O9+csNNNkaE14rK/X03RFdYAGSClArx3h8ybbDCwBrTlLL9m5+qBy
         McW35EiTRjN1GCHXyXs6Mfi19vXnTclGUF+rgOa7Xd7C2XUaq0u5BNRJM+CVoZHJ1Aph
         YHDZV08sIpsY4TPCN+WyF5vxtQRHHF7YXxHdCcZwbufHz7kUbkFxyGU2+b3h/pcYG5+g
         27GeVPW5vjpgYBBRS4mujL/RHvGwP8JF2z2BtfCQus4NB7wr8fGsL1xsuiKGyvsgoqkV
         lFq2pHsfJcvjg2hfb6WpWH+Oc2JeXGAiQanmTn2q2fNs2jRLfLjqI5erFiMoc34kVMNj
         iSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9yXJvnjx/o79AbzLsEFrXFeMDWpjXjlNcwmtm1szoOU=;
        b=fYIH+fRZI5R2ipRCWsaFZQYDqnJJ4XSnGtZ6KyTfvCoGa3y7o/oo4ixwMUHWrANLwh
         XyD8TluJ4+v+fpSUcwQVreVXFgtt6qt8IszgcnVzui9ROi0IQt4N34ijwmI7qw8YeFm5
         gCOm8nQiTK7UFk0EW5RdAzuy02tA3AO1tUQeAwD47iYgMaas8kjqWa6wfCpCgJIdIHq/
         L06Gv3szughjtApu8z2CMobFi8Ch7dHqfM0Y1lOwqA3tGAwxkG9uBHEcHoHxhOuUrBew
         Yl7khi9rox6NWbGP4wsVf1MKr/XECC5OA30CC/2nP/5Lbl4By32SMPwvZfg9T+Kt5pvc
         D2Ug==
X-Gm-Message-State: AOAM531U8IE6UePnmu6Oc89chcHI4SuKnxXgJCJ4f2dfnWs+PsbVKDys
        TQkFJZ6kyoYQxGgCkUmaxso=
X-Google-Smtp-Source: ABdhPJzJ2E3xWrJdZzusj/3ISttLYh2ci3j4CSdYw216rzo0CfnJ9NObxZixnT6MI/8vy0yNNDxfgQ==
X-Received: by 2002:a65:6e88:0:b0:382:3851:50c8 with SMTP id bm8-20020a656e88000000b00382385150c8mr23132564pgb.270.1652309831741;
        Wed, 11 May 2022 15:57:11 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id e3-20020aa78c43000000b0050dc7628182sm2322162pfd.92.2022.05.11.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:57:11 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 15:57:09 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Martin Liu <liumartin@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v4] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <Ynw/RRsEj33gq+Hf@google.com>
References: <20220510215423.164547-1-minchan@kernel.org>
 <20220511153349.045ab3865f25920dce11ca16@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511153349.045ab3865f25920dce11ca16@linux-foundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:33:49PM -0700, Andrew Morton wrote:
> On Tue, 10 May 2022 14:54:23 -0700 Minchan Kim <minchan@kernel.org> wrote:
> 
> > The rmap locks(i_mmap_rwsem and anon_vma->root->rwsem) could be
> > contended under memory pressure if processes keep working on
> > their vmas(e.g., fork, mmap, munmap). It makes reclaim path
> > stuck. In our real workload traces, we see kswapd is waiting the
> > lock for 300ms+(worst case, a sec) and it makes other processes
> > entering direct reclaim, which were also stuck on the lock.
> > 
> > This patch makes lru aging path try_lock mode like shink_page_list
> > so the reclaim context will keep working with next lru pages
> > without being stuck. if it found the rmap lock contended, it rotates
> > the page back to head of lru in both active/inactive lrus to make
> > them consistent behavior, which is basic starting point rather than
> > adding more heristic.
> > 
> > Since this patch introduces a new "contended" field as out-param
> > along with try_lock in-param in rmap_walk_control, it's not
> > immutable any longer if the try_lock is set so remove const
> > keywords on rmap related functions. Since rmap walking is already
> > expensive operation, I doubt the const would help sizable benefit(
> > And we didn't have it until 5.17).
> > 
> > In a heavy app workload in Android, trace shows following statistics.
> > It almost removes rmap lock contention from reclaim path.
> 
> What might be the worst-case failure modes using this approach?
> 
> Could we burn much CPU time pointlessly churning though the LRU?  Could
> it mess up aging decisions enough to be performance-affecting in any
> workload?

Yes, correct. However, we are already churning LRUs by several
ways. For example, isolate and putback from LRU list for page
migration from several sources(typical example is compaction)
and trylock_page and sc->gfp_mask not allowing page to be
reclaimed in shrink_page_list.

> 
> Something else?

One thing I am worry about was the granularity of the churning.
Example above was page granuarity churning so might be execuse
but this one is address space's churning, especically for file LRU
(i_mmap_rwsem) which might cause too many rotating and live-lock
in the end(keey rotating in small LRU with heavy memory pressure).

If it could be a problem, maybe we use sc->priority to stop
the skipping on a certain level of memory pressure.

Any thought? Do we really need it?
