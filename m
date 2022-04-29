Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8616A514880
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355311AbiD2LtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343581AbiD2LtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:49:13 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057E162DF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:45:55 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s30so13987309ybi.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NHJAqhwPXVgAB8bEwImwTbvvWr4gJ0gDlgorBDbdgHs=;
        b=SVMfF83v311IaOIZZIA2fhgHQGdVLyA7wa35WKE7cbrUay9cJlOOIIvedSERRe7BAB
         7qoQXITorvj6Eoy6wRapcNP+dfnI5BQNnm0lcXEob2YfW5XzbcsX8qAzHNPq4yr8tfM3
         VvZ9QjFOgw8y9NglSzmdpazJZPDjDiMWNuFSWYpkSwWNxXuA6m9F3jBJpDfuGU1pvfuh
         OsUjeJEd45FkHQa8jIGgnEgSq+RRcptie7ovyLz2XX1EwIrkjORWTQlYPdMMI4KDFpEr
         xfT+vdFdX8pqk4pkK1FDt0Ph8M3c2cDSo+3gOQVnzeBMEB0yfBWTVtcT5kyD3lmmq1XB
         Jsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NHJAqhwPXVgAB8bEwImwTbvvWr4gJ0gDlgorBDbdgHs=;
        b=HmijcifiHGaaH+/KebYRtUGUzyhCS0mWPxuBSjjhqIYq0O8t1OHblLi9QQReETRhtY
         Im2HxtxymwOdrxMz9HhKAt9oNCdY4EDS+y/yUU1HYS92oklyzPigtotXTY6k4nIx4Ca4
         dkkfJCPYb7X0NVLsRHZhSN9LpdkFQezBTiLpKGEYNlVr2aF3FAeKFHDN0hhK7561ynKE
         q9l/719cdCJRRMpsYXgkQiumdBjf6U+3eRzEH+pyXLAAWLKkz38WQZkfyNk4En/Peela
         Deg/zzUJ4UzOBTvCGd1s+oe3xMOCJ3f7m13crMCDT0QiEFCJj6sPHDsvePnPLG1Vwg2M
         bcOA==
X-Gm-Message-State: AOAM530gm22d0eTYN3Xqry39FZH4UILsa1o7rf3IfbG73O/Nt/dYfYsD
        nhJwWBgbEZ62Yl37mVnwWTApk4lZGwi3cjTDFXY=
X-Google-Smtp-Source: ABdhPJyObx4s8cIEvwWwy3MKnbthHo/ZjAQ2+fWwuxXRlfj2rv0OTSBPV5L+/3VVxhPjTgZQi+0zB2VQyhddDfq7W0s=
X-Received: by 2002:a25:df8a:0:b0:647:4954:83e8 with SMTP id
 w132-20020a25df8a000000b00647495483e8mr27281608ybg.526.1651232754281; Fri, 29
 Apr 2022 04:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-7-jiangshanlai@gmail.com> <Ymu2XC7k8Xj/vMjG@zn.tnic>
In-Reply-To: <Ymu2XC7k8Xj/vMjG@zn.tnic>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 29 Apr 2022 19:45:43 +0800
Message-ID: <CAJhGHyBHPDD=hD-78rQDCj2VfQT21m8JzD-m9DazsUa8VpBVcQ@mail.gmail.com>
Subject: Re: [PATCH V6 6/8] x86/entry: Convert SWAPGS to swapgs and remove the
 definition of SWAPGS
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?Q?J=C3=BCrgen_Gross?= <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 5:56 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Apr 21, 2022 at 10:10:53PM +0800, Lai Jiangshan wrote:
> > diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64=
_compat.S
> > index 4fdb007cddbd..c5aeb0819707 100644
> > --- a/arch/x86/entry/entry_64_compat.S
> > +++ b/arch/x86/entry/entry_64_compat.S
> > @@ -50,7 +50,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
> >       UNWIND_HINT_EMPTY
> >       ENDBR
> >       /* Interrupts are off on entry. */
> > -     SWAPGS
> > +     swapgs
> >
> >       pushq   %rax
> >       SWITCH_TO_KERNEL_CR3 scratch_reg=3D%rax
>
> I'm not sure about this: why can't XENPV do a 32-bit syscall through the =
vdso?
>
> Also, looking at this, J=C3=BCrgen, it looks kinda spaghetti to me:
>
> entry_SYSENTER_compat
>
> ...
>
>         /* XEN PV guests always use IRET path */
>         ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_=
to_usermode", \
>                     "jmp swapgs_restore_regs_and_return_to_usermode", X86=
_FEATURE_XENPV
>
>
> then at that swapgs_restore_regs_and_return_to_usermode label:
>
> #ifdef CONFIG_XEN_PV
>         ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", =
X86_FEATURE_XENPV
> #endif
>
>
> Can we simply jump directly to xenpv_restore_regs_and_return_to_usermode
> from entry_SYSENTER_compat or is that CONFIG_DEBUG_ENTRY chunk there
> needed?

Hello

Adding ALTERNATIVE in swapgs_restore_regs_and_return_to_usermode()
results a simpler patch which is better served as a bug fix:

https://lore.kernel.org/lkml/163861832551.11128.1645285137833652414.tip-bot=
2@tip-bot2/

which is also your suggestion:

https://lore.kernel.org/lkml/YYD9ohN2Zcy4EdMb@zn.tnic/



While the original patch has sprinkled all those ALTERNATIVE calls
everywhere:

https://lore.kernel.org/lkml/20211026141420.17138-5-jiangshanlai@gmail.com/

And this original version has a SYM_L_WEAK placeholder
which is objected to by some people.

Thanks
Lai
