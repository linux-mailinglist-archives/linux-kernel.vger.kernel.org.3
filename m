Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8640257BC58
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiGTRKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiGTRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:09:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619DD6D9E2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:09:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e15so24606347edj.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWV4kGPSgS3dgACnghLX442NCtxuMfI2XNxn+GBngHU=;
        b=WKE25XPtm+e6+es+UEIO8WGaaINb5wjmiqjVoghjfCBwnQZp1p88+2FRRcnlQgu3LR
         NvV9d+HsdGiHdcyZ+kJJ0QJM+zqH+cpaLaQpzn+ichRCIjFvfdcBEZUB2ZrH1j89VeyU
         Tkh0dbrGWYlVlSc3KYUyQYmWIFY5ccockBWd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWV4kGPSgS3dgACnghLX442NCtxuMfI2XNxn+GBngHU=;
        b=S+9BNvNmjMAZ17z6r61kxXFUoTJmI21I7RsdfZapqJnTS9HvRwFBbDtRl7hkh/NM97
         WY9j3Ktr3UIgfF2eUKOhA/3u51NSRUgj2AINIzG3AmrjrX12k/W+wqhhxkaBjLeBEDIh
         wo2O+upVkwTup/BYwprXNVnwVqNsaSb5XcCZY5T4/P1g1hTc++iz86980Lv6lWHc0ZAr
         rGDxKZr3NPXNMQL0FLmZZiCERCP1hZQDMqj+Tp5zM9gmSPTntKGfSI6wlsyWOdIw4s2V
         XVIGODzLCzuzCUF+oQmsQhPskT9S2DpfoXV+xOOWpaEJ/YRs4lr7dPdbgF3g4KYcQIUB
         qDww==
X-Gm-Message-State: AJIora/PTLG2Fro2L2Lo/U8KLsLb91lBGMdUk8H706FwtB3afSZRmGl7
        uuatkmUMTd2qctqrvra7rCYXfXfsFHba/aBIV7E=
X-Google-Smtp-Source: AGRyM1uc20W7gRKIYcORbqs2qSzC5uvdvlJ0b4k2SPLLgET5wA/uaRyhX8yhuPyiwyih7MXsTKhH5A==
X-Received: by 2002:a05:6402:430a:b0:43a:9ece:d6f8 with SMTP id m10-20020a056402430a00b0043a9eced6f8mr52419165edc.361.1658336995718;
        Wed, 20 Jul 2022 10:09:55 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090632d000b0072b6d91b056sm8250618ejk.142.2022.07.20.10.09.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:09:54 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id bu1so27025773wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:09:54 -0700 (PDT)
X-Received: by 2002:a5d:5e85:0:b0:21e:45e3:f23b with SMTP id
 ck5-20020a5d5e85000000b0021e45e3f23bmr4961690wrb.274.1658336993654; Wed, 20
 Jul 2022 10:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <20220720125736.48164a14@gandalf.local.home>
In-Reply-To: <20220720125736.48164a14@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jul 2022 10:09:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
Message-ID: <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 9:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> [    2.488712] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:558 apply_returns+0xa3/0x1ec

That warning is kind of annoying, in how it doesn't actually give any
information about where the problem is.

I do note that we only fix up JMP32_INSN_OPCODE, and I wonder if we
have a "jmp __x86_return_thunk" that is close enough to the return
thunk that it actually uses a byte offset?

But that WARN_ON_ONCE() should probably be changed to actually give
some information about where the problem is.

The silly thing is, there's even debug output in that function that
you could enable, but it will enable output for the *normal* case, not
for the WARN_ON_ONCE() case or the "we didn't do anything" case. That
seems a bit backwards.

               Linus
