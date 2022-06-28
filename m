Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052A155F185
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiF1WnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiF1WnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A2951EB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656456183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N3IX/gTlOzcMhZyH2BrZr3zTeEd5GIRlks/xcDq+XFo=;
        b=UfvPTzD41rvXA2l9B+CbhVkJqRJQggq9FUrcbPFORqNxFiCSoEbZiQQwuAw950cY2EjQMG
        u4I+X+ejjBTWO79oPQ26bY8mqPw2X6AVvEkQgt/TuQEr0E/y2K9nnOVQ/VHPdgM5HXmpVE
        plxWVM5gugHMPuHzTjuv6Mx8tp8Gt3M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-HRMjf2mqM--EoK4jeMcX0A-1; Tue, 28 Jun 2022 18:43:02 -0400
X-MC-Unique: HRMjf2mqM--EoK4jeMcX0A-1
Received: by mail-qk1-f200.google.com with SMTP id m15-20020a05620a290f00b006a74cf760b2so14853555qkp.20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N3IX/gTlOzcMhZyH2BrZr3zTeEd5GIRlks/xcDq+XFo=;
        b=ZhA0Ggk5c9xN0S0HVb5cdavoxwDmeroePLTN71s3diJuI4WKsUnXySidqaFES850JC
         D4CIMPaDhgntzVMSbbv83sqQnwyP/xG9kd4qFP50l52HJNt9vwZlgg9SzqXqnQpYwELH
         p5DFgGoksyliR+hSpNKIj2FSQCBchawKC4bk2xYFCw2QXNr9MiISXBH6ZJZZjywUDLQh
         SsTENzWEKixawtJaop4wrAnYHgSrx0a2exAVdhDEzyyokMUpq3JwhNMa7/76m4CdxaQZ
         1OY3WTm2WHkVR25OP3TaJkB/loMm6wiQUfHYBuVH7NibH2arzBu4dRfPExknN3OaCor0
         RefA==
X-Gm-Message-State: AJIora+UlYha+AdkbqpMY3uwkVUbIqSkSPUoJDcBxxGXQ8V9UM10vkmX
        KKLDFAoK9cesMIn6N/5HVqI8LqkhjF1SiHSAMYwm9nYO7qmSb+4FXwl/mbsGIQpMu6ybj/04Nxv
        rCVz5lMtVj5mSqiePEQFw1J58
X-Received: by 2002:ac8:5b85:0:b0:31c:b896:fb7d with SMTP id a5-20020ac85b85000000b0031cb896fb7dmr286291qta.188.1656456181279;
        Tue, 28 Jun 2022 15:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOE0vK9uPK65DjDEw777VflVFI5uUmbAR0W0EzUmbV9uksIeb1t92cVYt8toPcx1d0/to2gQ==
X-Received: by 2002:ac8:5b85:0:b0:31c:b896:fb7d with SMTP id a5-20020ac85b85000000b0031cb896fb7dmr286269qta.188.1656456180961;
        Tue, 28 Jun 2022 15:43:00 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a280100b006a71c420460sm13022378qkp.22.2022.06.28.15.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 15:42:59 -0700 (PDT)
Date:   Tue, 28 Jun 2022 15:42:55 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang
 support")
Message-ID: <20220628224255.w4lmzalkx3qejuyg@treble>
References: <YrLtpixBqWDmZT/V@debian>
 <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMu5bdhkPzkxv/X@dev-arch.thelio-3990X>
 <CAHk-=wjTS9OJzggD8=tqtj0DoRCKhjjhpYWoB=bPQAv3QMa+eA@mail.gmail.com>
 <YrNQrPNF/XfriP99@debian>
 <CAHk-=wjje8UdsQ_mjGVF4Bc_TcjAWRgOps7E_Cytg4xTbXfyig@mail.gmail.com>
 <CAKwvOdmQKo4tZRLWxK2tTvd+OEtUmKJM7XiijLAF8JWMeUzFMA@mail.gmail.com>
 <CAKwvOdnfRnqBF8exO-Y1ooX=67TrO_8fSzgZwvUtidN_P31hzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnfRnqBF8exO-Y1ooX=67TrO_8fSzgZwvUtidN_P31hzw@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 04:33:35PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 22, 2022 at 3:40 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Jun 22, 2022 at 10:49 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, Jun 22, 2022 at 12:26 PM Sudip Mukherjee
> > > <sudipm.mukherjee@gmail.com> wrote:
> > > >
> > > > Tried it after applying your patch. There was no build failure, but some warnings:
> > >
> > > So some of those objtool warnings are, I think, because clang does odd
> > > and crazy things for when it decides "this is not reachable" code.
> > >
> > > I don't much like it, and neither does objtool, but it is what it is.
> > > When clang decides "I'm calling a function that cannot return", it
> > > will have a "call" instruction and then it will just fall off the face
> > > of the earth after that.

FWIW, GCC does the same thing for calls to __noreturn functions.  After
the call it just "falls off the face of the earth".  So there's nothing
special about Clang here.

> Looks like these are actually from calls to
> __ubsan_handle_divrem_overflow which is __noreturn when panic_on_warn
> is set by the corresponding config.  I wonder if we should be
> unconditionally adding __ubsan_handle_divrem_overflow to the allow
> list `global_noreturns` in tools/objtool/check.c?  It seems like the
> kconfig defines aren't passed through to the tools/ sources.
> 
> List of fallthrough warnings from allmodconfig for reference:
> https://lore.kernel.org/lkml/YrNQrPNF%2FXfriP99@debian/

As discussed with Nick on IRC, the problem highlighted by the
fallthrough warnings seems to be a mismatch in expectations as to
whether __ubsan_handle_divrem_overflow() is noreturn.

When Clang inserts calls to it, it assumes it's noreturn.  But in fact
its kernel implementation can actually return, if !panic_on_warn.

So it needs to be changed to *never* return, otherwise hilarity will
ensue when it returns and "falls off the face of the earth".

And then objtool needs to be told that it's in fact noreturn.

So, something like this:


diff --git a/lib/ubsan.c b/lib/ubsan.c
index 36bd75e33426..d257baa62721 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -177,6 +177,7 @@ void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
 		pr_err("division by zero\n");
 
 	ubsan_epilogue();
+	panic("can't return from __ubsan_handle_divrem_overflow()");
 }
 EXPORT_SYMBOL(__ubsan_handle_divrem_overflow);
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 864bb9dd3584..6f67d48fb3e4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -187,6 +187,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"__invalid_creds",
 		"cpu_startup_entry",
 		"__ubsan_handle_builtin_unreachable",
+		"__ubsan_handle_divrem_overflow",
 		"ex_handler_msr_mce",
 	};
 

