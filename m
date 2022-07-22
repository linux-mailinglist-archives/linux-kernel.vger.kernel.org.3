Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F146157E2EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiGVOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGVORY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:17:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C4A025A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:17:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mf4so8864685ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOFvKfEIVXIuCG4wFkll4Xj+8m/Jo4dyU0NBpZKLOaE=;
        b=Oe2uAHcYKDidPdcan2Blg4s7Aj8e1cUpI2iL+dDn5seVv/fNHJVQg2aQQQp3XTbjad
         NWAxBESHJ4/X5V1m4vFnM4gxIx/Q9iOJpMe8wPviVmGI64lPZFICsANkWdBL2AtAPfZd
         ULt24o7YUW09Ix6j706SPUebafwFWZmh6JY4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOFvKfEIVXIuCG4wFkll4Xj+8m/Jo4dyU0NBpZKLOaE=;
        b=4Ss9ervcoKiOZjYLEzAJZbm202Te54EI9zmLU7XCno9wdx9WsOd5xzT4/bwxHOj0Sy
         IJPhptP7cRg+0gzItlG6o1rGrhda/Fzy75fJiPleNKdNkEMhpmcaLGVoFQ+OAMgGEtEV
         7X2uDMHosVqCmDyvJSF3KxSlk5My1ucv1fFBUxqSc0lq8CjtKsX0AsskQhSLTmcX+pEH
         1NyfHI39KMF4Ybult6zB6U9g7wVhHK7jcF/oKPMSmjsMCBt8SV1wUgepe8ZPNxgdLDWP
         xYGIu5IG+S7nXiVjmQ7F0k2lBZTn6ySg/H48hZo4J+HLLFkLViJaLhu4is0HyGtg5kx6
         7Kwg==
X-Gm-Message-State: AJIora+immOQr5+CiSdFWAPG8v2Ngz9cRT5UPUn3DjkSfvTPFZMDp3CJ
        p2/lNdRUCIu8gKFGfRdds3JUPLugs0UtAqBaZLY=
X-Google-Smtp-Source: AGRyM1vKpjbdMaaGXq213F5c5DPKOWAWwzkpJ1I86O0OMNmKuA/V22esYUc8mipXkpc/cOz/lulp+A==
X-Received: by 2002:a17:907:7348:b0:72b:44bf:96b6 with SMTP id dq8-20020a170907734800b0072b44bf96b6mr107969ejc.7.1658499441475;
        Fri, 22 Jul 2022 07:17:21 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id k7-20020a056402048700b0043a61f6c389sm2608297edv.4.2022.07.22.07.17.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 07:17:20 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id n12so6691878wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:17:19 -0700 (PDT)
X-Received: by 2002:adf:ead2:0:b0:21d:8b49:6138 with SMTP id
 o18-20020adfead2000000b0021d8b496138mr126302wrn.138.1658499439534; Fri, 22
 Jul 2022 07:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220722081127.228971-1-jinghung.chen3@hotmail.com> <SG2PR03MB50062792832700DC51EF6143CC909@SG2PR03MB5006.apcprd03.prod.outlook.com>
In-Reply-To: <SG2PR03MB50062792832700DC51EF6143CC909@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jul 2022 07:17:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vx9zOefBFw25tP7+nwuiggC1eEq0R8xAGD6YGaZdWmHg@mail.gmail.com>
Message-ID: <CAD=FV=Vx9zOefBFw25tP7+nwuiggC1eEq0R8xAGD6YGaZdWmHg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
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

On Fri, Jul 22, 2022 at 1:12 AM Jimmy Chen <jinghung.chen3@hotmail.com> wrote:
>
> This adds LTE skus for villager device tree files.
>
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> ---
>
> (no changes since v6)
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

Please carry forward tags from previous versions unless you've done
something to justify removing them. From v6:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
