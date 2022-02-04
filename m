Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E034A9197
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356213AbiBDA0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354856AbiBDA0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:26:14 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A572C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:26:14 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id t9so1482583plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 16:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0eVjWkn3YypKipWU59VgB8hKpGPPC7yMLBku/5hkxYU=;
        b=B/63qRKoTa/jPTvT35HS/ppnB6hN1ge8X/OnvCRnPNLr09AMTKLpwTtWlV/p1K0wTj
         TNBYyZzDepc42Ky0lTjLbfsDa9eo1lJjo2OaJ230lmRphEb1jb+LaY9zv2FOqH1xu+Ho
         bC4DYlB3dtVmyzGf1J8nTPkRpbDJEbgxaFqaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0eVjWkn3YypKipWU59VgB8hKpGPPC7yMLBku/5hkxYU=;
        b=VXkZTpTDttxxNe5LBWJ3fYXt+48IFyVkmwLflFKZQleMpZzr3Dm6JcDtqDYn78X8Pm
         Kv/EI3UPiOxWxa/VhznFBVd8XiY7wcjtdMmuRZT1JiqcpocgIXeBHZTXsWaBjF9Dhie3
         yTX+hH5R1KamV575cc69SMCgixpToXnsYpZ6T02/95I63GmhXmEGWsxe6JFp/IFHpAJ6
         ILAMOGwUUzcrZmfx+95wwaTSZYGUZPUrO83ttLza5v1BzauwM1yLE5SdZ9x52Ea8p9HZ
         /aCp96lDOSj4wTHNwSUvRGtEb595HXcTubPheuzucHQ2KeYmStoYv5iBLsQEf0jbe6zb
         RvFg==
X-Gm-Message-State: AOAM5312YW8yCvLnTr2U9F/LeGfE4spNfhmtIroOYanh+22f7q87sfQ1
        I5QsxSMWdZhf6tHnQInfYbBAlG9hyTrh4Q==
X-Google-Smtp-Source: ABdhPJzePD01mIAj1XkpKw+GItPRqZPyAv9KEL3Ul555b3PT0ZywjsUHGOJxLNDywApQ4JvY2r3ybg==
X-Received: by 2002:a17:90b:146:: with SMTP id em6mr280597pjb.214.1643934373835;
        Thu, 03 Feb 2022 16:26:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id me4sm11588041pjb.26.2022.02.03.16.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:26:13 -0800 (PST)
Date:   Thu, 3 Feb 2022 16:26:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
Message-ID: <202202031618.BC9EDA9D82@keescook>
References: <20220203173307.1033257-1-keescook@chromium.org>
 <20220203173307.1033257-3-keescook@chromium.org>
 <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
 <202202031301.437D8FD3@keescook>
 <CAKwvOdm-_uGYrm=2LTGSR7yhGK08NniGdkhLj_sM-QD-xdKVtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm-_uGYrm=2LTGSR7yhGK08NniGdkhLj_sM-QD-xdKVtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:11:48PM -0800, Nick Desaulniers wrote:
> On Thu, Feb 3, 2022 at 1:04 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Feb 03, 2022 at 12:26:15PM -0800, Nick Desaulniers wrote:
> > > On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > must be marked as being overloadable (i.e. different prototypes).
> > > > This allows the __pass_object_size versions to take precedence.
> > >
> > > Is this because of the `const` additions to the function signatures?
> >
> > That might be an issue, but the *real* issue is the implicit mutation of
> > the function into an inline with _additional_ arguments. i.e.
> >
> > char *strcpy(char * POS p, const char * POS q)
> >
> > is really
> >
> > char *strcpy(char * const p, const char * const q, size_t __size_of_p, size_t __size_of_q)
> >
> > (i.e. what I was doing with macros, but all internally and still an
> > extern inline)
> 
> What do you mean "is really"? 4/4 doesn't change the number of
> parameters in strcpy explicitly in the definition AFAICT.

It really does change the number of parameters. See the IR difference:

$ cat example.c
#ifdef USE_POS
# define POS __attribute__((pass_object_size(1)))
#else
# define POS
#endif

int func(void * const POS);

struct foo
{
        int a;
        char *b;
};

void usage(struct foo *example)
{
        func(example);
}

$ IR="-O2 -Xclang -disable-llvm-passes -emit-llvm -S"
$ clang           example.c $IR -o normal.ll
$ clang -DUSE_POS example.c $IR -o pos.ll
$ diff -u normal.ll pos.ll
--- normal.ll   2022-02-03 16:23:39.734065036 -0800
+++ pos.ll      2022-02-03 16:23:49.518083451 -0800
@@ -11,14 +11,19 @@
   store %struct.foo* %0, %struct.foo** %2, align 8, !tbaa !3
   %3 = load %struct.foo*, %struct.foo** %2, align 8, !tbaa !3
   %4 = bitcast %struct.foo* %3 to i8*
-  %5 = call i32 @func(i8* noundef %4)
+  %5 = call i64 @llvm.objectsize.i64.p0i8(i8* %4, i1 false, i1 true, i1 false)
+  %6 = call i32 @func(i8* noundef %4, i64 noundef %5)
   ret void
 }
...

This is basically doing internally exactly what I was doing in v4 and
earlier with macros (passing in the caller's view of __bos(arg, 1)).

-- 
Kees Cook
