Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F909470958
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbhLJSzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbhLJSzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:55:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3E6C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:51:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id k37so19763794lfv.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXaHnqe5wvQNIW8pShMSOZQU+lFi8khZyCu5Ta4Jse0=;
        b=XNRA+9wkoCi0tLLatVhXORtcKPl4V1nn4w6Uq4YKX/J8YsxqkJQGqMf8hTsEs8LVjY
         PcJvH2zrw6/sgAdHwtebpkL3KkqMLINxXIB77gtzg9A5b8041+fCI02uyeYnvhk1p5f1
         cX1Q68q1uWelNgw2u0m2n2OXF7Ax3TE6tK/CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXaHnqe5wvQNIW8pShMSOZQU+lFi8khZyCu5Ta4Jse0=;
        b=WZRbSHiopBrx2RPaHm/oTILVcPpllBP/nj8wTxErD3fyAzCiFN4BtDd/vVuNIWzA0J
         3nEg45gb0Q+i8WD2cGv+/MiBwn/o/hceu7Jb4+LUFJ+f3VP2afHnLNWnc+KgpOnwglbS
         yPvbcLfGrh5lBMG7MUNQ9cXtDbaelOrb2h6/dGitvBMm5V0L+x33Jfdy0nG9Cq+SkOLO
         xCf3i3pehrLjAAmT6X0YXQSGPHLLMZCQn4b8MClB61P4352h5mGx7mEmF/OHY0tT/sZD
         OWoNGCfZZ2p/lgv9thWIsxtN3Wf/16Rf3w+8p6dI2NqVXLxb34wumIgu6uQyBdy1EJkC
         5rtw==
X-Gm-Message-State: AOAM533F6feVnoO27HH/9S3kZEbsz4Ln3kbYHHaGn3UTcTKoifMw4DdP
        +t95F/edm/bbaZ5tgCWvKHmuZYV56WOH82UDon8=
X-Google-Smtp-Source: ABdhPJwMzE7O8Jd54bYRWBneCIJADg4Bo4/lGD+eqsDPaQzQv+WYNspoW9LZvP3eMzJ/G2uBm6ydCQ==
X-Received: by 2002:a05:6512:33ce:: with SMTP id d14mr5477014lfg.623.1639162305166;
        Fri, 10 Dec 2021 10:51:45 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 9sm384432lfr.193.2021.12.10.10.51.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 10:51:45 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id p8so15073467ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:51:44 -0800 (PST)
X-Received: by 2002:a5d:4575:: with SMTP id a21mr16448262wrc.193.1639161949306;
 Fri, 10 Dec 2021 10:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20211209214707.805617-1-tj@kernel.org> <20211209214707.805617-3-tj@kernel.org>
 <CAHk-=wgiYkECT=hZRKj8ZwfBPw2Uz=gpOGBGd4ny0KYhSsjC0w@mail.gmail.com> <YbOeiu5+DZQsJbm8@slm.duckdns.org>
In-Reply-To: <YbOeiu5+DZQsJbm8@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 10 Dec 2021 10:45:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVUBc+9UVYp=uhyqTTw-QTHNrJow1Av+1jB4_Va93m1A@mail.gmail.com>
Message-ID: <CAHk-=wgVUBc+9UVYp=uhyqTTw-QTHNrJow1Av+1jB4_Va93m1A@mail.gmail.com>
Subject: Re: [PATCH 2/6] cgroup: Allocate cgroup_file_ctx for kernfs_open_file->priv
To:     Tejun Heo <tj@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Koutny <mkoutny@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:38 AM Tejun Heo <tj@kernel.org> wrote:
>
> It's a bit of bikeshedding but I wanna explicitly denote who at currently
> uses the fields, so how about nested structs w/ embedded iterator?

I don't mind being careful about uses if it makes sense and it's
really statically obvious and never used outside that one file so you
have no non-local cases,,,

Yeah, you export the struct in an internal header file right now, but
I think that is just for the upcoming 'ns' member, not the union
members.

But if it then ever becomes a possible source of confusion and it's
not obvious from the context who uses what, I'd rather use the extra 8
bytes in the allocation.

Ok?

                   Linus
