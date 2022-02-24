Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCEB4C2463
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 08:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiBXHKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 02:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiBXHKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:10:36 -0500
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF025230E42
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 23:10:06 -0800 (PST)
Received: by mail-oi1-x249.google.com with SMTP id w21-20020a056808091500b002d724f37efeso718278oih.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 23:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0HxuerY811sRCg0Jfk4JZiV8GyWj5zsy+8XByk2p3uE=;
        b=h044Pz91gVuphvakkKNhmZHHx6f6K0RMTVPCT1RY4ZuAIIRan7B3CdSOs0SFunl1gd
         I3V35Gy1MLUYGHta+YPdVS7oD/v2rnkX5ACpfzrdFQaEAbP61qP1dpwR+pKVWCz+KQj4
         kQevPpY1kjJ9v2JyI6mmU5fJmgpxY138W7S8zD6w0fTekRTcbVKexQpUfrh3klr5HeG1
         bhjeN6fIlAJ8T0KFgpq1AxOiVZC2PM2r5o+WuYNIX+qeRqQl4nAthw8n4NTG9SeQiVF3
         /Z8jUuCCvxoi6aDec1q6eL5HFiFKGSYGWwJFIlpo4QCACWab5smKNaimXFA1IKCFL2kM
         fxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0HxuerY811sRCg0Jfk4JZiV8GyWj5zsy+8XByk2p3uE=;
        b=WvQhh9MSovf0LphIK6P8ca3yXua4OEkbx37k3K2Af183Npa0mwieJkKAgyjOhYQ3nt
         Rz2838Htelf2fIHxl90Dlb7tAh8ZW+9p32KiUDU7jnn11MekqWtGkWmgjl1fL+eKsMig
         sJJBEsGzGQAvxEQ+l1VG4aWY7QvZm/5sihXZV7DlqGxcKcumC/kX7wf4aPT4QJ4mExiQ
         QL7lk6UrJZR4v6d71H8v2dy4jG6aBfjUdC31I/YjxsAhEEM4HLOqLx6OikPtUZvEoKxk
         C0AkIIc5uLwYjffukGTAq2W0QkurnFHsLWu0wYJOiATposPVyPu8yJr1R/JpMR7PuqA7
         AFqQ==
X-Gm-Message-State: AOAM530etAlYeznXo/R2YuKS+j0D2rTrcUG3SOCboRvagCRfnOXquKP6
        1L4LmVZAl+5BCItuHfB5edotz1yxOX2GEg==
X-Google-Smtp-Source: ABdhPJwF/l64e7Ik7fg0Dqg/2ETqDfmi125huEghgMaJKwhrrLZwspr/Y4tMqgu4emOFahgp0JWO+cpz9Ee44Q==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:8c61:13e8:87c2:e5f0])
 (user=shakeelb job=sendgmr) by 2002:aca:f0d:0:b0:2d4:e810:4249 with SMTP id
 13-20020aca0f0d000000b002d4e8104249mr6476444oip.37.1645686606011; Wed, 23 Feb
 2022 23:10:06 -0800 (PST)
Date:   Wed, 23 Feb 2022 23:10:02 -0800
In-Reply-To: <20220223194812.1299646-1-surenb@google.com>
Message-Id: <20220224071002.w3r3at3zhccwu6p6@google.com>
Mime-Version: 1.0
References: <20220223194812.1299646-1-surenb@google.com>
Subject: Re: [PATCH v3 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
From:   Shakeel Butt <shakeelb@google.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        pmladek@suse.com, peterz@infradead.org, guro@fb.com,
        minchan@kernel.org, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 11:48:12AM -0800, Suren Baghdasaryan wrote:
> When page allocation in direct reclaim path fails, the system will
> make one attempt to shrink per-cpu page lists and free pages from
> high alloc reserves. Draining per-cpu pages into buddy allocator can
> be a very slow operation because it's done using workqueues and the
> task in direct reclaim waits for all of them to finish before
> proceeding. Currently this time is not accounted as psi memory stall.

> While testing mobile devices under extreme memory pressure, when
> allocations are failing during direct reclaim, we notices that psi
> events which would be expected in such conditions were not triggered.
> After profiling these cases it was determined that the reason for
> missing psi events was that a big chunk of time spent in direct
> reclaim is not accounted as memory stall, therefore psi would not
> reach the levels at which an event is generated. Further investigation
> revealed that the bulk of that unaccounted time was spent inside
> drain_all_pages call.

> A typical captured case when drain_all_pages path gets activated:

> __alloc_pages_slowpath  took 44.644.613ns
>      __perform_reclaim   took    751.668ns (1.7%)
>      drain_all_pages     took 43.887.167ns (98.3%)

> PSI in this case records the time spent in __perform_reclaim but
> ignores drain_all_pages, IOW it misses 98.3% of the time spent in
> __alloc_pages_slowpath.

> Annotate __alloc_pages_direct_reclaim in its entirety so that delays
> from handling page allocation failure in the direct reclaim path are
> accounted as memory stall.

> Reported-by: Tim Murray <timmurray@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
