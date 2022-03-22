Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD524E491A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiCVWXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiCVWXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:23:32 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EED6276;
        Tue, 22 Mar 2022 15:22:04 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id b5so7282312ljf.13;
        Tue, 22 Mar 2022 15:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBOj/TLACVoWvnbuI9+M850QymsVSm9rsUXb8l3wuag=;
        b=TquQjP65YymaRqWO2/ezIYqyGJMH1WkxdL1sLhtgQGm8w1l/KO7DwFe8GdGtJhnP70
         PhdOkr3A1KyPuGBsUWDf5XmsUeyl1zCP9+FSIs3JWPlF/JucsyYotPebPuPEhGS1C8Cx
         NRwE0yCZ6zc6mMRR0rZdfibqrw6rq2tNl2jacM06HJNF88+WraohebHPL6vTy+QGiAT6
         iM4eMSXjvlUd7TmG5Pj14j0r52sixQrVsLEV0tgCJzvjz9HrqtbuVPTFE55y7alnusFf
         4xuf6wHei2LbaMyzEW33qDCxQ2dRSlqH1LnC83OATL3iz4YPWGsl+IaOhuZIknb6K2lG
         pRfw==
X-Gm-Message-State: AOAM531r8jMmXBKxJQdmULHcX7xn/aKk25jTLQh7VKBsN3YNnonhKhY+
        NoZKQlHe9ssaovvsk14kBsM5BGqYfdZerGIA+3o=
X-Google-Smtp-Source: ABdhPJwXgsXaKHttITvr+kTe2b2qhetY6HiHTVuHHul+MFEHOIlrwyJaGpWbJz1WiOWxeRWBT/9ljeje0QcvRf8tT38=
X-Received: by 2002:a05:651c:1544:b0:249:8c80:4282 with SMTP id
 y4-20020a05651c154400b002498c804282mr5965016ljp.202.1647987722546; Tue, 22
 Mar 2022 15:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com> <YjnIpn/PCM6wKpOC@hirez.programming.kicks-ass.net>
In-Reply-To: <YjnIpn/PCM6wKpOC@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Mar 2022 15:21:51 -0700
Message-ID: <CAM9d7cju-Z0_+WuhCZ+Y-4Hm6MCmXbF6XVBGd-n8BP_yoici5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] perf/core: Introduce percpu perf_cgroup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 6:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 22, 2022 at 08:08:30PM +0800, Chengming Zhou wrote:
> > Although we don't have incosistency problem any more, we can
> > have other problem like:
> >
> > CPU1                                  CPU2
> > (in context_switch)                   (attach running task)
> >                                       prev->cgroups = cgrp2
> > perf_cgroup_sched_switch(prev, next)
> >       cgrp2 == cgrp2 is True
> >
>
> Again, I'm not following, how can you attach to a running task from
> another CPU ?

I think it's supported from the beginning by writing PID to a file
in the cgroupfs.

Thanks,
Namhyung
