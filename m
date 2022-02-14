Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237874B5601
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356357AbiBNQWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:22:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356350AbiBNQWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:22:06 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CAF50B23
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:21:58 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p63so20412204iod.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/lXxznWJk6t4L5VwAqaMS0+NBIKS0zk3kQAGJ/1b/k=;
        b=JZLXUfRWra54tioTiu2lrYxDJmGtcUX8NNdySo/F7BWBvDruBVnf1bOydWNgXOogN5
         Iz7arnCufrG1kJ9V7DcoDSRxMCbNRVV3btf8XwNiGUJYm3d1E2eS92/RlK7bOd1VQe5G
         IQJLzFRnqEVjliOJs+NOd9nwMMPcEvNaZXjNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/lXxznWJk6t4L5VwAqaMS0+NBIKS0zk3kQAGJ/1b/k=;
        b=b2kBWfeeZmaDY1lEVEQfmBxy+xvno8Ih9SObOuiSfq1ed7GyvbSJXRNcjfx5LhMGlO
         Hf+9SK0+3VubvqVfwQa4NnKEfwtjrHFpRftWZod6+o6qXnHtBWXkGO847NzMcncpuNDM
         skL8R5wjQg//VJr5sldlyqCq4F+PLS+T03KIXa/qvGQUt4cpIS/Dm2XRI9ji4+TNt9IF
         SEDeq9aNug/UxYnenqvTqWGiIpqkIta7kUw64VYvxggiSVlbXZFAxTk0EOWvwyVhJyJe
         ahBofhuGO4AlNceS2h8fL7okO3DqZlb6Fjj2x4jt/f3DeDxwF9LmlYxUBdSVeoTQV6N4
         eRjQ==
X-Gm-Message-State: AOAM533pMK3ez0S3b5Orkn+HsQ3XlGEUic9cguDJzd/sEqpC14Ax5Yhi
        Di5yiUu9uWBxpB9BJxwuYccsMTb0LBuoXQ==
X-Google-Smtp-Source: ABdhPJxI/6lrvMfTjzQ6e8M8DEhijVmyQ6zbL69JcFlMjbltR9FNFGX28T24a5XGCD8qwsLzM7EVvQ==
X-Received: by 2002:a5e:a70e:: with SMTP id b14mr316207iod.171.1644855718167;
        Mon, 14 Feb 2022 08:21:58 -0800 (PST)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id y7sm13384377ila.7.2022.02.14.08.21.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:21:57 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id f13so12720515ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:21:57 -0800 (PST)
X-Received: by 2002:a05:6e02:19cf:: with SMTP id r15mr119973ill.180.1644855716786;
 Mon, 14 Feb 2022 08:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com> <20220214081916.162014-4-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214081916.162014-4-krzysztof.kozlowski@canonical.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Feb 2022 08:21:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VNarYKq8cZVqWfFKccTqxH46Wmm8Tr979EVsiAoOnT_g@mail.gmail.com>
Message-ID: <CAD=FV=VNarYKq8cZVqWfFKccTqxH46Wmm8Tr979EVsiAoOnT_g@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: align Google CROS EC PWM node name
 with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 14, 2022 at 12:20 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> dtschema expects PWM node name to be a generic "pwm".  This also matches
> Devicetree specification requirements about generic node names.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi               | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi             | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi             | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                 | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
