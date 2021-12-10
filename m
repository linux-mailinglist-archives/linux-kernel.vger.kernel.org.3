Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3872547078C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbhLJRp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbhLJRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:45:57 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A0C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:42:22 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so31485205edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jU4+ZJUt6AH1qNkknlpA94xy5vwnsr8pt6Dyw5zCAfI=;
        b=Z8tDT2VtrSThcDl7k6wASjqb/XKomG+eu42zCTgMoDNYx1xwGSTgpOWWNA11AJLtfV
         smnfdijrdSrGUJVFfawKIDjqDbNk9N7z+9zPrXOuuS4O+sa/o8ObC8PsHF3PvL2scjYG
         3nJV02qca6SCFENzUY3jFPfg+TvKr+5jPuKPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jU4+ZJUt6AH1qNkknlpA94xy5vwnsr8pt6Dyw5zCAfI=;
        b=PYOtUD7gEUN0wB+tlMZpim9ZRuCWQPFP8B8BwfU4cFw+BfPJ9wCdGuekISZ7eX67BI
         8b8t21KBFEaMZcqfkflWGyLUgLrHihLvtVrII+gFiid/to7xgInr7uGS15q9gPOgj+WU
         QVw7tV6MMSzHCIuU4IvQsqEiojIlNIxZeO+OAe39npmCW/LRZUK3PqYZP5sR0AiH1MTJ
         /3KPTln7dhxlFGavGAIw0lJwblckTi/uEtf4/0dHYugesXHqgYpR1gx671UOWChPciVX
         l/NhITXGFq1cUfx3BN6BpNbcNFMwFO81xvstrtpA5P9xgNUTEH2+la/eEe12jKI5V3ge
         p54w==
X-Gm-Message-State: AOAM5310a73S0fTnWKoY/WfKi4EbCc7b2G4AI2SZea48VthLWaqEpfiM
        ESMFL9jXBYsvpqjNjiwYR4zMerFfB2duxDKyZ14=
X-Google-Smtp-Source: ABdhPJw70fgmd2kuNr7GoPEvQWoWod9swfm8olzS/1QyDHafpO4A3L0j/NExQEzQmAdQWcYYuMmBPw==
X-Received: by 2002:aa7:d4c3:: with SMTP id t3mr41226578edr.268.1639158140490;
        Fri, 10 Dec 2021 09:42:20 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id f17sm1881814edq.39.2021.12.10.09.42.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 09:42:16 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so9557293wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:42:08 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr18357174wmq.8.1639158128346;
 Fri, 10 Dec 2021 09:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20211209214707.805617-1-tj@kernel.org> <20211209214707.805617-2-tj@kernel.org>
In-Reply-To: <20211209214707.805617-2-tj@kernel.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 10 Dec 2021 09:41:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiCZgpVjF2PNkx5V+Kuhr--1iX1yaYcOoxPsc2n2Zuhpg@mail.gmail.com>
Message-ID: <CAHk-=wiCZgpVjF2PNkx5V+Kuhr--1iX1yaYcOoxPsc2n2Zuhpg@mail.gmail.com>
Subject: Re: [PATCH 1/6] cgroup: Use open-time credentials for process
 migraton perm checks
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

On Thu, Dec 9, 2021 at 1:47 PM Tejun Heo <tj@kernel.org> wrote:
>
> +       saved_cred = override_creds(of->file->f_cred);
>         ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
>                                         of->file->f_path.dentry->d_sb, threadgroup);
> +       revert_creds(saved_cred);

I'm not happy about adding another override_creds/revert_creds pair,
but looking at what that thing ends up doing I don't see a better
alternative - no sane way to pass in explicit creds due to the way
that "descend to common parent, use inode_permission" thing works.

So it's not pretty, and I don't love it, but I don't see a better
solution either.

            Linus
