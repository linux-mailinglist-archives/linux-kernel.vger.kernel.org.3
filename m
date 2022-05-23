Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34206531D74
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiEWVNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEWVNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:13:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E33D7CDFD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:13:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id m20so31377022ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEP1Sx7rCNFyOLpG4WvaoVdWhcsixmKsvEBCEH9znfU=;
        b=Y+lzYq22HqtJwOUvt5765e/0ZNPSCo2xgjmlpoY7qzZJL12bKa5XotwTILyHeMerwQ
         YIRNxaSsbs7UFGVLboYg/r1kqAvoQWJPV4fJHG+9xqrKZGo9s2b6EGixYGUkab9yzrlm
         eXSKQkL454Gj0BQC4YIRI4VUqcG9BFfa/c5eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEP1Sx7rCNFyOLpG4WvaoVdWhcsixmKsvEBCEH9znfU=;
        b=jMcyqw0+DcDP42xYC9i5SnsPVxuPExpc7BBe4m2ZUx3qV3Gt0bypRxjJs3qIZ3ARZg
         IAyfFsE/JCQqxBT0pH+2fs4YuoXbZIfTqehHtYYg5/kNg48jaBxdaaDdj+e1QU3Wt5l0
         3+8QIwR+YhvF9/SnVjLwpv85vyyG350m22n8Z5KrKkAAzr+CJ9XVS9UCvLNNcnU9ztss
         Ftqk29nRCbXXJqWdWkt6/cB3IBRvORUyoHKpwnyb9x3B/9j1pcvv/SWAIKFgwjprrkfP
         ZGBuJDqzIbxyjGhAuV4eEReHoDvZM9rxJBsUKkpZS4I42mQNRXUdZpLTsUacyp2RHMXU
         PmHg==
X-Gm-Message-State: AOAM532g9fGnq/17LqSLVBch0vV1HLGLmB8VC0rewgsFWWJ7kIv/XYYx
        WGxXNx9jz38dUlNHH5wt68KylsTI0ecR3cMaHdI=
X-Google-Smtp-Source: ABdhPJzBEGAbeQyew3smt8/HR8pILGo91GdaXfCXbTffxITpaUHHDHNp9qFcvVaLLWRbKC15lwmVgw==
X-Received: by 2002:a17:906:3b8d:b0:6fe:94ac:2a78 with SMTP id u13-20020a1709063b8d00b006fe94ac2a78mr21988875ejf.547.1653340418835;
        Mon, 23 May 2022 14:13:38 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906849900b006fecf62536asm2024396ejx.188.2022.05.23.14.13.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 14:13:37 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id e28so22455663wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:13:37 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr14160275wrs.274.1653340416987; Mon, 23
 May 2022 14:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com>
 <20220523195605.GA13032@1wt.eu> <20220523202336.GB13032@1wt.eu>
 <CAHk-=wiX8P8atcx9at_N=-8pjU-d5cG509E=oZHfsVb1R41RZQ@mail.gmail.com>
 <20220523205043.GA25949@1wt.eu> <20220523210443.GD25949@1wt.eu>
In-Reply-To: <20220523210443.GD25949@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 May 2022 14:13:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFJKNPqLw1LW2pbfWxY50AGqBPJRMk2_KfpODD=-z5ng@mail.gmail.com>
Message-ID: <CAHk-=wiFJKNPqLw1LW2pbfWxY50AGqBPJRMk2_KfpODD=-z5ng@mail.gmail.com>
Subject: Re: [GIT PULL] nolibc changes for v5.19
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, May 23, 2022 at 2:04 PM Willy Tarreau <w@1wt.eu> wrote:
>
> On Mon, May 23, 2022 at 10:50:43PM +0200, Willy Tarreau wrote:
> > On Mon, May 23, 2022 at 01:30:37PM -0700, Linus Torvalds wrote:
> > >
> > > You speak the words, but you don't actually look at what it does.
> > >
> > > Try it.
> >
> > Why are you saying this ? I've figured the commands by trying
> > each of them.

Try this:

   make tools/help

and then actually *LOOK* at what it prints out.

Notice how it says 'nolibc' is a target here.

And then think about it. Just for fun, try doing

   make -C tools/ nolibc
   make -C tools/ nolibc_install

like that help message implies you should do.

Does it work? No.

> work the same on all commands but actually:
>
>    make -C tools/ nolibc_headers

Put another way: where did you find that "nolibc_headers"?

THAT is what I'm talking about. You are mentioning all these magical
things that don't match the documentation you yourself added.

                 Linus
