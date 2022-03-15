Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566244D9241
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbiCOBZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344280AbiCOBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:25:35 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177047541
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:24:24 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id m67so997950ybm.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HoZ1zKt0q25Q5dal4n689oI7sVmSymRUjK0r4Cr8DIk=;
        b=a4ezsPpowFS0VU5lUTu7aXKdVc9Jm9lgYKeL1/AXXvepgqPlFMhnlowVa6M2mIsYXu
         kOtK00n3qmtrC/0oLUY0idkar/9DvyKvtRcosRldvGlBJzNk+Jrq5idPcxSr8sI8ohEt
         8V/z4JleVtXOxGkUesXsBCmMJ0wW2YIFEsBGvXfD0iM8D/S6fBD+qVqwPSmzuPPN0Tfv
         DMiiDy7ObQpNRpZLaGPWn8vvS0nX71mpVzPPUaMM8uab2f6vNZOHmZPxa4JK1fyHMKBj
         B23K8GCbGl/BvU+3MEVE9RTPU+HC7DSpjD4O8WPM+R50NGkAPjkmHHyiaIxUV0MIvuu4
         k1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HoZ1zKt0q25Q5dal4n689oI7sVmSymRUjK0r4Cr8DIk=;
        b=1I5LT5hgj4ASOF2Pi2vDSz8BrRhbEVXMTvQIaLOJwDHjSsx2RF6jCnceJpPjvAWAmZ
         PTX1Cscb3QaJloWrexm05FluMKD6O6ErS1mlvK3g6QYZtXE8RUvSboIh3wMGePrBg0gp
         4xCArebSwB0RA4TmaAQzTK0uX7x/VdwvJHeWp4TH5BLL7A9qp+060gDOtHn1SujHGY1n
         UbGvFm7S6eW2JcR6y/O+Zq/egkiLMGRJX6r9z36fL+wrDURAuVOgclnjVZhsYDOFTySw
         C16Y17QFHoCMSEPtfTvUd4kzr4wosDuzYHaLjduARAgZnxlM3Eac+Ur/hmNNtlAiXdbw
         G+fA==
X-Gm-Message-State: AOAM530Oco05L/16kEUdYcV86Lz2cJ6UD7PabfOF9QT0+gFLSkGw3RdP
        yHrEk34L26NnQxNtcFnyJwqctAhd0yc4fZBiCwzb6Q==
X-Google-Smtp-Source: ABdhPJxvJ5Bc05j0AE0OHsu+uwzZ9IkQZvREDZzprZnxbKIAkZgJjfiW5rXpmaZTxW8zin0cnxA4j+xOolFipP52fbQ=
X-Received: by 2002:a25:4e82:0:b0:633:68d7:b864 with SMTP id
 c124-20020a254e82000000b0063368d7b864mr3400295ybb.514.1647307463666; Mon, 14
 Mar 2022 18:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220307120234.28657-1-linmq006@gmail.com>
In-Reply-To: <20220307120234.28657-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 02:24:12 +0100
Message-ID: <CACRpkdZ2EzZ1bOcothpxW=9b-qPsCDKwYt_zmEX1zvs+Bs+U1Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl/rockchip: Add missing of_node_put() in rockchip_pinctrl_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 1:02 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
>
> Fixes: 1e747e59cc4d ("pinctrl: rockchip: base regmap supplied by a syscon")
> Fixes: 14dee8677e19 ("pinctrl: rockchip: let pmu registers be supplied by a syscon")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Patch applied.

Yours,
Linus Walleij
