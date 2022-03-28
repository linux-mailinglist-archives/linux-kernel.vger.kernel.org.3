Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023304E98BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbiC1Nxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiC1Nx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1092D5EDC0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648475508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kNKLf8yfEf9VObJjS6Szdmj1nSgLd4zL/Xd+OpmbEc=;
        b=Fse/Xl7LHjFnfG/id6cF38fiOwDV3Wj/6zmjLLQCw/S3A8gImuA6AkBoC9WNSSweeTpfZg
        tvhIRL8dV5G7DFguZnY9ijPXUhoDeeX37+5uSZbI85e7L6pVp5EHepjXpNzXlydLp4nNxg
        9IRc4TWU9SI+yQB9OGSlzi63NQ8b/Ww=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-S0QTok44Me-_gYOOM7TZlg-1; Mon, 28 Mar 2022 09:51:46 -0400
X-MC-Unique: S0QTok44Me-_gYOOM7TZlg-1
Received: by mail-wr1-f72.google.com with SMTP id p16-20020adfc390000000b00204006989c2so4315623wrf.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7kNKLf8yfEf9VObJjS6Szdmj1nSgLd4zL/Xd+OpmbEc=;
        b=1b+bhkPDbpIw7fuwG4T6EDxxXIv8T28ae6t32FWg9pZRsbudlreqMmr6AvnpCItrOt
         aZGviNC68x3VxS6fFl5I/VV4bz9OBZxMx9WIl1sm/PL3qRtkBHq7BOstG3NvTjSALrra
         zCOmcdD+dokcCyaC/GEdHakpuJXh+Ll7k1OHeopaJjGSGXur6OwvBgUAWG2JYJi7ZfTX
         y7z8iLud1d1hyUbExBdji8DTMJEQXj5HsgnFq1p/FijVCti8Qx/90bvu/LaS/hqmfj6i
         p5AWgtWHPuEpoM0XQZdOq/Fuka+9UOFX8Gr3TvlYZQ5fCPp0ASJzvyI0iW30O76WJMbt
         KB6A==
X-Gm-Message-State: AOAM533dajYwXfbX10KY7MsfNE1FvxIrAVX7iupg955ksh94V+sWDe4t
        Vrl6K12ZbmCnzX1GMwSNz9chVAWERJGLtBEKQWIBjzL8eLAa+FZWQ7HHvo9h1vwmQkqwoauiwvi
        kSBH5CCjNY4MFikisQW//X8Ia
X-Received: by 2002:a05:600c:3c9d:b0:37f:a5c3:fccf with SMTP id bg29-20020a05600c3c9d00b0037fa5c3fccfmr26326991wmb.13.1648475505475;
        Mon, 28 Mar 2022 06:51:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDqmAiCMutmOITS8J5yRNisNHw6matYR2Mqlf/hrWAc0SWh4ga/RYFaM088TWMjvLA8ZIJ9A==
X-Received: by 2002:a05:600c:3c9d:b0:37f:a5c3:fccf with SMTP id bg29-20020a05600c3c9d00b0037fa5c3fccfmr26326947wmb.13.1648475505195;
        Mon, 28 Mar 2022 06:51:45 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3506:3400:69b5:c807:1d52:ff67? ([2a0c:5a80:3506:3400:69b5:c807:1d52:ff67])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm13491929wri.105.2022.03.28.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 06:51:44 -0700 (PDT)
Message-ID: <d21d742154cbd6d2b7546533655810e0bf7dd82f.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, linux-rt-users@vger.kernel.org,
        vbabka@suse.cz, cl@linux.com, paulmck@kernel.org,
        willy@infradead.org
Date:   Mon, 28 Mar 2022 15:51:43 +0200
In-Reply-To: <20220325104800.GI4363@suse.de>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <20220303114550.GE4363@suse.de>
         <3c24840e8378c69224974f321ec5c06a36a33dd3.camel@redhat.com>
         <20220325104800.GI4363@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Fri, 2022-03-25 at 10:48 +0000, Mel Gorman wrote:
> > [1] It follows this pattern:
> > 
> > 	struct per_cpu_pages *pcp;
> > 
> > 	pcp = raw_cpu_ptr(page_zone(page)->per_cpu_pageset);
> > 	// <- Migration here is OK: spin_lock protects vs eventual pcplist
> > 	// access from local CPU as long as all list access happens through the
> > 	// pcp pointer.
> > 	spin_lock(&pcp->lock);
> > 	do_stuff_with_pcp_lists(pcp);
> > 	spin_unlock(&pcp->lock);
> > 
> 
> And this was the part I am concerned with. We are accessing a PCP
> structure that is not necessarily the one belonging to the CPU we
> are currently running on. This type of pattern is warned about in
> Documentation/locking/locktypes.rst
> 
> ---8<---
> A typical scenario is protection of per-CPU variables in thread context::
> 
>   struct foo *p = get_cpu_ptr(&var1);
> 
>   spin_lock(&p->lock);
>   p->count += this_cpu_read(var2);
> 
> This is correct code on a non-PREEMPT_RT kernel, but on a PREEMPT_RT kernel
> this breaks. The PREEMPT_RT-specific change of spinlock_t semantics does
> not allow to acquire p->lock because get_cpu_ptr() implicitly disables
> preemption. The following substitution works on both kernels::
> ---8<---
> 
> Now we don't explicitly have this pattern because there isn't an
> obvious this_cpu_read() for example but it can accidentally happen for
> counting. __count_zid_vm_events -> __count_vm_events -> raw_cpu_add is
> an example although a harmless one.
> 
> Any of the mod_page_state ones are more problematic though because we
> lock one PCP but potentially update the per-cpu pcp stats of another CPU
> of a different PCP that we have not locked and those counters must be
> accurate.

But IIUC vmstats don't track pcplist usage (i.e. adding a page into the local
pcplist doesn't affect the count at all). It is only when interacting with the
buddy allocator that they get updated. It makes sense for the CPU that
adds/removes pages from the allocator to do the stat update, regardless of the
page's journey.

> It *might* still be safe but it's subtle, it could be easily accidentally
> broken in the future and it would be hard to detect because it would be
> very slow corruption of VM counters like NR_FREE_PAGES that must be
> accurate.

What does accurate mean here? vmstat consumers don't get accurate data, only
snapshots. And as I comment above you can't infer information about pcplist
usage from these stats. So, I see no real need for CPU locality when updating
them (which we're still retaining nonetheless, as per my comment above), the
only thing that is really needed is atomicity, achieved by disabling IRQs (and
preemption on RT). And this, even with your solution, is achieved through the
struct zone's spin_lock (plus a preempt_disable() in RT).

All in all, my point is that none of the stats are affected by the change, nor
have a dependency with the pcplists handling. And if we ever have the need to
pin vmstat updates to pcplist usage they should share the same pcp structure.
That said, I'm happy with either solution as long as we get remote pcplist
draining. So if still unconvinced, let me know how can I help. I have access to
all sorts of machines to validate perf results, time to review, or even to move
the series forward.

Thanks!

-- 
Nicolás Sáenz

