Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8D4DCE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbiCQTOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiCQTO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:14:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C2DE58
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:13:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so2546775pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NBOOF+uyFyxLaWu+GT1p9HM5Hekl2IkavrJeMjwJm0c=;
        b=MTDEfEjMhkmfx7trUWVfiIWtjPo+jRAM9pS5rkuvDODZcsrnB1D1YHjZO6vAf8s2ko
         PP1azNDvOHYXpFL8Re9KX3HkRLAfyCyDI3m2ufeR52kQK7ytfolD3wvbRm1X8fMGNiTe
         XwtlDIxvr5uAQ5nRxCSXR6iUW4HDYZdGu7nqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NBOOF+uyFyxLaWu+GT1p9HM5Hekl2IkavrJeMjwJm0c=;
        b=KByF4t6vH2jHHd+/e2ft2QNLa7sxeVrvAPDrV+0fZlf2Ku0UwdAH4k+cztiVgpfTMc
         mR4Cvtrc51wJYTqycE62KBOkqrxNL04zKrmPVM09f1IRABbOWdHI9827Qomnz9cjTYHJ
         f/O9ASu/XxT4Cj3AdrBrOuOuExK51r3bFG/SQXyAc6fU+aKN5ab2Gg9k+9rW5EvACS+v
         a/RcgQQStxHpVhp13deyNockk0ldjBQOljeRrZiplw7BNdcVaJ1y8l4uMgjb9RHeKsxt
         H9qhch5dfoGEo15aJEqxFmHXMwgzRXJP3UNyPOrPaWvUFFkUR7sIs1rNTLjorrJodlFA
         fHNQ==
X-Gm-Message-State: AOAM5326vBUL5TbMQo6x3F8ytipoTiwuvsYO8VrYkO+iaFKGYLNvnvb5
        heXthKOcAW6w07uon6Y/ZaX434lqjcarBQ==
X-Google-Smtp-Source: ABdhPJzsmV551Md9B7/0KWe56STaTbuehswwFZXGd8oi0eiPbB7J8JQUyWF/4gHJp7D1fUkPBWRTBQ==
X-Received: by 2002:a17:90b:38cf:b0:1bf:42ee:6fa with SMTP id nn15-20020a17090b38cf00b001bf42ee06famr17633458pjb.9.1647544390540;
        Thu, 17 Mar 2022 12:13:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e16-20020aa78c50000000b004f76c255e92sm6982254pfd.101.2022.03.17.12.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 12:13:10 -0700 (PDT)
Date:   Thu, 17 Mar 2022 12:13:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] ptrace: Return the signal to continue with from
 ptrace_stop
Message-ID: <202203171210.1239C9CDA@keescook>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
 <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 06:22:26PM -0500, Eric W. Biederman wrote:
> 
> The signal a task should continue with after a ptrace stop is
> inconsistently read, cleared, and sent.  Solve this by reading and
> clearing the signal to be sent in ptrace_stop.
> 
> In an ideal world everything except ptrace_signal would share a common
> implementation of continuing with the signal, so ptracers could count
> on the signal they ask to continue with actually being delivered.  For
> now retain bug compatibility and just return with the signal number
> the ptracer requested the code continue with.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/ptrace.h | 12 ++++++------
>  kernel/signal.c        | 31 ++++++++++++++++++-------------
>  2 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
> index 3e6b46e2b7be..15b3d176b6b4 100644
> --- a/include/linux/ptrace.h
> +++ b/include/linux/ptrace.h
> @@ -60,7 +60,7 @@ extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned
>  extern void ptrace_disable(struct task_struct *);
>  extern int ptrace_request(struct task_struct *child, long request,
>  			  unsigned long addr, unsigned long data);
> -extern void ptrace_notify(int exit_code, unsigned long message);
> +extern int ptrace_notify(int exit_code, unsigned long message);
> [...]
> -static void ptrace_stop(int exit_code, int why, int clear_code,
> +static int ptrace_stop(int exit_code, int why, int clear_code,
>  			unsigned long message, kernel_siginfo_t *info)
> [...]
> -static void ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
> +static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
> [...]
> -void ptrace_notify(int exit_code, unsigned long message)
> +int ptrace_notify(int exit_code, unsigned long message)

Just for robustness, how about marking the functions that have switched
from void to int return as __must_check (or at least just ptrace_notify)?

With that and the style nit Oleg already mentioned, yeah, this looks
good too.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
