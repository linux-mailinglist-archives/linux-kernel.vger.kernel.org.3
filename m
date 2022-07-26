Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0747580E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiGZHmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiGZHm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:42:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE3BC85
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:42:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w5so4296536edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSv0zT3hbYY0NoaOFjUySI9LkcnRa5c63eM0DyOgR4Q=;
        b=v48qZg+gkpnYGsfN7MlYTDVliXJAKPYp6VGdI8Y2dBdBkiObUrhziZXNTpAgxH3jOo
         kkdHUCnkqGzIqUQ23XEM7iTGoJfF9kNgedtLQ1nHp3UpsTqgdY3GeGP+tfjG9lky37ww
         vSpFR6IqM2jfALmsXWMXSKXA5UjGw5UhVVKM8Z43M5YoFBGQPvpssVFPa2fekJNU1uzr
         UWHViRuRA+U1AiWDl4+fsfypztg/fBvvjzg1qjUvtPePxO8eXcYXSNdWxF0KnlgEGjki
         IFkjqKMXqO/GMnyBHrj0m9A5bF0yItHwbMG8kZqSQky5nXcXdop9b/5RrmLBex0l4hds
         bazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSv0zT3hbYY0NoaOFjUySI9LkcnRa5c63eM0DyOgR4Q=;
        b=WDM61aHWhmtHrA2ga+knH+S2XtZKtwpImRyv6ErpthpUZhG84cNSN/f+dk/q+BpLGP
         d0ufGb7F/CZHdCiDrFXBnFx+RioG9P+WmVSwKnR+VfpIjitYLM81v1A7oC7XcnjEYWqO
         WNmMt7AcXSB86FnZOAT/r3D9zro/WHe4Hs1S89bx4hOSn1tvJfkfw+izol6MwQC42B8x
         dql7elGZRim/QzZthd808MmW1S+lPte5Kd++pH2hMS1S5w+udPI7jyMe8ctLEt5gkl0m
         trcbYuHPsQbCsWY+QxcwBMzjHp1SwYQTSX0vhuw/Tt29ZKVeXys3qddYwoII/x4vfxHK
         zoww==
X-Gm-Message-State: AJIora/9qYXt9MH+B2Dq5WebQX6z/Zr3rRdrmH4yxaaiBYI7Z3qwPYbJ
        FfCefr1SiqMth/hFDdfU/AFN/76CfzU63kvyJdxtDQ==
X-Google-Smtp-Source: AGRyM1tTFSZO4tGo0PCUFIhA8WVv02W9uMHhf8OODiEkjWYbUjWku28ujTzToAsX7ym7ilB5OhgyYpvNchLxnLnsMkM=
X-Received: by 2002:a05:6402:2696:b0:43b:eb8b:d0da with SMTP id
 w22-20020a056402269600b0043beb8bd0damr10708934edd.158.1658821332118; Tue, 26
 Jul 2022 00:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220720082934.17741-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220720082934.17741-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jul 2022 09:42:01 +0200
Message-ID: <CACRpkdbmaf1uLqs=k6yyb0twy0hp1izkWuJN-QYPJy1Gg6wJ2Q@mail.gmail.com>
Subject: Re: [PATCH] clk: davinci: remove PLL and PSC clocks for DaVinci
 DM644x and DM646x
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:30 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 7dd33764486d ("ARM: davinci: Delete DM644x board files") and commit
> b4aed01de486 ("ARM: davinci: Delete DM646x board files") removes the
> support for DaVinci DM644x and DM646x boards.
>
> Hence, remove the PLL and PSC clock descriptions for those boards as well.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks Lukas!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
