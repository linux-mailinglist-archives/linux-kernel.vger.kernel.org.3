Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD7A4E96DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiC1MnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiC1MnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:43:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B95C36F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:41:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bn33so19003251ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MegZaMgRrshb8FVD+WqvuRy2H4KFth7Hnw9qafWigzg=;
        b=sVgBvtgNOiUNfokbcV/UEDxd3JbQxAqFvnxjGqBN4cY1QyDJWCp4TYhdHlVxavEMwT
         NaFhnLpDLEIxIERrZCB/RKEyyreqy/bcT3s8yoTOkaKn3uBV1pHmbsPXVYpKERtWv7I0
         F2mmTxuFI5aPxwkvU3l9pzqSO9KrfYhA0VK+MjuVscOkMFZc4ZdLF72MLLsfQT6khDwD
         ixbnFD9X5+U7gmj1CmiV7l38/zxI2p1W5vRYGm4dgOWaUh6EG+T9+X4UouW6j48gfMhM
         kb3oqKb2aZGEB5WMIFtpmK0Ok5P4JpB/eDJY6Z44vQ+8KQuHELPXJa1Ss3+avqtOwYMK
         4PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MegZaMgRrshb8FVD+WqvuRy2H4KFth7Hnw9qafWigzg=;
        b=YNNGKXCU4VxqsNWuEQssz2Ynp2WTF8UCtkZGOmGWBLztbpr0FV1XzSeksUbzUN36Qx
         A2BW3DBURWJqzKEUF6ozh4pGgGVwYx6v76exsjzw97L3utpq2EHLa2uCcpE6sC2QuEEF
         B1yD4jUOZQmTwUufdwAp6dIkSFj+EjARUIJ0U3lDsJp7tZa7REpw83FcaRft6q6uKCfT
         4m+YPPY2fRVZiDOIA4FRjGOZEFCK1vfh+PwT6iY4S1qJlKkF/Z7ITuXYwP6vPdyDwcps
         10tjSY/u7OB7oPWKJblukn+ACuzdf/6AmIzPwVzxSWaLDdKERE0cpbqaqsaQDLCB0iMf
         BHAg==
X-Gm-Message-State: AOAM531XZs3+/MSa/+V7CP/cj7sbtcufu3hWTY45kbWBT9ffTH42bGmu
        5EB1GMHw07a0MP7dM2s8tJshKr/uBgIz3Ed0FVCJwg==
X-Google-Smtp-Source: ABdhPJz8oYefLtyZH5D4aZO3gwY4fRrPfU6rhkLLTSaJ+H+rVRizSEjRP9apIY+xtVx4iUTTPet971+EQdjqec2tvyg=
X-Received: by 2002:a2e:bc12:0:b0:249:8daa:4de4 with SMTP id
 b18-20020a2ebc12000000b002498daa4de4mr20231163ljf.383.1648471298777; Mon, 28
 Mar 2022 05:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-4-vincent.guittot@linaro.org> <6bee2e39-34a8-905f-084f-379b8476ea98@arm.com>
In-Reply-To: <6bee2e39-34a8-905f-084f-379b8476ea98@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 28 Mar 2022 14:41:27 +0200
Message-ID: <CAKfTPtCr0se4T=21VONvsR1wmxhWFiLDeh-Wpc3xhFxUYMh5OQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, Valentin.Schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
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

On Mon, 28 Mar 2022 at 11:23, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 11/03/2022 17:14, Vincent Guittot wrote:
>
> [...]
>
> > @@ -98,6 +99,22 @@ struct sched_param {
> >   * scheduled on a CPU with no more capacity than the specified value.
> >   *
> >   * A task utilization boundary can be reset by setting the attribute to -1.
> > + *
> > + * Latency Tolerance Attributes
> > + * ===========================
> > + *
> > + * A subset of sched_attr attributes allows to specify the relative latency
> > + * requirements of a task with respect to the other tasks running/queued in the
> > + * system.
> > + *
> > + * @ sched_latency_nice      task's latency_nice value
> > + *
> > + * The latency_nice of a task can have any value in a range of
> > + * [LATENCY_NICE_MIN..LATENCY_NICE_MAX].
>
> s/LATENCY_NICE_MIN/MIN_LATENCY_NICE
> s/LATENCY_NICE_MAX/MAX_LATENCY_NICE

yes

>
> > + * A task with latency_nice with the value of LATENCY_NICE_MIN can be
> > + * taken for a task with lower latency requirements as opposed to the task with
> > + * higher latency_nice.
>
> low latency nice (priority): -20 -> high weight: 1024 ... Doesn't a task
> with MIN_LATENCY_NICE -20 have the highest latency requirements?

IIUC, What Parth wanted to say here is that low latency nice
(priority): -20  is taken for a task which needs low latency. The low
applies to latency not requirements

>
> [...]
