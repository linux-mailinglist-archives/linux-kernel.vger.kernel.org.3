Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63991492C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347139AbiARRRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347121AbiARRRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:17:13 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:17:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c2so23707761wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjMQTF4eVKdyYAu8QrW4WjNPRTGXRpV0NBTS0oqE87o=;
        b=IZegMCoeQ3hsBGjk2vtSpm5HrT9deisVQ46CZM3W0KeCwtTnRXltsYEkFkK7yN3kmr
         FrxakSA4UABJoLpQ2vt1aupCGgjVZR/yetgF6KbYS+Wb1MvUDzzsBcLjGToUAv8yfWEN
         CtzNojQhJGGDxowfq4eZc6l3xtJmf2RhRdZky817UJYEa0IVe1hVWqPQ9jAmSvChBYiK
         CmJJe8g75QHXaKLXux+guYXIgee20K9ncaKL5KcgmzKX38rvjaK5D51MMxkhre0mhd9s
         halEpN+LKuSFqaBxYoxeF0T5KxSnAJXxWpNJO2ZMOb9zLt75zrGVSwmJWj3VVF7IVUMo
         uy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjMQTF4eVKdyYAu8QrW4WjNPRTGXRpV0NBTS0oqE87o=;
        b=uKm8YyzjN5Ixv4vGnvJoRAr0olu9pqe4nTDv/YI1LlmCN+1oso5In18G3hXoh1v5xK
         L4HFC8z4oWep6Pw2MUNSoCu17ky/jnEf4jUR8vqIzVHEV/d8mHFy4nkc0VjBwLXWsEOq
         00tyaZ/4zTlyPxB0dMPoyeMHfrPHlMROtKpf1paUIH1xPUM6c0pupQrplV8Wfu797Rkb
         0ZJWamI0nyfDwmWptZQLG1+/O+PzwOjj7E08vshNTavWiCtMZfZ2suw437kg3NoO5k57
         lcRxhg4+eH93gNnPvsoaw+enVwmgj+QgyCgfb5+kbtg4znc4ramLqFb6YISR9SvpHSGy
         BW2w==
X-Gm-Message-State: AOAM5335eIvw1P9rpTP5kdV6lxtk3CBKvaC9+sXSnXO59CNV0m+utIyi
        xjruaWCnj758MBIqizIJ574qd3++lyGN8PS8NhXQ/w==
X-Google-Smtp-Source: ABdhPJyM8Er7F8IWCUjoxB2zTsyLWrUtQFdcfszUUYmE5GJpHJTzU5uLC3uRD7QV0QTnKuyA/uRJk761VISSAS7dA7Q=
X-Received: by 2002:a5d:6da4:: with SMTP id u4mr20828497wrs.82.1642526230826;
 Tue, 18 Jan 2022 09:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20220113233940.3608440-1-posk@google.com> <20220113233940.3608440-5-posk@google.com>
 <YeU0nr6DfBCaH6UF@hirez.programming.kicks-ass.net>
In-Reply-To: <YeU0nr6DfBCaH6UF@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 18 Jan 2022 09:16:59 -0800
Message-ID: <CAPNVh5e+ijBCdvzZujWNUw7QnFt5Mdonw35ByuvcvzJu7gGjHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] sched: UMCG: add a blocked worker list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 1:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 13, 2022 at 03:39:39PM -0800, Peter Oskolkov wrote:

[...]

> >
> > So this change basically decouples block/wake detection from
> > M:N threading in the sense that the number of servers is now
> > does not have to be M or N, but is more driven by the scalability
> > needs of the userspace application.
>
> So I don't object to having this blocking list, we had that early on in
> the discussions.
>
> *However*, combined with WF_CURRENT_CPU this 1:N userspace model doesn't
> really make sense, also combined with Proxy-Exec (if we ever get that
> sorted) it will fundamentally not work.
>
> More consideration is needed I think...

I was not very clear here. The intent of this change is not to make
1:N a good general approach, but to make "several running workers per
single server" a viable option.

My guess, based on some numbers/benchmarks from another project, is
that having a single server/runqueue per four or eight running
workers, properly aligned with (= affined to) an AMD chiplet, will be
the most performant solution, comparing to both a runqueue per single
running worker and to a global runqueue. On Intel this will probably
look like a single runqueue per core (2 running workers/HT threads).

So in this model a "server" represents a runqueue.

I'll reply to other active umcg discussions shortly.
