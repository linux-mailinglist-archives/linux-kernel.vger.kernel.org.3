Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF1B4DD01D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiCQVXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiCQVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:23:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3297A9A2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:21:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w7so11133279lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRvk/VVnw4/zCdH06gyReu2Cz7SwRimW7RvRCfYZG4A=;
        b=dCDHswjwXChioTR3TMtLF47+FPdp3xR2CaEXTo6XGOtouRJ2I30xou2UBTwg5UYt5h
         niC3YiH/fcpCugWi3ZcOsMK6xoTFUjOHwqBU9sBz7hGe2ACJVpQu065giZSEtMNG0lbA
         Gb7Bvip8XiGbNvYEe5dxzeYkcjGEseJM1fPnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRvk/VVnw4/zCdH06gyReu2Cz7SwRimW7RvRCfYZG4A=;
        b=BysUJbaTRML1ug7hbGB0kca9po674Q09Inf/JSP5+heaFg35x2tfkohGphbhBzLn6F
         h5fKa4gLGleVab1IEqp6DiGph/LEIu+oj7hhIicB+0ua7HiDUoq+Wh6JpGwYVjdjhNEg
         Mr4/uAlPcFXcHgtz8MQ4H6SNGSt8Sr7t1PMhHhcVEzcMPrpIuOFhlQOvBuoCncr0EWA3
         xdP6Aj8mMRnFEHbBmyQ8lBWxG6L/J9conr7eD63QZw/9BhWeGojuSAVKNmzlPyzp3NTl
         WE9EE1JSIt/tMdMSNzs0hCDjmJIEO+EtGaGYd0aAPcNqv9g3tDj+8RDmkDdmMBytBC2k
         Nhzw==
X-Gm-Message-State: AOAM532Umf66peU2zCbVJoEaSCQlO8ReqrmGutyEB/mZlE/2ONqmjuEs
        nxYBgL/fQ7f7nJiHDTuPYzGlG6Pfg5qE3QTi0V4=
X-Google-Smtp-Source: ABdhPJyK03/PYJwqPsBFzAJnc0v2ngc1BwmfvxUJhp0YLSviNFHBG6C2UhZdMBPGvGcbIdAHT+GeJA==
X-Received: by 2002:a05:6512:3dac:b0:449:f740:eb87 with SMTP id k44-20020a0565123dac00b00449f740eb87mr3140579lfv.579.1647552113244;
        Thu, 17 Mar 2022 14:21:53 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p1-20020a05651238c100b004435d1d47fasm543466lft.102.2022.03.17.14.21.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 14:21:53 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id bu29so11219030lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:21:52 -0700 (PDT)
X-Received: by 2002:a05:6512:b13:b0:448:90c6:dc49 with SMTP id
 w19-20020a0565120b1300b0044890c6dc49mr4276267lfu.542.1647552112472; Thu, 17
 Mar 2022 14:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com>
 <CAHk-=whn3iYE7gZM4vHx1kFhWBD2P9Wvmcyj8OOqv=y_7nemGQ@mail.gmail.com> <CAGG=3QWC9VS9RdGFTwY8VGqujDnFYnRTT1dQ6kkVr+0SRk6COg@mail.gmail.com>
In-Reply-To: <CAGG=3QWC9VS9RdGFTwY8VGqujDnFYnRTT1dQ6kkVr+0SRk6COg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 14:21:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=x7oCk05JD1=6XNsvvgpsidRWupoqySw1zODmvNy9Ug@mail.gmail.com>
Message-ID: <CAHk-=wh=x7oCk05JD1=6XNsvvgpsidRWupoqySw1zODmvNy9Ug@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Bill Wendling <morbo@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 2:10 PM Bill Wendling <morbo@google.com> wrote:
> >
> > As a result, we mark pretty much all system instructions as being
> > memory clobbers, because that actually works.
>
> For now.

No. Forever.

If you change the compiler to ignore memory clobbers in inline asms,
we'll stop using clang again.

This is not some kind of "threat". This is literally just a plain fact.

If you turn your compiler into garbage, we can't use it.

End of discussion.

> > Whether they actually clobber memory or not is immaterial, and is not
> > why we do it.
>
> I understand that. My point is that it's not a guarantee that the
> compiler won't change in the future.

YES IT DAMN WELL IS.

If I have an inline asm thing, and I tell the compiler "this inline
asm reads or writes memory in ways you don't understand", and you then
move externally visible memory operations around it - or move other
inline asms that do the same thing around it - then your compiler is
simply not a compiler any more.

IT IS BROKEN  SHIT.

See?

That memory clobber is not a "please mister compiler, can you pretty
please take this into account".

That memory clobber is a "if you don't take this into account, you are
now no longer a working compiler, and thank Gods we have
alternatives".

This is not a "in ten years things can change" kind of issue. This is
a very fundamental and simple thing.

I don't understand why you can't just admit that.

This is as simple as 2+2 being 4. That's black and white.

There is no "the compiler might optimize it to be 3 at some future date".

               Linus
