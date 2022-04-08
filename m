Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0822D4F97E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbiDHOXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiDHOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:23:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B172E0A0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:21:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q19so13075359wrc.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olQLWu1R/3Sdbp1yPNJGC4ZbkN8O9H0Nzxueo3jwg+s=;
        b=mXN8vH4bFI8g5XwcuA9uXkyRpBEmHbq23qEU0gWLfPy+9MrgPu+P/4kL2C+TalwK/h
         ZhiqPrb5/kP3zT0K5WIvjw9sny/co3+iXpHLsCv/XNwnPPRDV7ke6RcBu5qPB7xPA1v7
         vcz2n6OQtQqCxce5LQBxtY/LGKykNw58kGwYsX8iKpmJMUcZYSltIHQsHnXXr3jJ+fZQ
         WQYMbgzEvM5JG1pqM7S0+L2fiRO/1hXlahUng5z7j6YZRBNQO0Er4WZ+i18aJUGE0v80
         xzb7wJPddWA5ZZmWf933zqxlPCZUhKB0cIhE5KFs6mCYL9RsFDegBRH38+YCiRN71eJY
         eCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olQLWu1R/3Sdbp1yPNJGC4ZbkN8O9H0Nzxueo3jwg+s=;
        b=LS+/+wHYAQJbKoH92CKxc4KBRDgLBySMVXJC3OQR3nKIcpAOYPelNghmwZKFMeKKXi
         Yqu/Vs54RAG05ELTBO3/jKhEnImolcmsM38lKUkjrngkxTdyBr70nQ22R9rHoWf+D91q
         nhN+jh2CsVadWvSFl5K03ISKpf83wby3CNdMD2Eo5bf+LnFOAd4RYbZhPauWIl8KS9rE
         sfo0bCWlObVkcJf6fTVBRIF7sGdajfqCuS8DLIeVEKTRrUUuW+Vt2mzDZJLXvEqrZ0J4
         1RMOOmICL6mHb1D8TUgd55sDb/wMMWr3341O/dWvsFLCGZJyxsAIy0V8YvxeQKqCSZ0y
         N1yA==
X-Gm-Message-State: AOAM532M/q8w5Lc4Q7i4fHsFaJy8Vb9ep50f96HlzWWiKtTDf5XGcjc9
        VErpyaubMJ0ggtdocnKjRAvrZhuy9dEcwZ0x1NIZ/QDYB94=
X-Google-Smtp-Source: ABdhPJyKvhoXFn5E9zZSLgAIAgWwA8ZDJ+RHJxplvBHU0FVzJSIA8Hsc26WwqGmI+QtEVor7CdQABz2AShAVsY/WACI=
X-Received: by 2002:a05:6000:1862:b0:204:e417:9cf8 with SMTP id
 d2-20020a056000186200b00204e4179cf8mr15247534wri.593.1649427691352; Fri, 08
 Apr 2022 07:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220329163931.710555-1-xiehuan09@gmail.com>
In-Reply-To: <20220329163931.710555-1-xiehuan09@gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 8 Apr 2022 22:21:18 +0800
Message-ID: <CAEr6+EA-7H4tfpUhZqwLJA=nT+1NgXjwcKYuiqMrrDuC_Bj4hA@mail.gmail.com>
Subject: Re: [PATCH 0/3] tracing: make tp_printk work on syscall tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Anyone have any suggestions for this patch series? ;-)

On Wed, Mar 30, 2022 at 12:39 AM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Currently the tp_printk option has no effect on syscall tracepoint.
> When adding the kernel option parameter tp_printk, then:
>
> echo 1 > /sys/kernel/debug/tracing/events/syscalls/enable
>
> When running any application, no trace information is printed on the
> terminal.
>
> Now added printk for syscall tracepoints.
>
> Jeff Xie (3):
>   tracing: make tracepoint_iter_lock public
>   tracing: make tracepoint_printk_key public
>   tracing: make tp_printk work on syscall tracepoints
>
>  kernel/trace/trace.c          |  4 ++--
>  kernel/trace/trace.h          |  2 ++
>  kernel/trace/trace_syscalls.c | 25 +++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 2 deletions(-)
>
> --
> 2.25.1
>
---
JeffXie
