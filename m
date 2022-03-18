Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0A64DD24D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiCRBPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiCRBPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:15:40 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30ED235866
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:14:22 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2e59939b862so76884467b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1IQdfgNMNTeetecO15UC3K0qBBIj0qq3aPo6vG3K4U=;
        b=ZUB/eJ1gCy8xExta/pF/c2jROdhmjh4T93jEAIMkjvwtNGFjvAa/wXlXK5hl7pe/ZJ
         I7CGHOTDKf0XA/cMuI0qAHkD+X7B7sQ9xw4BjS+WCAyYcppMS0K4Ym98NNS29japz3FL
         lhyrTG6u7pG/C5yaWZHDZ6b1PpSysKrtiqmLdiDGfi7IsSOHo4sHhe9Qvn8BBWrmm3f0
         ObtzphXJiVmjO4+seI72NpCq5qkZY+ivgQaXs5fL/2jkUsSQ1VjWVgxKkdx+ribh56+L
         LEBRyTkC2v87/zpjh9ySJVXkaNE0sEdrybV9Oc4ONIH7ygyGIFZJ9XIABJkrfw8VOXCB
         p1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1IQdfgNMNTeetecO15UC3K0qBBIj0qq3aPo6vG3K4U=;
        b=BPSc50IO3LsaZ8T0KrUiiAWbaQ2KG5PKzcZ6GBmeUABGRJqCESpZl/einWSFVaxYHK
         yZIYKATF3kAcvC/GnAFs1cVkGxlkZ0jsgGAHYe1oeD4fyPlkSiSboAv8pIP0eF5wczLd
         4uoS/rm72SmHIj/QzRE/Xe/CeO8NK1stYGDNaNa1wowI3zwvJi+RSt/ciMzt7K5h7Fn0
         YP7gnikZ8B/ZaEEq+iyt3t1a89oveZ+7wc7Y/las95Y0N8ayuo9uVzUh7nvZYVstXKbG
         HcDQdaPr7Xd2wLEpbP4MD/G8CuEYrH50IDMh7tBn30u9YusmoZGkwnJTgqGGeXYC0D9Y
         kg5Q==
X-Gm-Message-State: AOAM532bMKTULEBXYBXZWv3sT2x35kh3vQQUAoikFw4okJ5YUs1mhUP/
        sC0jwYaCWpDltyXZE4Q8LnxMegspblG3yXuw8Iw=
X-Google-Smtp-Source: ABdhPJyzxRVsiNukScsy5bPKZiRxvwT7AR6Fj9yLEwkLKesyVhcNCkMozdvmhwW8fhFFzDmrgs+79LQfGJRwaRso1s8=
X-Received: by 2002:a0d:eb02:0:b0:2e5:9d37:58ba with SMTP id
 u2-20020a0deb02000000b002e59d3758bamr9103969ywe.231.1647566062117; Thu, 17
 Mar 2022 18:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220316041612.71357-1-jiangshanlai@gmail.com> <20220317221943.6vhoqx3fdv7py6hi@treble>
In-Reply-To: <20220317221943.6vhoqx3fdv7py6hi@treble>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 18 Mar 2022 09:14:09 +0800
Message-ID: <CAJhGHyC1qPee2QOpgR8B+2Sd+XzfoJD3NL9biFZ5gKE-B9r_rQ@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Add ENCODE_FRAME_POINTER after stack changed for #VC
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 6:19 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Mar 16, 2022 at 12:16:12PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > In idtentry_vc(), the real frame is changed after it switches to new
> > stack, ENCODE_FRAME_POINTER should be called in case for unwinder.
> >
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> > ---
> >  arch/x86/entry/entry_64.S | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index e20eabaa56b8..f99f2881ed83 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -540,6 +540,7 @@ SYM_CODE_START(\asmsym)
> >       call    vc_switch_off_ist
> >       movq    %rax, %rsp              /* Switch to new stack */
> >
> > +     ENCODE_FRAME_POINTER
> >       UNWIND_HINT_REGS
> >
> >       /* Update pt_regs */
>
> Looks right to me.  Any chance you have the ability to test this
> scenario by unwinding from #VC with CONFIG_FRAME_POINTER?
>

I don't have the hardware to test it.  Actually, it was you to
inspire me to find this in the conversation of my patchset when
I tried to search all the code of switching of %rsp to see how
ENCODE_FRAME_POINTER and UNWIND_HINT_REGS are used once more.

> --
> Josh
>
