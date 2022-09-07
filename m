Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46175AFD0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIGHE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiIGHE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:04:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A7B4B0E8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:04:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bj14so5576924wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lB1tmo02fRBU5l99ERq/B48ipxrlpTBOmsY3GpHVDq0=;
        b=jpxnKj/tEOqK+taEe1NmXQq96RAJosDbqCL3MYiTan0yY9wRDEYP/c9UDDpwK3wqFe
         3Dk94gHbTndr8sH9LH1wRMAE7OvmiI8Kv4KKf7Qh7xWteJv72aYDkReV0FfVX2hDLIHt
         X8eIaBcG3xS0FPpWa3Q2u5awuNyRmr5qBo9yQShYvkUf/i+AYrOYrviOTZODAwAHr0+Q
         65uYP7r9+32R+wrFTso8y4jpgB319KqVUnekM3YvXqv27A6BuhNU2Od/lhv9TldDXBN3
         +5dlWoKjGF5CG7uoX+qiTaYcWIpaOiPskwkGvfNHu04UZ8wuB+hAxskBGugwsUPofBtJ
         zmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lB1tmo02fRBU5l99ERq/B48ipxrlpTBOmsY3GpHVDq0=;
        b=MYHM+IVKKl1EO/ODwPnlxKKE5hO3hQW+boqrJd8dY3CFwyklITyTnbtEsoCtQSTWJ+
         MwpCtbOW5Q69P44mHpfisCNuKBFftkNJRcNBBMZ1Pj4CDwkQ03DCebzdIZ/PjrgFjq0s
         D+hMMuHOCHuuWc5anKtXyxsAobh+WlEzqP0iKobkcZI5pb9bJfDVBPrGIelO95tSrlKt
         ephBznZds8EIRILCfUGI8dUufple4ajTMj5JP6wqSiK+QyBvPjlQ6X0wi++Y2X72Tygo
         FMnOS/Rrt6gJGMM1c0A9U/CkEtSnW+Wnt2frB5c3iUFaZYa0CG8ZRPP17uMDarfhJKfz
         WZOA==
X-Gm-Message-State: ACgBeo1SLE/cfxVlSGKAhqA7HQMZqmtAqr4W5uvuN2KJZGws1cgvl1cI
        26wFww6VKBg8fEPZbaC2KvNp48aUOyfqxdjMVS9FIA==
X-Google-Smtp-Source: AA6agR5pYRLCrtJ2SL9u5D4Xxh0DlWfT/umzHlIpkRTMxpdM3cDXNixeG9s5u5aZnnS7L3YgztNTexOd2o1mLhJMZrI=
X-Received: by 2002:a5d:47ac:0:b0:226:df12:412f with SMTP id
 12-20020a5d47ac000000b00226df12412fmr1129390wrb.675.1662534294077; Wed, 07
 Sep 2022 00:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220905003732.752-1-mailhol.vincent@wanadoo.fr> <CAKwvOdnr_F9-voPj4cp2HG8=U32a8Hp1aLpynSQiKOrwe4txpQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnr_F9-voPj4cp2HG8=U32a8Hp1aLpynSQiKOrwe4txpQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 7 Sep 2022 00:04:42 -0700
Message-ID: <CAKwvOd=PgVtCwjS=Z_iqqmWsQ=+HsnEnHX2LOjRPCYFoVhAZhA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Yury Norov <yury.norov@gmail.com>
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

On Tue, Sep 6, 2022 at 11:26 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Sep 4, 2022 at 5:38 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > The compilers provide some builtin expression equivalent to the ffs(),
> > __ffs() and ffz() functions of the kernel. The kernel uses optimized
> > assembly which produces better code than the builtin
> > functions. However, such assembly code can not be folded when used
> > with constant expressions.
>
> Another tact which may help additional sources other than just the
> Linux kernel; it seems that compilers should be able to fold this.
>
> Vincent, if you're interested in making such an optimization in LLVM,
> we'd welcome the contribution, and I'd be happy to show you where to
> make such changes within LLVM; please let me know off thread.

Oh right, it already does.
https://github.com/llvm/llvm-project/blob/ea953b9d9a65c202985a79f1f95da115829baef6/llvm/lib/Transforms/Utils/SimplifyLibCalls.cpp#L2635
I see what's happening. Constant propagation sinks constants into a
specialized version of ffs when there's only 1 callsite in a given
translation unit (or multiple call sites with the same constant).
Then dead argument elimination removes the argument, so libcall
optimization thinks this isn't the ffs(int) you're looking for, and
skips it.  Nice.
https://github.com/llvm/llvm-project/issues/57599
I guess ffs() is usually forward declared in strings.h, so we don't
have such a static inline definition available to constant
prop/specialize in normal C code.
-- 
Thanks,
~Nick Desaulniers
