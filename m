Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5524DD130
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiCQXdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiCQXc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:32:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E123318CD1F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:31:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h14so11509495lfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIik/7JhUqMYYHvz4PGBxZz1oteF8rRLVp9nxcgFqks=;
        b=DpOVy4EhBN9HRx+Owjx5178I49nqrRP/5Ghlg2kAeN2Nl1/gidgOPQ+PfyLo68cYOI
         v+92J+gf3eOFukalAdgvfsWyXUd5I+ofPmDLRlc6sgGLysLHI0E4Go3BsZjoVkO0RYWd
         bvEFttF33LX3h7fgWTXTuWJLu1V7dNVhisyoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIik/7JhUqMYYHvz4PGBxZz1oteF8rRLVp9nxcgFqks=;
        b=DLO+a0LVbdynbzlOW4RtLCzAZJwoIWzXaOoM6+W4LqJteAipYTfYSKe3R6AZ/uy7QE
         CUkKRXCJ/AkZw95UbS/IPaiVd+WlU9MZHdJLLoZNXagGPXpJb8VGPkIYAB/5Hb8+rX0q
         6/s4Va68RFsmRDAFmWx+G7R8jQNET+wiC5xQIW503bB62Rz77rbXZErvNS517V0Urgax
         mxRGafYZr5MDEo8mbkQEeW5P5dNT0eXldw/Ctf+Qxh3WX6S3TCpfzZKtjeSiiJfsSlSW
         iVs9tJZSsCc5iwPKdU0SxV6QsIe6TB7puIfYv3aukfOkuNA3pfXCRABtFePUOUm6/2pw
         4gIQ==
X-Gm-Message-State: AOAM533f2MII7xcHKiV2BKhnuYVPSbJY2hhvF2E/i+Wt4adW3QXVADMD
        HCn30sWzf3bu2vEwhOI/NcvYxguL2N/4JapL8B8=
X-Google-Smtp-Source: ABdhPJz12KrPASAMQRJA5cRaNSxl2vef54sP1lkJXfRtmOdlblmHf8O2tnz6pP9Wlrg4WCMqJgMDRg==
X-Received: by 2002:ac2:554a:0:b0:448:2a09:66eb with SMTP id l10-20020ac2554a000000b004482a0966ebmr4408218lfk.645.1647559898936;
        Thu, 17 Mar 2022 16:31:38 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b2-20020a196442000000b00443c5b81ce0sm581671lfj.180.2022.03.17.16.31.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 16:31:36 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id s25so9284277lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:31:36 -0700 (PDT)
X-Received: by 2002:a2e:a78f:0:b0:249:21ce:6d53 with SMTP id
 c15-20020a2ea78f000000b0024921ce6d53mr4379261ljf.164.1647559895803; Thu, 17
 Mar 2022 16:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com>
 <CAHk-=whn3iYE7gZM4vHx1kFhWBD2P9Wvmcyj8OOqv=y_7nemGQ@mail.gmail.com>
 <CAGG=3QWC9VS9RdGFTwY8VGqujDnFYnRTT1dQ6kkVr+0SRk6COg@mail.gmail.com>
 <CAHk-=wh=x7oCk05JD1=6XNsvvgpsidRWupoqySw1zODmvNy9Ug@mail.gmail.com>
 <CAGG=3QWcKof_NXrC0kznM2ikwTA00AgUJrcWhKBTitmjCuOxqw@mail.gmail.com>
 <CAHk-=wj=aK2T+h=rRJL4jDDTgV2U533E_duroCoVSUfkvYd0OQ@mail.gmail.com> <20220317231959.GN614@gate.crashing.org>
In-Reply-To: <20220317231959.GN614@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 16:31:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHgSJ-suTT6V6_2USPDrdmQweLR_M_YHjb8OsQvYWn-w@mail.gmail.com>
Message-ID: <CAHk-=wgHgSJ-suTT6V6_2USPDrdmQweLR_M_YHjb8OsQvYWn-w@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Thu, Mar 17, 2022 at 4:25 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> > I still think that from a sanity standpoint, it would be good to
> > actually strengthen the semantics of "asm volatile" to literally act
> > as - and be ordered with - volatile memory accesses.
> >
> > But I guess that's water under the bridge.
>
> That is what it has actually done since forever.  See C 5.1.2.3.  For
> GCC, "asm volatile" has a side effect like in /2 there as well, as does
> unspec_volatile (an internal GCC thing used to implement certain
> builtins, among other things).

Oh, so two "asm volatile" statements _are_ in fact defined to be
ordered wrt each other?

Because the gcc docs certainly don't say that ;(

Yeah, yeah, dead code can be removed, whether volatile or not. That's
true of "*(volatile int *)x" too. It's not the dead code that is the
interesting case, though..

Is this also well-defined ordering-wise:

    asm volatile("do_something");
    WRITE_ONCE(x, 1);

(where "WRITE_ONCE()" is that kernel macro that just uses a volatile
pointer assignment to force the access)?

And could we get that documented?

            Linus
