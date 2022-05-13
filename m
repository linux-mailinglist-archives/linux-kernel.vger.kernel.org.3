Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461A1526D56
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 01:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344902AbiEMXG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 19:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbiEMXGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 19:06:07 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F426084C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:05:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2feb8eac315so26890997b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20vdP+atjEjZhs5yJgS5YKDTDHHJ9Ifpl/sT0aKWLY4=;
        b=m+j5i6KqT3vzPFbJFYRsLAjZL1f88dlKxieE3PyBGCRC5fENmJJq5KL2nwLE+r4Usw
         KFU7MTr/YV0/GCVcSi6w+xvuXb4gnpZ6SXGuf1Ppm5u5OJlH4kX9wKcf6IAB3YynBhim
         7OuzeTVgvAzbEH9fewdjbBloKzSJ4LgUH4CBq6p3wmNP5GBm7Vt8rmfgdME13K0FXdv/
         oYbDGxVyEdZB4BhihJn3sDaggnAt6GJrbMySkcjanP2zYDs/y5+SAoTWiq2lwZZI8RzF
         YQXvOQi8vTjCWZiERQclgs63hI+tBqKjlZQ1xnnIyIe53ADFoMbIielktYi+PZjOPOn4
         9ZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20vdP+atjEjZhs5yJgS5YKDTDHHJ9Ifpl/sT0aKWLY4=;
        b=RLRDsrKfLUXXG3ASsbUlZ2Njk9CC8ZZuEhOcav3/GmmC1zUaaWBvPOKwzSetU3dDF4
         KtS8n3o/xqsDLsi6vqBsFNe2/+NiqX6RcfUk8EoLIUUohR91KVOy73F4HgtsYSqBGSeC
         GmQoCeNZmtxN5VJX8Q+SdPlQgEV8FSgsPa6giYr343HUIqcTtWwDudKLY7Qzm1eBZafi
         RBj1Q9jN12avShzrUI491sUEh0B2XjOQS/kEM7LUJ+tRu8xxHEyZjm1xdFiYawCZpBlr
         HobjNNcHA9AlGZa6fBLrcjwAS+yQXSIFUbqY+nNo3duwzu4X6afl0EIbpdBF0WYsHMga
         h3PA==
X-Gm-Message-State: AOAM530NGC9ITfwgii2O4o3qBG1GWCQPTSLXm3S+jHQFT2qJCy6cLg/7
        IS/onFrW0IIEUOy2TpXTBwkEtwx0k0ytV8wso847fQ==
X-Google-Smtp-Source: ABdhPJwg1gn4vyXSCAsXn7nzUnuz1q4FEzRjyuG4DMDgINbyOAJx6cpdY0REFXSha0pTwtIuBOdhvRVhGfAgD/v8v0k=
X-Received: by 2002:a0d:e612:0:b0:2fb:103f:4067 with SMTP id
 p18-20020a0de612000000b002fb103f4067mr8515792ywe.151.1652483150531; Fri, 13
 May 2022 16:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_70C1308DDA794C81CAEF389049055BACEC09@qq.com>
In-Reply-To: <tencent_70C1308DDA794C81CAEF389049055BACEC09@qq.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 14 May 2022 01:05:39 +0200
Message-ID: <CACRpkda2AEVf__6neYPOddnjL1=Www=HoHvyNzcBvjua7GeVQg@mail.gmail.com>
Subject: Re: [PATCH] arm: sunxi: fix f1c100s pinctrl function.
To:     IotaHydrae <writeforever@foxmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Wed, May 4, 2022 at 1:59 PM IotaHydrae <writeforever@foxmail.com> wrote:

> 1. change suniv f1c100s pinctrl,PD14 multiplexing function lvds1 to uart2
>
> When the pin PD13 and PD14 is setting up to uart2 function in dts,
> there's an error occurred:
> 1c20800.pinctrl: unsupported function uart2 on pin PD14
>
> Because 'uart2' is not any one multiplexing option of PD14,
> and pinctrl don't know how to configure it.
>
> So change the pin PD14 lvds1 function to uart2.
>
> Signed-off-by: IotaHydrae <writeforever@foxmail.com>

Thanks, fixed up the subject as indicated by Andre
and applied.

Yours,
Linus Walleij
