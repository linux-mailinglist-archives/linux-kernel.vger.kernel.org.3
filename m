Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB4559546
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiFXIWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFXIWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:22:51 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E66F6F798
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:22:50 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3177f4ce3e2so17642397b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYavTSJXzFboA12o1aNqK0Bgv6HNDxoV1o12UwGCEiE=;
        b=uESqRE1SxN4Jbk1e+RGoElruHmMUOFO8NXK/Lko5vIW8BeMSdDfIU3eZmgRlWVioaq
         gagdoIdU0pHlN3wywBLtzlWPdgJ8fsLyyNus8s2EoF0YYTXv9gAD5RtVH7Coio33vH+i
         dLGTugGLEY6Svxu4CCWOPrB/6jnYt7ixOKAAxRnYSLvvTJJC5li89RIUg7ps3IU9IyC1
         hoycvrG9jlZvL+J6GDMSrJ51R8vm2M3PrPurq8yOvMBi0iC/f4DUJiOmMpWaSrhaYG4H
         JxfwjUUWVk0wplShsQ2LzujtCja85gsNXrtgnvnYpXZVFvn1NnjvzO37ds1bZ0WbzPtG
         tfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYavTSJXzFboA12o1aNqK0Bgv6HNDxoV1o12UwGCEiE=;
        b=BPnCyNWOSzWQ53PXxYu4rPjVVjYs3sZEQky6MkcwZK5DpX4qyWhF9rESnYD9uFw5j4
         iLUmKZ45n3q/F1G7VrFuj9OUApj49c52QcecORS9aZ0ECbXMoNtIYd9lwsUa1Y+gcZb/
         Xo5hmh6Yf8bRRlQBuIQCTOAoPNMPrZpl7YufyDzrdkroBNKKwFoiZR+JMbdO9kajJIB4
         IcIE3GwGwha5D62fYDsJ8/R6uT9FGoemQEIMj2Won8aBd5njvbb+pXFdjn0mkJNsw9+k
         l5Rc61/3nYPUac35JKSO+8iKDQV1s1Hl5gmjf+SwDhmJ9tpnDsilJUK54aO3h9dHDco8
         mbnA==
X-Gm-Message-State: AJIora8UAnheSZ9xP6xuzkAu4URJ7+1V4aJ/q9Y4dyxQX1LFWm/KqfrQ
        QjNG5er6JwqGlwNZqkHzLoQmHL65WNn3LKFcUtdSAg==
X-Google-Smtp-Source: AGRyM1s89liEcGvSgNisA5MFGA+M/Col76feL0scmL8S48V5UjieiuwlluuvIIuf8J2NNtTy6+kbwv4Lwf2gFz8CX1I=
X-Received: by 2002:a81:6357:0:b0:30f:dbe5:b8ff with SMTP id
 x84-20020a816357000000b0030fdbe5b8ffmr15440103ywb.67.1656058969618; Fri, 24
 Jun 2022 01:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR02MB4488F89EC5DB73D1FEAE9B4594B59@BYAPR02MB4488.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB4488F89EC5DB73D1FEAE9B4594B59@BYAPR02MB4488.namprd02.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Jun 2022 10:22:38 +0200
Message-ID: <CAKfTPtA7wJBROfRkSQV7FzWaWqoaQjSO7iyqBt6AgGsv2OsNSw@mail.gmail.com>
Subject: Re: Perf regression from scheduler load_balance rework in 5.5?
To:     David Chen <david.chen@nutanix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 at 21:50, David Chen <david.chen@nutanix.com> wrote:
>
> Hi,
>
> I'm working on upgrading our kernel from 4.14 to 5.10
> However, I'm seeing performance regression when doing rand read from windows client through smbd
> with a well cached file.
>
> One thing I noticed is that on the new kernel, the smbd thread doing socket I/O tends to stay on
> the same cpu core as the net_rx softirq, where as in the old kernel it tends to be moved around
> more randomly. And when they are on the same cpu, it tends to saturate the cpu more and causes
> performance to drop.
>
> For example, here's the duration (ns) the thread spend on each cpu I captured using bpftrace
> On 4.14:
> @cputime[7]: 20741458382
> @cputime[0]: 25219285005
> @cputime[6]: 30892418441
> @cputime[5]: 31032404613
> @cputime[3]: 33511324691
> @cputime[1]: 35564174562
> @cputime[4]: 39313421965
> @cputime[2]: 55779811909 (net_rx cpu)
>
> On 5.10:
> @cputime[3]: 2150554823
> @cputime[5]: 3294276626
> @cputime[7]: 4277890448
> @cputime[4]: 5094586003
> @cputime[1]: 6058168291
> @cputime[0]: 14688093441
> @cputime[6]: 17578229533
> @cputime[2]: 223473400411 (net_rx cpu)
>
> I also tried setting the cpu affinity of the smbd thread away from the net_rx cpu and indeed that
> seems to bring the perf on par with old kernel.
>
> I noticed that there's scheduler load_balance rework in 5.5, so I did the test on 5.4 and 5.5 and
> it did show the behavior changed between 5.4 and 5.5.

Have you tested v5.18 ? several improvements happened since v5.5

>
> Anyone know how to work around this?

Have you enabled IRQ_TIME_ACCOUNTING ?

When the time spent under interrupt becomes significant, scheduler
migrate task on another cpu

Vincent
>
> Thanks,
> David
