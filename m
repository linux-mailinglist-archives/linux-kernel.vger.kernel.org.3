Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C600B55C5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbiF0Wfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242746AbiF0Wfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:35:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA0205DB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:35:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o19so12634225ybg.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdNzOeC3gRAa6rQF9qXJXPeMWI5VIg2SD/sfJr2c6tA=;
        b=fndGvdsS8pS3e9PK/GsoWulDrrDfD65+qLb7s4ZAP7aEzLB3M4Ub+GM0eBmbcASe3t
         oeeUNMR4hdV8S21dh4n0gq9QnIy1dtddf/t5Qj6Mp0fvz2h7hK7169cSIPbbTTb4qzzP
         uKJUPw80qKPszdXqfwaKIB/iBGhknbU5vjqx35GwhLZrNvkSrx5EujvV1IsoOieg1lWt
         VaFll4bpbtZr/ZnQo1IQ2Yhsy5J5GXb2NuNtHE5CVtdSyDGuBUBQykqnuOGK2nLY5Qdd
         0K60i7zQaGacDXD4FfIWtsr0aJ/D6XU8oJzs9wB5PXHPDsj1CDGRNJemzC1wPdjFRNNc
         0oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdNzOeC3gRAa6rQF9qXJXPeMWI5VIg2SD/sfJr2c6tA=;
        b=DTSMXSF16/TDvZzi5SO7vgGWYcZWmSLSDF88ABoKHFZqvcCu0EjILW07/Yv6C9Umh0
         SSMZ4gohsttzTfggKFdNUkkdO7MaoQ0xkcH6+9XNLlHtUBLouFMF9rDSGLt77P0ZG1//
         SwcagVMDqEg3pAeuSzumLBmP+sMqTtDZwj0wAghlB4alzEITb6mcCE1mUHT7flqn8Ta0
         ji8Q7WM3rRLnU2qXa8uAXZdCqeQYuyRHezPsox+MxPWaqak3gpgSbCjuhmNUtnVZq6cB
         L29sqC7OcgW4xcm0PivKjhZaUI5HN2tXBGJV+1WQLQUhUKpcz81KUAp1AlYRyGBcz76l
         GZUA==
X-Gm-Message-State: AJIora/ae9AHotiX6acsyVAKxYC4Bck9B4Je9b6xpBGzyHY5xudqe6Zh
        T9NkobmCAK443Ccd/uo5wOr+RgGrMooXL675rY6r2Q==
X-Google-Smtp-Source: AGRyM1s+nsF2ycvwsCq85Zie+J5Y/uPfAtzutFTOD1nqQi+129GLNifwrt8iLXvOQPBUlx5Abi+mJSSzscXCMNgZ/pk=
X-Received: by 2002:a25:cc89:0:b0:66c:990b:3638 with SMTP id
 l131-20020a25cc89000000b0066c990b3638mr12918052ybf.464.1656369332755; Mon, 27
 Jun 2022 15:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220621234443.3506529-1-joshdon@google.com> <Yrl1Tdds6g7h60F3@mtj.duckdns.org>
In-Reply-To: <Yrl1Tdds6g7h60F3@mtj.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 27 Jun 2022 15:35:21 -0700
Message-ID: <CABk29NvMRWbJgZ7VdzdeDVz0v=PKJJJ0gFk=+X884U25ZJhbsA@mail.gmail.com>
Subject: Re: [PATCH v3] sched/core: add forced idle accounting for cgroups
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
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

Thanks Tejun,

On Mon, Jun 27, 2022 at 2:16 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jun 21, 2022 at 04:44:43PM -0700, Josh Don wrote:
> > 4feee7d1260 previously added per-task forced idle accounting. This patch
> > extends this to also include cgroups.
> >
> > rstat is used for cgroup accounting, except for the root, which uses
> > kcpustat in order to bypass the need for doing an rstat flush when
> > reading root stats.
> >
> > Only cgroup v2 is supported. Similar to the task accounting, the cgroup
> > accounting requires that schedstats is enabled.
>
> Generally looks fine from cgroup side. One nitpick follow.
>
> > +     seq_printf(seq, "forceidle_usec %llu\n", forceidle_time);
>
> Would it make sense to namespace the name to reflect the fact that
> this is tied to core scheduling? e.g. something like
> core.force_idle_usec (and yeah, underscore between words, please). I
> kinda hate that the feature is named "core". The word is so
> overloaded.

Sure, although a namespace of "core_sched" would be a bit clearer,
since as you point out "core" is pretty overloaded :)

Lack of underscore for forceidle was to be consistent with
"core_forceidle_sum" being dumped from /proc/pid/sched, but I'm fine
with it either way.

So,

core_sched.force_idle_usec ?

>
> Thanks.
>
> --
> tejun
