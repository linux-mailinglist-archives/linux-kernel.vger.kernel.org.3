Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1705513EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353082AbiD1W6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353064AbiD1W6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:58:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3DFC1CAC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:55:00 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id m128so11633264ybm.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgTFMUsq9gVZz59+3kDOySK+OVbeH8W2pPDccjzuXKE=;
        b=ov2q5f2yE12o/uS00CPcFLtntiChTcYemtbGaDmhDAusLUIMEjB4VaNqGcC3WNcCPd
         L7yYE9xuB/7zZyKq9VQCxp2jIFB8CR7OFU5ZyhIOoVX3kFdYNID85+1a7J1f7sxAjjtG
         W7h8rWHl0hDVgXzxH0vvYzqteazALEC74JXOYii/DLzplO/NYZ0Lc0/ot+q4NvVAqt/I
         YIiJgCRu8Bb3hGo76YEBHfVL64mDFlBZKDBoB33icT3OC/SkBRmpCz6Nglkboa6ia0jE
         dDwfvH+RJVmQAqLIK8xM+VJl3XthUy4h6wSYEuLNngxFj+VdGOtvJcl1oBXwOwCsjeKl
         KreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgTFMUsq9gVZz59+3kDOySK+OVbeH8W2pPDccjzuXKE=;
        b=D2EsedcRAvU64WAn6/AeOTWiSOohn6drN4/TBQnWxT58Xk7lJH+emhMQO5UMdsRdPi
         x/+dL9uHKuJYsh/Tmc925QuhckjOkNQDDuV3OGoEYB1bNH/QrH/M0VT1TCYhp7zsU1S/
         aGHDeXDlIj2mh5F0YZVSFLipgpR56yv2GN/i2vqp+3TQEs/sIOLXEes6NjhQDBCdtIJx
         Qqap7zyFQFgCjycq1s5hXu/c03jXyy018cg3M3s3MMWuGISmFC8WE11C/sNVWtfAAxGi
         CNiLfxV55tRPf8K6m0EBf1igDI2Y9qgRju4OnIvWIYgWHJZb1Jzj5qZ0gb+0C5wVGNAH
         z63w==
X-Gm-Message-State: AOAM532LRiJh3SfsTj0CwTt7m4m5aU5kiwb+p1Aw28MLBQOMhJYr1UWV
        i0sLmD/u3DyOvt9GpIb6yQH2qw06MVgbM0ci84pvJQ==
X-Google-Smtp-Source: ABdhPJzzpmlI/Pkjo7HQbAq5Q2zszomNzPfs/JPPXY6KHrXgc/mt8oB2lus+Oi/UtX2SN9COoG/Tm2fMjSmMEsomV1M=
X-Received: by 2002:a25:bcc3:0:b0:648:7360:8e75 with SMTP id
 l3-20020a25bcc3000000b0064873608e75mr20334083ybm.533.1651186500208; Thu, 28
 Apr 2022 15:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220422170920.401914-1-sebastian.reichel@collabora.com> <20220422170920.401914-13-sebastian.reichel@collabora.com>
In-Reply-To: <20220422170920.401914-13-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 00:54:49 +0200
Message-ID: <CACRpkdZZGXMV5cnZpdat1Z_22CZE-gGfCqRHpOqnd_asw_KMwQ@mail.gmail.com>
Subject: Re: [PATCHv1 12/19] pinctrl/rockchip: add error handling for
 pull/drive register getters
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 7:09 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Add error handling for the pull and driver register getters in preparation
> for RK3588 support.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Patch applied.

Yours,
Linus Walleij
