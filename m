Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D09517165
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385593AbiEBOTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385560AbiEBOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:19:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0089F1704F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:15:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w1so25486874lfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOLJXo/vSTtpALBlBvzttw8Pp69Dqf8rGJt1mV1WZeE=;
        b=JOjFi/Yz1n/ESiYrUoOPh4k+lzcHGUxHZv17F0vKhorMYcWOQVs2vx39gV/QrDYYJr
         aSC9RNDE71JG2OX9f4/JMkpopqfaGihFSVdjoB3NQaVXnNIop5JjdX8okqqdr92gRLpz
         eCEOZodBnor9StmCDVIF+E3BvywjXWVkRyttw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOLJXo/vSTtpALBlBvzttw8Pp69Dqf8rGJt1mV1WZeE=;
        b=gPpB9lCVPcoUoWeZupfuiBLQczOKySPiAnueGrxy8EUNMQv9Tg0D1fcdfXiB8fgHeA
         0WuSrwnkA6ujb34yhGXuJsIeuoK+/nUQe0NpMMxfAaOxbpPJ6Q22C6gwIWEYPmJHE/SK
         EdOwUcLlWcugsuh4lcZCEik23taAhl9Rk2V6VyKt3NyA/MdOAUfITuXdTyKwjt9JHmRY
         C9oEeGP6ZLWdgmZ8r+jLQewltUI3voHOvPQqanYs+6dodBnvhnl+ygLxSoDAhKPxdNaA
         Vl+u06Gurl843rNTBGqEstiSa32hoLG5AZVMFdzo6oEY9xAxZbWcczIvGsPf6XZhTMLP
         u10Q==
X-Gm-Message-State: AOAM531tuvIdg9g7LZz0e2U1kfEN/Tge8EyfrqgmtuGWDFc+sRI4PDWl
        mI/6IwPKQ1bZBrIYkc66Yzi/8AU7gEv9vjMeueq8Ew==
X-Google-Smtp-Source: ABdhPJw/Ek08RuSjvgXRGCMqnKx1o3mXDTJJtx1mUw//TDguvxPqaSLUZxDN9M/aaF9KIS49cF6d1Kd/Gkfs9kJbu6M=
X-Received: by 2002:a05:6512:22d4:b0:472:3fb9:cf0c with SMTP id
 g20-20020a05651222d400b004723fb9cf0cmr8869774lfu.308.1651500943159; Mon, 02
 May 2022 07:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220429023113.74993-1-sargun@sargun.me> <20220429023113.74993-2-sargun@sargun.me>
In-Reply-To: <20220429023113.74993-2-sargun@sargun.me>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Mon, 2 May 2022 16:15:07 +0200
Message-ID: <CACaBj2Z0OO7quYDF6LBaNsh14xTm6cN+rcMJMYtTioXNQNd34g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] seccomp: Add wait_killable semantic to seccomp
 user notifier
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 4:32 AM Sargun Dhillon <sargun@sargun.me> wrote:
> diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> index 539e9d4a4860..204cf5ba511a 100644
> --- a/Documentation/userspace-api/seccomp_filter.rst
> +++ b/Documentation/userspace-api/seccomp_filter.rst
> @@ -271,6 +271,14 @@ notifying process it will be replaced. The supervisor can also add an FD, and
>  respond atomically by using the ``SECCOMP_ADDFD_FLAG_SEND`` flag and the return
>  value will be the injected file descriptor number.
>
> +The notifying process can be preempted, resulting in the notification being
> +aborted. This can be problematic when trying to take actions on behalf of the
> +notifying process that are long-running and typically retryable (mounting a
> +filesytem). Alternatively, the at filter installation time, the
> +``SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV`` flag can be set. This flag makes it
> +such that when a user notification is received by the supervisor, the notifying
> +process will ignore non-fatal signals until the response is sent.

Maybe:

This flags ignores non-fatal signals that arrive after the supervisor
received the notification

I mean, I want to make it clear that if a signal arrives before the
notification was received by the supervisor, then it will be
interrupted anyways.


> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index db10e73d06e0..9291b0843cb2 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1485,6 +1512,9 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>                 mutex_lock(&filter->notify_lock);
>                 knotif = find_notification(filter, unotif.id);
>                 if (knotif) {
> +                       /* Reset the process to make sure it's not stuck */
> +                       if (should_sleep_killable(filter, knotif))
> +                               complete(&knotif->ready);
>                         knotif->state = SECCOMP_NOTIFY_INIT;
>                         up(&filter->notif->request);

(I couldn't git-am this locally, so maybe I'm injecting this at the
wrong parts mentally when looking at the other code for more context.
Sorry if that is the case :))

Why do we need to complete() only in this error path? As far as I can
see this is on the error path where the copy to userspace failed and
we want to reset this notification.

I think that is wrong, we want to wake up the other side not just on
the error path, but on the non-error path (in fact, do we want to do
this on the error path? It seems like a no-op, but don't see any
reason to do it).

We _need_ to call complete() in the non error path here so the other
side wakes up and switches to a killable wait. As we are not doing
this (for the non error path), this will basically not achieve a
wait_killable() at all.

I think this was probably an oversight adapting the patch from last
year. Is it possble? Because it seems that in the previous version we
sent last year[1] (if you can link them next time it will be way
simpler :)) you had a new ioctl() and the call to complete() was
handled there, in seccomp_notify_set_wait_killable(). Now, as this is
part of the filter (and as I said last year, I think this way looks
better) that call to complete() was completely forgotten.

Is it possible that this is not really working as intended, then? Am I
missing something?


Best,
Rodrigo


[1]: https://lore.kernel.org/all/20210430204939.5152-3-sargun@sargun.me/
