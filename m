Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8632D47A641
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbhLTIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:50:38 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:40900 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbhLTIuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:50:37 -0500
Received: by mail-pj1-f45.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so1337107pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 00:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p9+kIzX2zRZpA12q8ZaVo/FiqIwT3gc0hricozgRWRo=;
        b=nyVTr2adiFJjnqeh9l3kZ4Dy2IiKTG1V+R6ntKLzVjHVd0pCPehlfAeq9OVarkcDWU
         ViCF6Zw5iFWhU9CdoXhgVI4Xt5e9YSrdPN0ZkptqWYzokd4cjVs1rrAufe6zVlf4obdK
         0h7e/hT+OYUedXN80vlw8pUlyVlY38E10+SfqXt3EE9nq9Xm1QQpj/HmGXkW39ZZNJhe
         gBAMOx6DX/pYU6CFVKzAclD7EI8KBs2q4zTELB864t0pK4dfnEFL1QXyFMVaGO8QyjLB
         BJIPC1PZ3Uy50/PK9oq7KCmu9oP1RTRlZIIGebZGmG3CTTCQczIZbMdgOVMmChJxmVwc
         iRsA==
X-Gm-Message-State: AOAM5329ju6qOOwVkKzXsFqPd1ReMEXhDUdMmbJZsO3p+2Hh1QNEsMKP
        O06ST4npw8Aeg6ZRcTZUh+0=
X-Google-Smtp-Source: ABdhPJzwxevOLrWBPHDrZoK+aCc3OpGXBGdw/ATREwLLVmCo+mHv7H/QAy04KcXUwjmMIZPBd4u0Lg==
X-Received: by 2002:a17:903:1246:b0:148:a3e3:c0d with SMTP id u6-20020a170903124600b00148a3e30c0dmr15860025plh.108.1639990236992;
        Mon, 20 Dec 2021 00:50:36 -0800 (PST)
Received: from sultan-box.localdomain (static-198-54-129-52.cust.tzulo.com. [198.54.129.52])
        by smtp.gmail.com with ESMTPSA id nu18sm2614968pjb.15.2021.12.20.00.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:50:36 -0800 (PST)
Date:   Mon, 20 Dec 2021 00:50:33 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Alexey Avramov <hakavlad@inbox.lv>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, vbabka@suse.cz,
        neilb@suse.de, akpm@linux-foundation.org, corbet@lwn.net,
        riel@surriel.com, hannes@cmpxchg.org, david@fromorbit.com,
        willy@infradead.org, hdanton@sina.com,
        penguin-kernel@i-love.sakura.ne.jp, oleksandr@natalenko.name,
        kernel@xanmod.org, michael@michaellarabel.com, aros@gmx.com,
        hakavlad@gmail.com
Subject: Re: mm: 5.16 regression: reclaim_throttle leads to stall in near-OOM
 conditions
Message-ID: <YcBD2dQEaBkwz/0H@sultan-box.localdomain>
References: <20211124011954.7cab9bb4@mail.inbox.lv>
 <20211124103550.GE3366@techsingularity.net>
 <20211124195449.33f31e7f@mail.inbox.lv>
 <20211124115007.GG3366@techsingularity.net>
 <20211124214443.5c179d34@mail.inbox.lv>
 <20211124143303.GH3366@techsingularity.net>
 <20211127010631.4e33a432@mail.inbox.lv>
 <20211126162416.GK3366@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126162416.GK3366@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 04:24:16PM +0000, Mel Gorman wrote:
> It's somewhat expected. If the system is able to make some sort of
> progress and kswapd is active, it'll throttle until progress is
> impossible. It'll be somewhat variable how long it can keep making
> progress be it discarding page cache or writing to swap but it'll only
> OOM when the system is truly OOM.
> 
> Might be worth trying the patch below on top. It will delay throttling
> for longer with the caveat that CPU usage due to reclaim when very low
> on memory may be excessive.

Mel,

Perhaps my old submission [1] could be helpful here? I could send a refreshed
version if you're interested. Using wall time to throttle reclaim seems quite
catastrophic IMO, given the inherent assumptions it makes about the running
system's performance characteristics and its workloads.

My patch tackles the issue from the opposite direction: rather than throttling
when there's no reclaim progress to be made, my approach stops kswapd early when
there is no longer any need for reclaim, which conveniently doesn't require any
sort of tunable or heuristic since kswapd can just be immediately woken up again
right after if needed.

Looking back, it seems your chief complaint was that my patch may stop kswapd
before it could reclaim up to the high watermark, which could thereby introduce
stalls; however, I've never run into any such issue in my testing, and neither
have the several people who use my patch under a wide range of setups.

[1] https://lore.kernel.org/linux-mm/20200219182522.1960-1-sultan@kerneltoast.com/

Sultan
