Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7657A4B2E13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353048AbiBKT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:58:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353041AbiBKT6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:58:18 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F1B90
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:58:16 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d187so18062639pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SPfAVMPxFXWP9yaWNQ8kQASSQMlDzKBO7XOnuPeP+c8=;
        b=lly4ZI04Jy6RBjOUgr4jYMTzZ2uCUnQ3vwJQpca1ZJyg5XJGU1J1k7CqP3pi6dHa5I
         Ps0uTkqHLTqZnb19yEQekzG4SeA3fPgRU76s2ZHiGEivW5YlFNnIYXPeYtG/jiP9RSzi
         s+QkHFWRhfnxbdBWMua2H6Vv7DXTB1q6VZsAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SPfAVMPxFXWP9yaWNQ8kQASSQMlDzKBO7XOnuPeP+c8=;
        b=xa8nsrQaH5IIz+iYERBrskj8UgisovqPfGFhpGALExtktDxmVNJ7ZpnRCwCmeffa4j
         PINIK3WuOt/1V+4pzsZTjwfSB0F+vG5CtLFG/X/HAprgRWtOLN1Zja/vDJInWQ9imd/J
         OCauRHquzwnWVMrZeWJmrSb588H3IeI2plbSvDXrUZTUSpAZSP8YWfF2yCvCgF29RM5x
         O3QAWZmcatRdulap/iz+5vbVovcG7dpFzbIdpAMgTtuor6e6uc8h/gpEzemlgFnUXnfj
         xJQiLebq+in4fzpX+WDGc/6P8lgG2qtvVRfGWKi2QU3lpuD1Aylb3cRjLhRqA+K2lsrP
         WfaQ==
X-Gm-Message-State: AOAM532IfDCLh3c+8hfDL8Ax9c0e46+B7JvBEUy+mAqKI9V8T/0Hvn6c
        1W+04cgYf5ez4lFOrtfCrgulcg==
X-Google-Smtp-Source: ABdhPJwX9z2DpIPF4RWD0zONi5vPZR2mOetW5ivl8slwqZNE7FCT+K4F8UNla32gNrSjYLc5v5mpew==
X-Received: by 2002:a05:6a00:b84:: with SMTP id g4mr3220812pfj.10.1644609496082;
        Fri, 11 Feb 2022 11:58:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d20sm27369792pfu.9.2022.02.11.11.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 11:58:15 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:58:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Message-ID: <AB117FDA-5D7C-4AA6-ACBF-400568CC6196@chromium.org>
References: <20220210025321.787113-1-keescook@chromium.org>
 <871r0a8u29.fsf@email.froward.int.ebiederm.org>
 <202202101033.9C04563D9@keescook>
 <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
 <202202101137.B48D02138@keescook>
 <87k0e249tt.fsf@email.froward.int.ebiederm.org>
 <202202101710.668EDCDC@keescook>
 <875ypm41kb.fsf@email.froward.int.ebiederm.org>
 <202202101827.4B16DF54@keescook>
 <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com>
X-K9mail-Identity: !l=0&o=0&qs=PREFIX&f=TEXT&s=--%20%0D%0AKees%20Cook&m=
 %23%3AOGM4OWE1MTEtMTdkZS00ODEzLTlhNDQtMGY1OTRhYjk5NDcx%3AMg%3D%3D%3AODc
 5NTg%3D%3AANSWERED&p=0&q=SHOW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 11, 2022 4:54:26 AM PST, "Robert Święcki" <robert@swiecki.net> wrote:
>> It's mainly about the exit stuff having never been run before on these
>> kinds of process states, so things don't make sense. For example, on the
>> SIGSYS death, the registers have been rewound for the coredump, so when
>> the exit trace runs on x86 it sees the syscall return value as equal to
>> the syscall number (since %rax is used for the syscall number on entry
>> and for the syscall result on exit). So when a tracer watches a seccomp
>> fatal SIGSYS, it sees the syscall exit before it sees the child exit
>> (and therefore the signal). For example, x86_64 write (syscall number
>> 1), will return as if it had written 1 byte. :P
>>
>> So, it's not harmful, but it's confusing and weird. :)
>>
>> > I am trying to figure out if there is a case to be made that it was a
>> > bug that these events were missing.
>>
>> I don't think so -- the syscall did not finish, so there isn't a valid
>> return code. The process exited before it completed.
>
>A tangential point: please ignore for the purpose of fixing the
>problem at hand. I'm mostly making it, in case it can be taken into
>account in case some bigger changes to this code path are to be made -
>given that it touches the problem of signal delivery.
>
>When I noticed this problem, I was looking for a way to figure out
>what syscall caused SIGSYS (via SECCOMP_RET_KILL_*), and there's no
>easy way to do that programmatically from the perspective of a parent
>process. There are three ways of doing this that come to mind.

I had hoped that the parent could read the SIGSYS siginfo_t from the
child, but I haven't found any way to do this. :( :(

I don't seem to be able to use:

- PTRACE_ATTACH to use PTRACE_PEEKSIGINFO on a dead process.
- signalfd (nothing is in the fd after the exit).

Hmpf.

-- 
Kees Cook

