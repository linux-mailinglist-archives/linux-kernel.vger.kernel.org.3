Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA048B73B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbiAKTUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344749AbiAKTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:20:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D09C06175D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:19:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u25so409067edf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPEufsiWRxBxFa3x05EyMO915zm/zBjp5MyFqHNhJt0=;
        b=ERiX4Sa6hmrEflDwpKLYWFdH4eDxBQb8cmI+yn5DTykZAfrSCNR3ZM+K/1r1Hyz4WG
         c9CpxvgXHLNO0t9dA5xzgQl2mgLMUDOCQlkAPquuslr7eILu6G/mtCEOgGFNw2k5h/eH
         3cCRKxlYIYK2pE4hpJRpHpPUb0I91BhUci27U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPEufsiWRxBxFa3x05EyMO915zm/zBjp5MyFqHNhJt0=;
        b=cD2salKc7WBikJ0iM+2wsMiqknkB9k68lUw4tlGl0aaSrqeQ0d+t0vnNDW8qOa5DK8
         FY6ttY6oZ2VfBK5tT51O8zFihu5d+uTiKR2iUzxXsw/jWPwxu3sLSuU5IgQeM51+LRb9
         4J0OznSPi22JGb/kJr/BL/l3deoAJkHRBEFlV1nNVPMejNY0Ljl0XvB2bbexwVEHJ6Ow
         04P6eVKtWuZEU6P4wnIfreHbiamKmWi26fXU6D4lWjhR6sSGW+GHP4YEyOjfMFx5zacX
         Mfx369zMCpmchftQ+uxrO6mzqz6cIxrXM+HvUT+HQSznIHSNDCceqN49PN8RY8Zt7E+O
         vsEA==
X-Gm-Message-State: AOAM5339FZsbKa/dk/cT4aJTE4RKfmcXg5W7yJKPWOnQLrFp8vdR5PEn
        1n83Bye+YmKxn4lPGVLHT/zuSy8dwdT0KgJTWNI=
X-Google-Smtp-Source: ABdhPJwg7c+fDer2O/ztK+gJR1rJV3SWLZjB//bOa9ltPOUwO1tIrsM4BpWyBkW/bxvSuHtW0uqBvw==
X-Received: by 2002:aa7:d4d9:: with SMTP id t25mr5845531edr.298.1641928786614;
        Tue, 11 Jan 2022 11:19:46 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id qa11sm3839232ejc.189.2022.01.11.11.19.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 11:19:44 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso2077701wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:19:41 -0800 (PST)
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr3682702wmq.8.1641928781521;
 Tue, 11 Jan 2022 11:19:41 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211213225350.27481-1-ebiederm@xmission.com> <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
 <87sfu3b7wm.fsf@email.froward.int.ebiederm.org> <YdniQob7w5hTwB1v@osiris>
 <87ilurwjju.fsf@email.froward.int.ebiederm.org> <87o84juwhg.fsf@email.froward.int.ebiederm.org>
 <57dfc87c7dd5a2f9f9841bba1185336016595ef7.camel@trillion01.com>
 <87lezmrxlq.fsf@email.froward.int.ebiederm.org> <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 11:19:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZ=aFzFb0BkxVEbN3o6a53R8Gq4hHnEZVCmpDKs3_FCw@mail.gmail.com>
Message-ID: <CAHk-=wjZ=aFzFb0BkxVEbN3o6a53R8Gq4hHnEZVCmpDKs3_FCw@mail.gmail.com>
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Olivier Langlois <olivier@trillion01.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-arch@vger.kernel.org>" <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:51 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> +       while ((n == -ERESTARTSYS) && test_thread_flag(TIF_NOTIFY_SIGNAL)) {
> +               tracehook_notify_signal();
> +               n = __kernel_write(file, addr, nr, &pos);
> +       }

This reads horribly wrongly to me.

That "tracehook_notify_signal()" thing *has* to be renamed before we
have anything like this that otherwise looks like "this will just loop
forever".

I'm pretty sure we've discussed that "tracehook" thing before - the
whole header file is misnamed, and most of the functions in theer are
too.

As an ugly alternative, open-code it, so that it's clear that "yup,
that clears the TIF_NOTIFY_SIGNAL flag".

             Linus
