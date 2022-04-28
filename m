Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B1C513ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353096AbiD1W7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353087AbiD1W7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:59:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0DE2AE3E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:56:04 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i38so11562205ybj.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZ8/ZHQt0GRQpJww4lct7d21fcaHvDESbeLqhd2I1bI=;
        b=ucuXnzehNcoNaIFz9y++2PCcsmNoxYh67Y2KFZNW1unHKW3FnmC4jzYOewXM8Y7g4i
         RCw2dTbN99FjrpiObL5fMg0NrgNqjjIxJ5Po0XBvbzx6JzwvnJ8DVM1zIs5zlD74E1q0
         m1O/Hbi6ojuQ+0olAjqTdPvqAkMZ9yZUPWgFNvaDvkofZjKTwao9BpU8U58p7Ha3ctLs
         Myce8HelYJRSbfctgbvNmZpVc9HR27CkzBi+prypXnuk44E85VVpxCQxnGUTA5Ry6iWf
         5XGDUTo34p7wqyxHe6NPQzmfgS+/lpiLoDsVYKk0dhjZWwIDojmNRq91DoVwj1LdSjIR
         axBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZ8/ZHQt0GRQpJww4lct7d21fcaHvDESbeLqhd2I1bI=;
        b=dOSv/9yVNiVU/047pt0db5Y8DQyY7ggFaIc33uBd2v0rqdgq9wB4yINVKTPBMG5l6R
         y4e5VA0xf8TpNPMj0yQ7CalCuU0iB2akEvCau9Lr9kUpwvVspOtt9veBKdFMXlQoLK0k
         +extdJiyNM0QeJZH8tMt5zdtGkfnlSaK3pCpb9eE020kBZeRRPtm8XFB/oWVrEPNRi4d
         zqYo9S4bZafujp6GlpOOm+dHQucEe0CQkajGk/KTs9LkmukNIRFq/FIiCdKd77rtDrlh
         pKGZe0chxH2fzVvSA/ETL1C2oPfl/gvRXcYjzeWedkBdi+5Ted8sMPQ6vkgbZn30sNqC
         a5WQ==
X-Gm-Message-State: AOAM531w8ngCfb0Gi/L7FeIvkSzx9lvtQxvAiKRS5fdBd8tu/YrAeD/1
        2jcxO7w4iZ90UQHQ66D3Pzvzw8QX4D9cdiY6SpRK2Q==
X-Google-Smtp-Source: ABdhPJyhJ2SNA8+s8ZqNAY+1RfMSxJ4alux7Fu+Nxl0Epn8PePLV4XNSQZmCWxbE/uh/DAjUC1b9me8wZwZ/ybZMEvw=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr21465149ybi.626.1651186563960; Thu, 28
 Apr 2022 15:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220422170920.401914-1-sebastian.reichel@collabora.com> <20220422170920.401914-14-sebastian.reichel@collabora.com>
In-Reply-To: <20220422170920.401914-14-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 00:55:52 +0200
Message-ID: <CACRpkdZXuLPpgKcM_OU+Xewuuq6zGJek0QXAT1Xxn5fcZofJvA@mail.gmail.com>
Subject: Re: [PATCHv1 13/19] pinctrl/rockchip: add rk3588 support
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
        Jianqun Xu <jay.xu@rock-chips.com>, kernel@collabora.com
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

> From: Jianqun Xu <jay.xu@rock-chips.com>
>
> Add pinctrl support for RK3588.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> [merged in downstream fixes, simplified register lookup logic for better
> maintanence at the cost of a bit more static const memory and fixed some
> incorrect registers]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Patch applied, unless Heiko does some loud protesting it stays
in the tree.

Yours,
Linus Walleij
