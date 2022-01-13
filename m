Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FD348D04A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiAMBzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiAMBzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:55:18 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95AC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:55:17 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g81so10786336ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2ktKUT0ZtiLTHav2IC7fy3Mir2Izcd/4dm2wCkI22w=;
        b=SY3ePgM97yidgxNWldi+d7gM+PpsH5FPjvc7229u0dHcM9x2xvBhxPBpCtbkIE8Mvn
         v3x0YpkJFKLpCIrxhFVDZ6qjg95luIe25UpohM3gMidzhz8xsTXuE7u2PPaL6JnO4A1q
         z+jne8C4detQHzRIWzEnj9GkiW55QYLmEDsWux7GVjcfcNvBhMVa3cA/ZFwJ3A7lYry5
         6lFbDsMOwSAuOSDFSPBOr94L4scOLs7aYtKsJck9UWZJqooB+0mGPZxinnHJEE+y/aSO
         sO36FUF+VOnSRMlgUEclnbaVbjOyMAdirr4fngkngenpD87g7Nclp9i4b4uvPwWn3oH7
         k/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2ktKUT0ZtiLTHav2IC7fy3Mir2Izcd/4dm2wCkI22w=;
        b=SnV/lebdwBYPA67ud2989hQykJgFg8AwQe1/mv0UIkOwuDamhecsw3k68YsofcKpvp
         roqV6Euv7qvSWFMATYuctgAQWdtDvYkMETPo4a94NavzGqyXZ0gqTPObbiyLX0njCFqF
         L52kN6FSqGYqGH0tXNz7Llr8hkbUeyW0d2p7ABvxL3ykN54CVhuWzmJzKRSUw3ic4f1G
         kl716UKzfTQF7OTKR/f5/pB3Ll4ESPzXT01SWZvDAkTNmVGWII9Fpw8v0PQ4TZ9R4ojf
         rozFc1fVHsOJ8leKHE5Fa6e2+5xgtmm3L19nrBxOGRgKlVG9tZoJRl7oSNTNL61/Ujkc
         mTTQ==
X-Gm-Message-State: AOAM531LAjSFTlmZtLmSGl6riiR3Umo1vGh4dr39P/GF8e64Rtq5FeTi
        TD+EhGzjbVCTxWya4qITOFgj6SE7t/cT4c/L4bFt8w==
X-Google-Smtp-Source: ABdhPJzp5WTSaM8jBXjAF63cA+JbGQ6c4R2i+vaR3nq1E1ibqxeqGMFdYTwbD4ho9jB2M18AakAz30CcXD6lYHprpeI=
X-Received: by 2002:a25:7ac5:: with SMTP id v188mr3376224ybc.246.1642038916137;
 Wed, 12 Jan 2022 17:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20220107234138.1765668-1-joshdon@google.com> <Yd189wHB2LJcK1Pv@hirez.programming.kicks-ass.net>
 <CABk29NuGs_9uxgbv678W=BGGinZNiUHO5T57FHGbOG+HP-FT2g@mail.gmail.com> <Yd8429VrPCay9cn4@slm.duckdns.org>
In-Reply-To: <Yd8429VrPCay9cn4@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 12 Jan 2022 17:55:05 -0800
Message-ID: <CABk29NtNhj2=6gHLSRp6XK4+BVtoSk3QgKdTbf4dKxTRdvgNtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: add cpu.stat_percpu
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, haoluo@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Wed, Jan 12, 2022 at 12:24 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jan 11, 2022 at 03:38:20PM -0800, Josh Don wrote:
> > Is the concern there just the extra overhead from making multiple
> > trips into this handler and re-allocating the buffer until it is large
> > enough to take all the output? In that case, we could pre-allocate
> > with a size of the right order of magnitude, similar to /proc/stat.
> >
> > Lack of per-cpu stats is a gap between cgroup v1 and v2, for which v2
> > can easily support this interface given that it already tracks the
> > stats percpu internally. I opted to dump them all in a single file
> > here, to match the consolidation that occurred from cpuacct->cpu.stat.
>
> Yeah, nack on this. That part was dropped intentionally. These text pseudo
> files aren't a great medium for this sort of (potentially large) data dump
> and they scale really badly with new fields which we may want to expose in
> the future. For detailed introspection, a better route would be using bpf
> and if that's inconvenient for some reason trying to make them more
> convenient.

Fair enough. Apart from needing to expose an rstat flush mechanism to
BPF, the main issues that come to mind are conveniently associating
with a particular cgroup, and allowing non-root to collect stats
independently. Hao's patch series
(https://lkml.kernel.org/r/%3C20220112192547.3054575-1-haoluo@google.com%3E)
makes this particularly convenient, but that's a topic for a separate
conversation :)
