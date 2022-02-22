Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDA14C019D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiBVStT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbiBVStS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:49:18 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD061323EE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:48:52 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e140so43109116ybh.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEvSCVwL/A3X3tCkaLLRRca+X+c7l6RWUROLPaM/Tx8=;
        b=rXGJIwjZlw3ACce5I3PFgeBjPS4fxuCYFOC2yx/AzU0OAp27JOu69nttt75RbiM0Rq
         +EFdpKhNyDOttFvq/XDfKuL3YIMcHnKFAdnwkxKPdELzMw/Fb/RajpsO0Q0Gw2gHBFLw
         dkUQxjNbQ4LU/8W/DMJLa/aan6kw01C//FtMYXz6gxOZkUJBtH2ATHdDucOM2Xsb1s3O
         WC505All0OB8eiocoWY8OAWdS7ec05vcs+Fbv5FNmamEZ43iDLEBykTFUKBQYghe+LyQ
         UBlTpXwVtJL25BPaVuhObMxdLZpW6bfM+4qZd8OCHTO7K2RJKzSUPbENzcLxp0s4snyN
         YBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEvSCVwL/A3X3tCkaLLRRca+X+c7l6RWUROLPaM/Tx8=;
        b=eC7wvI7qBtoDWUYz79wo2stltFUZH7JzUYi8mx0jiYvXj2o7/fdFqssST7DhQt1RZH
         mkev7t0+HrxvQYcG5WCYoq2Gd48ukPboAbU3KJPK7sQCCtRI4qyqjAQu8U9Bf9rYCqHx
         vCfwA6xUqMp9Fx/sn0DiAfS7BNKMe7H4l9kT0A3M2SRH3r5aGtQN7HJZPnDDex3olPpH
         Op/JW87+wtCZ1eprQr4yXUrZov9uXQgteoPbKWdOgUDbwXmqBgvGVfANfhtXZVuTdGYD
         UnfOn34andIlZXFukJ4tRNH+vJeEqmfArYwdMe9Ji1xXVDwZ1mFQ65StKle9quiShhox
         Qfeg==
X-Gm-Message-State: AOAM530faGSU4ybEuhLg33WJEuYvIb4hPyZZRAaSwuTGk6Ql6lyhrhdM
        vB4QzlmchZWv9glZ5609dCxnK8joQAan8YSuH6vI9Q==
X-Google-Smtp-Source: ABdhPJxC870BtNHWuFMIKLAeUWoVPt9DVgjg6YJTPrNb7Bn3HlGLHMIuVlPY/D4jk4/S+sixqxL+tjs2qEaIgMtLxRo=
X-Received: by 2002:a25:3542:0:b0:622:caf1:2c88 with SMTP id
 c63-20020a253542000000b00622caf12c88mr20154405yba.625.1645555731413; Tue, 22
 Feb 2022 10:48:51 -0800 (PST)
MIME-Version: 1.0
References: <019ac41602e0c4a7dfe96dc8158a95097c2b2ebd.1645554036.git.andreyknvl@google.com>
In-Reply-To: <019ac41602e0c4a7dfe96dc8158a95097c2b2ebd.1645554036.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Feb 2022 19:48:40 +0100
Message-ID: <CANpmjNNhvxEnjkq_s9DRyFd-r0hDnxGST6ommX3anTY+fBcLaA@mail.gmail.com>
Subject: Re: [PATCH mm v2] another fix for "kasan: improve vmalloc tests"
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
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

On Tue, 22 Feb 2022 at 19:26, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> set_memory_rw/ro() are not exported to be used in modules and thus
> cannot be used in KUnit-compatible KASAN tests.
>
> Do the checks that rely on these functions only when the tests are
> built-in.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Looks reasonable, thanks.

Reviewed-by: Marco Elver <elver@google.com>


> ---
>
> Changes v1->v2:
> - Hide checks under #if instead of dropping.
> ---
>  lib/test_kasan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index ef99d81fe8b3..c4b7eb2bad77 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -1083,11 +1083,13 @@ static void vmalloc_helpers_tags(struct kunit *test)
>         KUNIT_ASSERT_TRUE(test, is_vmalloc_addr(ptr));
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vmalloc_to_page(ptr));
>
> +#if !IS_MODULE(CONFIG_KASAN_KUNIT_TEST)
>         /* Make sure vmalloc'ed memory permissions can be changed. */
>         rv = set_memory_ro((unsigned long)ptr, 1);
>         KUNIT_ASSERT_GE(test, rv, 0);
>         rv = set_memory_rw((unsigned long)ptr, 1);
>         KUNIT_ASSERT_GE(test, rv, 0);
> +#endif
>
>         vfree(ptr);
>  }
> --
> 2.25.1
>
