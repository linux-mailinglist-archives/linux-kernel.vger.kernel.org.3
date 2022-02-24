Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94BB4C2FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiBXP3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiBXP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:29:49 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724091BA14C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:29:19 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bn33so3408864ljb.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMjz3GUKEught2ePjPyclv4KwRdqwfnECAei6dKW3vI=;
        b=gFftsX0zxW/J0elk0M3ECgZKjVXIIbavU/YePdhRXkpMslH4BYQQSm30MsSEwKkW+e
         5AM+QDI2cWeD6mu8dLlaGyL/YBEHISsTs16zDwC2BeOsfXMmL2JvRzaY8+vbjTvQ8HDV
         g+Yrl5r0cxVFAbHOZ4ReZzoUOeEb54kGl81MzFf7F+yykMW1xmJ49UvdySchA++r9WUt
         96bluTYY7CZGYQ24S+YJ3CxFuDpopexF88tihcK/fa8VIH8qSoYCAQ0kNvbZjWFOvlWi
         L2Rx2mXxDcF7a2gyCPz5fr8xPq6yRfMZGortCGXJUfVlWtY17nNRu+lRpHLH/NjvkxDh
         zVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMjz3GUKEught2ePjPyclv4KwRdqwfnECAei6dKW3vI=;
        b=6iZTRTgWV2YHM0pRxDD7/vmGNI+DM+d8OI7QqBLkY+Tk9Hw0v0fRuLHSaUR4RfbiX1
         J3idj/BiPnWOq+Tvn0tMz2H+HSGoyYCLE0dt/tsVt6eHLaZ01bwKM7mL82avgjbGKSD8
         CXBX6fkfUONVQddj/w7n/69tyAVxJ28BNW1SvA7Bcqf1E1QWGiMqMxGQAMToNmCCAZhr
         BoXaeOUnJ9yaMi6iRe4zSJMk5ugWSdOhKAd4RNlm7gfBKT58tENagUg5hkyoV5XuYFJl
         vzvSZa9/rhHZiKVsueDaZvqBFKElIcly/SkxtnJGmocQZCavrDB/EFCv/eufz6whWMQz
         AF3A==
X-Gm-Message-State: AOAM531iLNScUGhkQJCcKLnvy4qh751wvVcnJLagTn7H8wnNOTgifqIM
        X8uVqJqTMs6+UdMu0ur/s9XZvBr6lDMEZ23i9Eix8Q==
X-Google-Smtp-Source: ABdhPJyWNQWbKWSU29Xq+LUBZEvcQ2vCZFTH7TFlscZZvLsZwNfmFaJFGMKhd8U6YLb+3JT8tZqkBY/Zm0ZC2XFig0E=
X-Received: by 2002:a2e:a905:0:b0:246:609b:881e with SMTP id
 j5-20020a2ea905000000b00246609b881emr2202891ljq.383.1645716557754; Thu, 24
 Feb 2022 07:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20220217154403.6497-1-wuyun.abel@bytedance.com> <YheiT2pGNDggdFSu@hirez.programming.kicks-ass.net>
In-Reply-To: <YheiT2pGNDggdFSu@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 24 Feb 2022 16:29:06 +0100
Message-ID: <CAKfTPtB_GGb2eZqWfmKrY3-Z9spN9wzU4pXMGz38bAZu8ExCMQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
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

On Thu, 24 Feb 2022 at 16:20, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 17, 2022 at 11:43:56PM +0800, Abel Wu wrote:
> > Current load balancing is mainly based on cpu capacity
> > and task util, which makes sense in the POV of overall
> > throughput. While there still might be some improvement
> > can be done by reducing number of overloaded cfs rqs if
> > sched-idle or idle rq exists.
>
> I'm much confused, there is an explicit new-idle balancer and a periodic
> idle balancer already there.

I agree, You failed to explain why newly_idle and periodic idle load
balance are not enough and we need this new one
