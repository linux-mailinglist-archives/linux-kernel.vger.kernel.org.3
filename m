Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4485A7CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiHaMLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiHaMLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:11:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F154C6B46
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:11:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bj12so27896295ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=N9mB3LeYeeKKsLke6elSgPP7MvMdjqvIVXauRaWV/7o=;
        b=qR63pyLB9nR/0ty9Vl30AcuGCRKsexEsdq9CxvD8rkj5INrVZaWOda9P4qr8p92K5w
         KAIZvfnV2CRbl/C7pXXhMnyrvpAOdHMnI2uGvasnGgZz288rbN2vukDtPsyLff7HzzCx
         G31/KfQVQOk3hfz4yjChicGfj9jVCrlWaLufcQ+nJWVY3NYi0Xr2lP6A6qrRqYGOZf0e
         LC7NQWr4SxdqlVvbP6+FWrg43GLKqP8b2h7CN5/u2PpmC4Y8e+lO9NxGxjsfTGY/SOBI
         16F4r58W03MdBPNdHOCGeVKLN5n0+Nxyzfj9fsoWM35eT+2RCZQBY0W8PGuT6GwHh2cG
         e4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=N9mB3LeYeeKKsLke6elSgPP7MvMdjqvIVXauRaWV/7o=;
        b=17wErzHhAjxpQxI6H/RtzQFkBxRG4bmEGq/klUoJRQbvt/nUlOzvoMFVWmq12GP1xF
         RCWs76/I6SLFK7aXOY6jOTm0qlXGzJd0yLW1bEontKfY16CW6nwcjdA/aSTt+YHA2bD7
         k6x78uqZ8QAJx7tZjQlN2qboBnOb2RC8a6SvvBXpiEg9KJdTMR1N1nSK3JsNoRL5a/ez
         XgiK8IQxhtsKutMDCDCSfrmW6+wOIBbrsDIOvS9SYJutZTWyKBkPFFvGnfFoWw4/4Nld
         K1bN1c3snyz1bSsl3xvrGHEuJhbq15jgm8cozvDHLP9fP4mhOI2NkRbJB2H7XjUhNI8U
         sAvw==
X-Gm-Message-State: ACgBeo3ERIxKPzI2NCYg1Qu5MCImQ2n+F2lHdDCKJdsad5ZBeMWdZJ0h
        ZY95zZM7rwUBaJuGjxmx30RDRPpYxvkhPqeGLW+rjA==
X-Google-Smtp-Source: AA6agR5d5aCYQeq9aXc0ikVnGMt3loQp4a2ilkHtM2rVP4a43+3+ubDzbFK03fIcT8S3PH0dPdKt4acLqApBHqywj9k=
X-Received: by 2002:a17:907:7242:b0:741:770b:dfc6 with SMTP id
 ds2-20020a170907724200b00741770bdfc6mr11141393ejc.203.1661947900641; Wed, 31
 Aug 2022 05:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220824010605.14256-1-jeffy.chen@rock-chips.com>
In-Reply-To: <20220824010605.14256-1-jeffy.chen@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 14:11:29 +0200
Message-ID: <CACRpkdbzcGhUAHxhRon+1iQZOhmU929EwzcasRyHBZc-mN71GA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio/rockchip: Convert to generic_handle_domain_irq()
To:     Jeffy Chen <jeffy.chen@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Wed, Aug 24, 2022 at 3:13 AM Jeffy Chen <jeffy.chen@rock-chips.com> wrote:

> Follow commit dbd1c54fc820 ("gpio: Bulk conversion to
> generic_handle_domain_irq()").
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v2:
> Use for_each_set_bit().

Pretty straight-forward!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think we have a few drivers that could be simplified the same way...

Yours,
Linus Walleij
