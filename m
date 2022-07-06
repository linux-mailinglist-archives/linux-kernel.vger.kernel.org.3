Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89995567F32
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiGFHAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiGFHAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:00:24 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18D1F2C2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:00:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g4so25835867ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fP9UL96cxJNu+e/w1ZAS0SabjOjSeie47tNUCSGsUoc=;
        b=bInBYldfUKoDTJgam4jbKqa+UaD8EA8WAlBbf3FnOC4E50CpfP8GkcYd+oT8YoNZce
         jEaHOJ5DcEI5VMT/pCfcH847uP5MbHL6gLoCuevejao+xJxQiLAmM4TAiLFEIHjZFZsn
         sUFOErAxxxRrJTktcR+YDboQkteP4+At0xLApZ5Md/uSwKQUMbjUfkWxLHbbzL3oP28S
         zbQHnkZpcb7HwiIZ0zGYVbbG0e70enGSkiJaX/jfe7FSoRtsghLgPd8vIY5vCD855Vzw
         Qpy3wIqI/3r8EJVjVzAfTT4qSTaurvTTTKgrKveJkVzawr+kJhAYC5YdbIIrv7VIZfvA
         pTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fP9UL96cxJNu+e/w1ZAS0SabjOjSeie47tNUCSGsUoc=;
        b=foGZQsi/4PvZ4h+ZW+ZvOc809GtoRnNnV5Hl6PbV1tGQcR/n+k4V8rQYTtWMDzsHmq
         0rVjM4qjCQ+fIXD3aHGa7UEGcsdVSGDRwKSTZQRgPgr78qg10BQT9B1G5amng5DwlkcG
         cifwgfJMC016mJZD3S7qs5Gx9Gbot5fWGd7ZVaPQBl690ZMqDo4NQrrmiVWqLCYx01iM
         s4zX1h5DfwOaiavcLG1M5RNjzIlqWGAXeKp49wDyd41+RZt16WYsem1IFc8rPjTGXF46
         xxxBzH6ek5mgSHHhwQbkUvuaP7pPiSZVNvHYkCDrfoR4Wvtz9EmYbzVm+S1LmUnjLzpl
         +a4g==
X-Gm-Message-State: AJIora9bg606WXMy7oMoR9tSLkYt1ovnQk/w3JagRrW6QnAh7STRNDZ7
        G3bQqT8ubzirsa5U0mE5a5vDoJOOEufm+dR4xcAJFw==
X-Google-Smtp-Source: AGRyM1t+ZEQAVYtPCYHNF4OZvBPyldFzJskniQgVQGjAGnFo0ZI7Xdr+ZZT9n9u7lmcJSCmUhj7Qj2EvQYLapYoBwzM=
X-Received: by 2002:a25:7455:0:b0:66e:2daf:8924 with SMTP id
 p82-20020a257455000000b0066e2daf8924mr22469402ybc.427.1657090822296; Wed, 06
 Jul 2022 00:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220706052130.16368-1-kuniyu@amazon.com> <20220706052130.16368-4-kuniyu@amazon.com>
In-Reply-To: <20220706052130.16368-4-kuniyu@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Jul 2022 09:00:11 +0200
Message-ID: <CANn89i+mJCN=4h5-MM5jUQN8Hv=NdyTmQQb7Oeop+DyYVcEWUg@mail.gmail.com>
Subject: Re: [PATCH v1 net 03/16] sysctl: Add proc_dointvec_lockless().
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jul 6, 2022 at 7:22 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> A sysctl variable is accessed concurrently, and there is always a chance of
> data-race.  So, all readers and writers need some basic protection to avoid
> load/store-tearing.
>
> This patch changes proc_dointvec() to use READ_ONCE()/WRITE_ONCE()
> internally to fix a data-race on the sysctl side.  For now, proc_dointvec()
> itself is tolerant to a data-race, but we still need to add annotations on
> the other subsystem's side.
>
> In case we miss such fixes, this patch converts proc_dointvec() to a
> wrapper of proc_dointvec_lockless().  When we fix a data-race in the other
> subsystem, we can explicitly set it as a handler.
>
> Also, this patch removes proc_dointvec()'s document and adds
> proc_dointvec_lockless()'s one so that no one will use proc_dointvec()
> anymore.
>
> While we are on it, we remove some trailing spaces.


I do not see why you add more functions.

Really all sysctls can change locklessly by nature, as I pointed out.

So I would simply add WRITE_ONCE() whenever they are written, and
READ_ONCE() when they are read.

If stable teams care enough, they will have to backport these changes,
so I would rather not have to change
proc_dointvec() to proc_dointvec_lockless() in many files, with many
conflicts, that ultimately will either
add bugs, or ask extra work for maintainers.
