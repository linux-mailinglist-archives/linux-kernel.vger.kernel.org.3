Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2BB51F285
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiEIBsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiEIBlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 21:41:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62690344E5
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 18:37:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n6-20020a05600c3b8600b0039492b44ce7so451657wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 18:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ql2K8wjSf4eSR22uE7Flc4Ghh3WCh6Zkh++Kk33ag4=;
        b=Ra5fBxl1HbkVvB5WFu32ZS3wUApM4Nh/avRNb5JsMij0zVMYAj/r5UD5SACg1+lUzc
         /CdemvsyD7QwAU3vt0qcqdu5cEcWfHM+POLTZ4Z5dDSoqive9DkMrZXTjtsOMdE0/yGO
         P2qO09GGsC8R3xagaeYe16hOIFZ88hQNVU5eqADaFCo0ZJkn7jlIJRrNEOuyksBGLKRP
         iGG/BE51embL80f3Z9wNI0FJdfyIfiYVkmF4pD9pbsiH+uxfc8D5dZ+caQ+U+OYI1aNu
         iIYm6HzUVyFFHsyOSM7/n1YK+MMHIZe6sq7uluURvzm+1j1dkQeoMtAEbUF5beBun51y
         uL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ql2K8wjSf4eSR22uE7Flc4Ghh3WCh6Zkh++Kk33ag4=;
        b=mEi49q19N9eBTA/iQdlseIHrq0snEdoZTxqXEBVf+UeD8vHUOKU7LOWXF12SFDbqww
         h0s2G0FO1l4YAVYhcBj9/NZEUGfoAM0MKy6nxa9CrJu1JJBpk5qRFn6SqkCUV8+Zc3hp
         Cz3UIdrOTIQ9zhCF1b2Cn0P+pUaF35yGWwIahPai/bT788JzvcYD193PLruQKe0InyBO
         mUAnxbbjlEqtO2B2FwJVa6BZR2UhWARKWE0FeatIBLpyYFWIOIYIDUWXrTzBJGw570eG
         1q9GlixPUEPfS9WmFY+uoRIDZadVeFuHQihwvIE9mLSwDQKKJXgzlbRKG48K8J8kI+W9
         hrxA==
X-Gm-Message-State: AOAM532xeuSOuW+eSeEYtbyTCJB0x5fPO+yHeJ4rCz33YGn5nsTyiJKi
        2zei0Js/Uc81+37n0J4neF5vkdN8ncg4WCXkvYs=
X-Google-Smtp-Source: ABdhPJwaAqHptNkzX1mdGBUmDwDFFAnn19PIal9Nxh3ELThFCskmaptyyKr2IeXrNo9qfDSm7rRS84Rb5UL97LnYGDY=
X-Received: by 2002:a05:600c:ad1:b0:38c:8bf6:7d6b with SMTP id
 c17-20020a05600c0ad100b0038c8bf67d6bmr13755649wmr.84.1652060036236; Sun, 08
 May 2022 18:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220508161827.1014186-1-xiehuan09@gmail.com>
In-Reply-To: <20220508161827.1014186-1-xiehuan09@gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 9 May 2022 09:33:44 +0800
Message-ID: <CAEr6+EC+Kg4AJ=BFxrOSQV+KHj5WSm=1FtYCAPrn1gFnZUk-fg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Fix possible crash in ftrace_free_ftrace_ops()
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

I am so sorry to bother you, this may be an invalid patch, kfree can
return directly from null. ;-)

On Mon, May 9, 2022 at 12:18 AM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Currently if the ftrace_allocate_ftrace_ops() return -ENOMEM,
> the ftrace_free_ftrace_ops() will kfree(NULL).
>
> trace_array_create()
> {
>         ...
>         if (ftrace_allocate_ftrace_ops(tr) < 0)
>                 goto out_free_tr;
>         ...
> out_free_tr:
>         ftrace_free_ftrace_ops(tr);
>         ...
> }
>
> ftrace_allocate_ftrace_ops()
> {
>         ...
>         ops = kzalloc(sizeof(*ops), GFP_KERNEL);
>         if (!ops)
>                 return -ENOMEM;
>         ...
> }
>
> ftrace_free_ftrace_ops()
> {
>         kfree(tr->ops);
>         tr->ops = NULL;
> }
>
> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  kernel/trace/trace_functions.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 9f1bfbe105e8..d186d6101695 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -73,6 +73,9 @@ int ftrace_allocate_ftrace_ops(struct trace_array *tr)
>
>  void ftrace_free_ftrace_ops(struct trace_array *tr)
>  {
> +       if (!tr->ops)
> +               return;
> +
>         kfree(tr->ops);
>         tr->ops = NULL;
>  }
> --
> 2.25.1
>

Thanks,
JeffXie
