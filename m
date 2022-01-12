Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42E148C4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353474AbiALNSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiALNSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:18:05 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C13AC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:18:05 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u13so7911860lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=589cjnBZEKl9q4+xxorv3SSZSzOYcr8K9TNPLrqgfWM=;
        b=j+15T6TCSPNoci+MrlVw5pmAL6CCi22aScAAf9BhmvVnrp2Z2h7gUZpIpcGG9X2KOO
         KoXqZsu2/qwQMv2+G6KcirQR8KBOtaOpLk4jo339A/NmbXIGGeLUxGqbl7dCj/S8g1ZH
         5mj0H6K5i6USCdqKyu2LjQSwGuUM97F4mf2OrN4X1e5c6xzTgzfEoGkKvB8EyjDieQKM
         O6M9olnUCM1M1TD8hTQMCIoKUN1y12/jXUFq5cKlGm9eWDsOlJ21VHZEDGrMIbMV8m2O
         410WIyiAjadkL/Hy62dMnC3nSFCWDWKq1jY2SW5d23mhmt6ViXkSjbtwxXcRAOQL/9r2
         RULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=589cjnBZEKl9q4+xxorv3SSZSzOYcr8K9TNPLrqgfWM=;
        b=kFgFmn9BbvInlaukq8/n0Wnp58ARbPHkXw2vQlyPba1aKYK3zTJwpQImJsfObe5CFX
         HZup+7GUXusbqZz5le4ABgErVU0fcrhHWbb1HPXVZ/asr6NWHFqwUfsIsXHVhI/mxVHn
         Rr2ZdFYWXXdOTg/pM0z+KY5UzAZ9G5bRn9HeLfIhQZDHkfQCdUZYMXHFmAkRqLwET9q+
         9nFX3QTeqA1rWCpT7SWIvTYP69K9KOEANA+0T7PpNTIgz7sdmAayXTExY2BwKUg0gRaq
         v7i7mRvNyeuscTCBvEELzK6EuCfGWicaIMr0yjT91yOWC0qWIfRcf/UQjxU4j5XOLlMk
         II3Q==
X-Gm-Message-State: AOAM5302hKTC6p3PtZC9VU4aOr9oJShLfqgt8Lng5yL9g6i3hiEgIvEQ
        0e2O8hagpKotQyzgDZSiHSMzqBTKZib2PouoKqcSMw==
X-Google-Smtp-Source: ABdhPJxUOoKl9wFGXkt1vWoWgj355zS3WLOjEqIpor9lt6a0MldGrCnZaYNrcRkTMWyTRpafaXy1hvJRJkeOdPyuPoM=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr4863977lji.383.1641993483343;
 Wed, 12 Jan 2022 05:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20220111134659.24961-1-vincent.guittot@linaro.org> <1D84539C-994D-4156-B6C8-BED33EE387B5@linux.vnet.ibm.com>
In-Reply-To: <1D84539C-994D-4156-B6C8-BED33EE387B5@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 12 Jan 2022 14:17:51 +0100
Message-ID: <CAKfTPtC=OE2UnGbxs8uasM9c4yKzWhkfnbJt0Kpj7rtF+seBHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] sched/pelt: Relax the sync of *_sum with *_avg
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al, naresh.kamboju@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 12:24, Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>
>
> > On 11-Jan-2022, at 7:16 PM, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > Rick reported performance regressions in bugzilla because of cpu
> > frequency being lower than before:
> >    https://bugzilla.kernel.org/show_bug.cgi?id=215045
> >
> > He bisected the problem to:
> > commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
> >
> > More details are available in commit message of patch 1.
> >
> > This patchset reverts the commit above and adds several checks when
> > propagating the changes in the hierarchy to make sure that we still have
> > coherent util_avg and util_sum.
> >
> > Dietmar found a simple way to reproduce the WARN fixed by
> > commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
> > by looping on hackbench in several different sched group levels.
> >
> > This patchset as run on the reproducer with success but it probably needs
> > more tests by people who faced the WARN before.
> >
>
> I ran scheduler regression tests(including cfg_bandwidth) from LTP
> for about 6 hours. I did not observe any (new or previously reported)
> kernel warn messages.
>
> Based on this test result for ppc64le
> Tested-by: Sachin Sant <sachinp@linux.ibm.com>

Thanks

>
> -Sachin
