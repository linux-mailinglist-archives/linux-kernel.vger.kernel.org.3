Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6684DDFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiCRRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbiCRRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:30:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CDB38794
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:28:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n15so7505609plh.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L3+RARgNnNJbe27/avpVeSt85+3sh/ylIsjNHSeDaWM=;
        b=KKqFe6HDwI7jVlJZ+pP7+O3dWvHqRIneqwnoQXaQNs2/SkDvJMhHlcUCBPk0HJ/tGi
         lORUxECO92MNSSyaumzrYUAbKuVFb0IKRFhFe52wUbJ7tVjFa76NwSNg4J8WsWE06icU
         kaeqiSw3gdThITYF+XEzb/3zHZlBBoypPCCE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L3+RARgNnNJbe27/avpVeSt85+3sh/ylIsjNHSeDaWM=;
        b=3KSfqHb8n5ZGxz9O8eoRxyxd3ELDIoiWHfPBnMvGoOmisFwOixj22sDAHqrYG6ZDJw
         hLD697eV0ZXMwQWRs4RLbSdFbxce22Yri/7WbY2WOpq5QkBCi7+uAThF4BTMPuEoVbA4
         Nbu8wb/mbMqVonicuaR924aKykaR0PRxGvOulYGhap4tzYbA+MhyfgIq4YPUBoOcZ8Gu
         5Pg9x9QzQAJztEvpSUd2LMdwuZkMfqU+6psOlAHLaStzNsyNTqnpSqWaz392Eq1NOHJz
         QjW5wTt7vPZqTqtQOwkAYhIct3DWh3oG2FoCz4PAhmCY/f4t8mSlLhj0bL2Fqvr5tJxA
         blPQ==
X-Gm-Message-State: AOAM530YiZYfLY82uLfgHrhOD9Pwn1/3ssoqHpskQmWX6svmzlK6OcOR
        YJgXnLWzQRKaz1fpwRRf1T5BZg==
X-Google-Smtp-Source: ABdhPJyMir8MSvctrzKkTGqF4tgMxTIkvl/491CdlrP8tUWgxhh81rBEknMWh9IsddJGpG0yWJCzPg==
X-Received: by 2002:a17:90a:4a91:b0:1be:e51a:47df with SMTP id f17-20020a17090a4a9100b001bee51a47dfmr12395699pjh.40.1647624524568;
        Fri, 18 Mar 2022 10:28:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a00238a00b004f79504efc1sm10170994pfc.214.2022.03.18.10.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:28:44 -0700 (PDT)
Date:   Fri, 18 Mar 2022 10:28:43 -0700
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
Message-ID: <202203181025.69760E3@keescook>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
 <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>
 <202203171210.1239C9CDA@keescook>
 <871qyz2tz5.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qyz2tz5.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 09:52:46AM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Tue, Mar 15, 2022 at 06:22:26PM -0500, Eric W. Biederman wrote:
> >> 
> >> The signal a task should continue with after a ptrace stop is
> >> inconsistently read, cleared, and sent.  Solve this by reading and
> >> clearing the signal to be sent in ptrace_stop.
> >> 
> >> In an ideal world everything except ptrace_signal would share a common
> >> implementation of continuing with the signal, so ptracers could count
> >> on the signal they ask to continue with actually being delivered.  For
> >> now retain bug compatibility and just return with the signal number
> >> the ptracer requested the code continue with.
> >> 
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> ---
> >>  include/linux/ptrace.h | 12 ++++++------
> >>  kernel/signal.c        | 31 ++++++++++++++++++-------------
> >>  2 files changed, 24 insertions(+), 19 deletions(-)
> >> 
> >> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
> >> index 3e6b46e2b7be..15b3d176b6b4 100644
> >> --- a/include/linux/ptrace.h
> >> +++ b/include/linux/ptrace.h
> >> @@ -60,7 +60,7 @@ extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned
> >>  extern void ptrace_disable(struct task_struct *);
> >>  extern int ptrace_request(struct task_struct *child, long request,
> >>  			  unsigned long addr, unsigned long data);
> >> -extern void ptrace_notify(int exit_code, unsigned long message);
> >> +extern int ptrace_notify(int exit_code, unsigned long message);
> >> [...]
> >> -static void ptrace_stop(int exit_code, int why, int clear_code,
> >> +static int ptrace_stop(int exit_code, int why, int clear_code,
> >>  			unsigned long message, kernel_siginfo_t *info)
> >> [...]
> >> -static void ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
> >> +static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
> >> [...]
> >> -void ptrace_notify(int exit_code, unsigned long message)
> >> +int ptrace_notify(int exit_code, unsigned long message)
> >
> > Just for robustness, how about marking the functions that have switched
> > from void to int return as __must_check (or at least just ptrace_notify)?
> 
> We can't.  There are historical cases that simply don't check if a
> signal should be sent after the function, and they exist for every
> function that is modified.

This seems at least worth documenting with a comment, otherwise we're
just trading one kind of "weirdness" (setting/clearing
current->exit_code) with another (ignoring the signal returned by
ptrace_notify()).

I see only two cases that would need comments:

static inline void ptrace_event(int event, unsigned long message)
{
        if (unlikely(ptrace_event_enabled(current, event))) {
                ptrace_notify((event << 8) | SIGTRAP, message);
        } else if (event == PTRACE_EVENT_EXEC) {
                /* legacy EXEC report via SIGTRAP */
                if ((current->ptrace & (PT_PTRACED|PT_SEIZED)) == PT_PTRACED)
                        send_sig(SIGTRAP, current, 0);
        }
}

static void signal_delivered(struct ksignal *ksig, int stepping)
{
	...
        if (stepping)
                ptrace_notify(SIGTRAP, 0);
}


-- 
Kees Cook
