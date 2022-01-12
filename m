Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0668448BB90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbiAKXwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245096AbiAKXwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:52:15 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355C5C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 15:52:15 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id c10so1644775ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 15:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wKkvOi6CL+CUKSws0OOxycjJbGOa3ISqmAvlKnxPaQ=;
        b=WkGpcHKLJcXLClorQAecOFn9CNhS+bceFQ6mofBVna5AihqCPnuTRKd8T6lxX8NGx+
         y9xr8KBnuX7ZQWwJ5bMx3duvt9LbVXxHmhKuodJ3ZTMCgS4Rwq+hYYXUd/Fpw7453nYg
         qP5nSrkC7uPNjA/WMjZN1jxKQ/MejUGNUYgvtMvnCwBEI/8SjF0wLC/v4dqXuywNitA0
         7PMsCuQ23uU9ZuNugxM4t/2r8p5zdFeHUzw6f+sDX9vE7shIFBZbGS0tmy4XI6dFrbla
         HELillMj0V4a/2GYP9c3pupA/g94QCl3RwlNIWYwRNFhsAAZAPlLbWYeHjhMTTGCOqnq
         BKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wKkvOi6CL+CUKSws0OOxycjJbGOa3ISqmAvlKnxPaQ=;
        b=RTzuBMaHIL+TDX+FbOjtpGgmQizzmnQgz1VWPWVNHPuF57FY5lVS4pgbwb6a6BBkn7
         Rga8QKtcfABon/4qMXr8rTe732LlSLogTsoWZOURjFIw9bt5/1cr7DgEs/Af69s7ih/F
         YPqJMlDZKIujULEVCgEYO7HFoSO6Yz9JgcoXLLwXrvl6aKJ51TdCMkmnn1XoF6dni7KA
         5vH2MNq5I3ZIB8B4AfymJfsrrquPeVgDidnmC6xEM8E/KXVMM/0xYEAXvKG4ZG5HLz0Q
         ffTD6M2oD/g+4I9ul50G9UU93CZGsPWR9xfS56GsgV42ZT5iGFR0vz0UPcQOSQT6PYJE
         xX9Q==
X-Gm-Message-State: AOAM532e0Gfvo7DldwB3Q9XcIhUl9Oachi1nWImMNDmPyYrFmHLdosAm
        dlTgQGeM5PXOkpwEjsiarym5Ye1+rYgWhUkU5PNUwA==
X-Google-Smtp-Source: ABdhPJzDlxPB3uXYSLQwUwwUmkRZF91fpJVstFmxZ9CGHtzcqSLt0zalZaAMmtMF1ETT+psG4e1+UnBjKJFKQhStNPU=
X-Received: by 2002:a25:9787:: with SMTP id i7mr2670803ybo.192.1641945133363;
 Tue, 11 Jan 2022 15:52:13 -0800 (PST)
MIME-Version: 1.0
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com> <1641894961-9241-2-git-send-email-CruzZhao@linux.alibaba.com>
In-Reply-To: <1641894961-9241-2-git-send-email-CruzZhao@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 11 Jan 2022 15:52:02 -0800
Message-ID: <CABk29NuX1XYUXj8uZrSjm83n=-uk1LUbRQSMpo2s6er2pTRmDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/core: Accounting forceidle time for all
 tasks except idle task
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 1:56 AM Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
>
> There are two types of forced idle time: forced idle time from cookie'd
> task and forced idle time form uncookie'd task. The forced idle time from
> uncookie'd task is actually caused by the cookie'd task in runqueue
> indirectly, and it's more accurate to measure the capacity loss with the
> sum of both.
>
> Assuming cpu x and cpu y are a pair of SMT siblings, consider the
> following scenarios:
>   1.There's a cookie'd task running on cpu x, and there're 4 uncookie'd
>     tasks running on cpu y. For cpu x, there will be 80% forced idle time
>     (from uncookie'd task); for cpu y, there will be 20% forced idle time
>     (from cookie'd task).
>   2.There's a uncookie'd task running on cpu x, and there're 4 cookie'd
>     tasks running on cpu y. For cpu x, there will be 80% forced idle time
>     (from cookie'd task); for cpu y, there will be 20% forced idle time
>     (from uncookie'd task).
>
> The scenario1 can recurrent by stress-ng(scenario2 can recurrent similary):
>     (cookie'd)taskset -c x stress-ng -c 1 -l 100
>     (uncookie'd)taskset -c y stress-ng -c 4 -l 100
>
> In the above two scenarios, the total capacity loss is 1 cpu, but in
> scenario1, the cookie'd forced idle time tells us 20% cpu capacity loss, in
> scenario2, the cookie'd forced idle time tells us 80% cpu capacity loss,
> which are not accurate. It'll be more accurate to measure with cookie'd
> forced idle time and uncookie'd forced idle time.
>
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---

Thanks,

Reviewed-by: Josh Don <joshdon@google.com>
