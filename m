Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB8B57E2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiGVODC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:03:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C58913F04
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:02:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w12so5939571edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8dhudGEc/vsjtMExBcnd/syEyEJ59zKIhFV3K8lnhE=;
        b=ZhaNdgdZk/e4oDdQrneDDGgjy0McElD9StBqn+txOUA9gfBdEw83bUTSn/aQXPlpeh
         ojf9GRHez1SxI5LF0qR48XKv7oagMER+/Vsfz2MWcS5IMs1cFrtbeX+gz4zOmEUsjB2x
         pNWqFAAwoy4f5J1bqeaPHSclo8xSsrlqtYdpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8dhudGEc/vsjtMExBcnd/syEyEJ59zKIhFV3K8lnhE=;
        b=18t1ZPN1cvY4GWTaenAX2oLCVzEeWwKDt+XWeQF91hkuJzWU86gZtGtUD8btt96NEs
         IT2J3BaCInAZVcSMekaCFDpxPPyx7X+rX+8YzRtMqORCTxqdOff/F02LQaQoix/6Rt0I
         220OKos7rIMLJUHNRqkJAVzvR4r1a0pVtUbGfzOMp5uMbSKWT4c/OKGv1yQMOgVpa86g
         DIwbqQSfoHYaf4pidtcG5Z5W8rio3k8XeIXicEp0ahYZq49re6o8MvbEpjvOgXw0vikJ
         6PjYqhQmuk9+wq1fhEa917/QhSlgLLDGveUlKghX8YDqE8IJvHSFSmduHeI/ssToSije
         VMhQ==
X-Gm-Message-State: AJIora/Mg2LB082nmMQDuOfbMCLd5+BVgb+EMOeUC+EBOV8Fdl2gnoZr
        FGMnUHq0qI9ndRCWbYMgkODXy84iXdGRFHWmA4U=
X-Google-Smtp-Source: AGRyM1spCbhY6bVYKlHvcKWGL8RPRKQPiApepL12lVyrlsjtu5lomqOMx0izHeBhLCVNhYLE0QldSQ==
X-Received: by 2002:aa7:dbd9:0:b0:43b:6e02:7e37 with SMTP id v25-20020aa7dbd9000000b0043b6e027e37mr821968edt.341.1658498577475;
        Fri, 22 Jul 2022 07:02:57 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id kz22-20020a17090777d600b0072b16a57cdcsm2042014ejc.118.2022.07.22.07.02.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 07:02:55 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id n185so2852230wmn.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:02:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4e86:b0:3a3:2edc:bcb4 with SMTP id
 f6-20020a05600c4e8600b003a32edcbcb4mr7946235wmq.85.1658498574397; Fri, 22 Jul
 2022 07:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211116012912.723980-1-longman@redhat.com> <CAD=FV=URCo5xv3k3jWbxV1uRkUU5k6bcnuB1puZhxayEyVc6-A@mail.gmail.com>
 <20220719104104.1634-1-hdanton@sina.com> <CAD=FV=Xng_Mcd-9SaK29XSbsthDWLTR6sz53VEktAQFng6a27A@mail.gmail.com>
 <20220722115510.2101-1-hdanton@sina.com>
In-Reply-To: <20220722115510.2101-1-hdanton@sina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jul 2022 07:02:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XS_AqMveo=a2zN+=b3DxM-yJQapd27Dq8dR+kSb2oL_A@mail.gmail.com>
Message-ID: <CAD=FV=XS_AqMveo=a2zN+=b3DxM-yJQapd27Dq8dR+kSb2oL_A@mail.gmail.com>
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more consistent
To:     Hillf Danton <hdanton@sina.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 22, 2022 at 4:55 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Tue, 19 Jul 2022 08:30:02 -0700 Doug Anderson wrote:
> >
> > I haven't done any stress testing other than my test case, though, so
> > I can't speak to whether there might be any other unintended issues.
>
> The diff below is prepared for any regressions I can imagine in stress
> tests by adding changes to both read and write acquirer slow pathes.
>
> On the read side, make lock stealing more aggressive; on the other hand,
> write acquirers try to set HANDOFF after a RWSEM_WAIT_TIMEOUT nap to
> force the reader acquirers to take the slow path.
>
> Hillf
>
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -992,13 +992,7 @@ rwsem_down_read_slowpath(struct rw_semap
>         struct rwsem_waiter waiter;
>         DEFINE_WAKE_Q(wake_q);
>
> -       /*
> -        * To prevent a constant stream of readers from starving a sleeping
> -        * waiter, don't attempt optimistic lock stealing if the lock is
> -        * currently owned by readers.
> -        */
> -       if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
> -           (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
> +       if (WARN_ON_ONCE(count & RWSEM_FLAG_READFAIL))
>                 goto queue;
>
>         /*
> @@ -1169,7 +1163,11 @@ rwsem_down_write_slowpath(struct rw_sema
>                                 goto trylock_again;
>                 }
>
> -               schedule();
> +               if (RWSEM_FLAG_HANDOFF & atomic_long_read(&sem->count))
> +                       schedule();
> +               else
> +                       schedule_timeout(1 + RWSEM_WAIT_TIMEOUT);
> +
>                 lockevent_inc(rwsem_sleep_writer);
>                 set_current_state(state);
>  trylock_again:
> --

Thanks! I added this diff to your previous diff and my simple test
still passes and I don't see your WARN_ON triggered.

How do we move forward? Are you going to officially submit a patch
with both of your diffs squashed together? Are we waiting for
additional review from someone?

-Doug
