Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB057956E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiGSImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiGSImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:42:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50BA2C662
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:42:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bf9so23521898lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wnu/3vIy/EyKk8Ed8D6cTFH8iy5jebDSZ/AanZy9t/s=;
        b=do2BHwMsu7F2Z1rq1MpWG2gqnQ1DcjmoS4NUR8B6n3WDVOaTCFynyNxyt7SrK/HPcF
         eAb5C+TWX4ITxCWjvZyUEut0VRjv/liUxMP9/uqWFoPiH51O9kqVxqdyCF1SKGqwRRYN
         T75oPSUR8mkUZG6aiELNof7Cki7xb4PA43XK3eDIw/ZyPZQ6PdJtVOWsvNDuOFYcudfv
         wE3Yw9zDe2wjbyycIDp/TT4XdalYKTI4MVRyYiJB31jqelmjAXki91jHV2sW8AmSfxvS
         IPYv180w7UDXDdWD/sbn6oD/hRfzAk/2CdPpZMP2QLJcmB0Qc1KD24/VnM7zt68lgAuI
         Caig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wnu/3vIy/EyKk8Ed8D6cTFH8iy5jebDSZ/AanZy9t/s=;
        b=zbo+V85GX5Tu4k0FCErjrcikSzGFAgigwzbl2YywkulogV/hou6e2GI3mb7HaIB4QX
         8Pm/hZNQ0M7hpVC0D1Ng0wQc7eEUXCM5ntejsb9bayxb81KDvkAbGQvqgcxeDWLWq38f
         o9MSxDaJbyXH5+M4j34x74vwBN26XdU0xuouv5CVX2R1UcPxyUsK2nFT/0gMwVl4EnV3
         l6naWsS8ctfXnYramOXe1mrzvd/MmL+Do3Rk3YjkqUbY+Pl6J4f3gRaKB2SjEiA0iUok
         IShuSfAKyo93ePeg5owUBG/ct4XTLs56Us+W2JnUyjmr3x5v+Sm5OkZSgZkrTuLAxuSb
         Vmaw==
X-Gm-Message-State: AJIora/nBod5soH3+xQ+adAbjbnx70Yt+TDHS+UEsnpHi5plwW5F2UrM
        zHrkbada9zhXsxgQjjq0SgYtMRRow+iWYCH1Qv1y7w==
X-Google-Smtp-Source: AGRyM1tIw/nL1JsDz+rLmh9KoRcKXbYbJHhm6a4Q9+Si0H00rIVXplg0s5C+t128uWGdB1HIEC93R143WyiOpvIzb54=
X-Received: by 2002:a05:6512:2522:b0:489:daa9:467 with SMTP id
 be34-20020a056512252200b00489daa90467mr17375016lfb.71.1658220126191; Tue, 19
 Jul 2022 01:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220715040354.2629856-1-davidgow@google.com>
In-Reply-To: <20220715040354.2629856-1-davidgow@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jul 2022 10:41:28 +0200
Message-ID: <CAPDyKFo0AcNayzJa3SZOS4HX3tSBPT57Z+h8cJ9i56uz5ympRw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=m
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, Sadiya Kazi <sadiyakazi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 at 06:04, David Gow <davidgow@google.com> wrote:
>
> While the sdhci-of-aspeed KUnit tests do work when builtin, and do work
> when KUnit itself is being built as a module, the two together break.
>
> This is because the KUnit tests (understandably) depend on KUnit, so a
> built-in test cannot build if KUnit is a module.
>
> Fix this by adding a dependency on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y),
> which only excludes this one problematic configuration.
>
> This was reported on a nasty openrisc-randconfig run by the kernel test
> robot, though for some reason (compiler optimisations removing the test
> code?) I wasn't able to reproduce it locally on x86:
> https://lore.kernel.org/linux-mm/202207140122.fzhlf60k-lkp@intel.com/T/
>
> Fixes: 291cd54e5b05 ("mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: David Gow <davidgow@google.com>

I assume this should go together with the other recent kunit patches,
so please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 10c563999d3d..e63608834411 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -171,6 +171,7 @@ config MMC_SDHCI_OF_ASPEED
>  config MMC_SDHCI_OF_ASPEED_TEST
>         bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
>         depends on MMC_SDHCI_OF_ASPEED && KUNIT
> +       depends on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y)
>         default KUNIT_ALL_TESTS
>         help
>           Enable KUnit tests for the ASPEED SDHCI driver. Select this
> --
> 2.37.0.170.g444d1eabd0-goog
>
