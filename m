Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C738C57706C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiGPRel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGPRek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:34:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B841903C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:34:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v12so10042062edc.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iDiDQdK0Y4Twyf2w6H2yrqrbuVdQeYS04yw6GP8uk4=;
        b=heW9Qr2XiyY6OqRlLdI2V+LEMMLgw6QKsr5CvO05pRXWfqknCGfEu1MOaT3LQ796sI
         YOm74UnqUxNmDzHVdAddwWqtIRm6ry2PynKXbKgn7j885PGSl1OXlWeH/5Ie8ljVLmz4
         NpcIen2TBlI7yD07+24+irawf+bg2LFZA6CIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iDiDQdK0Y4Twyf2w6H2yrqrbuVdQeYS04yw6GP8uk4=;
        b=fHPbROXYVqNTWdpglJzqa2ccoaaf+vrh4J7h6+RuC/fRb1CB9T4ZUpPOa/RM2UYGhZ
         rrRCHgzTa/EN5khAOoG6fdDx2cK9Gi9o9RprHckq0aIWYhpEQVPjyL4SxS3eqoX8/On0
         bopnSg14PPbKt+5QazGfNjEQFVmRqz7ZFyLNi5VfC6QKXtq/i+s3iXdZRYVL6ebgxxVb
         GJuYrignY2BoKGNdj5xv2gbbiRarVGDXY8yNTwOgquhHyvIaU8PQK/1MQ+AC8vteRrvQ
         MkujK/yFYvFpuIm5wuHREsRPMbOpVJOGdOBWd5xQif+CBEBjGkVheopCJvHTV3xrCR8y
         N87g==
X-Gm-Message-State: AJIora/5kdz7+Uut6umBwU6xsPDAT4OQUWexYu5oC03k2Je8Qe2Pd17S
        Ub1dmU4uMbniO1899+9seAZ1uSMTrCvb6yGp
X-Google-Smtp-Source: AGRyM1uQow1KBICMnyRD32ZYuXHvTnkkFNKBe6oXGis+/9X+VK5ybYSfPWc57b2RQ+yYYcAfVfz4qQ==
X-Received: by 2002:a05:6402:268e:b0:43a:8f91:582 with SMTP id w14-20020a056402268e00b0043a8f910582mr26725790edd.419.1657992877386;
        Sat, 16 Jul 2022 10:34:37 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id q10-20020a1709063d4a00b0072b3182368fsm3404301ejf.77.2022.07.16.10.34.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 10:34:35 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id bk26so10898863wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:34:34 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr16322329wrb.442.1657992873956; Sat, 16
 Jul 2022 10:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220714205646.4023495-1-ndesaulniers@google.com> <CAHk-=wgf=mrK7KzNh23dGtegSfJZx=423dCwF0hVTPOjfQ7jtQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgf=mrK7KzNh23dGtegSfJZx=423dCwF0hVTPOjfQ7jtQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Jul 2022 10:34:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6iW0Fv9mbtX9k2=9Kc9pFEEX7unWzmN7vqB4qXhBL+w@mail.gmail.com>
Message-ID: <CAHk-=wh6iW0Fv9mbtX9k2=9Kc9pFEEX7unWzmN7vqB4qXhBL+w@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable UBSAN_DIV_ZERO for clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 4:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> There are still the "__ubsan_handle_load_invalid_value() with UACCESS
> enabled" messages, but those are misfeatures of the kvm cmpxchg
> implementation.

Ok, so it really is independent of the non-optimal kvm cmpxchg implementation.

The kvm code is fine - yes, it runs a bit too much code under the
CLAC/STAC pair, but that "too much code" really is just a few local
variable assignments.

So any reasonable compiler will keep them in registers, and even if
that's not the case, it would just be a stack spill or reload with AC
set, which is not really a problem.

But calling out to external functions within that SMAP region is
invalid, and objdump warns about it.  Because we really want to
minimize the area where user accesses are ok, and it's a "don't do
this, you now lost the SMAP protection".

ANYWAY.

The reason the clang build warns - but the gcc build does not - is
simply that clang code generation is just nasty.

I decided to make a non-kernel test-case so that clang people can look
at it without having to worry about any kernel code issues or the
details of the SMAP rules, and it really shows how clang generates
horribly pointless and wrong code.

I'm not sure what the right thing to do is to get this sorted out, but
I created an "issue" on github for this:

    https://github.com/llvm/llvm-project/issues/56568

in the hope that this can get fixed. Because it's very clearly a clang
misfeature, where clang basically generates insane code that violates
the rules we try to enforce with objdump.

Nick / Nathan / clang-built-linux people - if there are other better
ways than that github issue thing to make people aware of this, that
would be lovely, and please forward that issue to the right people.

                         Linus
