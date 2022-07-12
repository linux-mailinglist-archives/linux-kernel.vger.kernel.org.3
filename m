Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73382571B43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiGLNaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiGLNaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:30:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D121BB6289
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:30:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l22-20020a05600c4f1600b003a2e10c8cdeso776142wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/sYXMoiNTcLP4oKia5QR42veWinE4cNjWYJuUyBSyg=;
        b=A0HZ3XRjr20kgR1tWrM1jW4cvR2su5kDxMBHTSH67PN2hoL56wN/CnYJXUFc8GHaDu
         7ASpMkJfV9Lc/ylHpcVrju+tH7J3uPDWYhRv8KrEQPbyW7dPWYouM1EhxWOtG45W/+8O
         CaLQm7S3ItQjOLfUts32q9xTtEOVfEPcDbk/C1sQDNOj8NzmDTlc/l5naxoqPWFUtzSc
         bSrp1iq/8tyaWpAv2dRwhY3xA87xtgx45LVWvAl6WrCR90C+/OQ/yAHgPj/hyOW/jjrq
         0OA46fBk/pA5xaU2BhGQNcuzHmVvWVTf1VYBVjJx/vW0GQuZhGgIRXA95sp/y2A+cZaf
         ndRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/sYXMoiNTcLP4oKia5QR42veWinE4cNjWYJuUyBSyg=;
        b=3MJMsIAiLz+pTE6rTXZtUGJhSy9kK47RyKIkJFo7zbxi59PoLFajFYfdQRu/RTapda
         ejNoa6oygfJQbWMl45KyeckbBQz3c+qx9PHX/PmM3WD/4qGb0H5Lr4gR7r/4Ds9Rsnr+
         2RpWtLFj6vVplhH3NYsYSQXE4j6e9p+m+eGMVCoXj66WD/f6tYoRLDCfOKTovRI8dgvq
         mTicj2EineszpFXTDpAPObjqavgNAMgRnh2gE1ibT/ZGlDKP1NqEMuo2ZZwEbc7wOUPj
         AEuJksThlJRTq2rPYPtUgXA4I2ae7ptxe6rjRNNyebeB3pD9zn+nN9jdMHWpdpvSEjFC
         3nIw==
X-Gm-Message-State: AJIora9cmTS6KjBdiolAkf1ug9l1MZampXmc4l8VUGXJis2U/eRHXbPI
        qmArJ+YHXvTdQaArz8OJ73hErrzAJgnGrWmE8hL6iQ==
X-Google-Smtp-Source: AGRyM1vu7DcsXuBkpabZhgZFZXQozrTIgb+hGPIn/6EIEiTTb8/vCysY8izu1qDoJ1sCT0R8dJds1BGPr7eCu4jH/qg=
X-Received: by 2002:a05:600c:4fc8:b0:3a1:99cf:800 with SMTP id
 o8-20020a05600c4fc800b003a199cf0800mr3853176wmq.60.1657632606217; Tue, 12 Jul
 2022 06:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <202207101328.ASjx88yj-lkp@intel.com>
In-Reply-To: <202207101328.ASjx88yj-lkp@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 12 Jul 2022 21:29:55 +0800
Message-ID: <CABVgOSmvU1tOHBQDOr9vT-SSaM1k--mjck1-T-M_vWnDtWecDA@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:shuah/linux-kselftest/kunit 4/16]
 lib/kunit/executor.c:78 kunit_filter_tests() warn: possible memory leak of 'copy'
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Daniel Latypov <dlatypov@google.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
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

On Tue, Jul 12, 2022 at 8:51 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://github.com/ammarfaizi2/linux-block shuah/linux-kselftest/kunit
> head:   7635778bac7e46458392c1261e3916e8e9e86860
> commit: d2fbdde838f270377de4fc20e919aac3941ea55f [4/16] kunit: use kmemdup in kunit_filter_tests(), take suite as const
> config: arc-randconfig-m031-20220707 (https://download.01.org/0day-ci/archive/20220710/202207101328.ASjx88yj-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> lib/kunit/executor.c:78 kunit_filter_tests() warn: possible memory leak of 'copy'
>
> vim +/copy +78 lib/kunit/executor.c

Thanks: clang-analyzer also picked this up here:
https://lore.kernel.org/all/c8073b8e-7b9e-0830-4177-87c12f16349c@intel.com/

(... snip ...)

> a127b154a8f2317 Daniel Latypov 2021-09-14  76   filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
> a02353f491622e4 Daniel Latypov 2022-05-11  77   if (!filtered)
> a02353f491622e4 Daniel Latypov 2022-05-11 @78           return ERR_PTR(-ENOMEM);
>
> kfree(copy)?  Is the burden of random devs looking at this warning
> forever more than the burden of adding a kfree()?  Hard to measure.
>

I mean, it's the burden of not only adding a kfree(), but also a
couple of {}s. :-)

Regardless, this patch should add them:
https://lore.kernel.org/linux-kselftest/20220712095627.1770312-1-davidgow@google.com/

> a127b154a8f2317 Daniel Latypov 2021-09-14  79
> a127b154a8f2317 Daniel Latypov 2021-09-14  80   n = 0;
> a127b154a8f2317 Daniel Latypov 2021-09-14  81   kunit_suite_for_each_test_case(suite, test_case) {
> a127b154a8f2317 Daniel Latypov 2021-09-14  82           if (!test_glob || glob_match(test_glob, test_case->name))
> a127b154a8f2317 Daniel Latypov 2021-09-14  83                   filtered[n++] = *test_case;
> a127b154a8f2317 Daniel Latypov 2021-09-14  84   }
> a127b154a8f2317 Daniel Latypov 2021-09-14  85
> a127b154a8f2317 Daniel Latypov 2021-09-14  86   copy->test_cases = filtered;
> a127b154a8f2317 Daniel Latypov 2021-09-14  87   return copy;
> a127b154a8f2317 Daniel Latypov 2021-09-14  88  }
>

Cheers,
-- David
