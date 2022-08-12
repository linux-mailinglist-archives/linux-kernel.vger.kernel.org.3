Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E40590C19
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiHLGrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiHLGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:47:48 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0573FA573D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:47:48 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id q15so20521588vsr.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=62jXssQzwbkQ8Rmc1tx8vX5eCwUzcdRISHw/EF4b6zM=;
        b=njM+fpykYrXCTza8q/0vYz5xtoWf+ioQhQxNl8tlxQcrWVbiwi6q8OxFbsDCr/yDU4
         jqVKkGkR9xntwwvsJSNXoDpb7d0srEdQfyU1uL6NLID4Pv/sTp1A7ZiNWd++Ty0bm1zh
         9NKHccYi7PEoQnHdWHdd17pbED5tQCWzUUu5UurIPc/iwqrynY4kC1RlUVecsHZLNB/W
         1d00w5RH6Ne33/LuUAK44OeHyhb5zgPkVKzPfkXEbtDCqDi74hKuLTlnshrmT59WsoQ6
         B4ecCyukzezdcYuzY5cE+VrNIODl/Ap5VwAsDlvAnTvidXKfMFelwmAxM1nRHYAvEqMf
         9nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=62jXssQzwbkQ8Rmc1tx8vX5eCwUzcdRISHw/EF4b6zM=;
        b=qsdcGh7UsxrH0WmvOjOmoj6qomijekc9m3upW8kIsK8zPVAKDSPaylG5pSfDuHUzmP
         rfZ2Lwx7xNraCb1zy7U0f5TbU1bfM9ukgUjOR6MhEtXA2oIah4R9qMopnxNqVQ0e9acG
         J03iW2Gk1d37uLzOGy6YMxBgZloQwcsLqNLGBOecA3wdc+QuiLY4I99VKSorAYD8Y1nw
         pVH9PUzgk89agFMGNFH3q4WEnfIbTOwEqWN2y1QheGNGLY5aC5QimuOgZvQBfFEyKHhd
         0U1JTuq8rNx0vVQ8HtKiJsjyzGpQMvOyfqEo708Ap/UTW/gs1e5o407UimSUzB1nzadO
         CjPw==
X-Gm-Message-State: ACgBeo0GP6r66vCCuPfv6DIppnLINmMEmDjGteEj1tDx8MnmWo1vrhFv
        FBoIZdcVxUhkvTJkl1hqtbgNZFN44UjBNyeMVFcVFA==
X-Google-Smtp-Source: AA6agR6bmcSrP/3/JdOUhQzh48KeeHhgXsCC9wAF7H36hpVQ7CZ7oheYdMwjv9v6yQ9Kn69y/OIJFRSb+PjddLr1l6Q=
X-Received: by 2002:a67:fdce:0:b0:388:485c:889c with SMTP id
 l14-20020a67fdce000000b00388485c889cmr1145672vsq.38.1660286867085; Thu, 11
 Aug 2022 23:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220810234056.2494993-1-npache@redhat.com>
In-Reply-To: <20220810234056.2494993-1-npache@redhat.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 12 Aug 2022 14:47:36 +0800
Message-ID: <CABVgOS=rew6uJz_8xYtx5CmTTGraCZMocMyxfpAKOVPah_kAKQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix Kconfig for build-in tests USB4 and Nitro Enclaves
To:     Nico Pache <npache@redhat.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>, alcioa@amazon.com,
        lexnv@amazon.com, Andra Paraschiv <andraprs@amazon.com>,
        YehezkelShB@gmail.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        michael.jamet@intel.com, andreas.noever@gmail.com
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

On Thu, Aug 11, 2022 at 7:41 AM Nico Pache <npache@redhat.com> wrote:
>
> Both the USB4 and Nitro Enclaves KUNIT tests are now able to be compiled
> if KUNIT is compiled as a module. This leads to issues if KUNIT is being
> packaged separately from the core kernel and when KUNIT is run baremetal
> without the required driver compiled into the kernel.
>
> Fixes: 635dcd16844b ("thunderbolt: test: Use kunit_test_suite() macro")
> Fixes: fe5be808fa6c ("nitro_enclaves: test: Use kunit_test_suite() macro")
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

This is okay by me, though it's worth noting that this will stop these
tests from building when CONFIG_KUNIT=m, so that the modules being
tested will still load when CONFIG_KUNIT=m was enabled, but the
kunit.ko file is missing.

So if you're relying on being able to run these tests with
CONFIG_KUNIT=m, you'll want to NACK this one.

There's one comment below, but otherwise (assuming the USB4 and
nitro_enclaves folks are okay with this tradeoff):
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  drivers/thunderbolt/Kconfig         | 3 +--
>  drivers/virt/nitro_enclaves/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
> index e76a6c173637..f12d0a3ee3e2 100644
> --- a/drivers/thunderbolt/Kconfig
> +++ b/drivers/thunderbolt/Kconfig
> @@ -29,8 +29,7 @@ config USB4_DEBUGFS_WRITE
>
>  config USB4_KUNIT_TEST
>         bool "KUnit tests" if !KUNIT_ALL_TESTS
> -       depends on (USB4=m || KUNIT=y)
> -       depends on KUNIT
> +       depends on USB4 && KUNIT=y

"USB4 &&" shouldn't be necessary here: this opption is already under
USB4, IIRC...

>         default KUNIT_ALL_TESTS
>
>  config USB4_DMA_TEST
> diff --git a/drivers/virt/nitro_enclaves/Kconfig b/drivers/virt/nitro_enclaves/Kconfig
> index ce91add81401..dc4d25c26256 100644
> --- a/drivers/virt/nitro_enclaves/Kconfig
> +++ b/drivers/virt/nitro_enclaves/Kconfig
> @@ -17,7 +17,7 @@ config NITRO_ENCLAVES
>
>  config NITRO_ENCLAVES_MISC_DEV_TEST
>         bool "Tests for the misc device functionality of the Nitro Enclaves" if !KUNIT_ALL_TESTS
> -       depends on NITRO_ENCLAVES && KUNIT
> +       depends on NITRO_ENCLAVES && KUNIT=y
>         default KUNIT_ALL_TESTS
>         help
>           Enable KUnit tests for the misc device functionality of the Nitro
> --
> 2.36.1
>
