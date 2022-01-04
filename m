Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96771484802
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiADSpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiADSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:45:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D81C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:45:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f5so152083469edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kI7lvNJiYPzLyL1Je0qvpRBcO19V08nghbpJc6sg03Q=;
        b=O0l9LFOhe0v3r9xfQXVq7v4rwX3xK7UVbh17OAJbou3mDbSswePNdZq99CXPQ5vIbQ
         oDK6mHyvhN+fMCZYW134EsLULbvrAGYOKLuxUb7c4HjdN6JyBCmbvSofoCrh26sjcQVP
         Sv3wocV4KjjJ9qTWC0/NqJ1QLM6rKPr9OZG4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kI7lvNJiYPzLyL1Je0qvpRBcO19V08nghbpJc6sg03Q=;
        b=SfNAHe9MRxdEQdUvzbTOl9Ep7fxzXW8HlQs7e7jjwqK/UfY9OypOsSgOAS3Bq4DsYx
         utS3W+Kc9UUpImJZAIyR2xGKtQfDHvM8Ax3dT2FKeDatqMNRMBcGg6UJUkhmv6RbyEto
         uz6bWFR0le7dI+txeSHos7X7XHfYHiytWqyzUltnEXaavljfeRGmnikOOwF3fO1KamKG
         3QkN6VM5QTpvOUPnxht9TWlK0NA9eMFQkKp9LVp1hs1wgheHrf1aiZcIAt4LwPxba/Tf
         31jvtAo60Yd3H9Gxm3MFMSFGl7myuR5dDNpxqUXzymkkyjIbbAABwenwKexBJyVGCE3b
         b2cQ==
X-Gm-Message-State: AOAM532ADOJN4nYOtPBQ8zX0VQQDS5nArtkl+RwGwm6DmnQQLE+0dVld
        I4IVJcObvEq2CQjJUwVqw6U7npkAQfJvUnSn
X-Google-Smtp-Source: ABdhPJyTKhCqu78VvWXofQLMnyftctj0AzatraL5aEc8t7d6cPOSphFjbJc7yW5kqvy+3fyXXTk9NQ==
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr39876391ede.329.1641321917177;
        Tue, 04 Jan 2022 10:45:17 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id 27sm11645257ejm.41.2022.01.04.10.45.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:45:16 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso219265wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:45:16 -0800 (PST)
X-Received: by 2002:a7b:c305:: with SMTP id k5mr13487467wmj.144.1641321915993;
 Tue, 04 Jan 2022 10:45:15 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org> <20211213225350.27481-1-ebiederm@xmission.com>
In-Reply-To: <20211213225350.27481-1-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jan 2022 10:44:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
Message-ID: <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 2:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
>         if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
> -               if (!(signal->flags & SIGNAL_GROUP_EXIT))
> -                       return sig == SIGKILL;
> +               struct core_state *core_state = signal->core_state;
> +               if (core_state) {

This change is very confusing.

Also, why does it do that 'signal->core_state->dumper.task', when we
already know that it's the same as 'signal->group_exit_task'?

The only thing that sets 'signal->core_state' also sets
'signal->group_exit_task', and the call chain has set both to the same
task.

So the code is odd and makes little sense.

But what's even more odd is how it

 (a) sends the SIGKILL to somebody else

 (b) does *NOT* send SIGKILL to itself

Now, (a) is explained in the commit message. The intent is to signal
the core dumper.

But (b) looks like a fundamental change in semantics. The target of
the SIGKILL is still running, might be in some loop in the kernel that
wants to be interrupted by a fatal signal, and you expressly disabled
the code that would send that fatal signal.

If I send SIGKILL to thread A, then that SIGKILL had *better* be
delivered. To thread A, which may be in a "mutex_lock_killable()" or
whatever else.

The fact that thread B may be in the process of trying to dump core
doesn't change that at all, as far as I can see.

So I think this patch is fundamentally buggy and wrong. Or at least
needs much more explanation of why you'd not send SIGKILL to the
target thread.

               Linus
