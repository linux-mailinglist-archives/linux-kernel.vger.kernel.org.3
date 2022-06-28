Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1316F55E770
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346962AbiF1Nww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346915AbiF1Nwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:52:49 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D544B25
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:52:49 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31bf327d4b5so28369937b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9upcBG0MMkWjokT486LIbH25iwXepLGTqHnlYogNOEY=;
        b=NcSg2PNgj9jzoGvu0M+Ne6MJkj3SU7Cyyf74+X1VWhPOM/JZ3QtfuYLUlbRYnpUKfD
         j9zSF7BulNjjY5isG6haWnfY7PSEa1HpcHMPmkq7ICp/nQYMN9yns9a4wrNOxGsWIV5N
         fj/TFcRcnckkPIvIFrw4rr6LAWgozasMh2vTJRfQM9v493ghlTY8LrkUiUsRYUsaGCFV
         EcnzeXjBJ1Yjh3LhbHmqq+gaA+NoUMv3pzTU2VH6Rv5En0kSMFODZmIIbplwYUbXSBiV
         dZTTrTa6XY7oLPZGTWGVZxmPV124tcc7Q7BqM9YPsERic4J9U8CzTPOJZboaKIM6WxaT
         c/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9upcBG0MMkWjokT486LIbH25iwXepLGTqHnlYogNOEY=;
        b=keKr136Mxyt5IpGlz1NCC92km+U2VpLfH0Sw62i6kdPmnZaQ/qCHqacHGvat+ZBQgR
         bmPvpRA7U9ONn2/gufvXrGooJOnfsUd75sM7ghOQeCC2XN0i24LZxlDn2qcR4KFwZ3mO
         Uv6UxPJwX5lPqcn0EWv0N/5pKtpwK4G1lD/5v3hfrGOVT6Fw/BpYDasPzZa1x4WDLkJ7
         NDXSNHydewqBPAU70H6nMPlJjjzIltR+Lehoe5zCsNhjJ8Eik3SmNIXTyZQ7bcEQR+fy
         k/57hVOr1XQGIzvieRXGCmWmWJelpM2rIiRjQgY7ZBDFe3ImA71XXE738FyNxqo/+OIi
         0quQ==
X-Gm-Message-State: AJIora8lBf+SdWxzUkNwIxaVErufKjUwkmfTcitHHOJDzYhobYF1QU97
        DR/xCKSq8TsnVMw48lnWL0ukulGJLugJM60LThoI+g==
X-Google-Smtp-Source: AGRyM1svsZstAnVyKZcSo4aSnNDXoorFrsgBhav2DdlBbI8yV5im1Z5GT7JHDXDdnUYGFMbclrnWlsJ6mdvr9wNdUuk=
X-Received: by 2002:a81:d05:0:b0:317:76a1:9507 with SMTP id
 5-20020a810d05000000b0031776a19507mr21678625ywn.151.1656424368411; Tue, 28
 Jun 2022 06:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220613054310.21186-1-a-govindraju@ti.com>
In-Reply-To: <20220613054310.21186-1-a-govindraju@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 15:52:37 +0200
Message-ID: <CACRpkdZB1T1cKQcNDiriCdeQuHGMH-9BvV=a9mP21YENThA-bQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: davinci: Add support for system suspend/resume PM
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Keerthy <j-keerthy@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 13, 2022 at 7:43 AM Aswath Govindraju <a-govindraju@ti.com> wrote:

> From: Devarsh Thakkar <devarsht@ti.com>
>
> Add support for system suspend/resume PM hooks, save the
> register context of all the required gpio registers on suspend
> and restore context on the resume.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Hijacking thread!

Aswath, if you are testing DaVinci boards can you look at these two
patches:
https://lore.kernel.org/linux-gpio/20220507124536.171930-1-linus.walleij@linaro.org/
https://lore.kernel.org/linux-gpio/20220507124536.171930-2-linus.walleij@linaro.org/

I resend them every new kernel release but they never get merged :D

If you can test them, maybe I can queue them directly for the SoC
tree.

Yours,
Linus Walleij
