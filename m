Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBD655D8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiF0Wez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbiF0Weu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:34:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3377DF5D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:34:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lw20so22081991ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCkPoPb387dm0oEMmjD1G+OPWLFPYCkmoIbHTZj3UNo=;
        b=JiC57X8Fey3+PHFjcax1bTN2hkGvPmAw4a1GtCXCDd2Nqs4Kj1ehtG5Qhll9V98uFh
         xIcuXf3Gmr/TwRI+Wj2DzU5l6nZsKfBHR3vWpO0Hhv/Ns10IbpQlN8nKbnxaJ0PtyPGd
         NbOaA3iTaaGShW8zJkG6zQuEK7YUpM9ebzSK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCkPoPb387dm0oEMmjD1G+OPWLFPYCkmoIbHTZj3UNo=;
        b=jWI8CsZsJEGLJHOej7oxzObM8JAmAQollSalO8nkBtVWxb4WSaTAPog3CoNiKRueBD
         JdJl1m37aBLclNyQT5QLbCnmPqQMHCyW4g2epwNOEGjcqzBRerHdIHR8qEpKib7Hhv0H
         X7fOepWjAaWkQ0R1qySUqRwksKr2alBk3tX2V5YyvvZwf7CGzpWPVSdskR6IpEsGOagi
         vyslZVmAIBuQQPN/+ukhFsRYvnGEr8CCt94RH2eQf3iJV5KyVhvINxRgRO3ko7ETjo39
         NuCLmyWbVCHZb6KG0Q4baWcUNDx+9YyEDchIGQiOcW4RitrqiOsZitNkBW7x8E/h4b7d
         4LLQ==
X-Gm-Message-State: AJIora/65JffiQxFM9ylM92wkNAGoYr637TD4zHo6VScXdINq7sGUZWW
        sDZJwJl+4osHS4UkzAlgpz4RHs1Js3YXajukdok=
X-Google-Smtp-Source: AGRyM1v2tSTdI58ZFlyMKqAGGqOKdt2HIFpI8Qeuu1krTY6rLBsnd/h/HcSs03ZVFJ1tD5mBT74+IA==
X-Received: by 2002:a17:906:4fc9:b0:722:f204:ef5d with SMTP id i9-20020a1709064fc900b00722f204ef5dmr14343492ejw.213.1656369288059;
        Mon, 27 Jun 2022 15:34:48 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b0042617ba638esm8300798edt.24.2022.06.27.15.34.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 15:34:43 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso2941587wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:34:42 -0700 (PDT)
X-Received: by 2002:a05:600c:354c:b0:39c:7e86:6ff5 with SMTP id
 i12-20020a05600c354c00b0039c7e866ff5mr21798877wmq.145.1656369282336; Mon, 27
 Jun 2022 15:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org> <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
 <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org> <Yrlavf4Ymnz4T3LM@hirez.programming.kicks-ass.net>
 <YrlmOA/Xd+U7+b2E@mtj.duckdns.org> <YrnxHBoi6sO0vqV0@google.com> <Yrop5Wzc72GIREVv@hirez.programming.kicks-ass.net>
In-Reply-To: <Yrop5Wzc72GIREVv@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jun 2022 15:34:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGnX95hi315HnsTDiMdt3Kmq7y3PBBEJgoF2TdL9r44g@mail.gmail.com>
Message-ID: <CAHk-=wjGnX95hi315HnsTDiMdt3Kmq7y3PBBEJgoF2TdL9r44g@mail.gmail.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE (INCOMPLETE)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wedson Almeida Filho <wedsonaf@google.com>,
        Tejun Heo <tj@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
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

On Mon, Jun 27, 2022 at 3:07 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 27, 2022 at 06:04:12PM +0000, Wedson Almeida Filho wrote:
>
> >   let new_thread = task::new_paused(|| pr_info!("Hello world\n"))?;
>
> I'm still having a really hard time with this Rust stuff, the above
> looks like a syntax error and random characters to me :/

Heh. The '!' for macros is probably my least favorite part of Rust
syntax, it just makes macros look so unintegrated.

Not at all the kind of "you can use a macro instead of a function"
thing, because macros always have that '!' thing.

And yeah, the pipe characters used by closures sure make that
particular line look extra magical.

The question mark is a "do if ok, return if error". Think of it like a
"try" thing for exception catching.

But yeah, all the special characters does make me think of perl.

I haven't really gotten the hang of reading rust without a google
window open to figure things out, but I think that's just a "you have
to get used to it".

Or, alternatively, you have to just ignore the rust parts.

As I mentioned at OSS NA last week - it's not like most people can
read our MM code either - even when you know C, some of that code is
pretty incomprehensible unless you know how it all works.

If people can be productive kernel developers without understanding
the MM layer, I'm sure people can be kernel developers without
understanding rust..

                   Linus
