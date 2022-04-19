Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB0507953
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbiDSSpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiDSSpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:45:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7883BF94
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:42:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p10so30939047lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDT1toEd+SxicTRLNH83CxEECZvyMjfDPq8pQppOwkQ=;
        b=EzmCXxmppk+x1kuXCajLWtxL0Yf3QzQu14axK/XUvt3+tq3+neUL4BSThQPj9wW8Mm
         k54s6XYfLj7BrRE5RwqBTyaXjmiqlqhHHwyScrW3rmPUJTi7c81aLpgSYwXvLjlUqzIp
         /IG1Au25TkbDS1GellSRzC4ClKGyhC8ZTQ+EgGwq3y++CN4bvb0KCgGvB9vaTTt1n1h+
         kfAJ+8SNG0FB0iFbuS4r8D2M3TgARgFDdJ1D5hIkCFj4ji7ZfjSI9bTInM1A1yKK/Z1k
         kbWaCH6k9Y5O97XLtJDuP9WcKggKidnR1woL9GBtYRSaTHtrdmKJzh8Vg8ipPRm3Bogd
         xFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDT1toEd+SxicTRLNH83CxEECZvyMjfDPq8pQppOwkQ=;
        b=mKuRqq3+YC9or2VYkd8CJt/7pRYNGlf5JAY5Gl86KOphsvvA1aD7hBdSaUh9hVg1MA
         4RnLojvX7ZylnFIFKFMWW1k8C24nu38jyBng2fv2NdIa+ugXBPJ8ZsU7mVIQeuzilPR4
         TR0lXI5lq5ABv9QauBYHs5ZkinyJJ2UIAKP6gRcO4btHXuYfEsZX6eQkNeiWMKc6VNIG
         QKJvtYiSckFWzJ/zldlqxAkPUedjJ3d7bmk0u3hGiMVFIug0GcGE/mNPFeqQ9RhRK/YY
         UIcnPxWktxcwVI3V/WLjEKvAvd7EqWfF92YwNAR7pmgfDreuz0KDH1XvZLTOEsQJ88m5
         dsHA==
X-Gm-Message-State: AOAM5328NWT/gig/c9r+bNp+TQ+7QnR4LOQ4XM5ZsOq8ctok83lMm1O0
        FOSgg97Y1XbWHqzbXh11Y3FUq9JyU3Qod069dA+yYA==
X-Google-Smtp-Source: ABdhPJx2wgiQvWpN4TMoOnTQsSXLt8idgy9v+4kPQzlROnB+q4k+fMyC5johAnob03CW/zOXD0+xpYHyWbWm/E417BI=
X-Received: by 2002:a19:f00f:0:b0:471:b497:8583 with SMTP id
 p15-20020a19f00f000000b00471b4978583mr1030528lfc.502.1650393746349; Tue, 19
 Apr 2022 11:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220413085428.20367-1-ales.astone@gmail.com> <YlafI74E/5HttdeB@kroah.com>
 <b14ed993-6c3a-ca0a-1b5c-b365628bd1fc@gmail.com>
In-Reply-To: <b14ed993-6c3a-ca0a-1b5c-b365628bd1fc@gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 19 Apr 2022 11:42:15 -0700
Message-ID: <CAHRSSEzD6Upb67xrs6XqZ5CQvnxKmfGin2LTvZ_H6gY2Ej+krQ@mail.gmail.com>
Subject: Re: [PATCH] binder: Address corner cases in deferred copy and fixup
To:     Alessandro Astone <ales.astone@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, tkjos@android.com,
        brauner@kernel.org, arve@android.com, linux-kernel@vger.kernel.org,
        maco@android.com, Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
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

On Wed, Apr 13, 2022 at 4:20 AM Alessandro Astone <ales.astone@gmail.com> wrote:
>
> On 13/04/2022 12:00, Greg KH wrote:
>
> > On Wed, Apr 13, 2022 at 10:54:27AM +0200, Alessandro Astone wrote:
> >> When handling BINDER_TYPE_FDA object we are pushing a parent fixup
> >> with a certain skip_size but no scatter-gather copy object, since
> >> the copy is handled standalone.
> >> If BINDER_TYPE_FDA is the last children the scatter-gather copy
> >> loop will never stop to skip it, thus we are left with an item in
> >> the parent fixup list. This will trigger the BUG_ON().
> >>
> >> Furthermore, it is possible to receive BINDER_TYPE_FDA object
> >> with num_fds=0 which will confuse the scatter-gather code.
> >>
> >> In the android userspace I could only find these usecases in the
> >> libstagefright OMX implementation, so it might be that they're
> >> doing something very weird, but nonetheless the kernel should not
> >> panic about it.
> >>
> >> Fixes: 09184ae9b575 ("binder: defer copies of pre-patched txn data")
> >> Signed-off-by: Alessandro Astone <ales.astone@gmail.com>
> >> ---
> >>   drivers/android/binder.c | 11 +++++++++--
> >>   1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> >> index 8351c5638880..18ad6825ba30 100644
> >> --- a/drivers/android/binder.c
> >> +++ b/drivers/android/binder.c
> >> @@ -2295,7 +2295,7 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
> >>   {
> >>      int ret = 0;
> >>      struct binder_sg_copy *sgc, *tmpsgc;
> >> -    struct binder_ptr_fixup *pf =
> >> +    struct binder_ptr_fixup *tmppf, *pf =
> > Just make this a new line:
> >       struct binder_ptr_fixup *tmppf;
> > above the existing line.
> >
> Ack.
>
> >>              list_first_entry_or_null(pf_head, struct binder_ptr_fixup,
> >>                                       node);
> >>
> >> @@ -2349,7 +2349,11 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
> >>              list_del(&sgc->node);
> >>              kfree(sgc);
> >>      }
> >> -    BUG_ON(!list_empty(pf_head));
> > So you are hitting this BUG_ON() today?
> >
> Correct, both on 5.17, stable 5.17.2 and current master
>
> >> +    list_for_each_entry_safe(pf, tmppf, pf_head, node) {
> >> +            BUG_ON(pf->skip_size == 0);
> >> +            list_del(&pf->node);
> >> +            kfree(pf);
> >> +    }
> >>      BUG_ON(!list_empty(sgc_head));
> >>
> >>      return ret > 0 ? -EINVAL : ret;
> >> @@ -2486,6 +2490,9 @@ static int binder_translate_fd_array(struct list_head *pf_head,
> >>      struct binder_proc *proc = thread->proc;
> >>      int ret;
> >>
> >> +    if (fda->num_fds == 0)
> >> +            return 0;
> > Why return 0?
> >
> > This feels like a separate issue from above, should this be 2 different
> > commits?
> >
> return 0 because I want it to be handled as it was handled before
>         09184ae9b575 ("binder: defer copies of pre-patched txn data")
>
> Function `binder_do_deferred_txn_copies` distinguishes between a copy-fixup
> and a skip with `if (pf->skip_size)` so if the skip_size is 0, which happens
> if fda->num_fds is 0, it would accidentally enter the wrong branch.
> By returning 0 early i make sure a skip of size 0 is not added. It's not an
> error because it was never an error before commit 09184ae9b575 and some
> userspace in android is hitting this path.
>
> I would agree it's a separate issue.
> I originally merged it in this same patch because
> 1) Both are fixups to 09184ae9b575
> 2) Both are triggered by the same real-world android transaction that looks
>     something like this:
>       obj[0] BINDER_TYPE_PTR, parent
>       obj[1] BINDER_TYPE_PTR, child
>       obj[2] BINDER_TYPE_PTR, child
>       obj[3] BINDER_TYPE_FDA with num_fds=0
> 3) In the other hunk of this patch i replace the BUG_ON with:
>       BUG_ON(pf->skip_size == 0)
>     to only BUG if any item remaining in the pf_head list is not a skip,
>     but as observed we may receive skips of size 0.
> 4) With this hunk only, you would no longer reproduce the BUG_ON because the
>     only transaction we receive in android with BINDER_TYPE_FDA as last child
>     coincidentally always has num_fds=0. Certainly some weird behaviour...
>
> So if I split them, patch A would depend on patch B (see point 3), but the
> BUG of patch B would only be reproducible without patch A (see point 4).
>
> But let me know if you still prefer them split.

Thanks for the fix! Please go ahead and split it into two patches.

>
> > thanks,
> >
> > greg k-h
