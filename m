Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F35550DA53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbiDYHqH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbiDYHp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:45:59 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B863BBD0;
        Mon, 25 Apr 2022 00:42:37 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id i38so6494132ybj.13;
        Mon, 25 Apr 2022 00:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FzWf0IlKm0WlWwUvnTwOql8/+3g8LAVAbjzV5OJCv40=;
        b=7dSQtzkcx4U9FTpil+IAC2jKtSfstvWH1WYNPznUi1pkGrtOAi63l+e4u18PoO0xdr
         6U3tv3g6XiRMdmd2Gd+oMsKN0vckNur7DTIDh+xg8stT90UzfjF+0sXzyWZJH3k9ulCi
         pHwg5Dt9R1LDa+x76m+sJVss/Bx0OAH8Zz7JC03RLZQsvhNXiOXFc3cU2EpTZQF7mmC8
         CI6Z1p7c4NIiYOj31TyOD4Vj3iNuI+Pkffkj91Xj0FTlG51VZKvRcZhhY8U5VuTvLnY/
         22e85XaZgHo37LBDxWfgIkepJCm/9frVlJOudzUMDpZwNxDvA23Y9Q6GWC7B9soQAa78
         Am5w==
X-Gm-Message-State: AOAM533Rz4iPb20UIcopLJjSEBh/9bfIbtfWZQq/gPtP2szxjfPrwBaz
        ICcX+trc1FPmwCwZQLLSju2X6IpTdXOVi1d9EQ8=
X-Google-Smtp-Source: ABdhPJxoquitjR/CgWqxiQggvdjEfLTVH93JgWAsDE1w9KXG5pEboj4HBXfMD3vXswPoWKwRsD9CYDzZyIRa9lbYoN4=
X-Received: by 2002:a25:df0a:0:b0:648:6364:a150 with SMTP id
 w10-20020a25df0a000000b006486364a150mr3606038ybg.381.1650872556572; Mon, 25
 Apr 2022 00:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220422151725.1336997-1-mailhol.vincent@wanadoo.fr>
 <YmXMiTXEvFXZ/swU@dev-arch.thelio-3990X> <CAMZ6Rq+3XOze01dZZRTe+V44N2uo5J_=rtd9bKH7d7Fq9sNxVw@mail.gmail.com>
 <CAK8P3a31WAyh_vLqNwvv2GMcZ8SQp7gC=OV8c=Nc9pBtOSR8-g@mail.gmail.com>
In-Reply-To: <CAK8P3a31WAyh_vLqNwvv2GMcZ8SQp7gC=OV8c=Nc9pBtOSR8-g@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 25 Apr 2022 16:42:25 +0900
Message-ID: <CAMZ6RqL8G4uVn--Y5pBC+_c9Ex3Sjf8OJuVRwkVFFPwWd_ezLQ@mail.gmail.com>
Subject: Re: [PATCH] checksyscalls: ignore -Wunused-macros
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon. 25 Apr 2022 at 15:50, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Apr 25, 2022 at 8:17 AM Vincent MAILHOL
> <mailhol.vincent@wanadoo.fr> wrote:
> > On Mon. 25 Apr 2022 at 07:17, Nathan Chancellor <nathan@kernel.org> wrote:
> > > Hi Vincent,
> > >
> > > On Sat, Apr 23, 2022 at 12:17:25AM +0900, Vincent Mailhol wrote:
> > > > The macros defined in this file are for testing only and are purposely
> > > > not used. When compiled with W=2, both gcc and clang yield some
> > > > -Wunused-macros warnings. Ignore them.
> > > >
> > > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > >
> > > The change itself looks fine but a couple of comments:
> > >
> > > 1. Nick and I do not pick up patches, we rely on others to do so.
> > >    Additionally, this is not really something within our domain, despite
> > >    what get_maintainer.pl might say. This change should be sent to
> > >    either
> > >
> > >    Masahiro Yamada <masahiroy@kernel.org>
> > >    linux-kbuild@vger.kernel.org
> > >
> > >    or
> > >
> > >    Andrew Morton <akpm@linux-foundation.org>
> > >
> > >    so that it can be applied by one of them.
> >
> > Ack. As you pointed out, I indeed just followed get_maintainer.pl.
> > I will resend a v2 to the people you pointed out (and exclude you).
> >
> > > 2. I am not sure that silencing warnings from W=2 is that useful, as
> > >    they are unlikely to be real issues. Not to discourage you by any
> > >    means but it might be more useful to focus on cleaning up warnings
> > >    from W=1 and getting those promoted to regular build warnings.
> >
> > Normally I agree, but there is one reason to fix this W=2: this
> > warning appears when building other files.
> >
> > Example:
> > | $ make W=2 drivers/net/dummy.o
> > |   CALL    scripts/checksyscalls.sh
> > | <stdin>:21: warning: macro "__IGNORE_stat64" is not used [-Wunused-macros]
> > | <stdin>:22: warning: macro "__IGNORE_lstat64" is not used [-Wunused-macros]
> > | <stdin>:75: warning: macro "__IGNORE_llseek" is not used [-Wunused-macros]
> > | <stdin>:159: warning: macro "__IGNORE_madvise1" is not used [-Wunused-macros]
> > (rest of the output redacted).
> >
> > When I run W=2, I want to only see the warnings of the file I am
> > working on. So I find it useful to fix the W=2 warnings which
> > show up when building other files to not get spammed by
> > irrelevant issues and to simplify the triage.
> >
> > My initial message lacked the rationale. I will add additional
> > explanations in the v2 of this patch.
>
> I agree this is worth fixing if we want to make W=2 have any meaning at all.
>
> Your approach is probably fine. We could try to improve this by comparing
> against the list from include/uapi/asm-generic/unistd.h instead of the i386
> list. I suppose that would involve rewriting the script into a simpler one,
> but I'm not sure if anyone has an interest in working on this.

If someone wants to do it, great, but I do not have the
confidence to do it myself so I hope you will forgive me for
taking a pass here.

Another alternative I considered was to only call
checksyscalls.sh when doing a 'make all'. This way, we keep the
warning but people won’t be spammed when building sub projects
because the script would not be executed.

I tried to be as less disruptive as possible. Unless people show
interest in one of the alternative approaches, I will keep using
the -Wno-unused-macros approach in the v2.

> diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> index 9dbab13329fa..cde15f22ec98 100755
> --- a/scripts/checksyscalls.sh
> +++ b/scripts/checksyscalls.sh
> @@ -255,6 +255,7 @@ cat << EOF
>  /* 64-bit ports never needed these, and new 32-bit ports can use statx */
>  #define __IGNORE_fstat64
>  #define __IGNORE_fstatat64
> +

Just realized that I added a new line for no reason.
This will be removed in v2. Sorry.

>  EOF
>  }
>
> @@ -268,4 +269,4 @@ syscall_list() {
>  }
>
>  (ignore_list && syscall_list $(dirname $0)/../arch/x86/entry/syscalls/syscall_32.tbl) | \
> -$* -Wno-error -E -x c - > /dev/null
> +$* -Wno-error -Wno-unused-macros -E -x c - > /dev/null
> --
> 2.35.1

Yours sincerely,
Vincent Mailhol
