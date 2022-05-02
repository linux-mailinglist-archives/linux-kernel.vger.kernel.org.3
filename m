Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145B351726F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbiEBP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbiEBP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:27:03 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1513CC9
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:23:30 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f7c57ee6feso151623327b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ea1oEhzhMj8grWxQC5SgcBArE4/rXmfoEAuZM9GaSnk=;
        b=e8jLUWg60Xj2yGbY7ch7OqYrOgajvXWhT4iTIr2BEfGc4+9NKE3qXx5Xs7EWsTT9GL
         OeGOmR0vut0qQzy7JH/IrH9ka8nmoGFb2Gvyc23nt5LdSRcK5YcEOi9gq0tuIX1LeJ8F
         dgO5NTyqgBNIjtZfsGM/MVGmXurbMVjBLSFRbguI2sjEXBxprRb2lYwaWk3ntkRBUDU5
         w3d7TRfSKPgIEQBDgV73myrvp6CyIfvHo0gPoeiO3QhVlTaXfe6T8J6DfnjHgI0tJoXs
         /uqM+NbLt9VQB70/97KqEMc8frtLzcwZYPKAQP5xl9ZKUvDReHs43KuwvnY0KNe0WvE5
         DjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ea1oEhzhMj8grWxQC5SgcBArE4/rXmfoEAuZM9GaSnk=;
        b=ueXjcX0Vfv3v4Wce+xdXI1VnJUxglSxNDsDYw3Pit9nZ34cGxH63bCc5EeHNdgbs//
         ajMe6CDAz5lSNyX4tOvD5rt+MXc+ItmOAAE3yNs6AlXHLl28KjwcNkc0yIgZDptlciJ2
         UucRXIyBbnfuSA+172giRbdsoQnpnFjYiH688fT4EJB5LL9MsjRaituPpqHvB2JP/+xH
         eBqC8uJsiMfQSqxiKZ2msV8BZLid7z38cd78bB0Lzz0elSWCcgm7rnztmJ+g6NoOJv8+
         iFVolZ+/iFPS1l58WG7sU9yvjF0xk5YmJPNBqDtvSEdw7l+iCUxa7YvztRjjleCUGCtm
         rXEA==
X-Gm-Message-State: AOAM5312oMhQz8awoCbxZ/KWmOupdLlobeHqn2JSr1wJ3Lficn8tX25e
        yCF9amsLVAI01+JJOe217bC+E++9Yn0WAzut7UpWqw==
X-Google-Smtp-Source: ABdhPJzuy+A0wik9KFC+HHMm48ehGTHQOFaLPm3WarFTvUfmKlDOQAAm23en8K1MA9diKN/+E2i0Bt2GyOtIU8ryfck=
X-Received: by 2002:a81:a93:0:b0:2f4:d65a:d44e with SMTP id
 141-20020a810a93000000b002f4d65ad44emr11108924ywk.243.1651505009686; Mon, 02
 May 2022 08:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <202204291545.47C6A97EA2@keescook> <Ymz7DWkRJy3PMaHm@hirez.programming.kicks-ass.net>
In-Reply-To: <Ymz7DWkRJy3PMaHm@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 2 May 2022 08:22:57 -0700
Message-ID: <CABCJKuckt75qA1op-LpkJnQsJC36m9fstbY3uD=7pET2VyyZSg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] KCFI support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Apr 30, 2022 at 2:02 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Fri, Apr 29, 2022 at 03:53:12PM -0700, Kees Cook wrote:
> > On Fri, Apr 29, 2022 at 01:36:23PM -0700, Sami Tolvanen wrote:
> > > KCFI is a proposed forward-edge control-flow integrity scheme for
> > > Clang, which is more suitable for kernel use than the existing CFI
> > > scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
> > > alter function references to point to a jump table, and won't break
> > > function address equality.
> >
> > =F0=9F=8E=89 :)
> >
> > > The latest LLVM patches are here:
> > >
> > >   https://reviews.llvm.org/D119296
> > >   https://reviews.llvm.org/D124211
> > >
> > > [...]
> > > To test this series, you'll need to compile your own Clang toolchain
> > > with the patches linked above. You can also find the complete source
> > > tree here:
> > >
> > >   https://github.com/samitolvanen/llvm-project/commits/kcfi-rfc
> >
> > And note that this RFC is seeking to break a bit of a circular dependen=
cy
> > with regard to the design of __builtin_kcfi_call_unchecked (D124211
> > above), as the implementation has gone around a few times in review wit=
hin
> > LLVM, and we want to make sure that kernel folks are okay with what was
> > settled on. If there are no objections on the kernel side, then we can
> > land the KCFI patches, as this is basically the only remaining blocker.
>
> So aside from the static_call usage, was there any other?

Not at the moment, and it looks like we can get rid of that too.

> Anyway, I think I hate that __builtin, I'd *much* rather see a variable
> attribute or qualifier for this, such that one can mark a function
> pointer as not doing CFI.
>
> I simply doesn't make sense to have a builtin that operates on an
> expression. The whole thing is about indirect calls, IOW function
> pointers.

I also thought an attribute would be more convenient, but the compiler
folks prefer a built-in:

https://reviews.llvm.org/D122673

Sami
