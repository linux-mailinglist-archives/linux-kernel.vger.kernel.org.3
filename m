Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7048C46C7EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbhLGXEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhLGXEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:04:33 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A29C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:01:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n26so806654pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55rrWYDZKebf3dwxACmc3YdgzweWYJxj0Se0PreSxpE=;
        b=otePzmPR7kMmFRnzUxq9rbm0GLe6xTOHsWl14emXE524XmcrrmIQZP8EXLym+dUv+V
         TDbKkGrt/2ciza7qdpgZ2QVMInyCqNpoZ+cfhcO/oUxX660NzrPedTf3HiNyvoddnKNL
         cb1Sk8e2Lx827ReWZ191sJV4+GLefD7r+s2aKcPP4p70YJ1gQnvUUPfGEsMs+OaTSo2S
         smUY9Rp3I5XJkQQ2MPsyd03NdKfK7fFzgcaSNRQucBbgecbF7mmtjjJgcr5/yR5M1+h2
         seddlzF9ACX7KGe+cIeg+4KqR5Zopblbza2rXwGcYwSzmI6ejcVxcofe76iP1o87hiCP
         lQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55rrWYDZKebf3dwxACmc3YdgzweWYJxj0Se0PreSxpE=;
        b=pgGPIxpTygIOaELC1JmX63CGImN7/HDBaIuxWDgdcWSHSUrLxiyp34CceMXaIWeoo4
         iQuGWo0nC4Rjp9WS9Fva7em/r0qzY/xLjId3Prgaer54cE9IrGptn8+/AYqnzobfwD+q
         u4K3Dov4oIc2a2sxhiQpuswZ6Wi2pGgW6ws0mL/0tPdM43f5OB17FV6Ph7rQ6OMvQ+lk
         3kaxBQ/xEe6crJjG44/lP5iNKAs6c0WxkkAHt+D6fvUjZt+3/GYJqq6lTq5HT4t8teWc
         8FgF8CCcS8EFA/mQGk3JP1NQJLKb8QetGJmyV7KtJUGshB/4G99yniJ5epNixhxwjdIw
         XajA==
X-Gm-Message-State: AOAM533xhh5qObnDZ+viWrt4ATvMMT002XfeqOrN9CebEXV1taOhVKqu
        msW9YMPPmPjVNRakpmTybJw9t1to1JoYIODMwzNf7w==
X-Google-Smtp-Source: ABdhPJzFdZHmW+Yu/K3OlIPRoaUaZ6kqg260gGxxiLVZr3XvDMULeAlunwMdsbuPPqaoTJp2N5ZSQOgUCu40WAcOIhE=
X-Received: by 2002:a63:f91b:: with SMTP id h27mr25751296pgi.12.1638918061654;
 Tue, 07 Dec 2021 15:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20211202203927.2004527-1-dlatypov@google.com>
In-Reply-To: <20211202203927.2004527-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 18:00:50 -0500
Message-ID: <CAFd5g47JTNJbA65586gRTimBjSyvvO=UzT1f7_zPKpy2=93q7Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: make `build` subcommand also reconfigure if needed
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 3:39 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> If I created a kunitconfig file that was incomplete, then
> $ ./tools/testing/kunit/kunit.py build --kunitconfig=my_kunitconfig
> would silently drop all the options with unmet dependencies!
>
> This is because it doesn't do the config check that `kunit.py config`
> does.
>
> So if I want to safely build a kernel for testing, I have to do
> $ ./tools/testing/kunit/kunit.py config <flags>
> $ ./tools/testing/kunit/kunit.py build <flags, again>
>
> It seems unlikely that any user of kunit.py would want the current
> `build` semantics.
> So make it effectively do `kunit.py config` + `kunit.py build`.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
