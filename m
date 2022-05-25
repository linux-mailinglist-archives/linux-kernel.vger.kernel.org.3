Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91B153347D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiEYAz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiEYAzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:55:25 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6E36CF59
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:55:23 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-f2a4c51c45so3300591fac.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=87TAdO7JVTyU4dJLZx4/twxaR3Jk7wL6ogRvawQDX/I=;
        b=JIv9rAjc5IAfYhvvJ4+4CyGclox8QGMjVLCV4cdp6JH0BX/N5umdP0MRbQAiEZW9iH
         Tepm36gZweXci0jyXQz/OHvziPK6hnlGztgxjOt/n/8mWMSFnW/LjcpcXudoYPCDJeKv
         N3lBWB1XkkmwNMm7/R4jUBR6jvftLDN2KLLFXaCdTgEQEoyAo8FdYCWODHViuca04dbk
         IUtXTEtK8+z0KmykxRAQrE1MMpzcNcGTeOGBHi/dhWq3Z6vZk+H0Qu67jQtyQUUJWz3C
         GhLvq0MPZFFlPmbbg0+zVgmeUyPgb50F9kht7pKLCOKFngI+956xeYdrtxxGIg1b5lnI
         yaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=87TAdO7JVTyU4dJLZx4/twxaR3Jk7wL6ogRvawQDX/I=;
        b=X3NjEWpn60JZPyv0UvRdG0DDJmT9vL5p/5uXmRGpMm4uFyMuYCsiGqND8K1Ylkkk7i
         6scuDDD0YPzzSalGuGnYptkfByrquerMG/8jvJrl1f7O8eTYFws0jAEwFLuzD8D5rcIG
         z/acUzpBxGAQ3hQtIkpcNlfcZcoCe94xl9j8c15zBFCahnVz011yg7RhA7TimB/oZFtC
         UpKxOFlT8fvm8/lqSEbpINDceXFnKoR0ECkj6ma+s4Fup65dSR9e5fF87vfBckpDhDt0
         ROYZSL+Bpuw9Zw8YKrEnKwIamxOhj/8yR4//RRMISOLEkNenqEC/jUCPQeaFmE/VVY4t
         yjOA==
X-Gm-Message-State: AOAM533PyCiS8+kZYTsQbdTgMuaT+scIn76IJCsPYyy3pabo3oZffZXr
        Zd6qFnZqSTcLrmPnkYcFQ6uAX/DUgwS8rjp3m3ubZA==
X-Google-Smtp-Source: ABdhPJwuIQfcxPE3CrjW3nGLNRxcyh8Nyr3XOH9nVNz3aP18UDS9v2PrgtCxeZabMgswSF/jtx1j7MFj7uvcmqz5eic=
X-Received: by 2002:a05:6870:c683:b0:ed:efb9:ffe9 with SMTP id
 cv3-20020a056870c68300b000edefb9ffe9mr4067382oab.241.1653440122904; Tue, 24
 May 2022 17:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220504182908.1322874-1-yuanchu@google.com> <20220504184537.130085-1-sj@kernel.org>
In-Reply-To: <20220504184537.130085-1-sj@kernel.org>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Tue, 24 May 2022 17:55:11 -0700
Message-ID: <CAJj2-QGUsqx8uRTamv7Hbw_-FRJOtrEnX6=fGEseZDJEtcnOaw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/damon: suppress compiler warnings for huge_count_read_write
To:     Shuah Khan <shuah@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>, Markus Boehme <markubo@amazon.de>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Wed, May 4, 2022 at 11:45 AM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Yuanchu,
>
> On Wed, 4 May 2022 18:29:08 +0000 Yuanchu Xie <yuanchu@google.com> wrote:
>
> > The test case added in commit db7a347b26fe ("mm/damon/dbgfs:
> > use '__GFP_NOWARN' for user-specified size buffer allocation")
> > intentionally writes and reads with a large count to cause
> > allocation failure and check for kernel warnings. We suppress
> > the compiler warnings for these calls as they work as intended.
> >
> > Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> > ---
>
> It would be a good practice to mention the changes from the previous vers=
ion of
> this patch here[1].
>
> [1] https://docs.kernel.org/process/submitting-patches.html#the-canonical=
-patch-format
>
> >  tools/testing/selftests/damon/huge_count_read_write.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/to=
ols/testing/selftests/damon/huge_count_read_write.c
> > index ad7a6b4cf338..91bd80c75cd9 100644
> > --- a/tools/testing/selftests/damon/huge_count_read_write.c
> > +++ b/tools/testing/selftests/damon/huge_count_read_write.c
> > @@ -2,6 +2,8 @@
> >  /*
> >   * Author: SeongJae Park <sj@kernel.org>
> >   */
> > +#pragma GCC diagnostic ignored "-Wstringop-overflow"
> > +#pragma GCC diagnostic ignored "-Wstringop-overread"
>
> I agree that this must be the cleaner way than v2.  But, I get below warn=
ing
> after applying this:
>
>     $ sudo make -C tools/testing/selftests/damon run_tests
>     make: Entering directory '/home/sjpark/linux/tools/testing/selftests/=
damon'
>     gcc     huge_count_read_write.c  -o /home/sjpark/linux/tools/testing/=
selftests/damon/huge_count_read_write
>     huge_count_read_write.c:6:32: warning: unknown option after =E2=80=98=
#pragma GCC diagnostic=E2=80=99 kind [-Wpragmas]
>         6 | #pragma GCC diagnostic ignored "-Wstringop-overread"
>           |                                ^~~~~~~~~~~~~~~~~~~~~
>
> My gcc version is:
>
>     $ gcc --version
>     gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0

    $ gcc --version
    gcc (Debian 11.2.0-16+build1) 11.2.0

I believe this is a new warning for gcc-11 [1], and somewhat unfortunate th=
at
it results in a warning for gcc-9.4. So a patch that would resolve the test
warnings for gcc 11 would introduce a new warning for gcc 9, and vice versa=
.
What's the preferred solution here?

[1] https://gcc.gnu.org/onlinedocs/gcc-10.3.0/gcc/Warning-Options.html

Thanks,
Yuanchu
