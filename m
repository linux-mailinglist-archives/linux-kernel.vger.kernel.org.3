Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022C4470EAD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbhLJXdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbhLJXdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:33:37 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E71CC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:30:01 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id l22so20715258lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOitPlFFPm+OxvIXW3SBCRLA2E6nBZZcNrzvZOZlvfw=;
        b=YUCCHshg30a6x4iZjwL4w38Ua3LtcjYwUSVgqekLHysLrBZbDZni0fE3GteKw6qpCF
         MCcpEs2uq4CvBREY1K2470MDJ4RjS4DDmmM5sn8NXmyN/rN0gFY6ZfZnUWbfz/FLtyOk
         FILgv7p/rl+bWcjOy+GsrxwAksxlJNtylPnvLTXiufABTWJ/3Eij2BeytbNTgAlyZhyk
         Vr9JBRewG5QNPpg9Ov6+FaDcXNae+h2N86Za5gm/enJxDAaJjSl2E1jbNWti72MqySYz
         heZG8mETEOcPzWhKRW5QJGmPB/jjfdQisj+qjoLq+3Qd+YEJAwxol+GeH+CFbM2e2v3J
         I6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOitPlFFPm+OxvIXW3SBCRLA2E6nBZZcNrzvZOZlvfw=;
        b=30UK4UVBbe6bizMTDgFooNVz8YJwNNLtugnL4aAmtvyqXBT1Fg3jpnAUmNLRcZc+GJ
         ZFf8BUqarRQxfAcmjKu53Sh/G/eGkoXyCot5gide711E387wDADD/MJHGG+nGdWb6MFr
         z3jUr+kDXtJ3mwfIB58Cs88PgloSfccsUgQDzRPojMnlWrgY82vDBLFGvgX7WSt3fCRf
         5tUnAvm0efHzGP0eQXj7Cjy4XrN0ehbrquh/IbBTnVZ3faWKlJZWczViEgUKv18CpisC
         0WfgidKAhpwPiWhVzoD0gQ/enwfRjo5lMxwOUNi3stInwjdtoB2YGSvakKM2TH7/UYcT
         3o3Q==
X-Gm-Message-State: AOAM532mKO8yPEgdmNlLBWqZjleSTmAFnBOidf64G3XYWuCtW0V6au8E
        g2l02Vg8kValMQMW91Ta32JGrnztJRtAdNZCsPNsOQ==
X-Google-Smtp-Source: ABdhPJwQN9RH1Bv3Foi3+8KAq3ZqLMXl/xo6wQAwxOwKGK2STSSo4JkXq6rIHZZlWu+C5GD4FSdpmedQYJ0ViIhJAsQ=
X-Received: by 2002:ac2:4f02:: with SMTP id k2mr15776192lfr.283.1639178999328;
 Fri, 10 Dec 2021 15:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20211210053743.GA36420@xsang-OptiPlex-9020> <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
 <CAG48ez1pnatAB095dnbrn9LbuQe4+ENwh-WEW36pM40ozhpruw@mail.gmail.com>
 <CAHk-=wg1uxUTmdEYgTcxWGQ-s6vb_V_Jux+Z+qwoAcVGkCTDYA@mail.gmail.com> <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 11 Dec 2021 00:29:32 +0100
Message-ID: <CAG48ez2YE08+vo+E+ZtxeikN4vVCJC+-BrWJUYWb0f0vRA0Uug@mail.gmail.com>
Subject: Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:59 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Dec 10, 2021 at 1:25 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > We could make a special light-weight version of files_lookup_fd_raw(),
> > I guess. We don't need the *whole* "look it up again".  We don't need
> > to re-check the array bounds, and we don't need to do the nospec
> > lookup - we would have triggered a NULL file pointer if that happened
> > the first time around.
> >
> > So all we'd need to do is "check that fdt is the same, and check that
> > fdt->fd[fd] is the same".
>
> This is an ENTIRELY UNTESTED patch to do that.
>
> It basically rewrites __fget_files() from scratch: it really wants to
> do the fd array lookup by hand, in order to cache the intermediate fdt
> pointer, and in order to cache the intermediate speculation-safe fd
> array index etc.
>
> It's not a very complicated function, and rewriting it actually cleans
> up the loop to not need the ugly goto.
>
> I made it use a helper wrapper function for the rcu locking, so that
> the "meat" of the function can just use plain "return NULL" for the
> error cases.
>
> However, not only is it entirely untested, this rewrite also means
> that gcc has now decided that the result is so simple and clear that
> it will inline it into all the callers.
>
> I guess that's a good sign - writing the code in a way that makes the
> compiler say "now it's so trivial that it should be inlined" is
> certainly not a bad thing. But it makes it hard to really compare the
> asm.
>
> I did try a version with "noinline" just to make it more comparable,
> and hey, it all looked sane to me there too.
>
> I added more comments about what is going on.
>
> Again - this is UNTESTED. I've looked at the code, I've looked at the
> diff, and I've looked at the code it generates. It all looks fine to
> me. But I've looked at it so much that I suspect that I'd be entirely
> blind to any completely obvious bug by now.
>
> Comments?

One nit: The original implementation is using rcu_dereference_raw()
because it can run in different contexts, but here plain
rcu_dereference() would probably be more appropriate?

(I was wondering for a bit whether we should also change the
get_mm_exe_file() path, but I guess that's fine because it can only
ever happen for regular executable files and currently there's also no
path to pull out the mm->exe_file and use it for some other syscall?)

> Oliver, does this make any difference in the performance department?
>
>                  Linus
