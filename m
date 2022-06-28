Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F97A55E3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345934AbiF1Muw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344674AbiF1Muu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:50:50 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA34D25C73
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:50:49 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id o19so15486792ybg.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKtbEKOV9+zxoYN7EqIqx2vBNUtMCZigc7ffTBcwK8Q=;
        b=uZQymZCXoreVQDP9VaH5Xu6aY+TbA8g2WWt5B/nYT7gbNB4zf/Ez+BG3D1cvwU6Cye
         FhffW+Jun2H4wr4FzmyE5wEbsgc8X2+qfdJi25On/ceZOfSAmsFkh7x8EPc743UfJzmg
         37e0RA531885F62iRwQfmeIdod/WdziDha9TWbGSJv+2Vdojy/oUBFgwm4gj5QJ6mKmW
         HuJnBZN5byJWVxA483jTITjGJSfIRDtd+d83EgmmCsnpw68cNNtmA0Gol3O3wfvzAmxr
         sAendn0UvAkmy/w7TiPTP6XcRlZ+fbhBvDV9EbrxaTHvCOk5bC19Xo0SkFt+uqJ7pp8w
         cNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKtbEKOV9+zxoYN7EqIqx2vBNUtMCZigc7ffTBcwK8Q=;
        b=5m4oaEiwpn8EGxHS3MoC3As3Lg87XMing19n0rA2zE78DBsNWfDKggPUybbsi6NG9C
         v41IsgFQK+Ff/F4B+MS13rMyMzhYJ1LY1tnXKJoAQWVqkoUQq5MeE8aAMzQAWKHNJT/Q
         lcQDZ3djVSNMLaNMAyKQbQOCjLf1rxFDrw6x44+syTTt06cviEw7rbStRowXXLDOQL9b
         sFd1skB1dZNVVFtcXeX5ZIRVuI8DvzkzhHwDxjnqDliw5KNFdmj1d1zehtUfJcjN20PH
         04grF/5xbUOrVNDQkwW6+nzG45avAF1koZ0HxP1cMN/6vf7BhiNJy8Y5MHtQBl5MnnX3
         SizQ==
X-Gm-Message-State: AJIora/jwma5UUSekA8gZ4FwPsVHh9VaNmReBR6v/gTWii2ZC4DfqlEE
        ML06BAwtAUrw4bVEuKdl4KIWKHG9Gxrd/vUOWahjcw==
X-Google-Smtp-Source: AGRyM1te30st7VzTtroBHMaObPldx28Rm8JDULA6wS1L34yCcbwSW3ugPqxB3BN7D2zbOq+l5/oaQJD70zuDZLMm0RQ=
X-Received: by 2002:a05:6902:152:b0:66c:e116:6a7 with SMTP id
 p18-20020a056902015200b0066ce11606a7mr9403248ybh.533.1656420648733; Tue, 28
 Jun 2022 05:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-3-daniel.lezcano@linaro.org> <f4b13249-abe8-080f-4d36-24ef67d4fb62@linaro.org>
In-Reply-To: <f4b13249-abe8-080f-4d36-24ef67d4fb62@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 14:50:36 +0200
Message-ID: <CACRpkdZBUVGP6whu-ojW9KKapeuYKQbXWn1MEpJ33KFav+8zqQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal/drivers/u8500: Remove the get_trend function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:40 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> Adding Linus who is missing in the recipient list.
>
>
> On 16/06/2022 22:25, Daniel Lezcano wrote:
> > The get_trend function relies on the interrupt to set the raising or
> > dropping trend. However the interpolated temperature is already giving
> > the temperature information to the thermal framework which is able to
> > deduce the trend.
> >
> > Remove the trend code.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I certainly trust you with this :)
Acked-by: Linus Walleij <linus.walleij@linaro.org>

The code was originally written by Hongbo Zhang, but co-developed
and tested by Vincent Guittot I think, so paging
him as well.

Yours,
Linus Walleij
