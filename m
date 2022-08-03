Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2225589353
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbiHCUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiHCUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:35:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540925B7B9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:35:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y13so19459842ejp.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ut3pi8cayU++0GSGO54GljP1BR6nTHkf4mesrBKLYYA=;
        b=Ig8uG7D7SQeo3AQ8b8GvGsJyHUlyGNbXrjLnJsGssVXhbRpS9Uhnjw1fcV0EkPhRXO
         takrvQM5C1AuVQiSbWmBKV/dbWhOzBYicDIuZBssniivGUViQ5aAJk8/5g5+RLJoQ+4u
         ESp/lyA1Y0abiRNY6EyVarzn1Xw6U+CGh2cuUhvJfgrU1D9fhswRbarZ2jrGdUrVJf84
         gfEl4QKSLvRePRYhGb5YGqc10Ihrv0FShrARKau4lFvB1u0FUt42chEClh5Vh0L47j3R
         oDxH/Oibm2MTwlKqCLtbP/hC4/q5G6lWtrmZaafX9cDqJjkX1pzz8kOpdU3mCKJyEE0b
         +hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ut3pi8cayU++0GSGO54GljP1BR6nTHkf4mesrBKLYYA=;
        b=dgxlY/qDvA1zN3YDBT0F9K4js56rzGk8NJRrB91RjamIFVP1NxG2mU+cvEhuBn5/Ak
         ukxXYLFzYbl1iX0R2Xif4CW8lPX8dWsmt/VuCveCzOdjWRDoHvM7mGQv6ZZgkVeVQYi1
         NA7GWQqD/hDy3Bfue2+mS7GFIa6s4oKBE6CiRJkIdPL8FH/O626upGmq4pmo+nYfpWtk
         1ecNGzNPLSuXPlURMbvSwXMSDs7YA3EvDHrFfmwDs+EBouFG+tCJ2k6lmTPu9hsRQyKg
         o84t+oXM+W/5yhYdO0haMi/wRc3YUIMef29lURyW1ME0l5TO3XyKiYbe5I1uDm2vK8Ea
         GwdQ==
X-Gm-Message-State: ACgBeo0OL8GXL3EBXXG/jDC57V4W5CaX6/p9p805OsJ5yFKZUBO5ooSj
        mrLlSwKCiY64HMBZB9c8sMx/X0pu4SEug/BmwfMS8Q==
X-Google-Smtp-Source: AA6agR4rci+47W6uIwtnAZ4XTxeilLBmi8neIg2vdL5uiCYrUmfa+mIzMW+SHI5G4zdbCyQxdDEp36YqTxz6Ne0Xmo0=
X-Received: by 2002:a17:907:9726:b0:730:9e04:f738 with SMTP id
 jg38-20020a170907972600b007309e04f738mr8431225ejc.631.1659558944675; Wed, 03
 Aug 2022 13:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220715040354.2629856-1-davidgow@google.com>
In-Reply-To: <20220715040354.2629856-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 3 Aug 2022 16:35:33 -0400
Message-ID: <CAFd5g44h5viRSA_CU=4A0bPyj8yxQ8KgEVHKb=-JZENQwaGEnA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=m
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, Sadiya Kazi <sadiyakazi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
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

On Fri, Jul 15, 2022 at 12:04 AM David Gow <davidgow@google.com> wrote:
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

Acked-by: Brendan Higgins <brendanhiggins@google.com>
