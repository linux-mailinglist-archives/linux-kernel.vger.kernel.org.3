Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525945A5F87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiH3Jdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiH3Jcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A13E0FDA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:32:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bu22so13041463wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HgYd3d3VYtxdYcLPgCySGEmVJkVfThbgrxhOUNERh1k=;
        b=Na8wILonq+BLnoW8P6MiJP24r/Akpp+N9EMEdhrGiz1BsMz8kBfq3YqGxMRGJxzV1P
         +IxbAbLVgK3hRs28chUgGDQZtKkH1qwND0Ux5Pb7VFcmzEhTw0AFx21f/kbuv5aIEa2E
         2zNE2leJ2WlUgIdkGgMoBe5kUxUxH5iGS04fsuxxNXnQsGu7J8Z1jimPFQDxAo0BiGVf
         CDE+hKtnHkKjmqtNqI7T1+FkI/ZBCmOq7COX4v63ou5WsbzuS2+4JZspccWjYgmhvH0x
         TueiduxSlRweVTOS0OmvBbPw6vz1/LWdQNqfq/OXoQwSjk2cfjLGDlKy2QmWxJ4GpCAc
         sikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HgYd3d3VYtxdYcLPgCySGEmVJkVfThbgrxhOUNERh1k=;
        b=qFQLFuDzNPCJRBUHz4u2ZIbRBRXciRiLBbzCH0g9/HwmzTYVEToT6pp09oOPQQiAGU
         uew7c+D2odd2dcfyqLVpEQUG4TfXj47DvOst0B8U99lctn1bpaKPincW75amJ/a4mY6x
         stdQ8qNJLjJZ9IoIqozVWulZp74gYXhfJMzRgvFWj/j2VSJl+30DTIJASTtWjkclWmef
         S1AIW2FKhvvc5O84be7KnnKXi8BMW9tUT+2NqCVTZdbiYLzUwQ+MIuqaCQ3e9+ymqQp2
         X5TJWrDdAyH0zZk7SPFSrdFkXHLWWM0Mc2S7fwKMDLCM6hLcsxnM6WjomrbSowltqjst
         UOHg==
X-Gm-Message-State: ACgBeo2NGINBjobywaSAIliXz86J+X0Zq/OeSbgrR007pVZG1f1Qyk34
        aWX0aKIy2xSDatLUB1Hs08XtgFSqidfqwr5DDNOXBKpnT1s=
X-Google-Smtp-Source: AA6agR5pzkc7DUT+vCkdEvZePNLxFbdX02pdZh353bGxLp3Y08BYRfWMl8Hz8YL+mN0pFSXLuMrhCXxCRDEbLAkRBCQ=
X-Received: by 2002:a5d:4587:0:b0:226:d803:2acf with SMTP id
 p7-20020a5d4587000000b00226d8032acfmr5836912wrq.329.1661851949759; Tue, 30
 Aug 2022 02:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <Yvrb3hfZuUzSpX5e@slm.duckdns.org> <20220818143348.1134136-1-jiangshanlai@gmail.com>
 <Ywlmb1ADhHnfFUI8@slm.duckdns.org>
In-Reply-To: <Ywlmb1ADhHnfFUI8@slm.duckdns.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 30 Aug 2022 17:32:17 +0800
Message-ID: <CAJhGHyB69M7uSu6Ot5JQ=Uc_svRCKqXbvUvwFK1xCm=FcS9Zmw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Protects wq_unbound_cpumask with wq_pool_attach_mutex
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Zqiang <qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 8:33 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Aug 18, 2022 at 10:33:48PM +0800, Lai Jiangshan wrote:
> > @@ -5342,6 +5344,11 @@ static int workqueue_apply_unbound_cpumask(void)
> >               apply_wqattrs_cleanup(ctx);
> >       }
> >
> > +     if (!ret) {
> > +             mutex_lock(&wq_pool_attach_mutex);
> > +             cpumask_copy(wq_unbound_cpumask, unbound_cpumask);
> > +             mutex_unlock(&wq_pool_attach_mutex);
>
> Is this enough? Shouldn't the lock be protecting a wider scope? If there's
> someone reading the flag with just pool_attach_mutex, what prevents them
> reading it right before the new value is committed and keeps using the stale
> value?

Which "flag"? wq_unbound_cpumask?

This code is adding protection for wq_unbound_cpumask and makes
unbind_workers() use a stable version of wq_unbound_cpumask during
operation.

It doesn't really matter if pool's mask becomes stale later again
with respect to wq_unbound_cpumask.

No code ensures the disassociated pool's mask is kept with the newest
wq_unbound_cpumask since the 10a5a651e3af ("workqueue: Restrict kworker
in the offline CPU pool running on housekeeping CPUs") first uses
wq_unbound_cpumask for the disassociated pools.

What matters is that the pool's mask should the wq_unbound_cpumask
at the time when it becomes disassociated which has no isolated CPUs.

I don't like 10a5a651e3af for it not synching the pool's mask
with wq_unbound_cpumask. But I think it works anyway.

>
> Thanks.
>
> --
> tejun
