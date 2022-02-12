Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9014B31EE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 01:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354380AbiBLAYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 19:24:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344898AbiBLAYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:24:20 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92951D7C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:24:18 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 13so19516207lfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YAbGJf0nD3tv0C4+x4biz03025yR9r7nSe3Iqf91zgg=;
        b=NUDW/UNCFyXf4XFnOfAXDiJ0WTqWv4778H9sujmy90gvJyk4NNwFzad/b67l7mehR+
         6BuoqihBq3RXmDpM4Sp/LBqGcD4gkrR6prZrvrf9VmV5p7ohYI2j/MDJWp6EPCQ+c89x
         CNehIc2Ho+rJSWTrVBt/yochOwkDc0hx5h+y6sxDgBcmx7QmZQR9cb17i4UBS5I3RJ4B
         Bm7WClqNtkl7j/G9eBmPYf/16RmV6K2USKPMFolT64n6hXZQjzoVvUfsYH/vlecGBVlU
         St6bvBB2O6O6Ektmzn8dY+PySeYrt5HDRIDZ9UeSEZbsVmc9i4Zo5X9PCelMI477MLvJ
         1YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YAbGJf0nD3tv0C4+x4biz03025yR9r7nSe3Iqf91zgg=;
        b=rHJ9vFCUTC8+iZyAWtEdpLJ3oblGO1KyZAtLvOfSe96AfOp2dZGlVElztXy+noBKlD
         2JRjTe6ZGe06jFKTSvAYXJ+Nzt9tZGlLdHlmW+yiQzKVfGrgquDgNKRjUo7n2+hb+lMf
         XMTsVuev1cye3t5ALImdgHXxnffUmvIHVGPQkQkP6gcDwbMKaElwdS5ZiSTOkTbi9ZUE
         vW5z3iof1+kJfvInav13nRIBl/V0OWjAG2nmqYkbpZS2ZZhEqFzAL5mq4mjS74T/T7x3
         +XPl8TTcXWg3WKRQVbxuaWw5a/vNIPaIl5mcAAxH9dFeGy1EVcdBWuLay/dB1LR+Y3FL
         rDEg==
X-Gm-Message-State: AOAM533DvzBEHU1cb5CLpbY7sxpmtgmqLSUXiR29IucSpUbra70mcsoq
        ifzLpaWk1QPXvuyOh8MI/4GPSCDEeJjvYXcxSU2aBg==
X-Google-Smtp-Source: ABdhPJyVpMwka2BHTC6WOnJhHIhvUXIvzP3KrapzLDJ1aMR0QDplBlPBmpOjgK9mmQSY4XO3synZ60gF04cEls1BPYA=
X-Received: by 2002:ac2:5627:: with SMTP id b7mr2881588lff.489.1644625456780;
 Fri, 11 Feb 2022 16:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20220204005742.1222997-1-morbo@google.com> <20220210223134.233757-1-morbo@google.com>
 <cb2ff5da9b704a9792549a9433dc0ac8@AcuMS.aculab.com> <CAGG=3QXvSt=d94iqSV-Y9JVNc+pt-WOZGpSeW--fp=w2ttMvUA@mail.gmail.com>
In-Reply-To: <CAGG=3QXvSt=d94iqSV-Y9JVNc+pt-WOZGpSeW--fp=w2ttMvUA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Feb 2022 16:24:05 -0800
Message-ID: <CAKwvOdmqQ4M1pcz1BW+MTtRdwP3itOLcV83X+1nJQkf9BNJ7Fw@mail.gmail.com>
Subject: Re: [PATCH v4] x86: use builtins to read eflags
To:     Bill Wendling <morbo@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Feb 11, 2022 at 11:25 AM Bill Wendling <morbo@google.com> wrote:
>
> On Fri, Feb 11, 2022 at 8:40 AM David Laight <David.Laight@aculab.com> wrote:
> > From: Bill Wendling
> > > Sent: 10 February 2022 22:32
> > >
> > > v4: - Clang now no longer generates stack frames when using these builtins.
> > >     - Corrected misspellings.
> >
> > While clang 'head' has been fixed, it seems a bit premature to say
> > it is 'fixed' enough for all clang builds to use the builtin.
> >
> True, but it's been cherry-picked into the clang 14.0.0 branch, which
> is scheduled for release in March.

While I've requested a cherry pick, the auto PR has not yet been
merged into the release/14.x branch.
https://github.com/llvm/llvm-project/issues/46875#issuecomment-1035262333
https://github.com/llvmbot/llvm-project/pull/42

I share David's concern.  We currently support clang-11+, see
Documentation/process/changes.rst

Users external to Google do not necessarily live at ToT LLVM; we MUST
support them.  There are also multiple unwinders for x86 selectable at
kconfig time; this patch has implications for those different choices.

I would like to discuss this further off list with you Bill before you
resend this patch again.  Please do not resend this patch again until
we've had the chance to speak more about it.  I'm generally in favor
of the intent of this patch, but let's make sure this patch is the
best it can be for everyone, regardless of their compiler, compiler
version, or unwinder.
-- 
Thanks,
~Nick Desaulniers
