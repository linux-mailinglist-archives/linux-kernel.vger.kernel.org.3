Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25738515B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 09:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382314AbiD3Hoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 03:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiD3Hog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 03:44:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB7240B1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:41:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y21so11378838edo.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwPZKfu//VArF+FVVE8zbUqlSbSrCotry34rYD1+ekw=;
        b=ZoJDMlDRJQ+VhW4am5V169loO6fm7omKdERD77BJM0/JbiBvl70/SdDm5TY397yuf3
         rEj9Abv54/G7Btssc/0oJPXqDQR6m2ex9pM2Vvj1gozMPRCOqqszbxsdNYU2dB1p8Wnn
         AjQnlfHYHjTq8MIksiHY9n0oJn7jSVOR9A+wYn/mKyo5G06maOHup9fFwLUVwA1B/KRt
         HybaxGVyV4LOwi2buaE0z8iOLG0+iAX49x7AgSAG4LQXRHCPHh9ZZ/iSplo5tujCZvFn
         DexN5sVTAt0FKRCFtk+KJY/+qyGDH0cGjOQDkAVGTy2+RygyPTXwDY6N/TsjDXeVviPs
         zU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwPZKfu//VArF+FVVE8zbUqlSbSrCotry34rYD1+ekw=;
        b=fajlXBVWrvH2QG+iqvD140NYvyWwvrHkgX0JGsFCJWuRpSze+hxjwJ+fPZC8Rb1uDg
         uTFxQAG+yX5TOis0XACECL8BcUcxu+/zmajBYks4dPFkt3yy3YFPWADUi5C/XX13z3p7
         7hC0AbYmC1iNsb7cZ6YnR/RkHiqgJay8JjoD37vyLFSaq7qn5k30fGiy65Jz2ZhIMePN
         gLripDrI0qWJIiHqh4TOkDzFfiNOT2T72PZ3ewZtcQLzxNX51+iK8lh/esOOFnAV87rx
         Q+qZcESFRMpf6TbkWoqrQR40/IvAoaDOdoQ9Jtf0d1dEDaINHSZ8ofUSFjr7E8keCzTu
         l3SA==
X-Gm-Message-State: AOAM533nECODPbY9Gm1k15UC0FSiWkwdUynWT6OPc0jJrNhSRFnSXI8I
        5rKy5phk9o5bhE269TLuAcEnGcY6dVibp2YTQEhYKg==
X-Google-Smtp-Source: ABdhPJxR5dUZBHrZwxXS0EjAc8Yo2gFytkKQR0GWsxYatgTIE/NVBNHffKX/m/kBw0qYCP440uqV+fioqmlRZFZG9NI=
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id
 ds1-20020a0564021cc100b004132b12fc49mr3364804edb.118.1651304473460; Sat, 30
 Apr 2022 00:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220429181259.622060-1-dlatypov@google.com> <20220429181259.622060-3-dlatypov@google.com>
In-Reply-To: <20220429181259.622060-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 30 Apr 2022 03:41:02 -0400
Message-ID: <CAFd5g469Q2hF18HXgAhs=3ds_=Pw-s2yw3=msaCucJs-JVFmfA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kfence: test: use new suite_{init/exit} support,
 add .kunitconfig
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 2:13 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, the kfence test suite could not run via "normal" means since
> KUnit didn't support per-suite setup/teardown. So it manually called
> internal kunit functions to run itself.
> This has some downsides, like missing TAP headers => can't use kunit.py
> to run or even parse the test results (w/o tweaks).
>
> Use the newly added support and convert it over, adding a .kunitconfig
> so it's even easier to run from kunit.py.
>
> People can now run the test via
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kfence --arch=x86_64
> ...
> [11:02:32] Testing complete. Passed: 23, Failed: 0, Crashed: 0, Skipped: 2, Errors: 0
> [11:02:32] Elapsed time: 43.562s total, 0.003s configuring, 9.268s building, 34.281s running
>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Reviewed-by: Marco Elver <elver@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
