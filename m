Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AE6598AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbiHRR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242519AbiHRR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:59:20 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3738C6CCA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:59:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r141so1665978iod.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7oe2Eodvo4cHSy2YtCc59ePq/pRiQuqwvHx5VzBYsYs=;
        b=edIm4Rg6BSJsMQXvCvLFwwFXy0SgZL16xDx+ddO+pIxGoxGhVBW1JCUG4UJ4nMUG8M
         h9wXvegj3gt22AUMb2wOXjwfw2exTUiCTBBx/czTYs8MX1XFi3rftEoMeav0o1sDi4PH
         T5O1xzJMMPnXq9Tm/Z2EFTSP1YGgWu/FUpjClXnfOiUHoAd4VQvibkoMme4W9oxkJhWm
         9GMqef+W/Vs+jkHaqJVlLMkA+d4lhvKd+F6yj/327zqFExvFnlp9sarw3XYr4YD+WO7X
         FfTLBskgqGWvD6e+k6RBRl9E7jBeyHO2EstWlzSxL9MHnzGU6oG0h9vOvrFHR4B9mVtJ
         6C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7oe2Eodvo4cHSy2YtCc59ePq/pRiQuqwvHx5VzBYsYs=;
        b=qLYFtOpSr6iqD+raVmdJX6AskAoqSKJLMi1skefXfZrTjPsDT6sr2zXXGsg5qlEAUF
         j1rt/p9NieNNUvkpcImyqNrcuSTbEDpfBSYGMm6fojppwYiujYYxJ/Ao9OeW3SlQOCuk
         3Ogo94hLjXWoAVctxCrvD4ilq2tI9Dqx0puDSt3ej5roOJ0h4DDfU2zpet0cBzywNaJu
         79oGeCItJCIr5wi0xWaqPgg2XRzfqTiymJEQE00mmGTA4NjavYm3ZUhRQQ582o1fru6w
         j+ikF5t9Zj20K9SubebNDXeNmBrqPbaUvHb0cP1bpqavasuZvswyKF8+7dAERmqcJrfK
         fmbQ==
X-Gm-Message-State: ACgBeo2jJFX64XhhwvXTSzPA0xjKMQNlGEmlNzSnoSTMVc9XEp6U626z
        YMPO2hCZGUgoy4nUb14o9UlLCAcG9wB02XJD2Uw01g==
X-Google-Smtp-Source: AA6agR4U+57gHVzGKChcaUfF5FOoGlpZMDiAtZPsr1UjDP45RsQZeuVCHp+BILRKLZOZ5NtZ/tNWWI+NXk0bJOcx7N0=
X-Received: by 2002:a02:7a4d:0:b0:346:b4db:f4da with SMTP id
 z13-20020a027a4d000000b00346b4dbf4damr1863490jad.52.1660845558863; Thu, 18
 Aug 2022 10:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220817211356.273019-1-axelrasmussen@google.com> <190edda8-1f37-0fa5-1cc1-ada97518698a@nvidia.com>
In-Reply-To: <190edda8-1f37-0fa5-1cc1-ada97518698a@nvidia.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 18 Aug 2022 10:58:43 -0700
Message-ID: <CAJHvVcgktSjo5CncC25+2j1amXvn3TjnsfOCV6CxNDp5joey9Q@mail.gmail.com>
Subject: Re: [PATCH] selftests/vm: fix inability to build any vm tests
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Aug 17, 2022 at 3:15 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/17/22 14:13, Axel Rasmussen wrote:
> > Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >   tools/testing/selftests/vm/Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> > index d9fa6a9ea584..f2a12494f2d8 100644
> > --- a/tools/testing/selftests/vm/Makefile
> > +++ b/tools/testing/selftests/vm/Makefile
> > @@ -1,7 +1,7 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   # Makefile for vm selftests
> >
> > -LOCAL_HDRS += $(selfdir)/vm/local_config.h $(top_srcdir)/mm/gup_test.h
> > +LOCAL_HDRS += $(selfdir)/vm/local_config.h $(selfdir)/../../../mm/gup_test.h
>
> Hi Alex,
>
> Thanks for fixing up this build, it's always frustrating to finally
> finish working on something, only to find that the selftests build is
> broken!
>
> This looks correct, and also I've tested it locally, and it works. So
> please feel free to add:
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>
>
> A couple of follow-up thoughts:
>
> 1) I recalled that hmm-tests.c in the same directory also needs
> gup_test.h, and wondered if that was covered. And it turns out the the
> relative "up and over" include path is done in hmm-tests.c itself,
> instead of in the Makefile, like this:
>
> /*
>   * This is a private UAPI to the kernel test module so it isn't exported
>   * in the usual include/uapi/... directory.
>   */
> #include "../../../../lib/test_hmm_uapi.h"
> #include "../../../../mm/gup_test.h"
>
> It would be nice (maybe follow-up polishing for someone) if this were
> done once, instead of twice (or more?) via different (source code vs.
> Makefile) mechanisms.

Hmm, I suppose the way to clean this up would be to have the Makefile
compute this once, and pass in "-I $(selfdir)/../../.." to the
compiler so we could just "#include <mm/gup_test.h>" directly?

If there aren't objections to something like that being too weird, I
can write a follow-up patch which does that.

>
> 2) Commit f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
> claims that it is now required to "make headers_install" before building
> the selftests. However, after applying your fix (not to imply that there
> is anything wrong with the fix; it's fine), I am still able to build
> vm/selftests, directly after a top-level "make clean".
>
> I believe that this is because the selftests are directly including
> gup_test.h, via relative up-and-over paths. And I recall (and also did a
> quick dry run, to be sure) that this internal gup_test.h header is not
> part of the headers_install list. So that seems to be all working as
> intended. But I wanted to say all of this out loud, in order to be sure
> I fully understand these build steps.

I agree this is working as intended, my understanding is that "make
headers_install" is really for the stuff under include/uapi/*, whereas
headers under mm/ or lib/ aren't really meant to be "exposed to
userspace" except for these particular selftests. So including them
directly instead of looking for them under usr/include/ is
intentional.

>
>
> thanks,
> --
> John Hubbard
> NVIDIA
