Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679EE4B1CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347509AbiBKCxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:53:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347500AbiBKCxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:53:44 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B67B5F4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:53:44 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id l9so1936121plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q7nVE8+FuxeU5FFClhGDXDoFJV628rh5FpUiGKzXxNE=;
        b=Q4jSNnEEf5TTnDFdP+QIrGYCniWqlMjDtDl15EB6BuVgp/1kgHtK7NuR7irQUhk5HC
         h8JWRdNp5hfF1oaO0ia3rX1PLWPZ2sWlOgSooZy8LQUlQYFmEjQCm77cXB2nsH+NvJ0y
         /OSkr+7dew1D0TRgpAeJM01soH519lB49TkBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q7nVE8+FuxeU5FFClhGDXDoFJV628rh5FpUiGKzXxNE=;
        b=GtbVoGxrnsnFENTD82gp9FW66FdTUvE50Q3HLPf4qES1oz5oCYkO2eG9xnvZ20HmDB
         6LbG+uBvWCK1HvUlA1Z6GPVasopUqTta6NoJ3wpEmufsArneAKh09oMuAUndW9Zvc/X4
         JIKIY0/DAwQurx4rlIRagZfzXDRwCzQrGVV1MvIsvW4Pqjz/QAJbaU4CYBczSlKrXmy6
         N2INl8Gl/4D54EdAWJQhWAKQSkzUVwlJ/RxT1onFX2DlHQF7eGZzQy82tqzIPLNqFFCa
         Sng+oEp8v8FYBueQQFqvHJjCV4VaHneQj01vxk32mKd93g8iIc9k24r+m44MN4bofJPz
         0C3A==
X-Gm-Message-State: AOAM530h+vuG3N+ckm4y+uGt5D26PBVIoJyqBmFa0Zahvp2J1M4teBwo
        q3z4JarC9iDo/xKignnckz40YA==
X-Google-Smtp-Source: ABdhPJw0573RstLDOG/3Ni2PM5x/JJwAzoK13F6L/08toAdgodmpPNJOhaLW4NwtmU7o7tF3WaopRQ==
X-Received: by 2002:a17:90a:9e5:: with SMTP id 92mr500097pjo.128.1644548023775;
        Thu, 10 Feb 2022 18:53:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lj14sm3553116pjb.48.2022.02.10.18.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 18:53:43 -0800 (PST)
Date:   Thu, 10 Feb 2022 18:53:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Message-ID: <202202101827.4B16DF54@keescook>
References: <20220210025321.787113-1-keescook@chromium.org>
 <871r0a8u29.fsf@email.froward.int.ebiederm.org>
 <202202101033.9C04563D9@keescook>
 <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
 <202202101137.B48D02138@keescook>
 <87k0e249tt.fsf@email.froward.int.ebiederm.org>
 <202202101710.668EDCDC@keescook>
 <875ypm41kb.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ypm41kb.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 07:47:00PM -0600, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > The common accessors for the bits are set_syscall_work()/clear_syscall_work()
> > but I don't see anything to operate on an entire mask. Maybe it needs to
> > grow something like reset_syscall_work()?
> 
> Oh.  I hadn't realized SYSCALL_WORK_EXIT and TIF_SYSCALL_WORK were
> masks.  Yes it looks like a simple addition of reset_syscall_work()
> and calling it from force_sig_info when HANDLER_EXIT will hide these
> events.

Yeah, it's varied by features, architectures, etc. The good news is it's
WAY nicer now after the USER_DISPATCH. :)

> When you say the events are corrupted did you mean they return wrong data
> to userspace or simply that the events should not fire?

It's mainly about the exit stuff having never been run before on these
kinds of process states, so things don't make sense. For example, on the
SIGSYS death, the registers have been rewound for the coredump, so when
the exit trace runs on x86 it sees the syscall return value as equal to
the syscall number (since %rax is used for the syscall number on entry
and for the syscall result on exit). So when a tracer watches a seccomp
fatal SIGSYS, it sees the syscall exit before it sees the child exit
(and therefore the signal). For example, x86_64 write (syscall number
1), will return as if it had written 1 byte. :P

So, it's not harmful, but it's confusing and weird. :)

> I am trying to figure out if there is a case to be made that it was a
> bug that these events were missing.

I don't think so -- the syscall did not finish, so there isn't a valid
return code. The process exited before it completed.

-- 
Kees Cook
