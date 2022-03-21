Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FFB4E2EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351525AbiCURAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245727AbiCURAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:00:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A545C85E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:58:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u26so3052419eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utyUaFkr1ZuUiYWhJkaB0qXmsCfjA9OUpKcvX6RwIYk=;
        b=XiheaFj4jTydDhbYvNjr9omQv2Zp/C0MlIIU6zkU5VOIRbLNk0t6VwAsplXScFZ+iT
         0mVfRfx8BrSnrCW60YgtWfXKiVxii3x5D0Ei9Rq/sHLALGwDvddfnWi+PZ2vobYlSfwI
         6TpcGU6cypY7IpP1cZAsdxieS/Uau32wcvBcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utyUaFkr1ZuUiYWhJkaB0qXmsCfjA9OUpKcvX6RwIYk=;
        b=urdRbdBc75Eq6iNG3rZd0kjuPjokdu/18nrBoUqxic7PFCAf51nx+IMmzvjf7TJcxC
         Uk6qIOAZK69vUqTjkBrpPx5l4JLC1jA1UvZgLBEdce1uOi8ZMKKwckbE622jAaNjEYJE
         hHpE7lwYNP6p7g6aumpQHy5NusPN/gQPkLxxdUVRP0hzul7TUQDj6BMpiXGzL29ivi57
         Vgacd2aWNpXJ3RWJMULyS3u0/CIJuM3EClXCR/EfKrfUwvt3g/LK8OVVSDx4AGuUqn3H
         7C3dg9gjjKVfUbH5FFwCvSX3kvegVBYQIUU6WuwMujmNIFOVuwF13zBPGvDUvcGDG8dV
         6lvw==
X-Gm-Message-State: AOAM532I5q44WAB7ES9efeR1c2xrY5ZS3IHryyqv82e/05rc0ppF0nM7
        pc7kRKULRAULomlbb/CUE3d5sjbvVn9tI6TULDw=
X-Google-Smtp-Source: ABdhPJxMPg7wQxs2qB2lJpk3wlOZN2x/vdyIbMPPmZupUgBYk9fQEMsfs5slu9Ti8jayXx7o/ai64Q==
X-Received: by 2002:a05:6402:442:b0:416:14b7:4d55 with SMTP id p2-20020a056402044200b0041614b74d55mr23598492edw.183.1647881935583;
        Mon, 21 Mar 2022 09:58:55 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id o12-20020a50c90c000000b0041907e62024sm5304862edh.85.2022.03.21.09.58.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 09:58:55 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id w4so18599619edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:58:55 -0700 (PDT)
X-Received: by 2002:a2e:a78f:0:b0:249:21ce:6d53 with SMTP id
 c15-20020a2ea78f000000b0024921ce6d53mr16250149ljf.164.1647881594869; Mon, 21
 Mar 2022 09:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220321140327.777f9554@canb.auug.org.au> <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net> <Yjh4xzSWtvR+vqst@hirez.programming.kicks-ass.net>
 <YjiBbF+K4FKZyn6T@hirez.programming.kicks-ass.net> <YjiZhRelDJeX4dfR@hirez.programming.kicks-ass.net>
 <YjidpOZZJkF6aBTG@hirez.programming.kicks-ass.net> <CAHk-=wigO=68WA8aMZnH9o8qRUJQbNJPERosvW82YuScrUTo7Q@mail.gmail.com>
 <YjirfOJ2HQAnTrU4@hirez.programming.kicks-ass.net>
In-Reply-To: <YjirfOJ2HQAnTrU4@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 09:52:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguO61ACXPSz=hmCxNTzqE=mNr_bWLv6GH5jCVZLBL=qw@mail.gmail.com>
Message-ID: <CAHk-=wguO61ACXPSz=hmCxNTzqE=mNr_bWLv6GH5jCVZLBL=qw@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the tip tree
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 9:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > It's presumably not in any of the pull requests I already have
> > pending, but it would be nice if I saw some details of _what_ you are
> > complaining about, and not just the complaint itself ;)
>
> Duh, right. It's this series:
>
>   https://lore.kernel.org/bpf/164757541675.26179.17727138330733641017.git-patchwork-notify@kernel.org/
>
> That went into bpf-next last Friday. I just checked but haven't found a
> pull for it yet.

Thanks. I can confirm it's not in any of the pull requests I have
pending, so I'll just start doing my normal work and try to remember
to look out for this issue later.

                 Linus
