Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2F5474F0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiFKNvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiFKNvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:51:07 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B882E1A38B;
        Sat, 11 Jun 2022 06:51:05 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3137316bb69so14734767b3.10;
        Sat, 11 Jun 2022 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIi/KR48LCf1Hz2Cz/+6pDezxkIjhX95zYaLpybh09Y=;
        b=gKtsdoiImvMAjdt8jolYmLjjoL5nKmt7wFj2Hy/7Fo6Wc75aFcSpIfm9DWYwGvXN+u
         gL7J63+aKiOgihEp6oFVgF5v9kIRxtOhj0zIGZYm7JqPBEgM4ZVhPumey4YVoJk6g1fN
         Hlznvz3xCAOZJMHsbChoZprnCfXCpaHliMZDHOgcb1VkCW5zKMjGFfUC84cnjPwUWxYy
         uSf4B6baXr5rBXWliYbL5Lngau/PiG+I4p3md9XiGcy6o8HOtxD4XPUmyrJcZEuZI/ux
         n3nWCQ/qp8hmoG7R8FCkoH5U2Y4GXNXwK9jxif3RHqV7IOOwPlmNULU16p9iSAmvvvV6
         9HsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIi/KR48LCf1Hz2Cz/+6pDezxkIjhX95zYaLpybh09Y=;
        b=5cRZqJ7yoRo8dTWNV0XAwMMpX6zgkgV5txqKW2Ym0BA9ZHCEobrwE2cnXiUerNxYle
         0i5kD9WRpdq60QPCcT1joJBEhJFieTosampqOIode61P6nuOmkbG9nZBsOAPrQKAwWd6
         b4UnYWcAqFZ2F0kTRJgvHPeiG5iqlDKEoENihZFG0PIwL0GtkLh6cA1ar5PhqmUhbvz2
         rD0a42e8m8R1/HtVtKPQ58i97ZJt0c/TZkXMVyveFaiA42aXe/kU+6vWHqxgq2rHXZEB
         TaYzlStfyTjvVqfSm4ZFlFX6dQP3+Nw1j4xy0yOT5YeQEtgSH2gD+nhO/8ivINNQQQAx
         YNnw==
X-Gm-Message-State: AOAM532t0yhwus5Aad0hLOixkVKIObEffxxas9x4xLNcmPc0TePAwsH6
        ZiHjtocdCENE86puRKvY2JY03TmDHVbvh2df5n8=
X-Google-Smtp-Source: ABdhPJyw0mX4zwcIWAZ5xfazDHvtqgj48NkNv3sycBKJaZXGBlQWdOiHMHgR1FUorl6uAIo6XP9y9mOeIj8U7uM5WvE=
X-Received: by 2002:a81:5c5:0:b0:313:e5c5:53d5 with SMTP id
 188-20020a8105c5000000b00313e5c553d5mr3625440ywf.281.1654955464947; Sat, 11
 Jun 2022 06:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220611065300.885212-1-frattaroli.nicolas@gmail.com>
In-Reply-To: <20220611065300.885212-1-frattaroli.nicolas@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 11 Jun 2022 09:50:54 -0400
Message-ID: <CAMdYzYpvtZf8q+7Fon-nj=XbjZ-XQdD-bnY0mdaBxELVad2Cgg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] HDMI Audio on RK356x/Quartz64 Model A
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
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

On Sat, Jun 11, 2022 at 2:53 AM Nicolas Frattaroli
<frattaroli.nicolas@gmail.com> wrote:
>
> This enables HDMI audio on Quartz64 Model A, and the RK356x SoC in
> general.
>
> i2s0 on the RK356x is connected to HDMI, and only has one DMA. I've
> confirmed this with the TRM.
>
> To test this, one needs a video clock, i.e. there is no audio if your
> screen is off. The framebuffer console or something else needs to be
> running to get audio output.

Excellent work!
Tested on Quartz64 Model A.
Tested-by: Peter Geis <pgwipeout@gmail.com>

>
> Changes in v3:
>  - rebased onto next-20220610
>
> Changes in v2:
>  - reordered nodes in rk356x.dtsi to conform
>  - reordered properties in rk356x.dtsi to conform
>  - add Michael Riesch's Tested-by to rk356x.dtsi
>
> Nicolas Frattaroli (2):
>   arm64: dts: rockchip: rk356x: Add HDMI audio nodes
>   arm64: dts: rockchip: Enable HDMI audio on Quartz64 A
>
>  .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  8 +++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 33 +++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> --
> 2.36.1
>
