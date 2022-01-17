Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0899490BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiAQPoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbiAQPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:44:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADDFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:44:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so67558792edn.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Upvi0XzdCvtFkL0JqzI8bfZ5QWNaqy4SwHM8pYcOg9o=;
        b=Oo3Mrt6RPkDmTxg2P0tYbcMjVUYNHyWStbREGMl4xyj/FFC8q9haK3chg8iL1KD2ud
         zHwjiryWVt8bDldfcWm8lrzXMaEqff9Ddyn7NFXmH/47eK6SxG1yw6DfhyjNZ2TgSbO2
         pGHIQn1dTo8dLg4F2xKpbZeeTx7woU4UXsqgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Upvi0XzdCvtFkL0JqzI8bfZ5QWNaqy4SwHM8pYcOg9o=;
        b=3TfWCADPwv9ctnuH9Fxhw36Xs0E/VWj6iZxFdOGVG5B0UPy0Y6vSoj3lYg0kgiwTgH
         ID4ns2Rm0iDQi614CHhBb8j0KSUXtH9iWs2myOnCdH9/qk9LjzsjTPjj4ExscK4vN4/+
         G//25ge1ouVAxM1ctQeMoOMBqj7JZ7Td0IaYa06FxYGjjQRiXvn3xvAVT1ZSRq1+z7zs
         kb375jY9yDkzH2Nszj+5kszMStzxz9k2FNochjbRMzJhCzeg3m2JbYa21IBfvWA/UI77
         /1dcZ56JuAbFmk7+G07ySM9VWUKDdTCewO+saL4g5vol1n+C5oLnjSlXymo77Wl9ks5+
         CcSw==
X-Gm-Message-State: AOAM530KIgWlmjnpacQML2xET+R6pg696oMWMUJphY9ROnD/IGj3Yg7m
        Wb0I5EdTrgfsY9j9m97eQ+qnJ6aDCYqvA+Sf
X-Google-Smtp-Source: ABdhPJwZCapNcP5m5+FX3mgamhi+OQ13bF1tf/iwF0bahHYEspuzvXp03nvWoWp8tJqafgxjymwXrg==
X-Received: by 2002:aa7:c609:: with SMTP id h9mr21831610edq.248.1642434266668;
        Mon, 17 Jan 2022 07:44:26 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id k11sm2633627ejr.143.2022.01.17.07.44.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 07:44:25 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so455899wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:44:25 -0800 (PST)
X-Received: by 2002:a7b:ca42:: with SMTP id m2mr20661692wml.144.1642434264852;
 Mon, 17 Jan 2022 07:44:24 -0800 (PST)
MIME-Version: 1.0
References: <878rvhlvh2.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgS865kHU=4NO=AvK07fcK7M6C6EYGdk80R1tkPKTLyhQ@mail.gmail.com> <87bl0aidjv.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87bl0aidjv.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 17:44:08 +0200
X-Gmail-Original-Message-ID: <CAHk-=wju6gEi3faCozsfuE07KsHsqgvfXHLeETXO0QJa7eN+fQ@mail.gmail.com>
Message-ID: <CAHk-=wju6gEi3faCozsfuE07KsHsqgvfXHLeETXO0QJa7eN+fQ@mail.gmail.com>
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

On Mon, Jan 17, 2022 at 5:32 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I would like to have a version of pipe_write that sleeps in
> TASK_KILLABLE.

That would actually be horrible for another reason - now it would
count towards the load average. That's another difference between
interruptible waits and non-interruptible ones.

Admittedly it's an entirely arbitrary one, but it's part of the whole
semantic difference between TASK_INTERRUPTIBLE and
TASK_UNINTERRUPTIBLE.

You can play with TASK_NOLOAD of course, so it's something that can be
worked around, but it gets a bit ugly.

>  I want the I/O wake-ups and I want the SIGKILL wake ups
> but I don't want any other wake-ups.  Unfortunately the I/O wake-ups in
> the pipe code are sent with wake_up_interruptible.  So a task sleeping
> in TASK_KILLABLE won't get them.

Yeah. The code *could* use the non-interruptible 'wake_up()', and
everything should work - because waking things up too much doesn't
change semantics, it's just a slight pessimization. Plus the whole
"nested waitqueues" isn't actually any remotely normal case, so it
doesn't really matter for performance either.

But I really think it's wrong.

You're trying to work around a problem the wrong way around. If a task
is dead, and is dumping core, then signals just shouldn't matter in
the first place, and thus the whole "TASK_INTERRUPTIBLE vs
TASK_UNINTERRUPTIBLE" really shouldn't be an issue. The fact that it
is an issue means there's something wrong in signaling, not in the
pipe code.

So I really think that's where the fix should be - on the signal delivery side.

             Linus
