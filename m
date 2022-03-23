Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D114E5742
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245727AbiCWRTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCWRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:18:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085917A99E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:17:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b5so2774162ljf.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nV5zT/IPWfHfMALgu8jZtBHLqrJVNpVUru45QGm3f4Q=;
        b=EDGC6GZYd561Kfvi+UNV2Jbxs/RFabbWODAha5eN/uNyRfD+AR/HATK85SzSZjR0bd
         n9O/SCH17cisoXSg4p2AvG+0P0kJyIroKhhFJWOvyzrM9sAd8WNRvrUWMMf55mee7TcP
         ov5fPu7eDU8aOW8biKmHQDFZc31HOUmWJsRcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nV5zT/IPWfHfMALgu8jZtBHLqrJVNpVUru45QGm3f4Q=;
        b=xgCEq48ar1ViXu7fX8Pw1FtLfwxiLaX0kP7wZY3ZWg3qVAIdwStQ0jmiFC8iJ0w0HY
         //Upszn1kImBbrR/ihC5mcp70HCoRqQeHM/JTLvhPjvMk+VxFlEwdpaa16FLXkJ43LjA
         fE2f+QbCceMtQHOlB4gFuFYNGMNU8rH2YoZ5OZgwCNsDnB2DPH2v1Vj7nQwyZMEvnrBc
         rv4cxITtEyqilgECSf+J2LyS5rdwt9wfDniqRpZzmW+Do4Y3vpcroL/dlKDoClIh0c3t
         eF49Oq1k8dggxwBTNP28CvGZxds3wQ73cRSwEL8iJpB66J+Tb5pVXiMShIjJOVBIyL2E
         f/8Q==
X-Gm-Message-State: AOAM53130m2VgvvwDGUYTO5K1/0g32pjNIeSAFOSK0qcBDjXvjFKSZ60
        tTIaPoGN+gu57kF0IEfxOTV4cRvf6bKIIdo/GIs=
X-Google-Smtp-Source: ABdhPJwH/j0s6BDAWOIGpqGNIWSQkj+GvmZVmCZYmZt81Fl2x703kEy45FCCE0eDFmOlrVHtv5ONsw==
X-Received: by 2002:a2e:9a92:0:b0:249:7e2e:3aa5 with SMTP id p18-20020a2e9a92000000b002497e2e3aa5mr869701lji.86.1648055846818;
        Wed, 23 Mar 2022 10:17:26 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id z13-20020a056512308d00b0044874828803sm42003lfd.309.2022.03.23.10.17.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:17:25 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id w7so3819887lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:17:25 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr644774lfb.435.1648055844654; Wed, 23
 Mar 2022 10:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <YjhdcJB4FaLfsoyO@gmail.com> <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic> <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjrIDlUePHQtIV4K@linutronix.de> <Yjr/9ATrCDxr/0hq@linutronix.de>
In-Reply-To: <Yjr/9ATrCDxr/0hq@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 10:17:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh81PAKxapicYOby3WWOFJV2htR5KWCRdKNgw68mOc0Zg@mail.gmail.com>
Message-ID: <CAHk-=wh81PAKxapicYOby3WWOFJV2htR5KWCRdKNgw68mOc0Zg@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock: Pretend to use the per-CPU variable
 if not needed.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Wed, Mar 23, 2022 at 4:09 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Replace this_cpu_ptr() with __ll_cpu_ptr() which points to
> this_cpu_ptr() when it is used.

Ok, so that's just really ugly.

Is there really no way to just fixthis_cpu_ptr() to not generate crap
code when the result isn't used?

I get the feeling that the real problem is that on x86, we have this:

#define arch_raw_cpu_ptr(ptr)                           \
({                                                      \
        unsigned long tcp_ptr__;                        \
        asm volatile("add " __percpu_arg(1) ", %0"      \
                     : "=r" (tcp_ptr__)                 \
                     : "m" (this_cpu_off), "0" (ptr));  \
        (typeof(*(ptr)) __kernel __force *)tcp_ptr__;   \
})

and that "volatile" is just *WRONG*.

That volatile is what literally tells the compiler "you can't remove
this if it isn't used".

But there's no point to that.

So how about we

 (a) just revert commit 9983a9d577db4

 (b) remove that bogus 'volatile'

Doesn't that fix the problem?

              Linus
