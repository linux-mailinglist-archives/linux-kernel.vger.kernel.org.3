Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AED5728A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiGLVah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGLVae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:30:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839C2C9206
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:30:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so11743580edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uu5ujFc12aNN3GGgqs6/6TW5s77fyJHq00hImXE08gI=;
        b=jp/YuOF9u9ixWxX/FaasM7zJIZ22SD11WXANkZsA2SXcXAqk7mL9xH4XlWADqdZPQ9
         oOQSf0lzznnLakgMnSuhLJAHL6h8LmBH5RFTFVE6i3vmTSJQkDTtJkgqnZP0ltTOMkVl
         ST/MvgqZCH1gUrAc4tD0hrC0e9TNkZ/NCqz2NhpOMuqMDbejg++UlauSXwid1e1gHrTC
         DcF6qNCmyGdBFU9Gub4Og+XCanv/trY/27bEp/WlQZJkJv5pNNkFJMvovd74SzZ9eX+d
         LqkD2bo/bPUDdUTus90upuXoRy7WZrDFsfWjHjOCNBzuDLWHnw3cAsn7QT9XWddnwwV3
         kBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uu5ujFc12aNN3GGgqs6/6TW5s77fyJHq00hImXE08gI=;
        b=ZllGsN/JPevA7rdJm/ahgGC7pnSTVVqIMC8M8n/ujSDVUXqhwAecisxpkHpMxBWtF2
         uZyP/g+fsjqvcMfZRHw/1Ws91qfa6hgJUleMNVDqCwaeQ3sU1nUn4kD0Bq1ZwzH+rbCu
         ege3GyOWZGavOzGRocbupAkem36cwym+VihXOMm/M3Dt6cOwreJAGENYGtT6txkyKSn1
         iasx+6/Nz9EpQv0AjVwFNfYWcZ7iBvR9FGvmSjlSnVgqZKS178F22h8tGWHhU4pRXfQn
         AQobDxn7FPHVBJJPhszVejBrWj1lGvnmh0/1gFHUO1uVHagFldzxihqcE7t3qXwU9idE
         9B0A==
X-Gm-Message-State: AJIora8Dgyx0StLx/OXL+m9Oa4B8327D7hXGiYaZ2jpo8AQKwPejSDtn
        LsIq6qpt1vB2BxN4+eH1U/f2GUB0GhB/MjqF0Sp7dw==
X-Google-Smtp-Source: AGRyM1u5z01hy3Db/V7yac0AKg4gJxLrEynC/5VZC4/iEhjgrrd8swu9Ogii71DuH6u8AeBeQIY6BBvqQvxRat1WNZA=
X-Received: by 2002:a05:6402:4488:b0:43a:7b6e:4b04 with SMTP id
 er8-20020a056402448800b0043a7b6e4b04mr199448edb.202.1657661431987; Tue, 12
 Jul 2022 14:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220712095627.1770312-1-davidgow@google.com>
In-Reply-To: <20220712095627.1770312-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 12 Jul 2022 17:30:20 -0400
Message-ID: <CAFd5g46eTf_9i-JosUKiL5MQ_iTGNw5eO-TpokVh7PJevMztcQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: executor: Fix a memory leak on failure in kunit_filter_tests
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, kernel test robot <yujie.liu@intel.com>
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

On Tue, Jul 12, 2022 at 5:56 AM David Gow <davidgow@google.com> wrote:
>
> It's possible that memory allocation for the copy will fail, but for the
> copy of the suite to succeed. In this case, the copy could be leaked.
>
> Properly free 'copy' in the error case for the allocation of 'filtered'
> failing.
>
> Note that there may also have been a similar issue in
> kunit_filter_subsuites, before it was removed in "kunit: flatten
> kunit_suite*** to kunit_suite** in .kunit_test_suites".
>
> This was reported by clang-analyzer via the kernel test robot, here:
> https://lore.kernel.org/all/c8073b8e-7b9e-0830-4177-87c12f16349c@intel.com/
>
> Fixes: a02353f49162 ("kunit: bail out of test filtering logic quicker if OOM")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
