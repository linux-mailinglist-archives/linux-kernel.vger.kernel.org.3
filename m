Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F2E54404F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiFIAGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 20:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiFIAGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:06:36 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F0DF67
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 17:06:35 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-30c143c41e5so225529437b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 17:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rWmXg+4rcMcMBm2s7YjpkCcdd6M/TYiOX6qHnnqhyKA=;
        b=XkDvHxg+l2pqP3tUpPa58TwUKa05NcHTh5rKdyaGOQmzJQmB087nmkq6wgL6e+SNSj
         YezaKK2Ngjf2oyEKZdCkOkKQoz5DRHYAlxWGSou39iNNyetkG7ZHRdUjnRBbJoJFUj/u
         oxD1AJsylzkyygyCGZu8bl7IcvM82z9V3zntDKSdk6H0cC5Q7kCbbOlaOMWFUNofU2Rf
         hKd4csBqWt2cr52DKZumxU9EfAKqEyhB6Ksh9HyiAaUL8EtglJ9Fr7j5d+BYtxDnpX96
         A9YyZNI3c2WIN9FOoZEv1ABNuINhTqIqN9kGXzJMjVhO3qfYW1+u82Vg4cBba8cusKU4
         Uxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rWmXg+4rcMcMBm2s7YjpkCcdd6M/TYiOX6qHnnqhyKA=;
        b=y6pYLv0mSzIOxsYXjXu4AybC8qpuegJYUpMBySb88q1lqvJ4KN0Z0/PUUNKhamlyOJ
         Crmy5PDP9Z7gEEbGr0XW2qQzn1LCIZXwB9xlAWsXor4voKy3ZjCCNqE6kSBJ3AGGNuyx
         e4Z7cqdkLW5Oddu3oY3Q6xpN1DvpH8uk3uGjWfdEFHcR27CPufsLGc3p3oHsuNwzLvjb
         bX19kVK2oLNbCWNXfWIIvR4CgOkkSsuRFB8qURhkITMojF/c03HGR0NFYmi2wKJQOH/1
         AqEvmoxvtuhYVY+FtOsXQxae2s4hmGyCyz2IhvJlD+OxHBxeL9zJRngbD0fS42AJiakF
         onBA==
X-Gm-Message-State: AOAM532GAOxgaax7yoi11Pbd7y1OVXIdst+LNGHXLj/B2ERBm2CQln0k
        Srnag9QgYu11jSv9wWQCe2KYV2TlkUsV6pi9U5c2qg==
X-Google-Smtp-Source: ABdhPJycg/VezgHOfXrGTsDTYajapWp9fPNJzHErESk4GuOmkrZZOMqTUdYdU0DF7IL5AGUlMcqg+z2tDRU4Ec0d+9E=
X-Received: by 2002:a05:690c:b85:b0:313:2fee:a601 with SMTP id
 ck5-20020a05690c0b8500b003132feea601mr13521777ywb.243.1654733194645; Wed, 08
 Jun 2022 17:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211122170301.764232470@infradead.org> <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com> <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com> <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com> <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <Yh7fLRYl8KgMcOe5@google.com> <CAFP8O3JdYoMeF75XHCWue3fYG02W_95VGCU6AN+DYPj9F75kqw@mail.gmail.com>
In-Reply-To: <CAFP8O3JdYoMeF75XHCWue3fYG02W_95VGCU6AN+DYPj9F75kqw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 8 Jun 2022 17:05:58 -0700
Message-ID: <CABCJKueigY+oJ0HTV_YXKcTZG35ACxPE_YpKp_ZURgzxNYQ4WA@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joao Moreira <joao@overdrivepizza.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        hjl.tools@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 10:53 AM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@googl=
e.com> wrote:
>
> Hi Peter,
>
> On Tue, Mar 1, 2022 at 7:06 PM Peter Collingbourne <pcc@google.com> wrote=
:
> >
> > Hi Peter,
> > One issue with this call sequence is that:
> >
> > On Fri, Feb 11, 2022 at 02:38:03PM +0100, Peter Zijlstra wrote:
> > > caller:
> > >       cmpl    $0xdeadbeef, -0x4(%rax)         # 7 bytes
> >
> > Because this instruction ends in the constant 0xdeadbeef, it may
> > be used as a "gadget" that would effectively allow branching to an
> > arbitrary address in %rax if the attacker can arrange to set ZF=3D1.
>
> Do you mind elaborating how this instruction can be used as a gadget?
> How does it look like?

With the offset of -4, the je instruction here can be an indirect call
target because it's preceded by a valid type hash at the end of the
cmpl instruction. If we change the offset to -6, only the ud2
instruction is a potential call target in this sequence, which will be
less useful to an attacker.

> The information will be useful to the summary of Sami's KCFI LLVM
> patch: https://reviews.llvm.org/D119296

I'll add more information about the X86 preamble to the description.

Sami
