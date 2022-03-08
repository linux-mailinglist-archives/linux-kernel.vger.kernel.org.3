Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088534D0C70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbiCHAJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbiCHAJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:09:20 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35EC12762
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:08:24 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2d07ae0b1c0so184007927b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mx5hLEqn8My0F+yXTcGcX8saGMYANVTYsACmCpFd5d0=;
        b=LiHV6K7JBJSMYhKhrKF9W2mHES55ZBn8mEURsw17mfuBV4BSev7POOOhRzd8JKyBKF
         paBwZnN+QOzLeUc0+g7vXjBOguhMIuEnf1ZzfLj4rTs40Tnk9H0t9vCr5wE3rHn0D+gV
         EWtZrTqcTGgFWFx7nknKXdOQIhqGEenOZKYB7PKKunlLxXOUMVndrc89oQV6wAgrYTut
         SjP7NBczzWSbkdpJMULm7WEqLrJoggoPCkrhfB9dXfxHFE80l5050MfAK+EirIfJ0ry2
         RulRW9iQLwlKAPRgozIw8dYstsFGH/t5TM5OGhdxL5bZT3gwfFmrXCCO+mzlUHow/h/t
         Gevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mx5hLEqn8My0F+yXTcGcX8saGMYANVTYsACmCpFd5d0=;
        b=fFHBTLYMDJJlprYwsBE68CkY3E1o9A2ivBTIlFde5sb/1GENDBS4yHsCotSlP8KRa5
         my014HXI0guLISgS/Bdj1zjBDO2e6Erx/F4EAEJmaKvOdIHYXg/Pdu8LOirKMTHoiUWf
         K8iTT2IzQvMjhYVqsOkeudFYjyzplVHNNADtOmhYZCqyMakLQCDQDM+w7trHaSBay9OE
         IXpNYsL5yH34CU/vcCXqMW38jGhMWzLgEvNfCdYP//hZnDpFiLiK6MEbGLliDSridwwq
         y3j1CqdWfhLywZFSLYCwaKVYN33l2dkI9FQ65dIRjEyxF16oj07FMAoI1BY5By9M1ED7
         J+lg==
X-Gm-Message-State: AOAM5312oMvO4lyV1vT+sD+RmGzBe98T6qGuC+OQe3WNp3clvRLV2W6K
        wNSXpNvJdJ9J1dxjQmFoCLB4+fIaFS4ptbJJaRYWKw==
X-Google-Smtp-Source: ABdhPJwxi+FboTfWrIvFpQLriAStK9q1fbskER46jhk3WG0eM/a3DZxitYTJ/w20P3pnlqOQ/WkPO91Kvl7D/sPujJU=
X-Received: by 2002:a81:854:0:b0:2db:255b:dd6 with SMTP id 81-20020a810854000000b002db255b0dd6mr11185948ywi.140.1646698103518;
 Mon, 07 Mar 2022 16:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20220307110728.15635-1-linmq006@gmail.com>
In-Reply-To: <20220307110728.15635-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Mar 2022 01:08:12 +0100
Message-ID: <CACRpkdYTZDeumBHewcP79nvVOkHZtKZFecRQHtP4Uqouhzxu4Q@mail.gmail.com>
Subject: Re: [PATCH] hwrng: nomadik: Change clk_disable to clk_disable_unprepare
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Mar 7, 2022 at 12:07 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> The corresponding API for clk_prepare_enable is clk_disable_unprepare,
> other than clk_disable_unprepare.
>
> Fix this by changing clk_disable to clk_disable_unprepare.
>
> Fixes: beca35d05cc2 ("hwrng: nomadik - use clk_prepare_enable()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks for fixing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
