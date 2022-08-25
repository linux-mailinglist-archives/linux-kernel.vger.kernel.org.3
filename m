Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BF05A173B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbiHYQvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbiHYQvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:51:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A9DBB93B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:49:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d23so24657659lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Zej4CxY/1CWynJQcpIFCE/ePm/cZkXwlSREUqfzuJ8Y=;
        b=h5BQlI0xIEyNRWKjxWMt8RcIcaw6Iab9Lro//TN7cNvmYLCYmjHA9b7vqil1aO5lR2
         jjncnbXB0E5n8vUT5r/OBW2cdzESp8HNiF0+6Am4i8gbPE/IF29BiN++mET+t+9HhGXy
         KU+7dVHbSPecBR62YILXw08KL2z9er7opHtdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Zej4CxY/1CWynJQcpIFCE/ePm/cZkXwlSREUqfzuJ8Y=;
        b=mglY1DN7T1xJcc4a++eQSdEIgKr18V19+yDK88OfgingfLNZiqoLpYMHXdxFfvkSiD
         NY9pIBbgTgiEb/fNNWm+6BICVQyC1YFa83hGwJT6v/jfJ+EYEXnq17Ieqb9/W3cFFeLZ
         UID/M6EOQiGduuPn+xfJco7oixHMILtS8fSxONmv6TyEu+kQhn5QLLd1prs7xRk+IDwG
         oeHg7aHkvZplvLERVgb+sXMLf8qEqFyd4i0BD2VekhTSItdKCx/fJfIVEVBEx2TDmwAN
         la2eR5sX+v8GgGOw3dysq5pWJEZazl/fl8NGrptUG+1DtkvfaEtR05JoeVi/q3avfCt8
         KYXQ==
X-Gm-Message-State: ACgBeo1ZmQFj3FGgH5bK9ZqmCHfOPbSdVzNZqKRii6254tGJnrg32D5V
        hqxyuuRfPMP+bl99FCxu8FEsvEg1XtR0tdhJn4s=
X-Google-Smtp-Source: AA6agR5bDX6jdlVo9rrOd8LBH2wmkHo7uVYn7bURv3UtfPdafi5WDNneuB9QDubDK6i76yHLiY7SsQ==
X-Received: by 2002:a05:6512:2314:b0:492:b612:5390 with SMTP id o20-20020a056512231400b00492b6125390mr1582741lfu.115.1661446175821;
        Thu, 25 Aug 2022 09:49:35 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 124-20020a2e0982000000b0025e4e7c016dsm672186ljj.16.2022.08.25.09.49.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 09:49:35 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id l8so11495145lfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:49:35 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr2680808wri.442.1661445807749; Thu, 25
 Aug 2022 09:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com> <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <87ilmgddui.fsf@oldenburg.str.redhat.com> <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
 <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Aug 2022 09:43:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWiU_KjueEE1Mi7rk6NCKaQRE=5hQaQC+2MY6-CabKFA@mail.gmail.com>
Message-ID: <CAHk-=wgWiU_KjueEE1Mi7rk6NCKaQRE=5hQaQC+2MY6-CabKFA@mail.gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C naming
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 7:38 AM Joseph Myers <joseph@codesourcery.com> wrote:
>
> I've not yet implemented it for glibc or for GCC format checking, but C23
> adds 'wN' format length modifiers so you will be able to e.g. use "%w64d"
> with printf to print an int64_t and won't need those PRI macros any more.

Yeah, that's going to help user space.

We don't typically have huge issues with it (any more) in the kernel
exactly because we refused to do the syntactically horrendous PRIxyz
thing.

So in the kernel, we still do have some format string issues, but they
tend to be about "different architectures and configurations do
different things for this type", and those different things are sadly
not necessarily about a fixed width.

IOW, we used to have horrors like "sector_t can be 32-bit or 64-bit
depending on config options" (because small machines didn't want the
overhead of having to pass 64-bit things around - from back when
32-bit was a primary target).

We got rid of *that* thing a few years ago because it just wasn't
worth supporting any more, but some similar issues remain.

So we still have a number of cases of "if you really need to print
this out, you need to use '%llui' and cast the value to 'unsigned long
long'".

But it's happily not as common as it used to be.

                 Linus
