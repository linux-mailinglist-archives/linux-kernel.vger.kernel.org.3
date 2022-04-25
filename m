Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FF250E925
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiDYTKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiDYTKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:10:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A9523BC3;
        Mon, 25 Apr 2022 12:07:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t25so27914590lfg.7;
        Mon, 25 Apr 2022 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RWly8sd7d8QeY693RwMY0EPR+uMtvTexbsydzgQnqc=;
        b=D3xhXPdv2YvHfaWlGmDiw1VHNflMWXOyMgJ3FJZzVuqatITEPlZjbNSmUQ704Lx4/S
         u/p1f3uX5f2yrgz7dURzivu2lTtIHSFMr2dVcFe38wVtChTeGUD58LKwS86yzyciqITA
         J1SIQmN7tag8YN0S+YaSxKILd3kxcPDQep5TqySwcQA13ClugAGKo8u7sopM3+Zn0v8F
         7KLnfagruoRL6vpDH1paSm4xv4GUrOyAiis0PGfYEQiaZSZJKRnNH2BZfxTM3czLP4o4
         EzcUfns0WK9KhjG4OCgvQmlIbfDLa42oIiAIYKt9DaiTge1mx3/cnys5/WQq0dHg394e
         XRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RWly8sd7d8QeY693RwMY0EPR+uMtvTexbsydzgQnqc=;
        b=X+CoLsDD33I1N/oeCeM4ILolnMKG5etWrRuB3bx1XLARksbcnEbXReXdg+qryFxAcm
         S4etWd6wVhJ/QgGAhxwsD0Tmvs/xuSi/MOPkJJ3bsNSPmeZuW6MeSjPjd8aPL9oKIslr
         4tpAyMj5durhLCSq0LcI7zpua6BYwh3zLzodbQu/TdsJITCaAqNB3fa/Bvr4LeqoYeMj
         9g2X0UEap70JwLCYggNi0BUFzi9LF6I39dyDc2JJksagCpCwBh2kfkJMnpTgsaYbbsyj
         VpWi9iPlpkFwa5GG4X2NzZHemPohhtZxRGHhuqdF7OFBpo3ks6j+pb/5t4bCfQldPIwQ
         Yffg==
X-Gm-Message-State: AOAM531emnATTrUOB5rp5iLjUhLjqnhfkHdcFGjXbY2afwtzguwEMJTq
        lgdBMXF0HD8OKFBldnI7HQtdf+hd+MEHH+oe7S4=
X-Google-Smtp-Source: ABdhPJw6h8yF0Zjrpmx4ZLwfZr1STa170xBpI63ul7sWlIWlHbQItStw+dfUFyehDEhIUNbd0AUhyF3ko9xpDkX3fJs=
X-Received: by 2002:a05:6512:39cf:b0:471:ea64:70cb with SMTP id
 k15-20020a05651239cf00b00471ea6470cbmr12124971lfu.47.1650913624575; Mon, 25
 Apr 2022 12:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220420102354.468173-1-florian.fischer@muhq.space>
 <YmA48V09iBbqy6su@kernel.org> <CAM9d7cjcA0aYC1otY4WvCJ_h71P9wiHu42GK7iyv3=i01rQ26Q@mail.gmail.com>
 <20220423121557.z5gzbqadonmrg6ef@pasture>
In-Reply-To: <20220423121557.z5gzbqadonmrg6ef@pasture>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Mon, 25 Apr 2022 12:06:53 -0700
Message-ID: <CAM9d7cgcx42xD8QxOB+JBEL85mZU_va8FMiF31SRxABH8CakLg@mail.gmail.com>
Subject: Re: [PATCHSET v4 next 0/3] perf stat: add user_time and system_time
 tool events
To:     Florian Fischer <florian.fischer@muhq.space>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 5:16 AM Florian Fischer
<florian.fischer@muhq.space> wrote:
>
> On 22.04.2022 16:52, Namhyung Kim wrote:
> > Hello,
> >
> > On Fri, Apr 22, 2022 at 3:05 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Wed, Apr 20, 2022 at 12:23:51PM +0200, Florian Fischer escreveu:
> > > > This patch series adds new internal events to perf stat exposing the times spend
> > > > in user and kernel mode in nanoseconds reported by rusage.
> > > >
> > > > During some benchmarking using perf it bothered me that I could not easily
> > > > retrieve those times from perf stat when using the machine readable output.
> > > >
> > > > But perf definitely knows about those values because in the human readable output
> > > > they are present.
> > > >
> > > > Therefore I exposed the times reported by rusage via the new tool events:
> > > > user_time and system_time.
> > > >
> > > > This allows to retrieved them in machine-readable output:
> > > >
> > > > $ ./perf stat -x, -e duration_time,user_time,system_time,cache-misses -- grep -q -r duration_time tools/perf
> > > > 72134524,ns,duration_time:u,72134524,100.00,,
> > > > 65225000,ns,user_time:u,65225000,100.00,,
> > > > 6865000,ns,ssystem_time:u,6865000,100.00,,

> > Anyway it looks a little bit strange to me if we can get
> > system time in user mode only (the 'u' modifier).
>
> Sorry but I don't really understand what you mean.
> The system_time is reported to userspace via rusage filled by wait4(2).
> It will always report the value reported to the user space regardless of what
> counters perf has access to.
>
> If you run perf as user you get the same system_time (but with the ':u' suffix)
> as when you run perf as root or lower kernel.perf_event_paranoid to allow access
> to more counters.

The ':u' modifier means that the event should count only in user mode.
So I think system_time:u should be 0 by definition.
Likewise, user_time:k should be handled as such.

But as I said before, we already have the task-clock event, so it's not
clear why we need this too.  Also these tool events won't work for
other use cases like perf record.

Thanks,
Namhyung
