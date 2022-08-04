Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B286658A111
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiHDTGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiHDTGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:06:09 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4813138B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:06:08 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d16so513196qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=w1c2CYqHXV770pBVexFAMq+ahCfcb4kZPyaNDERN/10=;
        b=cKrU1RCYLJaPNuDDnLNSbKlXi8xGJzaLTalU7JEelZl4vVSe72dKtJwIXzLy+dcrAn
         OL/6tukAASsbZ706n2XS9xADAV5MUyekdsf6Ov/Ub/ZEdhDAhV0twzzS0AiTQzwoGVJf
         In3tH3jUAeMPmlBkmTuYSYu4ls/qE2ffRQi34Ua02Bi8BX5RXZXHISPjR5ROD9ub8aeX
         gxhnD/ohP9vA02ociykXaKZdiGHlMLh+RfrIsqRDG028girhm2505pAHUxe3cbepBCr5
         2pN0iLr+EPiYvaT3S9YQ6h4H4XFJLcUzKb2wnEBhFRO3JuPM3Elp8guJhtTcIY1upDlb
         b8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=w1c2CYqHXV770pBVexFAMq+ahCfcb4kZPyaNDERN/10=;
        b=S6hrNhaY2tdL8qFQTAKPPX4K+XUftQLP/rEw5dd9Z5T81WM6wXe54CkRll5YZiMEjW
         PyIx8NmpsTudQs1ro6DEeTnSuOaGPr6z/A7UjRiC/XYDXxvd0JFRc31lEgmWmWjQFQH0
         nUCkDx+0QKK1PzCPpZnGa+6q+fAnHirLumwGeYJmtK8kcvbCqt/WkZ11Ln3aTC3QFSy4
         6VgM4eToQLCqrYVSoAlgbheIb86Xy9QQLBK7f36XpGThgiWX3bxSfh2CQ5/PbBG42s2F
         D2ZGxLBwdUjUhTzuRm6cFq3ZNODXcaN1XCqmhCXL5+ZG4agHhehcEnqTMFzf4EwCVZgf
         qr/A==
X-Gm-Message-State: ACgBeo1FnGXCOw7rgy1BX+YtjTC2g1i94XiH9NXRI04rb8gRIrJ41ix7
        e43psXHWEOy9TB50hGRzrvYS/HQHrQCn1/BhHvM=
X-Google-Smtp-Source: AA6agR7AI9dPrdJAXeussmCOU1qLjPQ19soEGXWcC/9Ume8YsOf4lHPB8tynGo1FglDe55l7iSxUDmZT3PxRPK3r6HM=
X-Received: by 2002:a05:622a:1388:b0:342:321d:4a16 with SMTP id
 o8-20020a05622a138800b00342321d4a16mr1805857qtk.5.1659639968086; Thu, 04 Aug
 2022 12:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220804180358.32944-1-ubizjak@gmail.com> <YuwVY8iGkifExuli@google.com>
In-Reply-To: <YuwVY8iGkifExuli@google.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 4 Aug 2022 21:05:57 +0200
Message-ID: <CAFULd4a3oY6HPtccj0tAH0H9h=mhZkbUUimqq4tWBZU2E6oS2g@mail.gmail.com>
Subject: Re: [PATCH] x86/acrn: Improve ACRN hypercalls
To:     Sean Christopherson <seanjc@google.com>
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

On Thu, Aug 4, 2022 at 8:52 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Aug 04, 2022, Uros Bizjak wrote:
> > As explained in section 6.47.5.2, "Specifying Registers for Local Variables"
> > of the GCC info documentation, the correct way to specify register for
> > input operands when calling Extended 'asm' is to define a local register
> > variable and associate it with a specified register:
> >
> >       register unsigned long r8 asm ("r8") = hcall_id;
>
> Using "register" for input operands is subtly dangerous.  The compiler (at least
> some versions of GCC) isn't smart enough to realize that it must not clobber the
> register between setting the register and passing it into asm().  Or maybe that's
> the designed/intended behavior, but if so, IMO it's a terrible design.
>
> And since kernel style is to put declarations at the beginning of functions, it's
> quite easy for a developer/debugger to mess this up (speaking from multiple
> experiences).

All you said there is true, and these cases are even covered in the
GCC documentation (please see section 6.47.5.2, "Specifying Registers
for Local Variables"). But in this particular case, we have a static
inline function, which encapsulates low-level access, so we *can* add
the definition just above the asm.

Uros.
