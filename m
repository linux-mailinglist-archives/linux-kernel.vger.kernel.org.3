Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18A9570821
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiGKQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiGKQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:16:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0047AB37
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:16:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i128-20020a1c3b86000000b003a2ce31b4f8so5295248wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ac36GHPqLNsKOXcJS/JCbJrssirgqDImIw++AW07FLQ=;
        b=pXWRziR+xf0tdp3I549Xqt9JU5O3nTo6+wSVg1y007y5PLEbTQOGzKrJGShjdvVtrv
         8UHQGtmjgrEIg3Tzq2LHpsiULUkwgXbZO7VSx20IfgHUHpJpVeKL6Mzzcqs2BKVmBtbo
         QeYmy/hbYwxIWvTKMbZREOmGfjFvpN/pVRG9WQslb8/0PUxOwaODlAmK/v/t5DB9cG0A
         Kumu0fwerixNZioMEy4lbiNYiOkFez3ABXUtc+Nk8Qgf4ikFVAan8pTQh+rdwx3ondzo
         wqxIDWIF7Q+S8KQc9uB//buebsGFFVU8m2ovJsRX93IdxH5jlNhP+v/IIk53kYZAPqSi
         aznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ac36GHPqLNsKOXcJS/JCbJrssirgqDImIw++AW07FLQ=;
        b=3QMpm7lPY5Gc9ajkvyWE+sQbg0OKRAAbLUMshBG1jQlPWAtjRhkJ4pXmx51RSK97KA
         Skbu1baAccBGSB1AnWPa8vopVZ3w+cg07a10WGo60+XEss1hk2HrCWMwD5d+vIJQucxf
         mjqbxIeSqiGrmFDqKRZ+fLsiAPZ738hnF5pAk1/bn5LQxXmWdDM1lOHGTFv2KPlEJu11
         qPQZF7kG6eMvE3nTS8LfqKvVsmLtnm2jkLZMKVys68d2HcYlgR8OLeZ6Ima+9X0h1uSN
         lrKdXT0JRUe2AWo2K8WJNSuwztUddQX6Wclh2w3JPRyl5zwFHdjPkGkmgYR5aZJdB/lu
         XxaA==
X-Gm-Message-State: AJIora8W0cwyKP5L5kQ5g+YK3KA7vRS6Nr9uYzu25TDbu2KQT33uu3NQ
        Y76NwTHcd6CpRV/bmTnSvRpHw+mI6q5/jguGKNPjMg==
X-Google-Smtp-Source: AGRyM1sYtHZti/+mAu1TajubUU19ISNKfS6YUhimVsHN0bol+a9rmCs3QIR+qiHePachhZeYRlqYJPEYiHX17TSbzY8=
X-Received: by 2002:a05:600c:4e4c:b0:3a0:53a2:48b5 with SMTP id
 e12-20020a05600c4e4c00b003a053a248b5mr16127029wmq.174.1657556203057; Mon, 11
 Jul 2022 09:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220701063949.1769434-1-anshuman.khandual@arm.com>
 <b9da8d22-6896-68a3-b4e5-e8fd7b82b711@arm.com> <Ysgxzxl0N7+J8Vbt@worktop.programming.kicks-ass.net>
 <d03e334a-ec7e-cd87-7f0b-ac7564266d3a@arm.com> <YswVWwwXi6zWaEAy@hirez.programming.kicks-ass.net>
In-Reply-To: <YswVWwwXi6zWaEAy@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Jul 2022 09:16:30 -0700
Message-ID: <CAP-5=fW+S3UoqzUc7_+ZmaAj1b=0RtF5p9WHzw23t2AoWZGd9Q@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Add macros for possible sysctl_perf_event_paranoid
 values
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org
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

On Mon, Jul 11, 2022 at 5:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 11, 2022 at 02:55:12PM +0530, Anshuman Khandual wrote:
> > Enumerating [-1, 0, 1, 2] paranoid range values in kernel too, does not add
> > much value as well ?
>
> That's what the user-interface requires as well. How is obscuring the
> values the user has to explicitly poke in help things?

Perhaps a helper function like ParanoidAndNotRoot that takes the
failing paranoia level such as here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/shell/stat+csv_output.sh?h=perf/core#n48
would help clean this up. Perhaps something that explicitly calls out
this is a permissions check. Cleaning up permission checking seems
like useful value add. We've been trying to do something similar in
tests to make them skip rather than fail due to permission issues -
this should increase the signal perf test gives.

Thanks,
Ian
