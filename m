Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A57D4900BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiAQEPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiAQEPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:15:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:15:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q25so60216636edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGEuclQ/ANIgfjJaHzjsoMZgh2q/56zilLVKng+xQwk=;
        b=J215/W9IGyjNHcU/4krTzJEq6weMnjOV2BlNKLvKeADBIpE6TF/w0fxgLrFIjJuJBq
         g4R0D5BC2IVUmuhrw/c6JFy5aehn13DIdYgpN3MDT3BG3c7T2Zir0tm/mIVxL87PSMbg
         eZAVHnQt9v0uOuzSBn0bzadlV2r48kVjkAl4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGEuclQ/ANIgfjJaHzjsoMZgh2q/56zilLVKng+xQwk=;
        b=utllPhWjX+Cr/ZvJvHxFhPrC7lX87o1HZIoME0UcPAlVEyxiHvHvVCWkdhn/Hq4yPz
         T/x01C046QuGQOndjgVKXzz05e7fqnkw6r9a+XRrXX4L3QZQ3YX6Vm3werfLYQY8tTNj
         eRGvxClQatYTD8gHTQYw4a/3lGCidxrdtFwCjdAa5HL3PCIM0/jWJlV+XcgQL3A1Imac
         /NiE/ZuBBh9O36qslCppF87uAOwjZYejz2pAP76Ddt9klOXqt616TIL+qxI1kRZpyBrJ
         qqIjAgz2Gm61Vo2jQSnLe9zzIMfLhcoXG1XKDLWdP/AQt4zRNWSIXKvKfu1C9ZVJzBGx
         +q3w==
X-Gm-Message-State: AOAM532oF7KLhHQUnO6M3aTr8JjeERYtH7n7MDeBCNlqHEpAfxeLyadx
        9kEm7O1/Vu+vScGmxRM4ZmG8AaQKYYra5aQz
X-Google-Smtp-Source: ABdhPJzxkfmAQr2nuyDUOYvOduoFBThSKMxuEs9K5XXr/0FQ71RAt4HcJFEz4dyjmLzB7/s7IqDGsw==
X-Received: by 2002:a05:6402:40d6:: with SMTP id z22mr11526391edb.130.1642392933336;
        Sun, 16 Jan 2022 20:15:33 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id hs32sm3955384ejc.180.2022.01.16.20.15.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 20:15:32 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id r82-20020a1c4455000000b0034cd1acd9b5so213171wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:15:32 -0800 (PST)
X-Received: by 2002:a05:600c:1908:: with SMTP id j8mr3977616wmq.155.1642392932596;
 Sun, 16 Jan 2022 20:15:32 -0800 (PST)
MIME-Version: 1.0
References: <878rvhlvh2.fsf@email.froward.int.ebiederm.org> <CAHk-=wgS865kHU=4NO=AvK07fcK7M6C6EYGdk80R1tkPKTLyhQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgS865kHU=4NO=AvK07fcK7M6C6EYGdk80R1tkPKTLyhQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 06:15:16 +0200
X-Gmail-Original-Message-ID: <CAHk-=wheeokE5rr_64iS_qnKmzSH4=e2Ds2L3gR_zSH=Cr4F5w@mail.gmail.com>
Message-ID: <CAHk-=wheeokE5rr_64iS_qnKmzSH4=e2Ds2L3gR_zSH=Cr4F5w@mail.gmail.com>
Subject: Re: [GIT PULL] signal/exit/ptrace changes for v5.17
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 6:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> People sometimes think that is just a "poll/select()" thing, but
> that's not at all true. It's quite valid to do things like
>
>         add_wait_queue(..)
>         for (.. some loop ..) {
>                 set_current_state(TASK_INTERRUPTIBLE);
>                 ... do various things, checking state etc ..
>                schedule();
>         }
>         set_current_state(TASK_RUNNABLE);
>         remove_wait_queue();

Of course, in most modern cases, the above sequence is actually
encoded as a "wait_event_interruptible()", because we don't generally
want to open-code the whole thing.

But the actual end result still ends up being exactly the same, it's
just syntactically denser and more legible version of the above thing,
and you can still have the "event" you wait on have nested waiting
situations.

The nested waiting is by no means common. The only _common_situation
where you're on multiple wait queues tends to be select/poll kind of
things, when they aren't really nested as much as iterated over, but
conceptually the nested case is still quite important, and it allows
you to do things that a traditional "wait_on()" interface with just
one single wait-queue just doesn't allow for.

                Linus
