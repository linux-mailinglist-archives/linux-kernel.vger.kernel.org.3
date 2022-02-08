Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E64AE55F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiBHXTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiBHXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:19:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC9EC061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:19:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so1998843eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUmxDI5gH962mcf35zRHyi1vHGoo0+FBECSduCqHJtU=;
        b=mxfWHtMl7cXEGtgGJKRHvUKUFcTVd8kAqKacHbU8yN2dIBYcwIkI+PhC6SZuYlzKN+
         NIt4QxpAkYGAfYDHAjZ/8uf6pbNQKQWB0xhkwQN+AqE0k9dUwbhD294ElHbOitKdnm2w
         JxCjkqEeMEG+SJqu8B2sgzNubuatscgFicOCuWqK6u1KcYOOcWwVs0vG+OXWiBKwUADG
         i0XHxUxAizbxZExazKBsp9X3BU7ozTT3BILvLNEpnsIJaS63vbkJlhOodXfnuVedLWoR
         OaxsDtvA/gPuSLeERKAtgOAqCMWzleIt6nhsYp8wlDlTGh7RsdnRnNoU50+CooKaeVbI
         rgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUmxDI5gH962mcf35zRHyi1vHGoo0+FBECSduCqHJtU=;
        b=djvE+kAL3Ub0guZMUA8JKMDAUsgqvmw7SFWYsSXoaQY0TXd1Ek9sotvndTx+WCChYV
         QHd0WjPOg7Dao5vZkaiyApejNxMBsWL/9XLyW/S8yZ+ELT9bYVRnIyvvciWq3mT7+BQi
         f/5aRLnSqO+1cPhq75HZCDBzGA8e4I7/+mq0WF6j3k6A2CEAPaBKvE5k3gL3TuQKBAHO
         JEng4++PhS1ExrSiDYu99p/Ucetoh57CzTutLcwnmbT7L//zzQ00cJCrYB0epJvInGC7
         LYIc6rPJxTbVpz8foqHOo9j4TZbKg2q04fCfxKs6bkQzCmipe13uPdnRC15CrxmNaebN
         CQIw==
X-Gm-Message-State: AOAM5303JOsJ5Mb2JyniuvTIFYmyKbU3CR8r4OUycWwmT0k934nlEgGy
        o5g/XPpXSF5QzRD80zZ4nTIoQhFEftY7EkuRZpmx
X-Google-Smtp-Source: ABdhPJwubjTwWdJPO0enXlQGSyUnmVIcBvpEjKC/oSOsAWpfjcWAoAfDZbBSva5esvXhaxMkokZFdgqbALVd7W3xVA4=
X-Received: by 2002:a17:907:7b9b:: with SMTP id ne27mr5603709ejc.486.1644362341362;
 Tue, 08 Feb 2022 15:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20211229021258.176670-1-morbo@google.com> <20220204005742.1222997-1-morbo@google.com>
 <CAKwvOdk=VdDo1fhWJVa4eO0UjuQwtV9kC-cJd0J9-6guU2vafA@mail.gmail.com> <0d93ea4d847b42ca9c5603cb97cbda8a@AcuMS.aculab.com>
In-Reply-To: <0d93ea4d847b42ca9c5603cb97cbda8a@AcuMS.aculab.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 8 Feb 2022 15:18:50 -0800
Message-ID: <CAGG=3QW09mBaLNgu4+3oBw-NfYx+0xn86Cd5APYxGdSNgXzg0Q@mail.gmail.com>
Subject: Re: [PATCH v3] x86: use builtins to read eflags
To:     David Laight <David.Laight@aculab.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

On Tue, Feb 8, 2022 at 1:14 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Nick Desaulniers
> > Sent: 07 February 2022 22:12
> >
> > On Thu, Feb 3, 2022 at 4:57 PM Bill Wendling <morbo@google.com> wrote:
> > >
> > > GCC and Clang both have builtins to read and write the EFLAGS register.
> > > This allows the compiler to determine the best way to generate this
> > > code, which can improve code generation.
> > >
> > > This issue arose due to Clang's issue with the "=rm" constraint.  Clang
> > > chooses to be conservative in these situations, and so uses memory
> > > instead of registers. This is a known issue, which is currently being
> > > addressed.
>
> How much performance would be lost by just using "=r"?
>
> You get two instructions if the actual target is memory.
> This might be a marginal code size increase - but not much,
> It might also slow things down if the execution is limited
> by the instruction decoder.
>
> But on Intel cpu 'pop memory' is 2 uops, exactly the same
> as 'pop register' 'store register' (and I think amd is similar).
> So the actual execution time is exactly the same for both.
>
> Also it looks like clang's builtin is effectively "=r".
> Compiling:
> long fl;
> void native_save_fl(void) {
>        fl = __builtin_ia32_readeflags_u64();
> }
> Not only generates a stack frame, it also generates:
> pushf; pop %rax; mov mem, %rax.
>
It used to be "=r" (see f1f029c7bfbf4e), but was changed back to "=rm"
in ab94fcf528d127. This pinging back and forth is another reason to
use the builtins and be done with it.

-bw
