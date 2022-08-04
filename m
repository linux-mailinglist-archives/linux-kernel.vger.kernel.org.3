Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF658A0F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiHDS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiHDS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:56:29 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838DC175B9
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:56:28 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h7so519669qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bVALqVTUnqV3lcvJzi/YzDZb6mzm8cCv/nt8rs+22ls=;
        b=qdNtAT26wkBHtepS1n/e8GS+wgIy1R7t+9Fg8hEbc7ASBeGbC+QeeNrP5ZsrAiwTj9
         rMHUJ5ganVNDE7+NA+NiLQpZQAwNsqmtiZ5z7R4IITi0VWpKWRXzEaL94NNXIG4LDzqW
         ZyVedSLny9ByjXpuIJfTRcuSpw79Tqe0TooAabsgDiB//X90OYt1+9Y0aw2wqA8YO6rw
         d6d3RnycFuw7vo4akSGz637fSdyU9X+0T0NQvzyZD8uYFhdt25rFVRyPsG5twNKv5+Rl
         USZjJlzSfFq3WaMXnc/jvES3JPJLGj2s7ZeQ7wIDeIGd7i/upxwx6VixZQGUlrksDmzH
         n2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bVALqVTUnqV3lcvJzi/YzDZb6mzm8cCv/nt8rs+22ls=;
        b=yQz7IKavbAhL34ZCF6dj007iMB97NoU3HXVdJ5s+g6SPkKxucRPWStfzhDVqCU7Zq4
         5G1bM1l+GPrmg1HndO+j8vhm9ER1FfcMT6cfBl2dLFtfDpIVq/LRd8QSDUK4alIINBVg
         rGoPXZHgBpTxhpXaKfIUd1kEX2N+lzxUliPfx4BaZS4FYHs711E6f1T6cU0Ob5zBS47X
         MZdWXq+QT0gfTlFCYkG55fGbsMw29+QcRStf7Xt0gaWV1CK8EFwEoDE1YVfmhbeqeb/S
         T7pIOsVOTvX3lifw/3SKvMmuK/QOpsUZCJqVSOTqr3HUlr/+HLBmAZuxEas65gXhE1MZ
         MFCA==
X-Gm-Message-State: ACgBeo11znPKNuddW9+g9FnIQq8Yp540OOXRkeAEUyP/8TPk7S7Tsjgj
        ypnNLoKaw/z8Y9rAquNi3qbq9NN+DjCGpUIQ1xPTDz2BXthBTA==
X-Google-Smtp-Source: AA6agR7JBGnZHyBShIRr5222e5e6NeJtQ7KU63Fdm0M0jrWGzJuzNM+PD3hNmvpyjjsIKV1ge1MkwFBzvmdq8zM2Z7o=
X-Received: by 2002:a05:622a:1102:b0:31f:29ed:2e2 with SMTP id
 e2-20020a05622a110200b0031f29ed02e2mr2777169qty.54.1659639387605; Thu, 04 Aug
 2022 11:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220804180358.32944-1-ubizjak@gmail.com> <91ccae0b-6135-6163-f59b-4e99624090a5@intel.com>
In-Reply-To: <91ccae0b-6135-6163-f59b-4e99624090a5@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 4 Aug 2022 20:56:16 +0200
Message-ID: <CAFULd4YRzEXL1+cvBPT1hmfq=ZLwtrexHt+vDABnA2QMiVMBpg@mail.gmail.com>
Subject: Re: [PATCH] x86/acrn: Improve ACRN hypercalls
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 8:41 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/4/22 11:03, Uros Bizjak wrote:
> > As explained in section 6.47.5.2, "Specifying Registers for Local Variables"
> > of the GCC info documentation, the correct way to specify register for
> > input operands when calling Extended 'asm' is to define a local register
> > variable and associate it with a specified register:
> >
> >       register unsigned long r8 asm ("r8") = hcall_id;
>
> IIRC, that's what the ACRN folks proposed first.  But, it's more fragile
> because you can't, for instance, put a printk() in that function between
> the variable definition and assebly.

Yes, this is also stated in the documentation. The solution is to:

--quote--
    register int *p1 asm ("r0") = ...;
    register int *p2 asm ("r1") = ...;
    register int *result asm ("r0");
    asm ("sysint" : "=r" (result) : "0" (p1), "r" (p2));

_Warning:_ In the above example, be aware that a register (for example
'r0') can be call-clobbered by subsequent code, including function calls
and library calls for arithmetic operators on other variables (for
example the initialization of 'p2').  In this case, use temporary
variables for expressions between the register assignments:

    int t1 = ...;
    register int *p1 asm ("r0") = ...;
    register int *p2 asm ("r1") = t1;
    register int *result asm ("r0");
    asm ("sysint" : "=r" (result) : "0" (p1), "r" (p2));
--/quote--

The %r8 is not preserved across function calls, so your statement
above is correct. But as long as there is no function call *between*
the variable definition and the assembly, the approach with the local
register variable works without any problems. It is even something GCC
itself has used in its library for years.

Uros.
