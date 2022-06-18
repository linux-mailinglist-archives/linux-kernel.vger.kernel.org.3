Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07FA550141
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383611AbiFRAQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383613AbiFRAQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:16:44 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D244E3B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:16:43 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l14so3978889ilq.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUY4IDfHVWw771LXx7m4NTtTCDxzgte6IAjfOYq4YV0=;
        b=Z7sV+UaSj09IY9kA8WmG0cAhyHKUJQzu0VKFQDd35RCeypxP2w5NJwsNUhCgMjUqKd
         SUwKjLrCI+SJgR8B8wx6BKirjcr9zkigekjP4pH4pP1gHiqDd7b/5nG/hrIYYxxMwC+G
         YIU5lBenThrlc8Xox7yVYVZNtzkkY2AEO2kps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUY4IDfHVWw771LXx7m4NTtTCDxzgte6IAjfOYq4YV0=;
        b=d5hyL4kRtjj/KCOi427JMXzdrDVjPt+4nNVG9B+t74/QDgrluP7qv8s3BKeak/7szV
         JHQsCZ1++XWqf9d7yyBwsoFAEHMwGZ+0p+KzClzZWEv1Uo624HEuXD6VBAYHp6bZJHMY
         79PJKynCp+GsVFoL80wOCFrg/z/1+rLLJPf/1J2e8pL5qm2zD7UeSRf9IAvr28kKE5Dr
         9RLN6v9Jcu5e5Vo/FPigv2FWOWSFhD8h8TvPEyGydj5mkv8nCkWqO1FJI8GxcZJ3Hi1n
         8AxtroTwjsEJkxpJM4UXIHybW96H+bNcSZIffio+Zt+JH4ZPL/0eyhNZKEqgY77hoBdd
         VcSQ==
X-Gm-Message-State: AJIora+VbR2R8lQJezmV4WgPPBpurify2XywDFGTSfieoG6Sk1BOxaLo
        qawZdyuqz20V23tj1XNWDJxdS7Yr5bM+tKFTVVo=
X-Google-Smtp-Source: AGRyM1u46bkj7nc5RwtgBfa0LwxzqrRaNmsz6dxDvtbLaeRXT/qvOrUqMtfkLu5n6KIgL2y3HpzcTg==
X-Received: by 2002:a92:d6c1:0:b0:2d1:a99c:de93 with SMTP id z1-20020a92d6c1000000b002d1a99cde93mr7250566ilp.34.1655511402844;
        Fri, 17 Jun 2022 17:16:42 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id g22-20020a022716000000b0032b3a7817acsm2813775jaa.112.2022.06.17.17.16.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 17:16:42 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id p128so6061453iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:16:41 -0700 (PDT)
X-Received: by 2002:a05:6638:3472:b0:338:3aa2:fe9 with SMTP id
 q50-20020a056638347200b003383aa20fe9mr2033865jav.209.1655511401321; Fri, 17
 Jun 2022 17:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220617164000.v8.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
 <20220617164000.v8.4.I41e2c2dc12961fe000ebc4d4ef6f0bc5da1259ea@changeid>
In-Reply-To: <20220617164000.v8.4.I41e2c2dc12961fe000ebc4d4ef6f0bc5da1259ea@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jun 2022 17:16:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFxpBdsp7HN3B_cyq9un8zCH4bhyZXghBuHnixi2jn3w@mail.gmail.com>
Message-ID: <CAD=FV=XFxpBdsp7HN3B_cyq9un8zCH4bhyZXghBuHnixi2jn3w@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] arm64: dts: qcom: sc7180: Add pazquel dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 17, 2022 at 4:40 PM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Pazquel is a trogdor-based board. These dts files are unchanged copies
> from the downstream Chrome OS 5.4 kernel.
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v7)
>
> Changes in v7:
>     - Incorporated changes from Stephen's "Simplify!" series.

You missed an important bit here. Pazquel has a trackpad, doesn't it?
In the "Simplify!" series Stephen made it so that devices that have a
trackpad need to enable it, right?


> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 5cfd6316768c..dc26704dfe34 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -79,6 +79,10 @@ dtb-$(CONFIG_ARCH_QCOM)      += sc7180-trogdor-mrbland-rev0-auo.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-mrbland-rev0-boe.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-mrbland-rev1-auo.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-mrbland-rev1-boe.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pazquel-lte-parade.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pazquel-lte-ti.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pazquel-parade.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pazquel-ti.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pompom-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pompom-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7180-trogdor-pompom-r2.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> new file mode 100644
> index 000000000000..ecedab8d1662
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Pazquel board device tree source
> + *
> + * Copyright 2021 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7180.dtsi"

This is not good and was an important part of "Simplify!" sc7180.dtsi
should only be included by sc7180-trogdor.dtsi.


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
> new file mode 100644
> index 000000000000..5991c94b4aa1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Pazquel board device tree source
> + *
> + * Copyright 2021 Google LLC.
> + */
> +
> +#include "sc7180-trogdor.dtsi"
> +
> +&ap_sar_sensor {
> +       compatible = "semtech,sx9324";
> +       semtech,ph0-pin = <1 3 3>;
> +       semtech,ph1-pin = <3 1 3>;
> +       semtech,ph2-pin = <1 3 3>;
> +       semtech,ph3-pin = <0 0 0>;
> +       semtech,ph01-resolution = <1024>;
> +       semtech,ph23-resolution = <1024>;
> +       semtech,startup-sensor = <1>;
> +       semtech,ph01-proxraw-strength = <3>;
> +       semtech,ph23-proxraw-strength = <1>;
> +       semtech,avg-pos-strength = <128>;


You seem to be missing the recent downstream changes here.

semtech,input-analog-gain = <0>;
semtech,cs-idle-sleep = "gnd";

You had this right in one of your two v6 series. Not sure why you keep
regressing random things each version...

-Doug
