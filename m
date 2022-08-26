Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0819B5A3040
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbiHZT7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiHZT7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:59:49 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB98765B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:59:47 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3378303138bso62001807b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9BayX2iMxBiVznh3pmeqxcevUBf/Jj6vLcyG9kQaCps=;
        b=cV5ssXt0UElh5/1P6RF9tahnjlxXLp2tbEDga11kMa5HGC5KBLt3rnMwjMmeiMun9H
         T45QWVYWiuR6Vu5CsZaHT3JOIge2pywuReHzWGW/Nbt4rUwHdO5IMWMf5qtJ+Zqhdz/5
         gJ8DwkmdKPz9TVwgppm9pTg4XCUstc5/3yJTDgKjSTqneE1y97MLZYIuz2BVXAQH/Fcx
         9V5l6UV8IBPeqicTerooyiCQUISn9hhVHU9RMdntLKw6UybH/mUfDTgWyvhAtbZ/H1SO
         EtX1/tOzc7CBFzXpZNdYkUFnkxA3kOeSsllIwjcQk1mtBgp3sRAS5sbUULf7T2HdhF2X
         QU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9BayX2iMxBiVznh3pmeqxcevUBf/Jj6vLcyG9kQaCps=;
        b=ankZll7WEfKsGlXlygwm97niBDb0VOMUxzBnxcDgz2wJC1d0YhlYosAW7ODiuziM8f
         fiiQPWW49MI4zTwV1dHZuH8R/OjOeDDhLoyMTKecQ/bwLLxLCYU8gcfAJfbviQDYEo8d
         rfFwcPKvcO/AmaEtUiuByj/qQU//zM9k9Jr7cX4W7LLlCLJSLmLZrhnEipgZ+XHJIFAE
         WfVl9Ss9kuxlBnYYmijcaaSHYzH8tbqLuw/kKeSj5OYsL9uGJv+wX+n+BfXwyubrewyS
         pAGcLnaqJ9xxs4rak4fNjDBAMTlHWk1PceUjuDPrjkdK4UOCh6lsNob8XTDTsRuBA6yJ
         3eKQ==
X-Gm-Message-State: ACgBeo27I1JNlz87PIHq18wlz9ArqBoQRo0Hk43ttD2h2NnLSQc6CycW
        n+hfEIRw8zNns17TmKYYMyxAYfAijJyM1F2Q4LaUdHaI6n/LaA==
X-Google-Smtp-Source: AA6agR6QjZNQelPJHf+PFxzLaUy40toWppbFWoUx2wzgkG5djmH3uMyeOC1COzMdJInnfrPOMYxZ/YBk8NYTsK3V+wk=
X-Received: by 2002:a25:db4e:0:b0:696:4b8a:71d9 with SMTP id
 g75-20020a25db4e000000b006964b8a71d9mr1268717ybf.220.1661543986348; Fri, 26
 Aug 2022 12:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <202208221506.0Lo051G4-lkp@intel.com> <CACRpkdYoesPenQizTc6_MRZ14THBSFwyHb7oWJdR+CYYiJYYpQ@mail.gmail.com>
 <CAD=FV=Vxdoo21OQJ-Ad57-gFVcJ7biQipoJqDE2bSpLC2NxrhQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Vxdoo21OQJ-Ad57-gFVcJ7biQipoJqDE2bSpLC2NxrhQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 21:59:34 +0200
Message-ID: <CACRpkdaK+8bropqoRCaEw6KH7ZKRHUwNBPtc-cOojJZt+3S+yw@mail.gmail.com>
Subject: Re: ld.lld: error: undefined symbol: drm_gem_fb_get_obj
To:     Doug Anderson <dianders@chromium.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 5:48 PM Doug Anderson <dianders@chromium.org> wrote:

> Unfortunately, fixing the error isn't the most trivial thing in the
> world. If you just do this:
>
>  config DRM_MIPI_DBI
>         tristate
> +       select DRM_KMS_HELPER
>         depends on DRM
>
> ...then you get a circular dependency:
>
> drivers/gpu/drm/Kconfig:76:error: recursive dependency detected!
> drivers/gpu/drm/Kconfig:76:     symbol DRM_KMS_HELPER is selected by
> DRM_MIPI_DBI
> drivers/gpu/drm/Kconfig:31:     symbol DRM_MIPI_DBI is selected by
> DRM_PANEL_ILITEK_ILI9341
> drivers/gpu/drm/panel/Kconfig:165:      symbol
> DRM_PANEL_ILITEK_ILI9341 depends on DRM_KMS_HELPER
> For a resolution refer to Documentation/kbuild/kconfig-language.rst
> subsection "Kconfig recursive dependency limitations"

It turns out Randy Dunlap had made the right fixes, and I merged them
before you got the chance to reply!

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=84dfc46594b0167e5d3736273b0e0e05365da641
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=eb7de496451bd969e203f02f66585131228ba4ae

But thanks!

Yours,
Linus Walleij
