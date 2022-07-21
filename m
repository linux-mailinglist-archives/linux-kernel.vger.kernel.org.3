Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4373357D474
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiGUT6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiGUT6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:58:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4CB7DD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:58:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m8so3482040edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHKWUmFgUfuZc36J9hbJA8Kke1gZwOYkNn4MmRRQ64Q=;
        b=beAHVgvfeXkhJLLqR7EMnPg46bA2u+iFLwngja2Te+ki3gsPMJlt+qGKCn63WN9SLp
         1XWqRoiVTca7Vy9/skOyyqzKasfEB7HFvZsfS6SAcEzZf6jVN4Yu1IcuE4qWWnMHFjBC
         fPVcDvyptwdijAuWxXrvk1ONHaad+BKsTmbTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHKWUmFgUfuZc36J9hbJA8Kke1gZwOYkNn4MmRRQ64Q=;
        b=o/tRblD+1egR2CR7SMxRhUQUsNwK4H/gB9+g2y+6qLQ2loxqJ3mM/yhpSVPuzebvBc
         Axyz91VsfmRl55lfYtfGw9MOa1viYoJ1Hoo/WoYiZCjwG93HmAJBIz/5QLBETpEtF9K/
         rrXwy92L5JBWUR+FE22yqFlfNqohcUM/qKGoUv5WyOyuHBk2Gxw5IyDuLrcpX87lsRc1
         V8p9fuAWJIoepHixDEJYvELqdsHpPaxqyON69O+4nF0UFk4DuXCMIYNNOmTIEXCP6VK1
         a1AnsHdj20DzL/tkuenOBHuV2Hj7x7J42/uDH5dpfR5yW38DcvUinEsQBzYwTMV4UjSG
         Trfw==
X-Gm-Message-State: AJIora/48ucCtCkmaYpdotDDKT2+7JVPK9T0s0Z4AM5iwmeTf/baKX0P
        9CySsQnjj/mXGHFx5Q3R1Bkn8ae8q03l4ytpsmQ=
X-Google-Smtp-Source: AGRyM1vQaPue4DdBLL6EdR8yKDG9paADsvZYYMX8kAvOccg9gghA654BBgXIWu4hyTTlbiH+tl0XeA==
X-Received: by 2002:a05:6402:43c4:b0:43b:c5eb:c9dd with SMTP id p4-20020a05640243c400b0043bc5ebc9ddmr5808862edc.402.1658433515638;
        Thu, 21 Jul 2022 12:58:35 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170907774600b0072b3182368fsm1176801ejc.77.2022.07.21.12.58.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 12:58:34 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id bv24so3754963wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:58:33 -0700 (PDT)
X-Received: by 2002:a05:6000:2c9:b0:21d:bd7d:3af6 with SMTP id
 o9-20020a05600002c900b0021dbd7d3af6mr34835wry.405.1658433513568; Thu, 21 Jul
 2022 12:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220718073104.146985-1-jinghung.chen3@hotmail.com> <SG2PR03MB5006A2ADC6ED22199D8C88D9CC8C9@SG2PR03MB5006.apcprd03.prod.outlook.com>
In-Reply-To: <SG2PR03MB5006A2ADC6ED22199D8C88D9CC8C9@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Jul 2022 12:58:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WTe0ArnF2U43Nmy8Ri-CnqMCssVGcWiPUiLaHzS8zVUQ@mail.gmail.com>
Message-ID: <CAD=FV=WTe0ArnF2U43Nmy8Ri-CnqMCssVGcWiPUiLaHzS8zVUQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
To:     Jimmy Chen <jinghung.chen3@hotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 18, 2022 at 12:31 AM Jimmy Chen <jinghung.chen3@hotmail.com> wrote:
>
> This adds LTE skus for villager device tree files.
>
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> ---
>
> Changes in v6:
> - Remove v5 accidentally added sc7280-herobrine-herobrine-r1-lte.dts
>
> Changes in v5:
> - Reorder '.dtb' in Makefile
> - Put the "interconnects" line back
>
> Changes in v4:
> - Reorder 'status' last
>
>  arch/arm64/boot/dts/qcom/Makefile               |  2 ++
>  .../boot/dts/qcom/sc7280-chrome-common.dtsi     | 11 -----------
>  .../boot/dts/qcom/sc7280-herobrine-crd.dts      |  1 +
>  .../dts/qcom/sc7280-herobrine-herobrine-r1.dts  |  1 +
>  .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 17 +++++++++++++++++
>  .../qcom/sc7280-herobrine-villager-r0-lte.dts   | 14 ++++++++++++++
>  .../qcom/sc7280-herobrine-villager-r1-lte.dts   | 14 ++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts         |  1 +
>  8 files changed, 50 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 7e6a4d7ef3266..bd43d984f69fc 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -103,7 +103,9 @@ dtb-$(CONFIG_ARCH_QCOM)     += sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-herobrine-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-villager-r0.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-villager-r0-lte.dtb
>  dtb-$(CONFIG_ARCG_QCOM)        += sc7280-herobrine-villager-r1.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-villager-r1-lte.dtb

Whoops! Looks like you'll need a v7. There's a subtle typo above.
"ARCH" doesn't end with a "G".

-Doug
