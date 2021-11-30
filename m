Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2014F46438E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345209AbhK3Xka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345628AbhK3XkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:40:24 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F566C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:37:04 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b67so28799020qkg.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRFrGSoUXQy5HyRnh2s9d9Qk3ennLiQfcJOlftVc0Jg=;
        b=smhhc1pkJ5jt13RJCClZy3YgbdRAfvgYw6fDJccZT8DLgPBFMHRWplO+Mk9pOkg9Zn
         SPYZYCytnH2cqy6u2Xn1JmGkwap8+LL8sjRykeRzQP3eYTevtXSP3mwugLEPkLHF0A9n
         sqpYVl/GScee7RhDf4NYIE+74qb01LBFn5VELU3JBrzYNOwaYwtHdH4W5W1u+GNJvz+q
         AYrh4Wv1fMe2AhRS6lKSY1L0dl2LuGhDdYLYV/h+LA25xwSdOLb3bUnEWu94Hd4OT4G0
         eab19p2K3kH0c6B8uUH1OAgpj7u109ibf+hhEy1+TykUg/y6knwuSCvwCBMGT/jn1W72
         tDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRFrGSoUXQy5HyRnh2s9d9Qk3ennLiQfcJOlftVc0Jg=;
        b=SdT2Vfg0Hv0A2iO73GQ45xiRXdrpAKF2HKcyx2UbUTB5HrCuqivmFkW7x9Rw+wzI0R
         B1HlbdwbbelFCJhL+WC8yAX3tbgyiFGil+rQPI8boCMjMsVYxD7UQ1aW4Z0WmtcrHXsG
         +KcGAgCJCyZUF9OAgAGLTUoJ36nC6WooP95ciP2gIkfUXUBY0Am3QrfWiClqgAg67vix
         FFDSJskgYjonEWtqMtZ3fxquhhpjRvtnJ3iL7Z5J0QEMmipkkhtVkviTMvSnpWzdyEAQ
         RTvlEN6nE5hy6ejREzEtPmGxV+FbsgP+Wsq8Yip3Q5G6tOYwWADfc9eTzArkBXIPkZ3X
         91sg==
X-Gm-Message-State: AOAM532M8zc9eYS+ee/rUxa60tgVAEsfOLjnWb4KTjdWa0hYuqEi8dj1
        aJp8KWxJ0KAXpvahQfxzxME37+Z6+lh62j9Z5kb1Ng==
X-Google-Smtp-Source: ABdhPJzGtXjdMbMM/GsyjUK1dt6LJdKXXx5TXzyfV3qsBUJLVLduzkwVY1GI2ihcB867i4GvIboh6gWmKxGwbpqAO5c=
X-Received: by 2002:a05:620a:4454:: with SMTP id w20mr2776732qkp.369.1638315423230;
 Tue, 30 Nov 2021 15:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20211115170241.1.I94825a614577505bd1a8be9aeff208a49cb39b3d@changeid>
 <CAD=FV=UZNxt7y6bTipyvYFGMJhgp6nRozNt=iEaOYP6yc4OFpg@mail.gmail.com>
In-Reply-To: <CAD=FV=UZNxt7y6bTipyvYFGMJhgp6nRozNt=iEaOYP6yc4OFpg@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 30 Nov 2021 18:36:52 -0500
Message-ID: <CAJWu+ora8F0eurnYkSXRqcT4mB8k8wy9CyKj1EGk52vEVEkT3A@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Don't reschedule a throttled task even if it's
 higher priority
To:     Doug Anderson <dianders@chromium.org>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:30 AM Doug Anderson <dianders@chromium.org> wrote:
> I know this isn't crazy urgent and I'm happy to sit and twiddle my
> thumbs a bit longer if everyone is still sleepy from tryptophan, but
> I'm curious if anyone had a chance to look at this. Can anyone confirm
> that my script reproduces for them on something other than my system?

Maybe +Qais Yousef can also chime in. Just to add, I think Doug's
issue is that under RT group scheduling, he expects *other* well
behaved RT tasks to not be throttled while the tasks that are
misbehaving to be *gracefully* throttled. Gracefully being- it is
probably WAI that they are exceeding their runtime and so *should
naturally* be bandwidth-limited similar to deadline. I am not sure if
the design of RT throttling considers throttling as an anomaly or
something that's expected to happen. If it is expected to happen, then
I see Doug's point that the mechanism shouldn't affect other RT tasks.

> Does my patch seem sane?

To be honest, I don't understand that bit enough :(

 -Joel
