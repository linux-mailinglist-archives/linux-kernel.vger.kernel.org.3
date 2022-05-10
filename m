Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E522D5226DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiEJW17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiEJW0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:26:33 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CD93915F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:26:32 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a22so566814qkl.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GA6p49GY5/h4hxBHYG6KGm7j1D9KwWuMzGgnMV4sr8k=;
        b=vJ+i8ZzAZqYZO1y2E4qDXmI6uwjoJ2Zqe/hTyeZdeIAM1jNFVdK2fLliukaoHZ5KBb
         LI/t58R7x6Y+oW11h62WKJw+r7zy8spnG5UDQq4KFVBwiQeDmQG5HUg4ZIbUF6q0nZr9
         oRvbOuKlzmnHzrCTnrAtR1/PI3g8UWmfMWYdw1LAcb67yO7F2mucKP40Dm9ottZi4O38
         6N3VYsj6pSzsneVjLGYvZ/Jyy8ivXmtEU6Bc+03JIFwpahEtC5KLnDb7XGlkcKgKH0Xi
         yOsFybOJOogdT0xClTX61rBQVupFlMbYqkl48kmRiFwO76fP1D1RV61zUAGXnebF+VPP
         2jSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GA6p49GY5/h4hxBHYG6KGm7j1D9KwWuMzGgnMV4sr8k=;
        b=uCaR6wLkaG12siSJb08wzY2vmhiHU0j67r3Ps+bo2Uaa5lJDkpgNEPAET8mgu7AzFK
         B/+sPcd1uV0XDxRYjeuz3dizahcWMURVmWI5E/gNEz85pDKCcH0utEYz0nhwibEJE03L
         859hW+A6alXrdully43fIp1n4uZ9KEA7kNdkpo5a4PLeE8zSteNAQro3SeeDowVAxhqu
         JjTtmzLfTdPG4DEGC6S7TU6R9ZXey8JPsVUvCqI8KoDTUcqI3FKXn08tBL9Qqg9kR5c9
         klzEPkXl82aogOYG/MP6C5Y7OLs9utTsbLVmaihpvJgg/jrLQ+8DVBkLa7lhuJsOQNka
         ZLIQ==
X-Gm-Message-State: AOAM530ouEgG9xOF8AMGHppQeRSXhg/sbf+WGfPR69jY6nQ7YEO6Iclj
        7kDjvOuqfDjgAn+vmlqXnhXrVg==
X-Google-Smtp-Source: ABdhPJwAGE4HpfQr1zyKBBLJJWy5HYIA/l4hWhjPSJAJQttvVB6anLolljlksPKuLHdcda7ozKS91A==
X-Received: by 2002:a05:620a:22a8:b0:69f:ac6c:e6b2 with SMTP id p8-20020a05620a22a800b0069fac6ce6b2mr16337351qkh.403.1652221591545;
        Tue, 10 May 2022 15:26:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id t16-20020ac87610000000b002f3e8d94f8fsm127666qtq.29.2022.05.10.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 15:26:30 -0700 (PDT)
Date:   Tue, 10 May 2022 18:26:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Martin Liu <liumartin@google.com>
Subject: Re: [PATCH v4] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <YnrmlkozgG/9kSoi@cmpxchg.org>
References: <20220510215423.164547-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510215423.164547-1-minchan@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 02:54:23PM -0700, Minchan Kim wrote:
> The rmap locks(i_mmap_rwsem and anon_vma->root->rwsem) could be
> contended under memory pressure if processes keep working on
> their vmas(e.g., fork, mmap, munmap). It makes reclaim path
> stuck. In our real workload traces, we see kswapd is waiting the
> lock for 300ms+(worst case, a sec) and it makes other processes
> entering direct reclaim, which were also stuck on the lock.
> 
> This patch makes lru aging path try_lock mode like shink_page_list
> so the reclaim context will keep working with next lru pages
> without being stuck. if it found the rmap lock contended, it rotates
> the page back to head of lru in both active/inactive lrus to make
> them consistent behavior, which is basic starting point rather than
> adding more heristic.
> 
> Since this patch introduces a new "contended" field as out-param
> along with try_lock in-param in rmap_walk_control, it's not
> immutable any longer if the try_lock is set so remove const
> keywords on rmap related functions. Since rmap walking is already
> expensive operation, I doubt the const would help sizable benefit(
> And we didn't have it until 5.17).
> 
> In a heavy app workload in Android, trace shows following statistics.
> It almost removes rmap lock contention from reclaim path.
> 
> From Martin Liu
> 
> Before:
> 
>    max_dur(ms)  min_dur(ms)  max-min(dur)ms  avg_dur(ms)  sum_dur(ms)  count blocked_function
>          1632            0            1631   151.542173        31672    209  page_lock_anon_vma_read
>           601            0             601   145.544681        28817    198  rmap_walk_file
> 
> After:
> 
>    max_dur(ms)  min_dur(ms)  max-min(dur)ms  avg_dur(ms)  sum_dur(ms)  count blocked_function
>           NaN          NaN              NaN          NaN          NaN    0.0             NaN
>             0            0                0     0.127645            1     12  rmap_walk_file
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
