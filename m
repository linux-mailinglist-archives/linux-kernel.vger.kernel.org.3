Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B488560E64
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 02:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiF3A5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 20:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiF3A5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:57:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521281A818
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:57:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fi2so35837684ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7vCW8IYhm+2yyrB9+yLMMui5iqMlnMcEqzDN84wUcZo=;
        b=bN3+6Isir26Sr1XfDTvfMADv3bYhsAG6r8sElBLGsYJQq154w+i/b2TvLMRmfmsgbL
         jjjyfaQC31tBwLeMU/tFeg23xueymFSaYWhwsXAXWs09tKVnQ9e6sC/2a2zso8qZH3FZ
         qdfqpNd1WEhhchTF3vtrqHD2UbssPWdTp9RnKZWkGhzVEqr4+xaNGEJkL2R+UZfsDBvL
         cvqIZvP5KvECbBiWVO83lF4yiO3LBYk+40VjS0un7LK7zWlucEB/+9Jl6S2cQGRZsRI1
         bj/Kc3IFRAMS58cNlRUl2o40Wvopq3+8ZPL5GC1UndbgObtVu5NX2VvVW/U1bteCBM0+
         YRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vCW8IYhm+2yyrB9+yLMMui5iqMlnMcEqzDN84wUcZo=;
        b=n4zIOxhyMfTtz+1zX2ESufEeBfuHUxJ+t8CNLyY7lKMG+D6ufks8NnfXyRKFSXOm4e
         15dq+ikZoCuNWHITAe0BA2jTqPF8ZNH++2A/puR44LCgHr7MYVZ46OKHdoeXd0eAjOtl
         5dfx6S3CH5e45zP7UlOiexV8gl9ZNE62yYI58O33+BJUrPuXzTQmFAlCdAGCiylWa475
         J2OiqEOlNapEx1WAqfg7f9h2493PWrurKUAUtCjUWgNQ//EagEs6uR8ApTSTSfNQp5PK
         qGhtN+0K4cSuUSH0BRqXIrBLOytaOaGVP03d58fSm+CiRb6pxvAiYR9fkhuN4uPC4WZZ
         kTDA==
X-Gm-Message-State: AJIora+auC/xIBKdp6SeVRMVQxcBrwKTdNMELodtYFi/UmBGvV4pAiHe
        Z7S/XfzYfLnMbZnKAzsGYxu3
X-Google-Smtp-Source: AGRyM1sMwk77JzS+0ifsj8Ki2FYMMLZw2jYfI4GUdNFIGT+tvJJUwpojc2pzPTtz8igOmOf3uTMmSg==
X-Received: by 2002:a17:906:79ca:b0:705:111f:12dc with SMTP id m10-20020a17090679ca00b00705111f12dcmr5917462ejo.602.1656550648646;
        Wed, 29 Jun 2022 17:57:28 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id i24-20020a170906251800b007262a1c8d20sm8353505ejb.19.2022.06.29.17.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 17:57:27 -0700 (PDT)
Date:   Thu, 30 Jun 2022 00:57:23 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE
 (INCOMPLETE)
Message-ID: <Yrz089EH/cpbSUIq@google.com>
References: <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
 <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
 <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
 <Yrlavf4Ymnz4T3LM@hirez.programming.kicks-ass.net>
 <YrlmOA/Xd+U7+b2E@mtj.duckdns.org>
 <YrnxHBoi6sO0vqV0@google.com>
 <Yrop5Wzc72GIREVv@hirez.programming.kicks-ass.net>
 <YrpMIcECVOMPVpJN@google.com>
 <Yrq0swWUDQL2DPXc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrq0swWUDQL2DPXc@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:58:43AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 28, 2022 at 12:32:33AM +0000, Wedson Almeida Filho wrote:
> > Peter, I meant to ask in my previous email: setting aside the syntax for
> > a moment, do you have an opinion on the sort of things that Rust allows
> > us to enforce at compile time (as exemplified in the new_paused()
> > fragment)?
> 
> So I used to do quite a lot of C++ in a previous life; I think I'm more
> or less familiar with a lot of the things Rust offers, except it is a
> lot stricter. C++ allows you to do the right thing, but also allows you
> to take your own foot off (a bit like C, except you can make an even
> bigger mess of things), where Rust tries really hard to protect the
> foot.

That's a fair assessment. I'd just like to emphasise one aspect: if I
shoot myself on the foot with Rust, it's either a bug in the compiler or
because I violated a precondition of an unsafe block.

> The one thing I dread is compile times, C++ is bad, but given Rust has
> to do even more compile time enforcement it'll suck worse. And I'm
> already not using clang because it's so much worse than gcc.

Yes, it's definitely going to be slower, but I think this is a good
tradeoff: I'd rather have checks performed when compiling than when
running the kernel.

One thing that may speed things up is to disable the borrow checker when
compiling a known-good revision. I don't think rustc allows this but
rust-gcc doesn't implement borrow checking at all AFAIU, so we could
presumably ask them to add a flag to keep it disabled (when/if they
decide to implement it) in such cases.

> I've just not had *any* time to actually look at Rust in any detail :/
> 
> But given I'm the kind of idiot that does tree-wide cleanups just
> because it's the right thing, I'm bound to run into it sooner rather
> than later, and then I'll curse my way through having to learn it just
> to get crap done I expect ...

Looking forward to this :)

Jokes aside, when the day comes, I'm happy to discuss anything that
doesn't seem to make sense.
 
> Anyway; from what I understand Rust is a fair way away from core code.

Indeed. However, we do want to expose core APIs (like paused thread
creation) to developers writing Rust code, so while the implementation
will remain in C, we'll implement the _API_ for a bunch of core code.

Cheers,
-Wedson
