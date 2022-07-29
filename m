Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63235849ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiG2CuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiG2CuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:50:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C06B11C3B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:50:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n185so1886663wmn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcTxRPggfpfu+LMYFVT8bt70kr6HLoCtSw7aK/1OfNQ=;
        b=HN0omjeSSHB52udFZns52ARpnDOoCtqBTytwPkVavLJZb9Rkh8oxb2OwAbHGVLiRSY
         hMTk7CtD/WygkS8NryQHxXuO+rQaT1yEM6LDyaNv0hrGtoEcA2SP+rdtcb+iFnVM3iK2
         HNihiy1cDFxt8uYwXhU7TJJJmswc8ooiwwSehjhKnf6yz2oRAoMLcne6ePecYZ+Tup+x
         /f2sMp6IXLq85RSU1tsSnDTuvF5qKWBxEW2Y7XhOPzvQ6QsKFqVwt3BBCArdfGakNruW
         mXEoICFgH565794NkamYrCIkDKCzo0gjFwTMEzpgnZ8gg6aQVHlph8W6DTFcijZCgNeE
         IWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcTxRPggfpfu+LMYFVT8bt70kr6HLoCtSw7aK/1OfNQ=;
        b=fSAHt+2J4SKN+MliB35m3kHHJLMLMpPCuYMem3L9i9ZPkF2r7DGNp3oPYdrAdFfhoU
         2pdHZaVWExhfpjGeAPi15V1vipcPYC09sbi9itmMhqIxfY66ZKpI6Afja8Wi5T9TwuNX
         9kW7apsOTE6mhpUkAHgU8b5FBwAAvU0bAu8EMmfYBn99Oqv4bkdv2Bc+M4UvuoPUs8uA
         MJDxskBLYv9TDpfuWMymFhxNGMnZ9A350c+W6jWfqki4sSYwymCbL/0Qg3CQuknXXHoz
         yEJbub5GAq/FgAOqlo4+G2wS48HkOtA1QD51xT9lOoX5UOqeSHpd4Jr9LtU+3iQqHHyL
         4/aA==
X-Gm-Message-State: AJIora/z32vB+0RvQgkf1YtpZIew27zKi5Iz61DIX6oP/Zhwk5+kE3kp
        /wA2cQsnhFTXBAdhZIoFt+SIrqrVLBP6GYGy0BU=
X-Google-Smtp-Source: AGRyM1u4vwWVH9X+X6201E6WrNAG4camOXP/cEI46U9Jbdf5I30bBYa9b5ZEU1/i6PndwI5rbOPkDUznjArqo1odE9I=
X-Received: by 2002:a05:600c:3caa:b0:3a0:18e4:781b with SMTP id
 bg42-20020a05600c3caa00b003a018e4781bmr934477wmb.199.1659063011122; Thu, 28
 Jul 2022 19:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp> <CAJhGHyCbEn-gTaK57-QA7cszRS2hyBPWt2wPhmiGDY5M9x5eKg@mail.gmail.com>
In-Reply-To: <CAJhGHyCbEn-gTaK57-QA7cszRS2hyBPWt2wPhmiGDY5M9x5eKg@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 29 Jul 2022 10:49:59 +0800
Message-ID: <CAJhGHyCFzRmehgUZtvAeYznod4A8PkjkFaYjs1fB+jd_SeJ9Kw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: don't skip lockdep wq dependency in cancel_work_sync()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Byungchul Park <byungchul.park@lge.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Byungchul Park <byungchul.park@lge.com>

On Fri, Jul 29, 2022 at 10:38 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> > +bool flush_work(struct work_struct *work)
> >  {
> >         struct wq_barrier barr;
> >
> > @@ -3066,12 +3075,10 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
> >         if (WARN_ON(!work->func))
> >                 return false;
> >
> > -       if (!from_cancel) {
> > -               lock_map_acquire(&work->lockdep_map);
> > -               lock_map_release(&work->lockdep_map);
> > -       }
> > +       lock_map_acquire(&work->lockdep_map);
> > +       lock_map_release(&work->lockdep_map);
>
>
> IIUC, I think the change of these 5 lines of code (-3+2) is enough
> to fix the problem described in the changelog.
>
> If so, could you make a minimal patch?
>
> I believe what the commit d6e89786bed977f3 ("workqueue: skip lockdep
> wq dependency in cancel_work_sync()") fixes is real.  It is not a good
> idea to revert it.
>
> P.S.
>
> The commit fd1a5b04dfb8("workqueue: Remove now redundant lock
> acquisitions wrt. workqueue flushes") removed this lockdep check.
>
> And the commit 87915adc3f0a("workqueue: re-add lockdep
> dependencies for flushing") added it back for non-canceling cases.
>
> It seems the commit fd1a5b04dfb8 is the culprit and 87915adc3f0a
> didn't fixes all the problem of it.
>
> So it is better to complete 87915adc3f0a by making __flush_work()
> does lock_map_acquire(&work->lockdep_map) for both canceling and
> non-canceling cases.

The cross-release locking check is reverted by the commit e966eaeeb623
("locking/lockdep: Remove the cross-release locking checks").

So fd1a5b04dfb8 was a kind of hasty. What it changed should be added back.
