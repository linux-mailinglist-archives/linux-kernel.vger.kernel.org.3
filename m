Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D55E589F95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiHDQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiHDQ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:56:41 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D641C1D320
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 09:56:38 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z3so251019qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=2IfFvaqIAb3sUtS3vl0hfysQvE8nkRK4dXUfA9HeU1c=;
        b=lld8bLFJEzHSiOXE8dUIcAFqeINLHHTaJxuZkKmUuLhszrVFhi4ZCdyJtYWJNrk+BN
         3M1IoqDvZnGmJN/fl3PUrUqGJETgxVf94wPZH3+8YCmXIDF9+COkle9j6BLIkD9kmM6Q
         fAC+EqXFhHuFxi9AjMLo7Q/qM7MLKi1kkLrBNc37Y+/86EgYV+wj0jI23Jagvfo2GSCj
         flzBqpHyAqsWbI8ciADtfByA+J43zsddfZb9qiCtfD3AAVLXtGXBl9//LYixwYkvRO7I
         DM6OPP115O7Y3uoCuiT70jkUovXqs+Y2yJLbIVfEGGfbLnRuJFXtbfRmEUf8KLz046kj
         oXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2IfFvaqIAb3sUtS3vl0hfysQvE8nkRK4dXUfA9HeU1c=;
        b=ulRabN3OeskLRZQYiE4Xcs3RUd3xVjSK84CH0/qmX99uICpGl5Le0chQ/+t4qo5lHJ
         0lz8UurRUvYv33aD0m5LeJg0b/RGRQ8auJkIiIm6OmmH9/TQm6+sz9ZPrJn6xAFbZppF
         07SYBnEBnbw31OpCcONzW3EkB99QStZ02kGA8ls/ii2+6JRUs9FU5c9nW3m67DXAq/UN
         kn1ylfrLjDfK20Gx8CyUDbqdrRBGS4dmEo7mCyCtUALqv9brcKGExiThHUq/2qhTk6NS
         iKde6H5k/UytCae1+TbYb8t0DVvOSWukW91ZU6NDbbuxoVTrXuiDu0r9TW41YgPkMYGi
         3DQA==
X-Gm-Message-State: ACgBeo1f/EgOFaTC6bgL9ZIlQ5l9JOZW1/NctV2xqvTTr2Vdc3K17/hq
        l6iZ0s3Ekc+hmHJ8IjhaOuvXhQ==
X-Google-Smtp-Source: AA6agR4ucw3JsXuDN3v9VebA4uXtfn5U9BDGDOSS/aCIAHKAbcY9SjifajrjubtBrbbRIRKg2iNHww==
X-Received: by 2002:ac8:5809:0:b0:33d:f8e6:350e with SMTP id g9-20020ac85809000000b0033df8e6350emr2324289qtg.682.1659632197970;
        Thu, 04 Aug 2022 09:56:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::77e5])
        by smtp.gmail.com with ESMTPSA id c25-20020ac84e19000000b00338ae1f5421sm971855qtw.0.2022.08.04.09.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:56:37 -0700 (PDT)
Date:   Thu, 4 Aug 2022 12:56:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Tejun Heo <tj@kernel.org>, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 8/9] sched/psi: add kernel cmdline parameter
 psi_inner_cgroup
Message-ID: <Yuv6RHY0GRGBw+as@cmpxchg.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-9-zhouchengming@bytedance.com>
 <Yt7KQc0nnOypB2b2@cmpxchg.org>
 <YuAqWprKd6NsWs7C@slm.duckdns.org>
 <5a3410d6-428d-9ad1-3e5a-01ca805ceeeb@bytedance.com>
 <Yuq3Q6Y9dRnjjcPt@slm.duckdns.org>
 <YurK6MXdJPrV2VYS@cmpxchg.org>
 <f8444db4-3235-d108-698a-6772e03a6b67@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8444db4-3235-d108-698a-6772e03a6b67@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 09:51:31PM +0800, Chengming Zhou wrote:
> On 2022/8/4 03:22, Johannes Weiner wrote:
> > On Wed, Aug 03, 2022 at 07:58:27AM -1000, Tejun Heo wrote:
> >> Hello,
> >>
> >> On Wed, Aug 03, 2022 at 08:17:22PM +0800, Chengming Zhou wrote:
> >>>> Assuming the above isn't wrong, if we can figure out how we can re-enable
> >>>> it, which is more difficult as the counters need to be resynchronized with
> >>>> the current state, that'd be ideal. Then, we can just allow each cgroup to
> >>>> enable / disable PSI reporting dynamically as they see fit.
> >>>
> >>> This method is more fine-grained but more difficult like you said above.
> >>> I think it may meet most needs to disable PSI stats in intermediate cgroups?
> >>
> >> So, I'm not necessarily against implementing something easier but we at
> >> least wanna get the interface right, so that if we decide to do the full
> >> thing later we can easily expand on the existing interface. ie. let's please
> >> not be too hacky. I don't think it'd be that difficult to implement
> >> per-cgroup disable-only operation that we can later expand to allow
> >> re-enabling, right?
> > 
> > It should be relatively straight-forward to disable and re-enable
> > state aggregation, time tracking, averaging on a per-cgroup level, if
> > we can live with losing history from while it was disabled. I.e. the
> > avgs will restart from 0, total= will have gaps - should be okay, IMO.
> > 
> > Where it gets trickier is also stopping the tracking of task counts in
> > a cgroup. For re-enabling afterwards, we'd have to freeze scheduler
> > and cgroup state and find all tasks of interest across all CPUs for
> > the given cgroup to recreate the counts. I'm not quite sure whether
> > that's feasible, and if so, whether it's worth the savings.
> > 
> > It might be good to benchmark the two disabling steps independently.
> > Maybe stopping aggregation while keeping task counts is good enough,
> > and we can commit to a disable/re-enable interface from the start.
> > 
> > Or maybe it's all in the cachelines and iteration, and stopping the
> > aggregation while still writing task counts isn't saving much. In that
> > case we'd have to look closer at reconstructing task counts, to see if
> > later re-enabling is actually a practical option or whether a one-off
> > kill switch is more realistic.
> > 
> > Chengming, can you experiment with disabling: record_times(), the
> > test_state() loop and state_mask construction, and the averaging
> > worker - while keeping the groupc->tasks updates?
> 
> Hello,
> 
> I did this experiment today with disabling record_times(), test_state()
> loop and averaging worker, while only keeping groupc->tasks[] updates,
> the results look promising.
> 
> mmtests/config-scheduler-perfpipe on Intel Xeon Platinum with 3 levels of cgroup:
> 
> perfpipe
>                                   tip                    tip                patched
>                               psi=off                 psi=on      only groupc->tasks[]
> Min       Time        7.99 (   0.00%)        8.86 ( -10.95%)        8.31 (  -4.08%)
> 1st-qrtle Time        8.11 (   0.00%)        8.94 ( -10.22%)        8.39 (  -3.46%)
> 2nd-qrtle Time        8.17 (   0.00%)        9.02 ( -10.42%)        8.44 (  -3.37%)
> 3rd-qrtle Time        8.20 (   0.00%)        9.08 ( -10.72%)        8.48 (  -3.43%)
> Max-1     Time        7.99 (   0.00%)        8.86 ( -10.95%)        8.31 (  -4.08%)
> Max-5     Time        7.99 (   0.00%)        8.86 ( -10.95%)        8.31 (  -4.08%)
> Max-10    Time        8.09 (   0.00%)        8.89 (  -9.96%)        8.35 (  -3.22%)
> Max-90    Time        8.31 (   0.00%)        9.13 (  -9.90%)        8.55 (  -2.95%)
> Max-95    Time        8.32 (   0.00%)        9.14 (  -9.88%)        8.55 (  -2.81%)
> Max-99    Time        8.39 (   0.00%)        9.26 ( -10.30%)        8.57 (  -2.09%)
> Max       Time        8.56 (   0.00%)        9.26 (  -8.23%)        8.72 (  -1.90%)
> Amean     Time        8.19 (   0.00%)        9.03 * -10.26%*        8.45 *  -3.27%*

Fantastic!

> Tejun suggested using a bitmap in task to remember whether the task is accounted
> at a given level or not, which I think also is a very good idea, but I haven't
> clearly figure out how to do it.
> 
> The above performance test result looks good to me, so I think we can implement this
> per-cgroup "cgroup.psi" interface to disable/re-enable PSI stats from the start,
> and we can change to a better implementation if needed later?

Yes, that sounds good to me.
