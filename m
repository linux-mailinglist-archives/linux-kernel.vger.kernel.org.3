Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2503C52AD90
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiEQVeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEQVeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:34:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6236F2253D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:34:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so2129780wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yw3991yyqXdoZgLr6xY108MK8vCKvLkHLVKLeNkmSU4=;
        b=eO2Zv9AShOuP04vC6IJe/SIiGiOHuTnpNs6UkNyhn98hwb1Y+/Mc8S9GZu1il8O4FE
         RawvMihaX5nkWfqQCH8RoqZSCDrn3/7LRj9AF4r2bKpExxPs4DnwOv/0sUdAhCfn/0+R
         zjVZ72tuHKjoUG/hcuXhXgkgJH5cffsYhlpO19lEnCoBkgkoNcdBCyKuW1sOwK9VzylQ
         KjaScnXbB3K8O2G/5JVJ87jmWegFrmW8VleKBGiZ7yhFpAvA8MWTW3GOReAa9K5yr5u/
         MmJvTYpz+kr7xLQZWCBsdR62vWWYomFo2YSh7+swWNGfwvlQt9rK+9wLJ+Q3masIlvKJ
         VW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yw3991yyqXdoZgLr6xY108MK8vCKvLkHLVKLeNkmSU4=;
        b=SkMlYmaA4NhCwJ8BidW8dK+bVBX8Plu85kOCEGTwFAhxFDJOTDT9jt1qkNv7k+mB98
         UtI8Us3uDfgsRdCBC2TRIPKxd2EVH+M8N3FBb/tqK0/hi98VGV5eh58tpVcEun+ATCxi
         aHmAw44tQmvJeeBGm137ZrtbVwmgYDNpCC50eBlE/Hz+zPeHK/Tqa2JRZrcw1/XnQSJF
         bgcu8GHhjSFfypK8DrSnI717lVnKvlo8ODxOwBRx9wUuoFal6YBJNCYv9IuBjtuFDoVM
         ka8BscgZgcx55gcSLk9Iharl+2MuY9ul2yBjr1jVz047Phg6aYlywHcoM5l/QDi4tMlh
         blAw==
X-Gm-Message-State: AOAM531olOJXT6mWCnN6C13ZYyyNsO+8nBf7aZ8JwID3fQGqg0vQhIGe
        6WONM1thu9GAhqMCZV/eAtNescR8O4+sAZ/F7r9P
X-Google-Smtp-Source: ABdhPJyCKqGTk5/Vz0u8pzSkyZe5ejIEXrHcAd7CR+uomsShb42xckOya1o3xn4hRvw7x3IOcxESYjWR9yceVyImUTY=
X-Received: by 2002:a05:600c:3487:b0:397:ca9:c98b with SMTP id
 a7-20020a05600c348700b003970ca9c98bmr9839504wmq.51.1652823251792; Tue, 17 May
 2022 14:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220517103253.22601-1-ju.orth@gmail.com> <20220517103253.22601-2-ju.orth@gmail.com>
 <CAHC9VhR_N+N1=3vbbmym36aDA+sUY2c4yRJq74K+=Fr27TBLQw@mail.gmail.com>
In-Reply-To: <CAHC9VhR_N+N1=3vbbmym36aDA+sUY2c4yRJq74K+=Fr27TBLQw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 May 2022 17:34:01 -0400
Message-ID: <CAHC9VhT9ZEM03CYq9eJu-V-Ei0qFWV7XTC4EUU8fV274JK=WDQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] audit,io_uring,io-wq: call __audit_uring_exit for
 dummy contexts
To:     Julian Orth <ju.orth@gmail.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 9:12 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, May 17, 2022 at 6:33 AM Julian Orth <ju.orth@gmail.com> wrote:
> >
> > Not calling the function for dummy contexts will cause the context to
> > not be reset. During the next syscall, this will cause an error in
> > __audit_syscall_entry:
> >
> >         WARN_ON(context->context != AUDIT_CTX_UNUSED);
> >         WARN_ON(context->name_count);
> >         if (context->context != AUDIT_CTX_UNUSED || context->name_count) {
> >                 audit_panic("unrecoverable error in audit_syscall_entry()");
> >                 return;
> >         }
> >
> > These problematic dummy contexts are created via the following call
> > chain:
> >
> >        exit_to_user_mode_prepare
> >     -> arch_do_signal_or_restart
> >     -> get_signal
> >     -> task_work_run
> >     -> tctx_task_work
> >     -> io_req_task_submit
> >     -> io_issue_sqe
> >     -> audit_uring_entry
> >
> > Fixes: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
> > Signed-off-by: Julian Orth <ju.orth@gmail.com>
> > ---
> >  include/linux/audit.h | 2 +-
> >  kernel/auditsc.c      | 6 ++++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
>
> Hi Julian,
>
> Thanks for the report and the patch too!  I agree that it does seem a
> little odd that we haven't seen this before, let me dig into this a
> bit more today and respond back.

The patch looks good to me, thanks again.  I just merged this into the
audit/stable-5.18 branch and added a stable tag; assuming the test
runs go okay I'll send this up to Linus tomorrow.

-- 
paul-moore.com
