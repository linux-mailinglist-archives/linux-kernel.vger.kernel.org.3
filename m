Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0353D585
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348970AbiFDEiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiFDEiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:38:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62E3206D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:38:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x62so12465439ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hh4ELzZPJFhmxKWds3g9V2X+IxOzPvS8KSmxMCSqtss=;
        b=YUKSooZoVPXYG42IT9ndGNg7dC1LZpK/VfKSn0j57Z+sy/uNIrK4r7Gg/XCMWo/MXe
         eembK/oUt12M3iUxeSnaBQ5kVxZY/it5PLDSYraoq+49vmEuFqaJXLHFKXJ+xIWcpi63
         N1NzZSeKmfbq5jX7aFzK8yeeG9r1V9tkLi9Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hh4ELzZPJFhmxKWds3g9V2X+IxOzPvS8KSmxMCSqtss=;
        b=0gjtisUOH2V3x5Gg5HIKDciuxVQ8Mi2Rks76L/dmAHC2Y/Bn7ZozJX8TChCWeEu2rJ
         v3sSAcnhfLwvipRr0ZLbJho9AZSNBMKRgLas0C92GwhZjeqM33zAfw9Be1abbU7TZ7BF
         eckb+Ia7hTaDw+BjmtU5PUV3+Ftz8l0zQYO5iLVNFAnFO2b4Lwx/dP5/EEkLuOzLKKek
         4GtCoaNgpcS4hw7Y/ltLDE5MQTzLEZs5WneyYoMwJ2zvDfWlUFjN4kEAZfJcsE0HTFgh
         6eSKnDQsYbg+TYS43c7Tc9TOFJjN6aRF6y/oPP6nKCMDFc6c/7yxT7tFRFYUw5s1MC80
         zj+w==
X-Gm-Message-State: AOAM530hVk/b8iQ+u53CSo2UDYJJYMH1Src7fPk6pa4oUbhoTLrWgf38
        C7ltK6uGY/35Osduxx3y2aE+8Qomtd/RAO8z
X-Google-Smtp-Source: ABdhPJw3JLMro1bfHvHcuDxAGJ6QqMChLvi20p343bboemhdsB7TxgZ5GA3bdTr2JvwZD5Gx7b3lng==
X-Received: by 2002:a05:6402:268c:b0:42a:f0ca:2840 with SMTP id w12-20020a056402268c00b0042af0ca2840mr14341732edd.343.1654317495646;
        Fri, 03 Jun 2022 21:38:15 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id k11-20020a056402048b00b0042ab02e3485sm4863313edv.44.2022.06.03.21.38.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 21:38:14 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so5210670wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:38:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4982:b0:39c:3c0d:437c with SMTP id
 h2-20020a05600c498200b0039c3c0d437cmr7056295wmp.38.1654317494164; Fri, 03 Jun
 2022 21:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220603113908.78777-1-thierry.reding@gmail.com>
In-Reply-To: <20220603113908.78777-1-thierry.reding@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jun 2022 21:37:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVxF5VLFSuet3OrC7u1Gfb-ZyMs4W-KXAc42rXPRWmhA@mail.gmail.com>
Message-ID: <CAHk-=wiVxF5VLFSuet3OrC7u1Gfb-ZyMs4W-KXAc42rXPRWmhA@mail.gmail.com>
Subject: Re: [GIT PULL] hte: New subsystem for v5.19-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 4:39 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> Note that this currently supports only one provider, but there seems to
> be enough interest in this functionality and we expect to see more
> drivers added once this is merged.

So the "one provider" worries me, but the part that really doesn't
make me all warm and fuzzy is how this came in at the end of the merge
window.

And it's a bit odd in other ways.

The DT bindings got the comment "why call it 'hardware timestamp'"
when no other case seems sane.

So the DT bindings got renamed. So now part of the code calls it "hte"
(which nobody understands outside of the hte community that is
apparently one single device: Tegra) and part of the code calls it
"timestamp".

Hmm.

             Linus
