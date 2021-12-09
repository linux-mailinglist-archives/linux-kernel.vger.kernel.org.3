Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99AB46F400
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhLIThs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhLIThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:37:46 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681BEC061746;
        Thu,  9 Dec 2021 11:34:12 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id h16so6388229ila.4;
        Thu, 09 Dec 2021 11:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjbF/e4IPr6w41XoeHe90MU9VqeA6wWtIu93GK+U99I=;
        b=VxpxA7pazg4J0Uw2yrJ468h9XVbHM3XC98y1oSNtayeUNncaxTuWP3jLdrD3yPYz+8
         Cy4PYzhBRe0bh4+o4TschXKyCc8S69143NLLw9MzbpyvMoRnfrPHP+JSH0ykpU5/80oj
         fK6gHhR7FpIG8HPoKD/LF8IgGl0RXhGMMkSJUcr0CkSGPhzgONrudJK9g8YVgLeh9OMn
         9O6ylG6WRFFWwsnPafiv/kTzFa9jwbsPp1nMBjHF+R8s1lt0YatXp+31bjmds+WwZEm6
         dlD7OQbNrYfwqYvrB4RkhIChnfiWB0Xi9ohc9ABKI/qvOzA3TvRdUimv+78J82ejERa2
         JF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjbF/e4IPr6w41XoeHe90MU9VqeA6wWtIu93GK+U99I=;
        b=lSUOOxn29z58gasOOazz+Qm1U7mTsuQEeku8orxk/HiWt8fwbJtfJNgDF3vwSZHePX
         UkD5zVwVszoiiUYUE7FoQC85wpCvwBb2HBrLdlA+dwp02SUhfvHKfaN+GefLJTWkKiIP
         aO3IgY+K/4mCyk/jhwIaKD+DAkl9onf6yt27sZnw16ivXvvDp7nJUEhlZJiY3G17LHqT
         FBYpUXhVtO2fK7bJCGLF/gfEmmcZZ7SuOo3ejBZzW1a4MpPzj5iA9hqHY7GLVA+XNQjU
         /W9WMmpu0cXjFrU6ya+e2Sl1zOHD+VrompDPkmDFPpOYl0pTIZmmvOvA8RNVWOSlSoul
         6Y9g==
X-Gm-Message-State: AOAM531EiJx9Qg4puTIMEbu8YxZ5Gqb/5KdGLunuuo1c2SzZd/GaflBI
        MOK8udxIWM/UQxqdRCsoQ68kEkVqHPOyQd58xlg=
X-Google-Smtp-Source: ABdhPJwbf4BStyul78aoixIbYXeNPT+vDDvVw180IUPyJAQY1AyTHLV4ByxbrJlu+3wi4eYKD/VfG1dO2Wq/7usImKU=
X-Received: by 2002:a05:6e02:1ca1:: with SMTP id x1mr17110581ill.72.1639078451722;
 Thu, 09 Dec 2021 11:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20211206140313.5653-1-ojeda@kernel.org> <20211206140313.5653-6-ojeda@kernel.org>
 <CAKwvOdk+A2PBdjSFVUhj4xyCGCKujtej1uPgywQgrKPiK2ksPw@mail.gmail.com>
In-Reply-To: <CAKwvOdk+A2PBdjSFVUhj4xyCGCKujtej1uPgywQgrKPiK2ksPw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 9 Dec 2021 20:34:00 +0100
Message-ID: <CANiq72kUBy64D_psB2YsBs4evfyGUJO6g2eb5-5xZYg2rVETsw@mail.gmail.com>
Subject: Re: [PATCH 05/19] rust: add `compiler_builtins` crate
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 12:02 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Rather than panic at runtime, could we do some binary post processing
> in Kbuild with $(NM) to error the build if any of the below symbols
> are referenced from .o files produced by .rs sources?

To error the build, we only need to not define them; i.e. the issue is
passing the build. Eventually, we should be able to avoid defining
them (this is what the comment is referring to).

There are other ways around, like providing an in-tree `core`, but it
is best to see if upstream Rust can do it.

> If we provide definitions of these symbols, then I worry about C code
> that previously would have failed to link at build time when
> referencing these will now succeed at linking when CONFIG_RUST=y is
> enabled, but may panic at runtime IF we happen to hit those code
> paths.

It should be fine -- by the time we consider the Rust support
non-experimental, we should not be defining them.

Cheers,
Miguel
