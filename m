Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A458CF7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbiHHVIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiHHVIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:08:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5186C19C02
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:08:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o22so12844973edc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lv26Q3sNxfEifdTpne61U1pkeE4sDF6GrXRlpPg4PbU=;
        b=LEuzOqsKGBmJ9I+TFAOXTx5jZrMKvhNvc27x7c9WibTJn3ejHzbKIiP3uVAlx3xwYC
         k0Y6K/CFzU/4eefSL2CLYD2AAF9U816dVyBiD6KftXoBXJ9IFuGBBB5nIJ+1g/1rrLU1
         ER9CMr1EyMh1gtywDU+AMIlcocFVVxXErwWNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lv26Q3sNxfEifdTpne61U1pkeE4sDF6GrXRlpPg4PbU=;
        b=wI9Zvs+391XW0bfA1cQX88IC0/Q2n5K84Kr4u1I+p0OTwflH79lBl2GD+pUOLvlquS
         0UmlHP+aEVZScfI78pzBHOPJ2G2JLaVEFFOuYiKiVaTqGwofaPwzsmflLJd2P5Huj/Xg
         N+A07YhuFiV//AbfzgILkbTGNkDg0I7BW6lHncXp/60XfdPAy+RK+Y2ctj9XZvTa+Mc3
         3Y2PuPi4Wht/rQC2qHVCpjsRobZmD/1dIDpdzPDCvKJG7LjCqJVSV0QVWJYxbs2JHn44
         GmprEEZIqnQI9EIEw7lncrLTr0ZDgJyoJWd63tBEtFrcqezDce/19m/fZVKj/Lg53CY3
         c0jw==
X-Gm-Message-State: ACgBeo0RgXM9HysAvmdkM7HlV+rt2D8hAzUnwo1dYaQV+Cw2I/ztT9GD
        mk6VOU3agKWK+2YHWrg16iPpAg8gSUcARfSp
X-Google-Smtp-Source: AA6agR6PGci6Mxcc5n1mtq5VzWxIVg8+tdBShGlcxEoCRIQDfj2/bDsTirE9Bo+24SRtEbHhCPbrtA==
X-Received: by 2002:a05:6402:424d:b0:43e:95d8:eb46 with SMTP id g13-20020a056402424d00b0043e95d8eb46mr18900922edb.306.1659992918735;
        Mon, 08 Aug 2022 14:08:38 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id bx7-20020a0564020b4700b0043577da51f1sm5060493edb.81.2022.08.08.14.08.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 14:08:35 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id n185so5374246wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 14:08:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr18515437wmq.154.1659992913709; Mon, 08
 Aug 2022 14:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220808192321.3490995-1-ndesaulniers@google.com>
 <YvFkmfHTUYGzeeQs@dev-arch.thelio-3990X> <CAKwvOdk0q1G--S7JhxOdN4KtCgDETDbkMMnfRZoCERfOmVyVyg@mail.gmail.com>
In-Reply-To: <CAKwvOdk0q1G--S7JhxOdN4KtCgDETDbkMMnfRZoCERfOmVyVyg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Aug 2022 14:08:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFDPvKZORw228YFWX_QTc7D0EoMEDP58P2pCocRSnsHA@mail.gmail.com>
Message-ID: <CAHk-=wiFDPvKZORw228YFWX_QTc7D0EoMEDP58P2pCocRSnsHA@mail.gmail.com>
Subject: Re: [PATCH] x86: assemble with -Wa,--noexecstack to avoid BFD 2.39 warning
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nick Clifton <nickc@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Jens Axboe <axboe@kernel.dk>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicolas Schier <n.schier@avm.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Ben Dooks <ben-linux@fluff.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Mon, Aug 8, 2022 at 1:32 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Thanks for the link; I recall Ard mentioning the ELF segments are
> ignored by the kernels loader in another thread.

Yeah, the kernel loader is not some generic ELF loader thing.

> Perhaps we should be adding
> --no-warn-execstack
> wrapped in an ld-option check to KBUILD_LDFLAGS at the top level?

I think both the linker flag and the assembler flag are the "correct"
thing to do.

And yes, I don't think there is anything architecture-specific about
it, and the top-level Makefile is likely the right thing to modify.

I'm a tiny bit worried about "what versions of as/ld accept those
flags", though.

              Linus
