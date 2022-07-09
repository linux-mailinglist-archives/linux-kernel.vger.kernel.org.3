Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8BB56CBE1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 01:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiGIXFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 19:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGIXFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 19:05:36 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7B7101E7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 16:05:35 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id f73so3249645yba.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szElR8mFW0oJw4wL/YkFxH4pnVX5wiTe/kH9rlsKmNA=;
        b=YWqAHiKxPYP2rDEIH0ZBpN/McfFwUqo4/gEkUzFDychfTL0K9nCn4arnapm794J+rA
         4QoMh8LjbMG9C4Ih2pPj3dAKx4VJbSh/c7mEdoi1lg0KIVzW62oTVnUr0xvM6BgRdfSn
         pxlW1NNS0T6+Ws9LAKhQoPdIvL3fsfEW4+o/nN0fMR+limWjIKruYwOENI+eCpCZ1yzE
         4xAWBB52DwBtXvikaeDje6+T4riPIUs04dvMiD+Xnaks1S2vRMGdWR10t4LLMQcHiULL
         fMC7Ag7zVSIoDMjoxpJskKN6R8aJaCnVxZTKlShwthMryadNiYhFkX58Y4c25pJycRht
         KQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szElR8mFW0oJw4wL/YkFxH4pnVX5wiTe/kH9rlsKmNA=;
        b=Dw5ndylZOI2CFSalNUlMXcapoH5jXhx/9f6JOHG2RtF3vpvczZ9j0wUl+nq7GdmxpS
         uWXs396Byi21uwhMCrrPJfkhANbhv8ypJdLZDjDkCG3FOnSLVp9I4pPtp39P5BKshgIy
         x+2L0Isui18BZ5mxArR4UKdjdvS60Rqu/uRmL1vDf/2Ig0j7tIAJINaaz9hmF0RVa1zo
         8j+J+JJ6G8fJrdxVI8DD5DFun05BKd9OIbXKKK/uzHCchQar/KAawssEkIxyJYFj42jI
         TE1ECQIMmSWVg/CdYAX2pgXb91bgiLrRmmlOiqDOZiapflMeDszg9dO2okag2T95bNPY
         fcCg==
X-Gm-Message-State: AJIora9OYK6BLuhWmbOe7ssTLwbLNFY5Hg1vafGOVnvPEDI64qzNTmzN
        Dq2gipFHNaAyO653V1Ask75Dq0mrdnBP8w2KTS6KVg==
X-Google-Smtp-Source: AGRyM1uyWCBaeTqPo7gQXz29HDuranIxQRGFZ0H6DJli1dXJPgovoIAzDeDGDNsj0sScwXhLjKzet2/h705wLYkr8hw=
X-Received: by 2002:a25:fe04:0:b0:66e:1f8a:8e89 with SMTP id
 k4-20020a25fe04000000b0066e1f8a8e89mr11232850ybe.514.1657407934008; Sat, 09
 Jul 2022 16:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220624195112.894916-1-robimarko@gmail.com>
In-Reply-To: <20220624195112.894916-1-robimarko@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 10 Jul 2022 01:05:22 +0200
Message-ID: <CACRpkdZdccrfA4yHoVjzpsJesYshuP6PjtT=KTeEQgOdXR6_5w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
To:     Robert Marko <robimarko@gmail.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Jun 24, 2022 at 9:51 PM Robert Marko <robimarko@gmail.com> wrote:

> Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
> immutable") added a warning to indicate if the gpiolib is altering the
> internals of irqchips.
>
> Following this change the following warning is now observed for the SPMI
> PMIC pinctrl driver:
> gpio gpiochip1: (200f000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!
>
> Fix this by making the irqchip in the SPMI PMIC pinctrl driver immutable.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Patch applied!

Yours,
Linus Walleij
