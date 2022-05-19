Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE70B52DB11
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiESRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiESRVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:21:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C6A9E9FF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:21:36 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2fedd26615cso63643607b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mLS4PfQr+FDNI3uFdJ7+BYDJ3LWS+aKjrtyVzRLVpY=;
        b=WMa5x8l6tFoxGelsCird41pK0BBotvFBfvnE5lwAdL/kgrGv6gu86m+TJd0JyCaXE2
         SeJisA5KBdLUbqM6JhWR9PKhwqYmnk0OsE019K0ueszy1r3lXgYJHWlhn8lp43uUeppZ
         8ds7Pg5NNzov+e4FToqf03y/SseCfayzEqKBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mLS4PfQr+FDNI3uFdJ7+BYDJ3LWS+aKjrtyVzRLVpY=;
        b=SC7VAdoxToK3G9WMeRuyHoUJVlOYa6+QmaKu6sTrPoNBUfkr0b6i2Gmqsq9BsQXdjw
         JC5EvzfoQyrP4RlqZ3E6holIITNAxTJ9mkS8pErf/lfvI9bApVPakSCjm0jHv7wdJrD6
         Hn/IEsXIbYQJBGUPWLaric+CcG7MuCeKjjfgweq78I2M8WA00mCMCUvc+UnoNwrsJyDh
         zpxgUT+4mZtUUTduC44OtTJydRLW+LNtnGb9j3IJ11qX1xDvunygX1rvEUsGm2KU1+9+
         mAI/i8RvilxCYlQXrHyzRxqjKLwuQGpgtGTnxNXQCtBcHwV8kvwG/WfeJZONxI+hjZNN
         XLMg==
X-Gm-Message-State: AOAM531e5nNn6UiDd5U7Gi7Zae0hSrkZHr+7FEEd4H+1zN2TysigOfY/
        zJzzqFAWSRMfBUEEwt4NZ+Q004dlsmcIluV+1ojbfQ==
X-Google-Smtp-Source: ABdhPJwjBm47AxoIlFq6XagEmC7wbYZ2wxl3/jTwYhj+YxDS2rVY0NG98+vdG3Ak21OAPWgRCgo5H5QxkyN8eYoZulE=
X-Received: by 2002:a81:8450:0:b0:2ff:c13:17d1 with SMTP id
 u77-20020a818450000000b002ff0c1317d1mr6004756ywf.207.1652980895889; Thu, 19
 May 2022 10:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220519000623.1715899-1-dualli@chromium.org> <YoZnVrU8Dih+urv6@kroah.com>
In-Reply-To: <YoZnVrU8Dih+urv6@kroah.com>
From:   Li Li <dualli@chromium.org>
Date:   Thu, 19 May 2022 10:21:25 -0700
Message-ID: <CANBPYPjkNWsO94nuG1TkR1DgK2W2kBxiJTriyVB7S3czHTZ1Yg@mail.gmail.com>
Subject: Re: [PATCH v1] Binder: add TF_UPDATE_TXN
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dualli@google.com, tkjos@google.com, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com, joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 8:50 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 18, 2022 at 05:06:23PM -0700, Li Li wrote:
> > From: Li Li <dualli@google.com>
>
> Note, your subject does not say what TF_UPDATE_TXN is, so it's a bit
> hard to determine what is happening here.  Can you clean that up a bit
> and sumarize what this new addition does?

Sure, I'll add a brief summary there.

>
> >
> > When the target process is busy, incoming oneway transactions are
> > queued in the async_todo list. If the clients continue sending extra
> > oneway transactions while the target process is frozen, this queue can
> > become too large to accommodate new transactions. That's why binder
> > driver introduced ONEWAY_SPAM_DETECTION to detect this situation. It's
> > helpful to debug the async binder buffer exhausting issue, but the
> > issue itself isn't solved directly.
> >
> > In real cases applications are designed to send oneway transactions
> > repeatedly, delivering updated inforamtion to the target process.
> > Typical examples are Wi-Fi signal strength and some real time sensor
> > data. Even if the apps might only care about the lastet information,
> > all outdated oneway transactions are still accumulated there until the
> > frozen process is thawed later. For this kind of situations, there's
> > no existing method to skip those outdated transactions and deliver the
> > latest one only.
> >
> > This patch introduces a new transaction flag TF_UPDATE_TXN. To use it,
> > use apps can set this new flag along with TF_ONE_WAY. When such an
> > oneway transaction is to be queued into the async_todo list of a frozen
> > process, binder driver will check if any previous pending transactions
> > can be superseded by comparing their code, flags and target node. If
> > such an outdated pending transaction is found, the latest transaction
> > will supersede that outdated one. This effectively prevents the async
> > binder buffer running out and saves unnecessary binder read workloads.
> >
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  drivers/android/binder.c            | 90 ++++++++++++++++++++++++++++-
> >  drivers/android/binder_trace.h      |  4 ++
> >  include/uapi/linux/android/binder.h |  1 +
>
> How was this tested?

Old kernel: without this TF_UPDATE_TXN patch
New kernel: with this TF_UPDATE_TXN patch
Old apps: without setting TF_UPDATE_TXN
New apps: if (flags & TF_ONE_WAY) flags |= TF_UPDATE_TXN;

1. Compatibility: New kernel + Old apps, to verify the original
behavior doesn't change;

2. Compatibility: Old kernel + New apps, to verify the original
behavior doesn't change;

3. Unit test: New kernel + New apps, to verify the outdated oneway
binder transaction is actually superseded by the latest one (by
enabling BINDER_DEBUG logs);

4. Stress test: New kernel + New apps sending oneway binder
transactions repeatedly, to verify the size of the available async
binder buffer over time, and if the transactions fail as before
(due to async buffer running out).

>
> >  3 files changed, 92 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index f3b639e89dd8..153486a32d69 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -2594,6 +2594,60 @@ static int binder_fixup_parent(struct list_head *pf_head,
> >       return binder_add_fixup(pf_head, buffer_offset, bp->buffer, 0);
> >  }
> >
> > +/**
> > + * binder_can_update_transaction() - Can a txn be superseded by an updated one?
> > + * @t1: the pending async txn in the frozen process
> > + * @t2: the new async txn to supersede the outdated pending one
> > + *
> > + * Return:  true if t2 can supersede t1
> > + *          false if t2 can not supersede t1
> > + */
> > +static bool binder_can_update_transaction(struct binder_transaction *t1,
> > +                                       struct binder_transaction *t2)
> > +{
> > +     if ((t1->flags & t2->flags & (TF_ONE_WAY | TF_UPDATE_TXN))
> > +                     != (TF_ONE_WAY | TF_UPDATE_TXN)
> > +                     || t1->to_proc == NULL || t2->to_proc == NULL)
> > +             return false;
> > +     if (t1->to_proc->tsk == t2->to_proc->tsk && t1->code == t2->code
> > +                     && t1->flags == t2->flags
> > +                     && t1->buffer->pid == t2->buffer->pid
> > +                     && t1->buffer->target_node->ptr
> > +                     == t2->buffer->target_node->ptr
> > +                     && t1->buffer->target_node->cookie
> > +                     == t2->buffer->target_node->cookie)
>
> Did checkpatch pass this?  Please always use --strict and fix up all the
> issues that it reports as this is not a normal kernel coding style,
> sorry.

It passed checkpatch but --strict does suggest I adjust the logical ops.
I'll update it in v2. Thanks for reminding me about using --strict.

Thanks,
Li
