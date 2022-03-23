Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E654E4AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbiCWCFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiCWCFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:05:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40ADF55
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:04:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q5so43957ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sj6VvC5iMmzyukYbPBIOXyTPJrBZLqUvWOBfUQn8two=;
        b=UOXiI1q346c6OcIvufJQ0+4pmDjiHq9Jpv4CjRI3buFoKmrtF5s5hrtsI9plQZhtca
         utP01u0qD7ibZpwsgmM1HnxjnR+hmocZRN32SaDsELqJqqLM2VfhmEjqmUNxVra8NkwO
         F3bE988q7tf976xM1smV6Ehz0ahG9oBY/x2RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sj6VvC5iMmzyukYbPBIOXyTPJrBZLqUvWOBfUQn8two=;
        b=rgvMDcQDMc3DoB3cE45oBooK5cv1MqtPmUow7Ho2DKdDmitmbUMJtxURCnqpmrrLp3
         rdpacq902eapiTbHji5j4K+/XZbXF8trYFTf63h2ECXdbfOkTmMiYYFxF/R0Ri3ltAve
         jzvvZcGvQMFtryGK9DwVLp04WZR09vptuW3kHyk/oERqmFyZImV5Y5k8PQOXRZMdk+uD
         qEPQ0f6TLuYTZAYX4d0gsgrk1EFvKowPrqb2e+laEqB4eCuJvNxKt5smzqm0qJ1CHp6r
         Z3LJJ1qIzQrxKiJpJILSclKqDp/Nd6IG2O+ifcFmpgn2PHm8U9/FDZLQSI4mMydce5yE
         tKYQ==
X-Gm-Message-State: AOAM531Bf+PA2xi2y04iQJXcgMbVnhiHia5vadmg812Gt1zWa7EfRldf
        Il/pbd10EOxvzrr73A8pWtV4MrdcV4uJJJ/wrbI=
X-Google-Smtp-Source: ABdhPJyV8olwRJYgqXwiF+lbH9WRvfTXNZH9CqeB/C/etIOuYdE7GUxSt/UwywtZbhwkSTU5E/YeNw==
X-Received: by 2002:a05:651c:1543:b0:249:a2bd:4a74 with SMTP id y3-20020a05651c154300b00249a2bd4a74mr986206ljp.375.1648001050059;
        Tue, 22 Mar 2022 19:04:10 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id h20-20020a056512221400b0044a347019c2sm659257lfu.72.2022.03.22.19.04.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 19:04:08 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q14so40488ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:04:08 -0700 (PDT)
X-Received: by 2002:a2e:9794:0:b0:249:8488:7dbd with SMTP id
 y20-20020a2e9794000000b0024984887dbdmr9582628lji.176.1648001048529; Tue, 22
 Mar 2022 19:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <YjjihIZuvZpUjaSs@google.com> <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com> <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
 <CAEe=Sxmcn5+YUXBQhxDpzZVJu_T6S6+EURDqrP9uUS-PHGyuSg@mail.gmail.com>
In-Reply-To: <CAEe=Sxmcn5+YUXBQhxDpzZVJu_T6S6+EURDqrP9uUS-PHGyuSg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 19:03:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGKUyJpi0dTQJjyJxdmG+WCeKkJJyycpOaUW0De17h_Q@mail.gmail.com>
Message-ID: <CAHk-=whGKUyJpi0dTQJjyJxdmG+WCeKkJJyycpOaUW0De17h_Q@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs for 5.18
To:     Tim Murray <timmurray@google.com>
Cc:     Waiman Long <longman@redhat.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 5:34 PM Tim Murray <timmurray@google.com> wrote:
>
> AFAICT, what's happening is that rwsem_down_read_slowpath
> modifies sem->count to indicate that there's a pending reader while
> f2fs_ckpt holds the write lock, and when f2fs_ckpt releases the write
> lock, it wakes pending readers and hands the lock over to readers.
> This means that any subsequent attempt to grab the write lock from
> f2fs_ckpt will stall until the newly-awakened reader releases the read
> lock, which depends on the readers' arbitrarily long scheduling
> delays.

Ugh.

So I'm looking at some of this, and you have things like this:

        f2fs_down_read(&F2FS_I(inode)->i_sem);
        cp_reason = need_do_checkpoint(inode);
        f2fs_up_read(&F2FS_I(inode)->i_sem);

which really doesn't seem to want a sleeping lock at all.

In fact, it's not clear that it has any business serializing with IO
at all. It seems to just check very basic inode state. Very strange.
It's the kind of thing that the VFS layer tends to use te i_lock
*spinlock* for.

And perhaps equally oddly, then when you do f2fs_issue_checkpoint(),
_that_ code uses fancy lockless lists.

I'm probably mis-reading it.

             Linus
