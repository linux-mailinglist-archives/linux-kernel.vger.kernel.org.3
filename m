Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73E652085A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiEIX2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiEIX2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:28:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B7916C5FE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:24:30 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 4so18849510ljw.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/2uXldvfYoKX/QsgMzn7huOl5appHYsaoLbp3Ty8ys=;
        b=J6HtOOIXn+++9tZpxLOu3p9VYF0mdyUdqvhQsO5esN7i/sXmpTP/yO4M9nC18YZ6Mj
         5fDNgWJFuYgNnzVEHtwaWjR/nzrq9uaMKxaOi054liqU7iEqnkwiZ9eSB9ZNXwSLka2b
         OWi3F4ycgplHJ7P/nbouHWtaehw+9S4DEdXcufofzqQUcNjDLlkfUi0iM5fmkIeIgfPx
         X6YXT/3MUf69um4+Jbw7v1vl/8Mw0K5TixG94pZ1N1XgR/rJWARIzw+DrXl78jZ8d//N
         J43xMqAQk9/TBw55RTFdPFbYGqAkK6SS/T1eOWQvhLARW8uZrIFW+pxjOV8WmimrVK1b
         rrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/2uXldvfYoKX/QsgMzn7huOl5appHYsaoLbp3Ty8ys=;
        b=3L8xS9WZuuV5OESKIui0CS6UDm8tYCgZ321QC3Dh1hCM9YwGLVK2AZNh0JYq1mh+ZZ
         yAkFNBKHJgYCgN1lZ8H1EDKyXPovoK7nLVCH3F/2DF1+mtP6h4F2+r5H2AJS7YAUxJzu
         bbo4dkG7bu4tcI4gVQU9HxVMK+B4tU63xbIA/Eh8LvV72wSEipI6aQAFyvIvsWucjhq6
         gLCu/YcT5V/98GnrMxtfbiPbJyW3kvogSaXjLMTdGcvy1jmiGpkimnp2Qs+8GrrmuBTk
         QGKQYNiImcWPO3nqdWRWVqdeAbBn2MjJvDRTm0HluCP62PlH24oTjVAAaWl7qZ3DUL5j
         EroQ==
X-Gm-Message-State: AOAM533yYrYeHbyFjFByUw5edQiJJpQjC548xBrrMhhlPKnSyc523VEj
        UhhMh7elU7o1xc6ScUvVyi7YQ52udL1RNQZz8PoYug==
X-Google-Smtp-Source: ABdhPJzEWFMfMDkJhx3DOXRi1RCESf4tPt23Su+LqDhn2rNxataUfhalMNNxRSEuSe669M7+8nEhNwRRaJLBStfbqe8=
X-Received: by 2002:a2e:a88b:0:b0:24b:5714:213d with SMTP id
 m11-20020a2ea88b000000b0024b5714213dmr12090006ljq.412.1652138668138; Mon, 09
 May 2022 16:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220509231901.3852573-1-cmllamas@google.com>
In-Reply-To: <20220509231901.3852573-1-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 9 May 2022 16:24:15 -0700
Message-ID: <CAHRSSExZrAEZuxska3kwpXCCv+p2+W_UPYCWbKUAswBjy97iBQ@mail.gmail.com>
Subject: Re: [PATCH] binder: fix printk format for commands
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
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

On Mon, May 9, 2022 at 4:19 PM Carlos Llamas <cmllamas@google.com> wrote:
>
> Make sure we use unsigned format specifier %u for binder commands as
> most of them are encoded above INT_MAX. This prevents negative values
> when logging them as in the following case:
>
> [  211.895781] binder: 8668:8668 BR_REPLY 258949 0:0, cmd -2143260157 size 0-0 ptr 0000006e766a8000-0000006e766a8000
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f3b639e89dd8..b4b0e4489bef 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3984,7 +3984,7 @@ static int binder_thread_write(struct binder_proc *proc,
>                 } break;
>
>                 default:
> -                       pr_err("%d:%d unknown command %d\n",
> +                       pr_err("%d:%d unknown command %u\n",
>                                proc->pid, thread->pid, cmd);
>                         return -EINVAL;
>                 }
> @@ -4490,7 +4490,7 @@ static int binder_thread_read(struct binder_proc *proc,
>                 trace_binder_transaction_received(t);
>                 binder_stat_br(proc, thread, cmd);
>                 binder_debug(BINDER_DEBUG_TRANSACTION,
> -                            "%d:%d %s %d %d:%d, cmd %d size %zd-%zd ptr %016llx-%016llx\n",
> +                            "%d:%d %s %d %d:%d, cmd %u size %zd-%zd ptr %016llx-%016llx\n",
>                              proc->pid, thread->pid,
>                              (cmd == BR_TRANSACTION) ? "BR_TRANSACTION" :
>                                 (cmd == BR_TRANSACTION_SEC_CTX) ?
> --
> 2.36.0.512.ge40c2bad7a-goog
>
