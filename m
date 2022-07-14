Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90957513D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiGNO61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239642AbiGNO6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:58:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C305E32F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:58:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z23so3890493eju.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzlS1o4zpkdBg0kf1F9ofQFGm4csN2E2tHeWJuRCCH8=;
        b=DwZj/wwwa4swLjncjyiludhr6VwWG07cQwlmVvVgZCztjCpADIEAb30MvOITr/KA36
         36st2x6Xlu317xrll5fyaZ44ASnf88gJc1Sn2QG4Aif97xXOG4OHA95J6CngG4I0Sfl+
         BQQhsgJT2ucPbs6xXw+rDUZqOHVzrD0iuSCMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzlS1o4zpkdBg0kf1F9ofQFGm4csN2E2tHeWJuRCCH8=;
        b=uaNWfzyk39OG98KcDHfi7DA14mFgw0bdRQb8O2YVvAOXHJWE6NCeHu7Q6Wjj3Hp/Vy
         ENtQGpPqjVwfPoIO2ijV6dH32SWE75PvEGjRfK6XzYbD6IQHMbvn5UoPspKY12zZ+W9E
         Z4GG79BrHVVhLR2Ronn/Y3KlXNkmScnS+IQ8umidbAeEx8XMNoKN07lOfpXONADVlaI4
         sxFWBzZEqeRqrWBrb/H2VUSq/N9LMkpdzvfroBPsW32QMTVD8xPM6RvDhxHicyeJXSC8
         CBMoER2Mc3fYkkJVBUBeQv3pxeHBYzhQy5SdsJc44ST83g2PrIyvMlKJWx5KAFzOEh6g
         RhcQ==
X-Gm-Message-State: AJIora832hXrtrmQXlEmv7b6qU03nV+gvNxnBXb1PxMImtccEFSUKgfi
        EZfnGdw7U7U2QcGqRO+dvYCTQKTrFu9r031o
X-Google-Smtp-Source: AGRyM1tOHuh8r0zDgbiLSWPCfPGn20n3uqJkXe36jQ8U0J2++aiHuNV+H1ZFT5PF2OJr6kMXtKOmfQ==
X-Received: by 2002:a17:907:6e0e:b0:72b:9ec4:2ba2 with SMTP id sd14-20020a1709076e0e00b0072b9ec42ba2mr8247414ejc.300.1657810695994;
        Thu, 14 Jul 2022 07:58:15 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id fq37-20020a1709069da500b0072b55713daesm786180ejc.56.2022.07.14.07.58.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 07:58:15 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id q9so2913991wrd.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:58:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2c9:b0:21d:bd7d:3af6 with SMTP id
 o9-20020a05600002c900b0021dbd7d3af6mr7863205wry.405.1657810694850; Thu, 14
 Jul 2022 07:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220714074958.86721-1-jinghung.chen3@hotmail.com> <SG2PR03MB50066EA3AE8F8E98B67C920BCC889@SG2PR03MB5006.apcprd03.prod.outlook.com>
In-Reply-To: <SG2PR03MB50066EA3AE8F8E98B67C920BCC889@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Jul 2022 07:58:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WjaHsFS4WRcJA_6w9mnDMrUq4rZAzzQ3Qs6Z8TTE8Oag@mail.gmail.com>
Message-ID: <CAD=FV=WjaHsFS4WRcJA_6w9mnDMrUq4rZAzzQ3Qs6Z8TTE8Oag@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: Add sc7280-herobrine-villager-r1.dts
 file for LTE sku in sc7280-villager family
To:     Jimmy Chen <jinghung.chen3@hotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
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

On Thu, Jul 14, 2022 at 12:50 AM Jimmy Chen <jinghung.chen3@hotmail.com> wrote:
>
> This adds sc7280-herobrine-villager-r1.dts for villager device tree files.

You could mention why -r1 is different. It would be enough to say
something like:

Herobrine-r1 is exactly the same as -r0 except that it uses a
different audio solution (it uses the same one as the CRD).


> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
>
> ---
>
> Changes in v4:
> -Add this patch
>
>  .../boot/dts/qcom/sc7280-herobrine-villager-r1.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts

The ${SUBJECT} of this patch is a bit long and seems like it could be
shortened. Unless it's unavoidable I try to keep mine under 80
characters. How about just:

arm64: dts: qcom: sc7280: Add herobrine-villager-r1


> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
> new file mode 100644
> index 0000000000000..c03b3ae4de506
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Villager board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine-villager-r0.dts"
> +#include "sc7280-herobrine-audio-wcd9385.dtsi"
> +
> +/ {
> +       model = "Google Villager (rev1+)";
> +       compatible = "google,villager", "qcom,sc7280";
> +};

You should also add the -r1 dts to the Makefile in this patch.

Also as part of this patch you should change the
"sc7280-herobrine-villager-r0.dts" so that it isn't "rev0+" but is
just "rev0", AKA:

-       model = "Google Villager (rev0+)";
-       compatible = "google,villager", "qcom,sc7280";
+       model = "Google Villager (rev0)";
+       compatible = "google,villager-rev0", "qcom,sc7280";
