Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF257E608
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiGVRyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiGVRyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:54:19 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128AE4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:54:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r70so4174662iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ue0tc0adu1W83NSgyETf8DUiCKAIIriUdz0pGaeFGiM=;
        b=h7n2Ohg6jboD5Oevy+0g87C911HBazqSA8cA404DtpQJKvNaWodxAOKcF5pr4LZRwC
         HV1Qu5FqHBz4aiUjc+OzYlURLq6KwN0tLVuixL9qccP9jz46c3uJVI2z0DqcmWIFBuYN
         RA2dnwvZMKZe+2dWiMZVvidUgX9zZuPTVKoyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ue0tc0adu1W83NSgyETf8DUiCKAIIriUdz0pGaeFGiM=;
        b=2YSgcwsHm8+Wja2O14BftkKuSvhTMY+xtHRzVh55nFhQU5IFt9385YWUJMbeWSeTim
         842crBb1V/F51+iuxpnZSSp8kddO+CbrssqpUWcdWyFr5+yW57O/WjhLxfFTYs1M1dHc
         cwSEOTidF21jJmRdT4aG1Pt93Ax3gbAberJqC+pog8tJYalIjwl0p/STLeNS0+YJnh3h
         lLyhJgLLuBt84QiFKtymVuruT5Pd2tQYeKn72gvk6oLWzJpKspE9jOa2gQiOW0Xy9oU5
         +uJUX5Mb95W2qDxIj3w7kHhnW+OgGkqUkWQUD+UxCPft4htckc05hYx7YsGI3BVZLt05
         KJ/Q==
X-Gm-Message-State: AJIora+zItcWiAw6huoYL8CWHdR09hNoL0ADspW+wZTt4PBWKUZnnc77
        izkpn8P3G6Lcr+D457lPYknZ/C1caYQ7Na5Q
X-Google-Smtp-Source: AGRyM1s/TxMaxdS13KzTwKyYiTMg1D0s6ayERW6lbq5QN0mNWdmkR2r5fcJENLdkQzuTRjzBrKg3xw==
X-Received: by 2002:a6b:3fd6:0:b0:67b:d97f:47d3 with SMTP id m205-20020a6b3fd6000000b0067bd97f47d3mr334147ioa.46.1658512457584;
        Fri, 22 Jul 2022 10:54:17 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id 2-20020a020a02000000b0033ea1d9858bsm2236712jaw.36.2022.07.22.10.54.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:54:15 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id 125so4178646iou.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:54:15 -0700 (PDT)
X-Received: by 2002:a05:6638:388e:b0:33c:b603:516 with SMTP id
 b14-20020a056638388e00b0033cb6030516mr534277jav.133.1658512454563; Fri, 22
 Jul 2022 10:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <SG2PR03MB50065D57C3D89C39FA90AC08CC909@SG2PR03MB5006.apcprd03.prod.outlook.com>
In-Reply-To: <SG2PR03MB50065D57C3D89C39FA90AC08CC909@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jul 2022 10:54:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V861t9d0Q1DdYOD1xBcds79WrG=t36Fn2sw9rV=ukQyQ@mail.gmail.com>
Message-ID: <CAD=FV=V861t9d0Q1DdYOD1xBcds79WrG=t36Fn2sw9rV=ukQyQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Add new board revision and LTE SKUs for
 sc7280-villager family
To:     Jimmy Chen <jinghung.chen3@hotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Fri, Jul 22, 2022 at 1:11 AM Jimmy Chen <jinghung.chen3@hotmail.com> wrote:
>
> These patches add a new board revision for device Villager, and add
> new LTE sku for both board revisions.
>
> yaml issue has been clarified in [1] and [2], and 'status' has been
> reordeded last since v4.
>
> [1] https://lore.kernel.org/all/CAD=FV=WtKRFQr5jSQvsr08x9dgHrvenUWWtX_SKuCLuSvSH7WQ@mail.gmail.com/
> [2] https://lore.kernel.org/all/d3d4d90b-85b5-5ad9-78e6-5a074c21af4f@linaro.org/
>
> Changes in v7:
> -Revise typo in Makefile in ptch 2/3
>
> Changes in v6:
> -remove v5 accidentally added sc7280-herobrine-herobrine-r1-lte.dts in patch3/3
>
> Changes in v5:
> -Update subject and revise Makefile
>
> Changes in v4:
> - Add patch 1/3 and update patch 3/3
>
> Changes in v3:
> - Update patch format
>
> Changes in v2:
> - Add patch 1/2
>
> Jimmy Chen (3):
>   dt-bindings: arm: qcom: document sc7280 and villager board
>   arm64: dts: qcom: sc7280: Add herobrine-villager-r1
>   arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
>
>  Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
>  arch/arm64/boot/dts/qcom/Makefile               |  3 +++
>  .../boot/dts/qcom/sc7280-chrome-common.dtsi     | 11 -----------
>  .../boot/dts/qcom/sc7280-herobrine-crd.dts      |  1 +
>  .../dts/qcom/sc7280-herobrine-herobrine-r1.dts  |  1 +
>  .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 17 +++++++++++++++++
>  .../qcom/sc7280-herobrine-villager-r0-lte.dts   | 14 ++++++++++++++
>  .../dts/qcom/sc7280-herobrine-villager-r0.dts   |  4 ++--
>  .../qcom/sc7280-herobrine-villager-r1-lte.dts   | 14 ++++++++++++++
>  .../dts/qcom/sc7280-herobrine-villager-r1.dts   | 14 ++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts         |  1 +
>  11 files changed, 82 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts

We're at a point now where this won't be able to land for at least 2.5
weeks. Given other changes happening (especially the audio changes), I
suspect all the in-flight stuff will get confusing. As an experiment,
I created a staging tree atop the current arm64 dts tree and put this
there. I'll try to put only things that I believe are truly ready to
land there, but git hashes won't be stable since it's just a staging
tree:

https://github.com/dianders/kernel-staging/commits/qcom/arm64-staging

-Doug
