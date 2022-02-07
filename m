Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773964AC99E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiBGTdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbiBGTby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:31:54 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F99C0401E6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:31:50 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id m6so43126786ybc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MK2v0Nt4cCV21YTIg8dlF+1LBbs9TTGPuFsltjIOmZY=;
        b=rMiweCVJx+urv7AcwZojioWaGyvA45MimmXZ4nW0za2fZ/cduytjm2OQZyHtYp+tPx
         1HrHmPCebzKnd6tfbU9efn7x6cPgg2Ts12sYH1bDkvdoffD8pp5XtzMRdtBkI3j8bFgF
         YF8jFpySNTXhHpbW0iLLaZ4Xdtr7HVgrurfwh05TUxgliW41tE3zDiMNBC92jvKeZe2h
         BS7mTS5MFOFRAbgaP/GIIe5MrNQy5/9MDgN3RIjeirtsr0eY6VsPOsClYYcVlnZCqq2l
         1iBhLbmjaF6IPhNqDof1RAmK2+93XkctSjr/Btdd8oUPy7U+M6KqcYX7XZFxPvWMb/zn
         ooHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MK2v0Nt4cCV21YTIg8dlF+1LBbs9TTGPuFsltjIOmZY=;
        b=Yd0saLbsOH0LIlq8J//E47k5GvTWNZiXXIc31HJ9IaXEBEH1VfPbCfzrv8xETMMA2A
         4W+KPJWCigKmc4siY3kb35IcrSHz0BZ6zSGOiuOdeI1ANt/AEUayhG5u/OyBEUl/Hrnj
         yrbGqFsWZlYY4+RT7le7hrAT4HZfdkgrW6Lt9bjIurvBdfzgWGLBZA9pppGSDHp+7X3m
         yt36vT7DOkujZwpyQ+NG9qW/ZbyrquRkjdrPc8G2PUSA1e6o2K6WlI25bQB6tiGSweKm
         /3Wi/wSg0zSXOkzmNRD+LVamClN5QpuVQYguSYh3iC1z5hP68PWQEcuutpD21AWD41QJ
         mQOw==
X-Gm-Message-State: AOAM5338/sHNBBPRAiCCqZrlgJLsXzSrlrJOuKGxDKiyN/F3QSVGvTwJ
        zOi0BzSWNGVasOrJEiaV3Wy+DrNY4n5jVOBBeXNmK1EuL41fNvYi
X-Google-Smtp-Source: ABdhPJx6cAOVkZDsEsjED0wt0V+zqCARCd6Uf0sXMZfve4eA84dGGFKqAgMYW0gF9smp23F+c8iYQKEpGwRFHz8d2dg=
X-Received: by 2002:a25:d7d0:: with SMTP id o199mr1316951ybg.34.1644262309574;
 Mon, 07 Feb 2022 11:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20220128131006.67712-1-michel@lespinasse.org> <20220128131006.67712-23-michel@lespinasse.org>
 <20220129121319.3593-1-hdanton@sina.com> <CAJuCfpHBfSQBuz8=LHYhX-aOgZ1ng6nNfpv_jeBLz+KVr1OU5w@mail.gmail.com>
 <20220201020958.3720-1-hdanton@sina.com>
In-Reply-To: <20220201020958.3720-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 7 Feb 2022 11:31:38 -0800
Message-ID: <CAJuCfpG95cA68Y047MKsXYjvGMENXsjSzHkhYktagcT=fjagWw@mail.gmail.com>
Subject: Re: [PATCH v2 22/35] percpu-rwsem: enable percpu_sem destruction in
 atomic context
To:     Hillf Danton <hdanton@sina.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Jan 31, 2022 at 6:10 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 31 Jan 2022 10:04:16 -0800 Suren Baghdasaryan wrote:
> > On Sat, Jan 29, 2022 at 4:13 AM Hillf Danton wrote:
> > >
> > > On Fri, 28 Jan 2022 05:09:53 -0800 Michel Lespinasse wrote:
> > > > +
> > > > +static LIST_HEAD(destroy_list);
> > > > +static DEFINE_SPINLOCK(destroy_list_lock);
> > >
> > >    static bool destroyer_running;
> > >
> > > > +
> > > > +static void destroy_list_workfn(struct work_struct *work)
> > > > +{
> > > > +     struct percpu_rw_semaphore *sem, *sem2;
> > > > +     LIST_HEAD(to_destroy);
> > > > +
> > >
> > > again:
> > >
> > > > +     spin_lock(&destroy_list_lock);
> > >
> > >         if (list_empty(&destroy_list)) {
> > >                 destroyer_running = false;
> > >                 spin_unlock(&destroy_list_lock);
> > >                 return;
> > >         }
> > >         destroyer_running = true;
> > >
> > > > +     list_splice_init(&destroy_list, &to_destroy);
> > > > +     spin_unlock(&destroy_list_lock);
> > > > +
> > > > +     if (list_empty(&to_destroy))
> > > > +             return;
> > > > +
> > > > +     list_for_each_entry_safe(sem, sem2, &to_destroy, destroy_list_entry) {
> > >
> > >                 list_del(&sem->destroy_list_entry);
> > >
> > > > +             percpu_free_rwsem(sem);
> > > > +             kfree(sem);
> > > > +     }
> > >
> > >         goto again;
> > > > +}
> > > > +
> > > > +static DECLARE_WORK(destroy_list_work, destroy_list_workfn);
> > > > +
> > > > +void percpu_rwsem_async_destroy(struct percpu_rw_semaphore *sem)
> > > > +{
> > > > +     spin_lock(&destroy_list_lock);
> > > > +     list_add_tail(&sem->destroy_list_entry, &destroy_list);
> > > > +     spin_unlock(&destroy_list_lock);
> > > > +     schedule_work(&destroy_list_work);
> > >
> > > Nits
> > >         spin_lock(&destroy_list_lock);
> > > 1/      /* LIFO */
> > >         list_add(&sem->destroy_list_entry, &destroy_list);
> > > 2/      /* spawn worker if it is idle */
> > >         if (!destroyer_running)
> > > 3/              /* this is not critical work */
> > >                 queue_work(system_unbound_wq, &destroy_list_work);
> > >         spin_unlock(&destroy_list_lock);
> >
> > Thanks for the review! Just to clarify, are you suggesting
> > simplifications to the current patch or do you see a function issue?
>
> Apart from the nits that can be safely ignored in usual spins, I wonder if
> the async destroy can be used in the contexts wrt raw_spin_lock.
>
> Hillf
>
>         raw_spin_lock_irq(&foo->lock);
>         ...
>         percpu_rwsem_async_destroy(*sem);
>         ...
>         raw_spin_unlock_irq(&foo->lock);

Sorry for the delay. Are you concerned about the use of spin_lock()
inside percpu_rwsem_async_destroy() which would become a sleeping lock
in case of PREEMPT_RT? If so, we can use raw_spin_lock() when locking
destroy_list_lock. Please confirm. Thanks!


>
