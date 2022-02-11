Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864504B2E20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353055AbiBKUBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:01:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBKUBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:01:06 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54CFC51
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:01:01 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id l19so12304926pfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QNqvweKtPqIF4attpHp1noQLaabICsimXqSeB/QPjEI=;
        b=DpIN81zjnh+AwCO+qCWcnLW920fFY9PMwlJ3PW0Ee5vWBCqso1AyT9kdGi/ouyKLeQ
         RPUIDaScKejJU5SIIErkiywv1jEBq22/gq1gLqIZhlxR9SPmoJZaGuYxRuE2mCHVsIXy
         wyVqBsoQh4qoAteYdlaENTxzZ8rO0FY7grMN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QNqvweKtPqIF4attpHp1noQLaabICsimXqSeB/QPjEI=;
        b=EeZSfOgbNRSmH3U8lX8FRGkpkb4znXg4G38vquo6gvhtUrK/EP7k4KeBivJQf/UPf7
         qiyEMxXb9Aj+OmQon3GaUZuUw0D+zExvXchR6oWkTu1iA8u0lVnHOl/9GGV18xLWDt7l
         r3bM14Uc+XH21D4ybInqzMJb+GGmZfIKarTtKBUW/epT1Zex7Qpt4ARa2ZYyjf8EMFEj
         updvK0kz0AY60/3VHl7LiUvKFHygdeg4YKK69RmX3BJRGz1PL/qe0VDRH6276pcgy+LC
         zOWvKcpX0TGPnYrsUodpTq13/ZY6l4pkoLguqNfZ3q2RSapHKkLTKgw7RVsdlip26Myy
         BrOA==
X-Gm-Message-State: AOAM530iA+m+mV1Y15L6a0KZwFwvpZYrPWsOwRcX02y1ahDxXH9BimQr
        W9idpRdPDUq0JUK19bt7A+qrEw==
X-Google-Smtp-Source: ABdhPJwLAGT61PFgZsP2SAVpzMNkZ+DM5KpdHyqc7A087qE45VeO3Biw1+4t38r3D6WqAK6kg6XHPA==
X-Received: by 2002:a63:8849:: with SMTP id l70mr2701342pgd.25.1644609661110;
        Fri, 11 Feb 2022 12:01:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k22sm28951487pfu.210.2022.02.11.12.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:01:00 -0800 (PST)
Date:   Fri, 11 Feb 2022 12:01:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Message-ID: <202202111159.7B2BAD2EF1@keescook>
References: <871r0a8u29.fsf@email.froward.int.ebiederm.org>
 <202202101033.9C04563D9@keescook>
 <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
 <202202101137.B48D02138@keescook>
 <87k0e249tt.fsf@email.froward.int.ebiederm.org>
 <202202101710.668EDCDC@keescook>
 <875ypm41kb.fsf@email.froward.int.ebiederm.org>
 <202202101827.4B16DF54@keescook>
 <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com>
 <87a6ex1ek2.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6ex1ek2.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 11:46:53AM -0600, Eric W. Biederman wrote:
> Robert Święcki <robert@swiecki.net> writes:
> > When I noticed this problem, I was looking for a way to figure out
> > what syscall caused SIGSYS (via SECCOMP_RET_KILL_*), and there's no
> > easy way to do that programmatically from the perspective of a parent
> > process. There are three ways of doing this that come to mind.
> 
> Unless I am misunderstanding what you are looking for
> this information is contained within the SIGSYS siginfo.
> The field si_syscall contains the system call number and
> the field si_errno contains return code from the seccomp filter.
> 
> All of that can be read from the core dump of the process that exited.
> 
> Looking quickly I don't see a good way to pull that signal information
> out of the kernel other than with a coredump.
> 
> It might be possible to persuade PTRACE_EVENT_EXIT to give it to you,
> but I haven't looked at it enough to see if that would be a sensible
> strategy.

If there is already a ptrace on the child with PTRACE_O_TRACEEXIT, it
should be possible to use PTRACE_GETSIGINFO.

> > I think it'd be good to have some way of doing it from the perspective
> > of a parent process - it'd simplify development of sandboxing managers
> > (eg nsjail, minijail, firejail), and creation of good seccomp
> > policies.
> 
> By development do you mean debugging sandbox managers?  Or do you mean
> something that sandbox managers can use on a routine basis?

It'd really be nice to be able to get this info without the ptrace
relationship already in place... hmmm.

-- 
Kees Cook
