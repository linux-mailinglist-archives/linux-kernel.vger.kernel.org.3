Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2904C702B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbiB1O5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiB1O5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:57:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA17F6EB;
        Mon, 28 Feb 2022 06:56:54 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id dr20so598887ejc.6;
        Mon, 28 Feb 2022 06:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMUUaFr53vM+bHQN9bUKQbcGu2hmLlJ8vx029fVzu3s=;
        b=NR36y4Q2atTSVf7gFgboX5vqzYRPo4dL9uOkQe1/yuVnPJ5A1rYmEq5yuA6B/UHV9u
         6Z5q+4JhfUYGh4bTfCJ5C4FNBslgEDm2eC1dCOT8ARa+ngNLSG8YkV5vDR6OhE0hJoBI
         07L5ZNS7H2IIeWDjsYlvHZUGJq1dnXnR6LyblIWxoBrNUgT0mI+gD7vi8Goo7CaQsbrM
         kJm4wxTN0MXEvEIB1FA0XjeBFQ3P9EtVxwKBl7oZ2Cm5GUpyzQgyTaWs+0YDpPENM2J3
         p/aPn+cVKFvdHxtt3HbYMTcRctoiHDtGx7VwI6yLxbEC95x4AeDnTb0ljoTuzn9KIkFN
         STDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMUUaFr53vM+bHQN9bUKQbcGu2hmLlJ8vx029fVzu3s=;
        b=fbc2TFm61BjLDyyZvAsV40xKlJLINreoQqpRLod55D4lK5xL87CjtlzrIg52esd60A
         03mIupcjMxUhqixBLqxn3YGaT7A0oXgTTXbYSdTLdjc5F1Lz3rPQL126Olxs839ntCD2
         gj7EeLXl8GqqDt7Ru8c/Ie2NYEDU7sd3n//D4gKXtCdb8Vmh2IUjpUDiXQ9MAS4++W4R
         ZAhrtD4w3ysGnvIV7kt0AF4nurc3zKHtE/2a3KVAEQ/F6hQdqytz3kjtZNmZgCjo3vrJ
         u52l88ur5MCXAE8wF3R1G8VzANxSM5dh+EML3tF4Pd38BWf++JUxclBeUveo5fPq5iX7
         fwkw==
X-Gm-Message-State: AOAM532dndWquMk7zeRri7kfTadh10ZBMo1IsTONJzLicArDlumUs7+G
        e8xIqW2RYNAd2KMSUab2+3WG3XgkREnSeX+je84=
X-Google-Smtp-Source: ABdhPJy8ekYCFQ22LFX2uOonLVbB+pSg/6+sh9tctiEU7McZq9LCAoxnoIjcj3wtwbSO79NJ6zBGF1vXuGb0X9Zo1Rs=
X-Received: by 2002:a17:906:5950:b0:6b3:65b7:82d3 with SMTP id
 g16-20020a170906595000b006b365b782d3mr15125201ejr.636.1646060212791; Mon, 28
 Feb 2022 06:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20220228100317.59885-1-akhilrajeev@nvidia.com>
In-Reply-To: <20220228100317.59885-1-akhilrajeev@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Feb 2022 16:55:31 +0200
Message-ID: <CAHp75VdUb7cDJY8MNHVDmgtBqkAZ5CskyVsA=7v=q9b8Tm=wHg@mail.gmail.com>
Subject: Re: [PATCH] gpio: tegra186: Add IRQ per bank for Tegra241
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 12:51 PM Akhil R <akhilrajeev@nvidia.com> wrote:
>
> Add the number of interrupts per bank for Tegra241 (Grace).

Is it a fix? Then add a Fixes tag, please. Otherwise, how did it work
before? Elaborate that in the commit message to explain why it's not a
fix.

-- 
With Best Regards,
Andy Shevchenko
