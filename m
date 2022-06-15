Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B2154D405
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349751AbiFOV5M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Jun 2022 17:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346784AbiFOV5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:57:09 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B734924D;
        Wed, 15 Jun 2022 14:57:08 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id i25so4224634oii.7;
        Wed, 15 Jun 2022 14:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NfJNqYnHg5jT84TKlwHYypRpT48LvHsRNmVuy2m2v4U=;
        b=wYeF8l0qC+IcpMO6hWb35lH1oLW1QTmgCxWicgjFILfkJ2d/F1DnGW2ipAgJGfpvaC
         oiDOnTCCIK0/zmJ++tAA80KjrIYIHN1ExUu2ZIqHW2s/ZcNv+3JSly+liwTb57fagJg0
         4cwyAeoN43oEHHZ/27q0jqp5ASMI2DN1To8KWi/28e7tor/J39UHN5TzGvw2INVjJ0ma
         1WJwCUIKqQVYzMjg5Ng9DoTJTaV+7TWOZVMJ4mDEGYzZB05kn/fHGlL+6YjBc2oNL3bK
         TuB+5SDM0o5VakJoW2g6N0OmS4KhHcm9ShVNAS166c89LuO3Clg8I8Bpe1umEbLLtKDt
         hVXA==
X-Gm-Message-State: AJIora8JFxZEN8DwNMFuG5q+i7HhwWFIPjaIN1FO9kXGst24O5Pm2YXb
        4SpGMCM9x9L1cDVrwcOJR9lccfBeiyh3jXYR3KNAO5e8C+s=
X-Google-Smtp-Source: AGRyM1tLEPNDQx/1p/3aUZgmNvB9cB6wTgPhLrf2o1sWbOmJ8VklkTjJ2IjHHfBgp1nDWFK9Qd58NyXSwC/+s2JYg8k=
X-Received: by 2002:aca:bb56:0:b0:32f:2160:bfd8 with SMTP id
 l83-20020acabb56000000b0032f2160bfd8mr958031oif.92.1655330227860; Wed, 15 Jun
 2022 14:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220613094605.208401-1-yangjihong1@huawei.com>
 <20220613094605.208401-10-yangjihong1@huawei.com> <CAM9d7cijyKgCt7su96yM9OWgHP5Hh1UMQh+iBskO+m+rb_y5ww@mail.gmail.com>
 <81afcdb8-0bbf-a28b-d944-770ca3de0397@huawei.com>
In-Reply-To: <81afcdb8-0bbf-a28b-d944-770ca3de0397@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Jun 2022 14:56:56 -0700
Message-ID: <CAM9d7ciZqe76dsF2peo55nDwWSyQEKw1+5TT67gzdWMu2M1POA@mail.gmail.com>
Subject: Re: [RFC 09/13] perf kwork: Add workqueue report support
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 8:22 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Hello,
>
> On 2022/6/15 5:54, Namhyung Kim wrote:
> > On Mon, Jun 13, 2022 at 2:48 AM Yang Jihong <yangjihong1@huawei.com> wrote:
> >>
> >> Implements workqueue report function.
> >>
> >> test case:
> >>
> >>    # perf kwork -k workqueue rep
> >>
> >>      Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
> >>     ---------------------------------------------------------------------------------------------------------------------------
> >>      (w)0xffffffff83e09fa0     | 0001 |   2152.678 ms |       194 |     12.376 ms |    2059361.546621 s |    2059361.558997 s |
> >>      (w)0xffff888332fea180     | 0000 |     17.125 ms |       301 |      1.018 ms |    2059358.441070 s |    2059358.442089 s |
> >>      (w)0xffff8881035a83d8     | 0007 |      7.556 ms |         3 |      3.212 ms |    2059362.614643 s |    2059362.617855 s |
> >>      (w)0xffff888102fc14a0     | 0002 |      7.080 ms |         5 |      1.962 ms |    2059365.421753 s |    2059365.423714 s |
> >>      (w)0xffffffff82f7da00     | 0000 |      4.277 ms |         7 |      3.778 ms |    2059360.851063 s |    2059360.854841 s |
> >>      (w)0xffffffff8305d680     | 0006 |      1.796 ms |         1 |      1.796 ms |    2059360.046818 s |    2059360.048613 s |
> >>      (w)0xffff8883339e9040     | 0005 |      1.659 ms |         2 |      1.619 ms |    2059361.266051 s |    2059361.267670 s |
> >>      (w)0xffff888333de9040     | 0007 |      1.121 ms |         5 |      0.783 ms |    2059368.238059 s |    2059368.238842 s |
> >>      (w)0xffff888332fe9040     | 0000 |      0.990 ms |         4 |      0.911 ms |    2059359.604075 s |    2059359.604986 s |
> >>      (w)0xffff8883331e9040     | 0001 |      0.244 ms |         6 |      0.046 ms |    2059362.689277 s |    2059362.689323 s |
> >>      (w)0xffff888102e44400     | 0007 |      0.239 ms |         2 |      0.137 ms |    2059363.117537 s |    2059363.117674 s |
> >>      (w)0xffff8883333ea180     | 0002 |      0.141 ms |         5 |      0.049 ms |    2059365.423784 s |    2059365.423833 s |
> >>      (w)0xffffffff83062f28     | 0006 |      0.084 ms |         2 |      0.047 ms |    2059358.208033 s |    2059358.208080 s |
> >>      (w)0xffffffff8305ca48     | 0003 |      0.078 ms |         2 |      0.041 ms |    2059361.071371 s |    2059361.071412 s |
> >>      (w)0xffff8883337e9040     | 0004 |      0.062 ms |         1 |      0.062 ms |    2059362.605723 s |    2059362.605785 s |
> >>      (w)0xffff8881035a81e8     | 0001 |      0.056 ms |         1 |      0.056 ms |    2059363.118231 s |    2059363.118287 s |
> >>      (w)0xffff8883335e9040     | 0003 |      0.026 ms |         1 |      0.026 ms |    2059358.573397 s |    2059358.573423 s |
> >>      (w)0xffffffff83062e70     | 0006 |      0.023 ms |         1 |      0.023 ms |    2059368.398864 s |    2059368.398888 s |
> >>      (w)0xffffffff83e06480     | 0002 |      0.000 ms |         1 |      0.000 ms |    2059359.986792 s |    2059359.986792 s |
> >
> > Using "function" in the tracepoint and symbolizing it would be
> > far more intuitive.
> >
> OK，This is a simplified version that will be improved in the next
> version, and I'd like to add the following features:
> 1. Supports the kthread profile.

Could you elaborate more?

> 2. Save runtime and latency in kernel using ebpf(similar to "perf
> record: Implement off-cpu profiling with BPF") . This reduces the number
> of interruptions caused by writing files to hard disks, which is closer
> to the actual scenario.

Sounds great.

>
> This RFC is sent to discuss to see if this function is useful to the
> community and can be accepted by the community. :)

Yeah I think it'd be useful.

Thanks,
Namhyung
