Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D2154CA43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiFONtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349036AbiFONtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:49:49 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFF43FBE2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:49:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id h27so20641450ybj.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U88w6rJYcyJnx/PiUJFBepiomOwqP/IlAl1ZUElx+ME=;
        b=jJ3LLJifolkoYZ1YfbdVFN+8wHt8g2celG7g1c4F5G7jOrEHq/sEKBkogiMU+yAlmV
         70E45k5zMfIX+LJr1FRtG2V9pWcgV1WU32SP6J18wKxMTBlt48cPYfehNldHyzZJzQGw
         dQ8C5Tv2EW0YMKanBUnNoreZDtTGDHPWZrhJk+bU25QQXgjhFy+E+C1DfBzjmHLPI+/E
         zyBjliyX6QovEvO9M9WVz/b/2yfiI3r/AWgyYoT6tYQRA4DKRFlQlpqPA5FSNIGxYZBd
         OuNZ3xqj8AUDtwNXaO3MLwy+Py19AxS+rU/cdpZ5XlMmsmp0qaPHeDxUORjE2mcPKTZ4
         ulVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U88w6rJYcyJnx/PiUJFBepiomOwqP/IlAl1ZUElx+ME=;
        b=FiUKbUCmo2ivWr0sgEIyA6g2Qzo35J5r/G+ZUgp+L2sCLiWgL14bOXd4x4fTc8YqW6
         G3sRD0eji/s58Il6G4stR7Ha/Wi3APQeZIhK80p8NJPKyC+y8XfFtir5mEZCkVNDC65h
         zukyfDzagqes3c1HCZPa2hTeWWtyyLtLfdGZ5bLdJGfuLoX9F6Gurt7rhgnjqfjiPXsT
         TN92DFLkF2A0z4IM3ljYCPNkIaDQ3Yem0vkx6+wEmtlwm7DGuco72P9YGFf3UJFEcIyf
         DPlkoZGNYek1Picl4NRCUy1wnmc8QM6MvJmKkrtIVgSBdTiMx1I/evdaQZW1p1kP0BEb
         v67A==
X-Gm-Message-State: AJIora88keqnGv9MNKxBvUeYo++1nJNwnGRMc8XXMPdJa1iMqdtsMBK1
        8QXlp3fQhyE1dhHDfC9o1wqDgxhZeNgihdbdmdWvzA==
X-Google-Smtp-Source: AGRyM1uRGcS4u7CE8T+7q54IVeoVZ6QJLPafoXD4TtCs8MF/xkhyj+z422B9IZUbR9Pzir4GWckGrm2ekxu3ik3++Cw=
X-Received: by 2002:a25:3417:0:b0:664:aab3:7c44 with SMTP id
 b23-20020a253417000000b00664aab37c44mr10357824yba.533.1655300987386; Wed, 15
 Jun 2022 06:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org> <20220605160508.134075-8-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220605160508.134075-8-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jun 2022 15:49:35 +0200
Message-ID: <CACRpkdZ-1FZv+SXGTG=3Tj4C7M9RNCASHNz-UeULVmu0z6kNeQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] pinctrl: samsung: do not use bindings header with constants
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Chanho Park <chanho61.park@samsung.com>
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

On Sun, Jun 5, 2022 at 6:05 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The Samsung SoC pin controller driver uses only three defines from the
> bindings header with pin configuration register values, which proves
> the point that this header is not a proper bindings-type abstraction
> layer with IDs.
>
> Define the needed register values directly in the driver and stop using
> the bindings header.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
