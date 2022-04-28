Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039A551382B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346813AbiD1PXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiD1PXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:23:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1175E241
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:20:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so10229101ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KK0oOt6tLl8qviBpPxZTlU4vCH0knOLsx36mHAlT6lQ=;
        b=hobi6qzldDfJZ9JO2M31Iij9Vk0MCdxX/g/ZxjRTOwC71zomr2LAVZ72xxu23k6QMr
         BzsHAysTO/zmBS6Gy4Pk58tUeavMruHU41mr4Hj1JDsxKLoEfSXwBFZCCQFb3MvA4U2U
         sTRUcMk4GmEE8c4/K7qEonnyFvoBezEpXBUz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KK0oOt6tLl8qviBpPxZTlU4vCH0knOLsx36mHAlT6lQ=;
        b=y25NSDNqLq3VPFHna39j++jySDurvGsK4zE4hS3+GS1kp/oavtHGnaXQzD9GZf0KTj
         5LdSa+0SNnJW6BmQhaUlykUb62i2rOBsftLN1ptFO7F7fwqC2h8FADBhiwrvZhuZOfRn
         BmcvQSO7I09GQ/R5LF0jDa+y0OjxqRW0PtuDc9N3c4JbvgWvWBExgbubpsxdIyrCQRpn
         nPmaTo+8Qr3giC0eq06/DnBnj1BZM7h1YyX8tbmIvbvqH3fuglMV98IfSEQqNqeY8lkC
         kddHdv/j7G2kiXuvxYfldDmbtYz1o/B5vs+Kms3DRqW/XD1hMJgYKa6086l43czWbwM8
         vVAQ==
X-Gm-Message-State: AOAM530MF/F+F2dJi4oKBCAEQTNWcG+6oJUzlcXSrxsiu83Emj2KXPM6
        t5x/obUR+zsXYHtDSGjmxgah8eE0fenGEf8e
X-Google-Smtp-Source: ABdhPJxFduYGQYQAfnSXoBku6NyxSbb59fcp1RGe+VPug6BZ02XPlBNawNADwa8FmJQEUCm3+qcN3w==
X-Received: by 2002:a17:907:3e11:b0:6e8:cccd:de80 with SMTP id hp17-20020a1709073e1100b006e8cccdde80mr32021509ejc.162.1651159202188;
        Thu, 28 Apr 2022 08:20:02 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906088f00b006f3cea6b85dsm103393eje.42.2022.04.28.08.20.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 08:20:01 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id b19so7202686wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:20:00 -0700 (PDT)
X-Received: by 2002:adf:f50d:0:b0:20a:e096:ef with SMTP id q13-20020adff50d000000b0020ae09600efmr13733028wro.679.1651159200182;
 Thu, 28 Apr 2022 08:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220427161717.v1.1.I300757d61810c5e9aa60ff964d09251cb4422c73@changeid>
In-Reply-To: <20220427161717.v1.1.I300757d61810c5e9aa60ff964d09251cb4422c73@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Apr 2022 08:19:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WwN-mANNGK_2Lo8u0kuBcG_UOLdKQVfxEVpnmn0pMbTQ@mail.gmail.com>
Message-ID: <CAD=FV=WwN-mANNGK_2Lo8u0kuBcG_UOLdKQVfxEVpnmn0pMbTQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7180: Add kingoftown dts files
 from v5.4 branch
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 27, 2022 at 4:17 PM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Kingoftown is a trogdor-based board, shipping to customers as the
> HP Fortis 11 G9 Q Chromebook. These dts files are unchanged copies
> from the downstream Chrome OS 5.4 kernel.
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  44 ++++
>  .../dts/qcom/sc7180-trogdor-kingoftown-r1.dts |  17 ++
>  .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   | 223 ++++++++++++++++++
>  4 files changed, 286 insertions(+)

This looks reasonable to me, but I think it would actually be more
convenient to send the support for the 3 boards you're adding in one
series just to reduce the likelihood of conflicts in the Makefile. Can
just include all 3 patches at once and call it "v3"?

Also: for future reference, the first version is usually not called
"v1". Usually the first version simply has no version at all and then
the second version is v2. In patman you simply leave "Series-version"
off the first patch that'll work.

-Doug
