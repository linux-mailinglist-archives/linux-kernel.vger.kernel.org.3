Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260FD529631
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiEQAyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiEQAyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:54:44 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C28333E80
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:54:43 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2fefb051547so43648607b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3T7zEU19sGE5Plnl9Vaht4RrmQHbsRiV5kkfiBBdKc=;
        b=RtjGPlT3zqjBi6g/bDTHvJiXmIQtqmJgz2y8SJCSDQZoPDbsOcEQ9kKU6Hk8Rwh0ZT
         Xz3KInguaZKzd1GDQe2SKxFzMm4vKqQuiNc+5Z5SVC0KZVm1jfkAB+XM63DUzLn7iMuU
         BFVqfj7t2xSxUdNvYa65Upc+Fv0iVnjgehEyvKENoFyN8idIx91a1vkyeV/4ktQEshOw
         IeCujLLP/SNLdwKEA2RNk5hvscn+0Q7fu9v5nQHRwdW19wDRG8ImGoZntuv3mRD10Z8v
         uCk6yKebGGiRT+P6u647Ou/zGBnK3yiTvo7sjff5sAyGOeLvGHEmpY0LKwRfYlNlrjHu
         lupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3T7zEU19sGE5Plnl9Vaht4RrmQHbsRiV5kkfiBBdKc=;
        b=T2003T1sy++8Xuv6VkSsol6h367XuF5h0XPwzKEZCMaCX43yjwvXH0HDJriTNfjmuT
         fMusaxLZbT2Sb8oP12OauWfFaeJ0j6S+6S09W6zpMGy/C4pgcG9At1yxh0kjDik6H8bw
         c7AcCEFQT/51a81nU8wJrECoz0xWRYUlepeWEK5xDNdKpF8vE6jPRJWy6F+nQhcl2zU3
         WRP8XFbB+Lf7JVP9v3jNq3dLwQTTX9Ms79n8UjNGinIhIHsOBBGiQcX5msDXecE3U0Se
         de69dpuYFDQhrEze7eWPH5UD5LxRFNrxHzRCjhyGTG6OtQtUYn7YbjhocJ3jMwrPxIRd
         CUEg==
X-Gm-Message-State: AOAM531k/75SNlIcpn6rQqvnMVQYAqCvv5+iNXr889teWbWzZnP1vF81
        EFDqA7EnZlm7gNPbTofbRYoG5RsCRqSwBKKRkcdG6w==
X-Google-Smtp-Source: ABdhPJxEriw8iTtrC+eg5FV6EDZCBhdIxS1L5XvgaKaqw1ErDZG1pwm0AMD8riIr821guQjoEpCYTzDCN4HwLSKCUS0=
X-Received: by 2002:a81:108:0:b0:2fb:9664:cbac with SMTP id
 8-20020a810108000000b002fb9664cbacmr23163974ywb.167.1652748882601; Mon, 16
 May 2022 17:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220512163534.2572-1-vincent.guittot@linaro.org> <20220512163534.2572-6-vincent.guittot@linaro.org>
In-Reply-To: <20220512163534.2572-6-vincent.guittot@linaro.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 16 May 2022 17:54:31 -0700
Message-ID: <CABk29Ns-3L1S2xuRg15VxzcXJyNpA6nB2A4jdM9eyx0jiWjn+Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] sched/fair: Take into account latency nice at wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, parth@linux.ibm.com,
        Qais Yousef <qais.yousef@arm.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        Paul Turner <pjt@google.com>, pavel@ucw.cz,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Thu, May 12, 2022 at 9:36 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Take into account the nice latency priority of a thread when deciding to
> preempt the current running thread. We don't want to provide more CPU
> bandwidth to a thread but reorder the scheduling to run latency sensitive
> task first whenever possible.
>
> As long as a thread didn't use its bandwidth, it will be able to preempt
> the current thread.
>
> At the opposite, a thread with a low latency priority will preempt current
> thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
> wait for the tick to get its sched slice.

Following up from the discussion on the prior series, I'm still not
sure why this approach is exclusive of extending the entity placement
code; I think both changes together would be useful.

By only changing the wakeup preemption decision, you're only
guaranteeing that the latency-sensitive thing on cpu won't be
preempted until the next sched tick, which can occur at any time
offset from the wakeup, from 0ns to the length of one tick. If a
latency-tolerant task wakes up with a lot of sleeper credit, it would
pretty quickly preempt a latency-sensitive task on-cpu, even if it
doesn't initially do so due to the above changes to wakeup preemption.

Adjusting place_entity wouldn't impact cpu bandwidth in steady-state
competition between threads of different latency prio, it would only
impact slightly at wakeup, in a similar but more consistent manner to
the changes above to wakeup_preempt_entity (ie. a task that is not
latency sensitive might have to wait a few ticks to preempt a latency
sensitive task, even if it was recently sleeping for a while).
