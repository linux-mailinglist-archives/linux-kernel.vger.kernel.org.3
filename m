Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C23526BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384492AbiEMUkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384489AbiEMUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:39:59 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ED11BE12A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:39:57 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id j84so6410476ybc.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjgsJyomaG9QQtE3jbFFKe/5rvj6syuow/ZH8n5yvJ4=;
        b=SQoFqGZkR8OJQ0Qk63dN6u8KZ6fGMmX6HLbVWIW46XqaVncbFbTDVP9cdiNDF8Rx/D
         WHT7hM6yG5Ja3/APJFYAliXvVtbW5HdfL+mBQgLhAYE2KGom/m9srR1otUd/jjymzi7N
         enIhThFTnZLdAgcq2IbD5PxYIagJ5EtxK0/v0a5Y/Zw05uI9+cSDpSCoRPue6ht09eni
         yptXjDz3CYCwtP34zBKm5VInN3wkF0uonNI+DuaMzjSTHJSvuJaBWZh/aG+fWtNMlJh9
         doNK7QZ2aOhX3wYSA4XJdgITh3XvxexMRA+Q3rrmOLo10t0QbM42+rpxw87Y/V7qY6Ht
         BdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjgsJyomaG9QQtE3jbFFKe/5rvj6syuow/ZH8n5yvJ4=;
        b=rZnHnZOSpj4scpWPI+/gGSbuIVeGA4JH1WzlaI5X4yhp/t2SYbsQqqmWVF3lQrxBLZ
         aafmIfxP2etorZeyBaDXPxxz+c6zfr3VH94sboe2OI544pyxNMb5vBhMVW99dRsBazOW
         NK8iKHE3mudNb9m/yhG1Fuqj4MVb6g3QhR3DdZCLoEozr0gPmTPTxf1aJ3WS56LwMJe2
         vRmrzhj4fMuLSznqEIIPzG3yoKpDDd9fdR3wmTQ5wG6YarjLL28zytYkmsdMTjKqrhU7
         Z+DAyeljvG+OqAx4z2EZT7VsDGDM1nmOFA9OvXwq+X1UoWc6oeh/fMpbFXWS1qo7OSWc
         9qhQ==
X-Gm-Message-State: AOAM533ln6Vc6fPPndgjhYdKbaAw2zFupTOizSOXiAM3Pv7Q66ek+cWk
        Y7yU3pj0PKKOZQp5a9QVJO+wa5yzxOGh3ESKbyENGg==
X-Google-Smtp-Source: ABdhPJxqWNc/BcbrWALPfb9mCeCOCpLqwW04ceOHeKLE9KROovikbSFRNij1NE2lfz4+r3R3/cUkmXIQUrDYhhomyZ8=
X-Received: by 2002:a25:1f85:0:b0:64b:a5fc:e881 with SMTP id
 f127-20020a251f85000000b0064ba5fce881mr3813638ybf.514.1652474396907; Fri, 13
 May 2022 13:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652245767.git.jo@jsfamily.in> <BY5PR02MB70098FF9BDEDE264B78CFCE0D9C89@BY5PR02MB7009.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB70098FF9BDEDE264B78CFCE0D9C89@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 22:39:45 +0200
Message-ID: <CACRpkdbvv6FcdatAPdTq4fmzgXyr-SjYEwuc_sT+152DtqhiUw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: introduce ebbg,ft8719 panel
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Hao Fang <fanghao11@huawei.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
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

On Wed, May 11, 2022 at 7:28 AM Joel Selvaraj <jo@jsfamily.in> wrote:

> Add DRM panel driver for EBBG FT8719 6.18" 2246x1080 DSI video mode
> panel, which can be found on some Xiaomi Poco F1 phones. The panel's
> backlight is managed through QCOM WLED driver.
>
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>

I see my review comments on v1 arrived after v2.

Nevertheless, please address my review comments on v1.

> +struct ebbg_ft8719 {
> +       struct drm_panel panel;
> +       struct mipi_dsi_device *dsi;
> +
> +       struct regulator_bulk_data supplies[ARRAY_SIZE(regulator_names)];
> +
> +       struct gpio_desc *reset_gpio;
> +       bool prepared;

For example that means to drop this prepared member.

Yours,
Linus Walleij
