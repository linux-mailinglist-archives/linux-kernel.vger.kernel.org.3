Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456DE55EFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiF1U3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiF1U31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:29:27 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A491277C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:29:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p7so22780654ybm.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VpGH11Guh8rdsh3z058jC9ypnWb3bXPwZ5CJDh6nAbg=;
        b=eMdegjIl2NftbeQfoctOLt/tjssA05O+IhXuF98Nz8avx0rUC0yosIZeB1eZQqE8Xs
         TwCUiJUxxEms4fnuKZ2XsvPP28q6BRuI4N7bTuhWVrSIrvoQ3ElEItPh1QqFatLiTHNi
         vwqAcpw+V+nyP+wPSL0M0yJxyAx7ayv99oFcNKk+tPSi+LMNTisplMKz1jmbEHn4V2+7
         EDYKO62nS/ODLVDzGalFyFmsEfPX411xYCCwBfcgDX1ZhAGXKzPuYLdcB8Aw7tMPM+Tq
         N75V+eJ/DEpZn/obijHtS3itoO7VEXhMoMqI/Aj+E7VvRCv/TnuDB4SAjt9QQR2q1x/K
         sm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpGH11Guh8rdsh3z058jC9ypnWb3bXPwZ5CJDh6nAbg=;
        b=sfq4Onrq4faX61zKmnPB8om27GkEIU4z0PtO24Qi4vlmVuj9MJzYD2zkXae3+WbNZv
         fjsBYbOT5e3EGKz+bHO18kW1Gd64agbt/om3klwuw9unYCYTwJZm4qLv1BBH6D4Y6goK
         tl4jxXo8Pxfj8CEjLR5nLOWZPLJPqH5eKDm1PKQ87P152tVFIUXYF5GtpTgg1Xg1KVxm
         1ZXAiqGiXNkvuyoXAyje8978aQmtw2VCUd2VobQnG3SYv1EBvLmKJdXpvwi07vlF3mX9
         UAIwtVu516EZcOzkg0xuYo/knUus75W+Cmi4BRSOjcxE3WXANBRK+O04459FQrzN5QDx
         0K3Q==
X-Gm-Message-State: AJIora8jU3XSJVD3Qmzpia+5hMDjuyylFScMczj0F3LNvvfCXyUD90u6
        1NR9GR3na/lhilahx6Hbgn67zKEsnXOzuWTh2aNSmQ==
X-Google-Smtp-Source: AGRyM1t1dbyPl6CAg4FL6tR6+dKA5IfRahhFoxfR92PSD1p80uf525mojDabMIcGrcvegRH3Rv8XyogOu2qmNKH0+TY=
X-Received: by 2002:a25:8403:0:b0:66c:a405:a01e with SMTP id
 u3-20020a258403000000b0066ca405a01emr15309604ybk.369.1656448164157; Tue, 28
 Jun 2022 13:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220628195913.36940-1-andriy.shevchenko@linux.intel.com> <20220628195913.36940-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220628195913.36940-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 22:29:13 +0200
Message-ID: <CACRpkdYWFZL+N-X3g=MTJwsn5Hd64wNTeqNDv4r97ur6t_Q1+g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: adnp: Make use of device properties
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Tue, Jun 28, 2022 at 9:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Very nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
