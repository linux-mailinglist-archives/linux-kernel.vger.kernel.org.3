Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D265221CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347726AbiEJQ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347740AbiEJQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:56:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFEA2A5EA4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:52:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v10so15092227pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CAb5qgIGZHvkhuu++jNQ4Uz5Ur68fJI6xcgxESp+i+o=;
        b=PDZyCHMhVV079XeFsWfYUpuAzMxw9Dj9fLHCBNoBEHtgOOVYfFPE9vFw9TSmgxygyy
         k56iRCt97VOVUzxR8ZayCyUZQGx4VihsPQyehAIRjPHQaBdFHTBEVKh/OX+ZM28eDK0u
         hs947ugxSkqWMi6une/oebfVYxHX1S/2l2Er2s0p4grv/euCn8tQLq8OZnVipcya2FwG
         nfxBVBpro71MfkheX/BsaA6FWmi8PUm/4PhqxDtkyIwjcelS+vhdsG3EnLA5f2TWl7pl
         qe5ywlXX8qtoImCrN33fTs5o+HUCaHLEuDjxf5QkW9Ap6BDBPfmEhhQZOwtcGi6JtGMX
         UWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CAb5qgIGZHvkhuu++jNQ4Uz5Ur68fJI6xcgxESp+i+o=;
        b=E8//04fPiTT7Dug7nYCEKf7XEAx0zNmf/yX6DG0mjhj4EETVmHVbqdFndkbNM42drD
         +cuXbhIEaeBCxY45GRA62uHtB+7K37IjZLXgmb+bSsfyrT4Y9+R9aWeV4q59bECsfB7l
         aloPfMaom5gSoYgQJwsowlrcrX7qlFZHREYFcbUjMm8p9yJSooMUWs33U/rpQIjyVbnW
         HMFy5SmlSypZvSJN8hXYRXrMlk1PrbSXeisOS6JlecKQbNTO1dobbI5K7h0WwQzuRF8l
         Ks1GT6gPrGTgHidgyMbxIqSdZHQDioAwSToGfuLv7DVYKw68vNHX9ksO86Mi9BHGlKLm
         owrw==
X-Gm-Message-State: AOAM533cjcN/EkgQS9BPbNYLoCd38QbSoHM9gtdFs4rAf2vHn5ozFuS6
        fLa96wKyQGQHPCSiryKXhXLUKUhCeL4=
X-Google-Smtp-Source: ABdhPJw6Hikjp9mrvhz7MZKs4XHHUXfVCJml38Lqv1YK7ZqexYGfCbD+43KoNFeBZ7FMK74NTpGjBQ==
X-Received: by 2002:a63:2bd4:0:b0:3c5:ecc9:6064 with SMTP id r203-20020a632bd4000000b003c5ecc96064mr17172748pgr.397.1652201574238;
        Tue, 10 May 2022 09:52:54 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:c98a:65b0:edca:b69a])
        by smtp.gmail.com with ESMTPSA id o23-20020aa79797000000b0050dc76281fbsm10780430pfp.213.2022.05.10.09.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:52:53 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 10 May 2022 09:52:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v2] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <YnqYYwGjOEFcN1JQ@google.com>
References: <20220509154710.4132957-1-minchan@kernel.org>
 <20220509115449.f48559dd40a5e5ec95b8ead8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509115449.f48559dd40a5e5ec95b8ead8@linux-foundation.org>
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

On Mon, May 09, 2022 at 11:54:49AM -0700, Andrew Morton wrote:
> On Mon,  9 May 2022 08:47:10 -0700 Minchan Kim <minchan@kernel.org> wrote:
> 
> > The rmap locks(i_mmap_rwsem and anon_vma->root->rwsem) could be
> > contented under memory pressure if processes keep working on
> > their vmas(e.g., fork, mmap, munmap). It makes reclaim path
> > stuck. In our real workload traces, we see kswapd is waiting the
> > lock for 300ms+(a sec as worst case) and it makes other processes
> > entering direct reclaim, which were also stuck on the lock.
> > 
> > This patch makes LRU aging path try_lock mode like shink_page_list
> > so the reclaim context will keep working with next LRU pages
> > without being stuck.
> > 
> > Since this patch introduces a new "contended" field as out-param
> > along with try_lock in-param in rmap_walk_control, it's not
> > immutable any longer if the try_lock is set so remove const
> > keywords on rmap related functions. Since rmap walking is already
> > expensive operation, I doubt the const would help sizable benefit(
> > And we didn't have it until 5.17).
> 
> Some quantitative testing results would be helpful.  Demonstrate
> the benefits of the patch?

In a heavy app workload in Android, trace shows following statistics.
It removes almost of lock contention from those rmap.

Before:

   max_dur(ms)  min_dur(ms)  max-min(dur)ms  avg_dur(ms)  sum_dur(ms)  count blocked_function
         1632            0            1631   151.542173        31672    209  page_lock_anon_vma_read
          601            0             601   145.544681        28817    198  rmap_walk_file

After:

   max_dur(ms)  min_dur(ms)  max-min(dur)ms  avg_dur(ms)  sum_dur(ms)  count blocked_function
          NaN          NaN              NaN          NaN          NaN    0.0             NaN
            0            0                0     0.127645            1     12  rmap_walk_file


I will include this data in the description.
