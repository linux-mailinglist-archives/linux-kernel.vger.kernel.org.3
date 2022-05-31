Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0177538DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbiEaJkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245350AbiEaJjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:39:55 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8036392D16
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:39:50 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l204so12230314ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owik/ERIKQ/Xn0y08fcg1q8jOY8cbMmZRyuaUyU18sA=;
        b=lQQ96cMxOA4G9iVLjQ4z6e2m7ZJQpJFgBxCrdGn/ioTtmBrwPLWuH5n8fDoP8/GAlq
         WrFsT2wBmih+5WcNUVwYVfUuC3xdE/uwnVd7D9zQybSFIJu8Yn+KkYCM9mOfy5e2WHit
         7YyYNk6XvJpPs7ZcV/IJHCWxPpXQ+vP7mBOAe8jIu6TneEQW0ha6Z4LKRQ0dSXpWZPno
         Sx42g/lk+HqSaAAeF9geGAOlGAA/i8HoBxIUZH9O37RvveMM9nozLDC4p8bMfbS1+8Is
         ILFHFv1n18ekK70DyNN4VL8spINVIQ/A4NZWL+0C49tdaEDoVVkpOznurGQzq4Wzgr93
         11bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owik/ERIKQ/Xn0y08fcg1q8jOY8cbMmZRyuaUyU18sA=;
        b=rgy0jP+1k3GJHe06ofwIjaw08AqSIVqjQNMclVkfzE6TMLf8ThjlrkBak3Ecwyha7U
         +KIQw42ET5iEtkHRYADPhAp/9y8P81ofTF36jNekxuL3mFqfAiEScWiwAMSLQjBx4TbW
         aVzDvMbQYKQ4/+d6RKMiX8KwC/jFHgIFvP2E3USg0cKMJU8jMER2XcgyWwq1lSWyFCv5
         +GxJHK1KNIzGj9myRmhN05cwXbQLSnO9bibw5cn5UhMqWbly8GVhdaX1BEktDHcLoVZQ
         CixgqI3R2F0nSC2vrm3OfKVhRxpZhOzmMw8AMZavIfYpICNu1WcsRLAXkA8XQQALej10
         tCAw==
X-Gm-Message-State: AOAM531kchSBquAd+xj1jZXnJoSx6WCHJta2CAGVInBgRgFFqkRuAFoB
        K8uDqhoFk1B72FmPAjD6w4lBmo5SBtIdPr3z2QFlng==
X-Google-Smtp-Source: ABdhPJzJ5ytNhC9HvdgLcAnnUu0XWT4XYNnYlfIbRfnZZFTub5PI7q+eBt5ywXskTbAQnXYM+BDjueQa7AkpkbKiHvQ=
X-Received: by 2002:a25:df50:0:b0:65c:e053:3449 with SMTP id
 w77-20020a25df50000000b0065ce0533449mr9534101ybg.291.1653989989529; Tue, 31
 May 2022 02:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220530160753.100892-1-jo@jsfamily.in> <BY5PR02MB7009301398881E89033F1DF0D9DD9@BY5PR02MB7009.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB7009301398881E89033F1DF0D9DD9@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 May 2022 11:39:38 +0200
Message-ID: <CACRpkdZO6yB4SZzMgORv=1LCxbiaabfv=UyOQksn6F_WxgGa=w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/panel: introduce ebbg,ft8719 panel
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Hao Fang <fanghao11@huawei.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
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

Hi Joel,

On Mon, May 30, 2022 at 6:08 PM Joel Selvaraj <jo@jsfamily.in> wrote:

> +#define dsi_dcs_write_seq(dsi, cmd, seq...) do {                               \

Please name it mipi_dsi_dcs_write_seq() and...

> +               static const u8 d[] = { cmd, seq };                             \
> +               struct device *dev = &dsi->dev; \
> +               int ret;                                                \
> +               ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d)); \
> +               if (ret < 0) {                                          \
> +                       dev_err_ratelimited(dev, "sending command %#02x failed: %d\n", cmd, ret); \
> +                       return ret;                                             \
> +               }                                               \
> +       } while (0)

My suggestion was to add this macro to include/drm/drm_mipi_dsi.h, just patch it
in there under the other mipi_dsi_dcs_* functions.

I think a few other drivers could make good use of this macro.

Yours,
Linus Walleij
