Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74875201D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiEIQCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbiEIQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:02:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2B2D9EDF
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:58:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 204so9816993pfx.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ovHXHnJzD5F69EY5C8hXYAXQBThNl0UDtBld+Nc6kDM=;
        b=Y8+UTuE9qeljoEsdsMcpsv3oxDrb/2FBxEGKuiL5xCmn3CiW6pS0Fm4tn9voCBQI+u
         RAI5ETb94t3B1yB4ZK8TY6hPB7IfdoJT0UsP1SyBmgxoJZJNZCXy20h/u9MUSEce0xNv
         eCFB9oT6x65f/MJjK45SAwcQdlCcP7MlqbtUUgp/8Fw08t9CmugmKGVZHxdly+4s2swW
         vn5gRt4K5VILxWzB4wFY8jd/sAfIg347Vo1r3Qx4YTkIObNBkNmITALmiaCeJL4hI27S
         fPCvY9AfuRDZR6PhDHEguxpM+I2xRZo+uRg4qfGCkN1sqNNkyrmYwienXZLWQm+wdeM7
         tAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ovHXHnJzD5F69EY5C8hXYAXQBThNl0UDtBld+Nc6kDM=;
        b=ZsGbv/oScDYqBOk1zkm9obrSWwt6AgHALF2WJmMXrgZJa/qNlv6b7VxVY6wv0UnFWg
         9s9kXY8Q26hcQjf5/gSWfNXR8WFuPAvSrF9BRFXTfSCh9Y1emOob8b+6QGKhCt+OzTwe
         gLUuQ2ZylCbN8022c09w3i3gUgCgd3zPDK3YxYcbXNCJGvxthRv/Y29r82tEDUQLHKqr
         zs85usDXoudZ4hU3BY2ypikQW5XAvNWCvk2uM8Ll2hImbrqN3UM1TbIkmtbJRuiXWEtF
         qtuVUrxy0cnirueF/7Wdio66tS3jH5iTvu6ThZ6Zwy+yTU7SrV5Cce1B/LUiahipF5lP
         uohg==
X-Gm-Message-State: AOAM532mUOfM6b4BlARKyrN5/VkhAh/Aqr1jjSeoO6Jcux54tPvENZl3
        +Iwpu334rwn3iZaehmWVqVQ=
X-Google-Smtp-Source: ABdhPJx11e9DSVY97nEoONFZQfdsmDx9mqofMqF27/c4ah5COn8w5JA+AhFPJYKwJe50Mig/9urKjw==
X-Received: by 2002:a63:2bd4:0:b0:3c5:ecc9:6064 with SMTP id r203-20020a632bd4000000b003c5ecc96064mr13352533pgr.397.1652111933752;
        Mon, 09 May 2022 08:58:53 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3704:694b:acc0:e064])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090acd0600b001cd4989fed4sm12907302pju.32.2022.05.09.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:58:53 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 9 May 2022 08:58:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 0/6] Drain remote per-cpu directly v2
Message-ID: <Ynk6O4WAut0Ejl7Z@google.com>
References: <20220509130805.20335-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509130805.20335-1-mgorman@techsingularity.net>
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

On Mon, May 09, 2022 at 02:07:59PM +0100, Mel Gorman wrote:
> Changelog since v1
> o Fix unsafe RT locking scheme
> o Use spin_trylock on UP PREEMPT_RT

Mel,


Is this only change from previous last version which has some
delta you fixed based on Vlastimil and me?

And is it still RFC?

Do you have some benchmark data?

I'd like to give Acked-by/Tested-by(even though there are a few
more places to align with new fields name in 1/6) since I have
tested these patchset in my workload and didn't spot any other
problems.

I really support this patch to be merged since the pcp draining
using workqueue is really harmful in the reclaim/cma path of
Android workload which has a variety of process priority control
and be stuck on the pcp draining.

> 
> This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> per-cpu lists drain support" -- avoid interference of a high priority
> task due to a workqueue item draining per-cpu page lists. While many
> workloads can tolerate a brief interruption, it may be cause a real-time
> task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> the draining in non-deterministic.
> 
> Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> The local_lock on its own prevents migration and the IRQ disabling protects
> from corruption due to an interrupt arriving while a page allocation is
> in progress. The locking is inherently unsafe for remote access unless
> the CPU is hot-removed.
> 
> This series adjusts the locking. A spinlock is added to struct
> per_cpu_pages to protect the list contents while local_lock_irq continues
> to prevent migration and IRQ reentry. This allows a remote CPU to safely
> drain a remote per-cpu list.
> 
> This series is a partial series. Follow-on work should allow the
> local_irq_save to be converted to a local_irq to avoid IRQs being
> disabled/enabled in most cases. Consequently, there are some TODO comments
> highlighting the places that would change if local_irq was used. However,
> there are enough corner cases that it deserves a series on its own
> separated by one kernel release and the priority right now is to avoid
> interference of high priority tasks.
> 
> Patch 1 is a cosmetic patch to clarify when page->lru is storing buddy pages
> 	and when it is storing per-cpu pages.
> 
> Patch 2 shrinks per_cpu_pages to make room for a spin lock. Strictly speaking
> 	this is not necessary but it avoids per_cpu_pages consuming another
> 	cache line.
> 
> Patch 3 is a preparation patch to avoid code duplication.
> 
> Patch 4 is a simple micro-optimisation that improves code flow necessary for
> 	a later patch to avoid code duplication.
> 
> Patch 5 uses a spin_lock to protect the per_cpu_pages contents while still
> 	relying on local_lock to prevent migration, stabilise the pcp
> 	lookup and prevent IRQ reentrancy.
> 
> Patch 6 remote drains per-cpu pages directly instead of using a workqueue.
> 
>  include/linux/mm_types.h |   5 +
>  include/linux/mmzone.h   |  12 +-
>  mm/page_alloc.c          | 342 +++++++++++++++++++++++++--------------
>  3 files changed, 230 insertions(+), 129 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
