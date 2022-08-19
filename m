Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9246159A478
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350695AbiHSRMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350554AbiHSRMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:12:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761D14328C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:31:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a9so6753831lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jBh1UbdsKajFE932mTf86NTEzzBwRixx74h/kr9bRj8=;
        b=JqUxUTJksgA8Zy6DqDMZoTUUkEgDvtco2VdSts57CP+Qy2eClm3e6eM9dUHObfiAsV
         BYY6sFczhrlmmzzptl2Ip7fKMjW0nBsjb+LatZ+gKqBHj9MFnn/WAKRNgUza5GVR3asm
         UYR5vSlfAP6QM8gSEqICZ9pZn/zh1zH0hXQ3FckoHRIaW5KS8PbsjFk1qo0QqzAmLGIF
         Y7USXWnPQS8nmksGVLoXM6E1UPzFuQW1FlEh7XKrLCfopX3CcbfUx9kJAQBMj6ynEO2d
         f/ggDPM2wSEymlmiIt0ImjvabdXl7EiB5ph5IH2Zkdll1iR1CnPksxDVjAgUdc8n6Wo8
         DxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jBh1UbdsKajFE932mTf86NTEzzBwRixx74h/kr9bRj8=;
        b=BHCENak2WdlhB2CVSLF+63AQ86qSj0VDKHNwVELUhfI7V87vCoIN6gp/Rdv523Hps1
         8x8NdEEH9+Ij3mnbuwn6rW9osD4VKcl8MUWTVcOOyYPasHOtYcbPYGNZfBCmXXuNxfyr
         neAIUBZLLc+G2kE3vrvwa/j1Uve20V5MiJL5CrGLSH8l3IJrazz0+2QvNTbPbSBEzTPI
         RBnaLY6O0cISQHkCKMWnRoCSZ+Xv8ZYlzsxm2fFiFtvwOAF0hd6/s6uoq/DwzUCuPQFn
         yxiYxRMIKTZdxg0Slml30/e34dMUEHzY620EyQj3hHkgqB9kDiv4gWcZVDk2k5NZEjJC
         ae2Q==
X-Gm-Message-State: ACgBeo3GDirdo06xs1FomzroIO1+xmHN891Gkg26x3n8wyDf5tXh99Ff
        raVoj+SaxyQy7pRELqzqIpwM6iNry8hqEekv0aX1KQ==
X-Google-Smtp-Source: AA6agR7BDHERdyQ0KkwtYGF6bn7C1R77LnSas9ZAvWSThzva8MHmZbPtdAXHao/NXfwsSRRdaAxcXGtTloiUr1QU1zU=
X-Received: by 2002:ac2:4f03:0:b0:48a:6061:bd8e with SMTP id
 k3-20020ac24f03000000b0048a6061bd8emr2949968lfr.647.1660926710894; Fri, 19
 Aug 2022 09:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
 <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com> <CAK7LNATSr=BXKfkdW8f-H5VT_w=xBpT2ZQcZ7rm6JfkdE+QnmA@mail.gmail.com>
In-Reply-To: <CAK7LNATSr=BXKfkdW8f-H5VT_w=xBpT2ZQcZ7rm6JfkdE+QnmA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Aug 2022 09:31:38 -0700
Message-ID: <CAKwvOdmYfr0yWAEBesA4D6E68qwhO46m6O90Rt1wvGr7_8mnVw@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     alexandre.belloni@bootlin.com,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Aug 18, 2022 at 7:29 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Aug 18, 2022 at 8:47 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Thu, Aug 4, 2022 at 12:03 PM <alexandre.belloni@bootlin.com> wrote:
> > >
> > > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > >
> > > When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fails
> > > with a syntax error which is not the one we are looking for:
> >
> > Thanks for the patch, though I think I'd rather see `/bin/bash`
> > hardcoded. Bash is a non-optional requirement as of
> > commit da4288b95baa ("scripts/check-local-export: avoid 'wait $!' for
> > process substitution")
> > scripts/ is kind of a mess...
>
>
>
> As for scripts/ mess,
> perhaps we can remove scripts/gcc-goto.sh?

Good idea, I think we can.

>
>
>
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
> seems like a bug for GCC 4.x at least...
>
>
> If we can revert the following two commits:
> f3c003f72dfb2497056bcbb864885837a1968ed5
> a9468f30b5eac6957c86aea97954553bfb7c1f18
>
> ... the asm-goto test will become simple enough
> to fit into init/Kconfig.
>
>
> If we know all GCC 5.1+ and Clang 11+ support asm-goto,
> we can remove CC_HAS_ASM_GOTO, but I am not so sure.

Yeah, asm goto has been supported for many releases of either compiler
at this point; here's versions we don't support anymore for kbuild yet
demonstrate asm goto support: https://godbolt.org/z/dr3zzn98e.

I'll send a patch with your suggested-by tag.

-- 
Thanks,
~Nick Desaulniers
