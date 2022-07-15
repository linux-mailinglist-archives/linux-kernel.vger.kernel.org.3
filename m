Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D956257637D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiGOOO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiGOOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:14:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AA215813
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:14:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ez10so9161349ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gmpAzq1QLQJvy1sF1qsN2KHunfvdectBOUVazsFT0c=;
        b=M7DPLx6wiUJsGIxyF+Mfs16brKcddihTLDDfbseDRC0UoXNlRRl5Tk7c84fYx+qxK0
         HipLuAx8IOhv9YAWcHpvJL2VSY6g8vwXNJPBQleA650i8RJDezv4aXGTdaAVFlOOJgFX
         bQW2PSWuaNK8v7zyIeFh7rmx+svJvoQkrywDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gmpAzq1QLQJvy1sF1qsN2KHunfvdectBOUVazsFT0c=;
        b=Yp1kCVpv3YUbfTq6bRSy8HtSBStsIgbx3DQ52VZrCT4DAY75FzRTYX+N6W7N75SMfu
         EsPnl/pFLAg5Vr7xA/vWq4D5rx53UPYO14rBweuMYkvXp+5HuSRqPW015tblDhhdJIAN
         hHn2hq4vAZQ0MIeoWI4RkG3gFaIxC1b/8cAUKRRvbA490G78JdCFWosz6rGcH+W9XCR9
         90cusG2wqmdjMxRvrVOLSZNwlcVYxHKRL+BJD7UE/RGm3d42zVScBjNp05xfew3CGAiy
         4DvUIjzFhsESD4cvLwI8Sbzrtsblps8Cqb71aiL2popoc1U9xn2moZ9tOHmkMKJlcK9f
         KnFg==
X-Gm-Message-State: AJIora+t0A/S1Lr/ZtJsZgIdWWMKcftnFgtZ8hsub0Li+ng3hEZWcRbF
        G51VisfJwL3vQMe/3bmBX7qIvp7Isy4DoNkt
X-Google-Smtp-Source: AGRyM1vTViNXnjZrQuh6YlSNVA5uNgixncGrz1QxmLankY5lPF3TVhW1++Cl7nqPoJjd+/K1CVbvag==
X-Received: by 2002:a17:907:7214:b0:72b:8720:487f with SMTP id dr20-20020a170907721400b0072b8720487fmr14091070ejc.640.1657894461385;
        Fri, 15 Jul 2022 07:14:21 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b006fe9e717143sm2087520ejf.94.2022.07.15.07.14.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 07:14:20 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id e15so1671055wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:14:20 -0700 (PDT)
X-Received: by 2002:adf:ead2:0:b0:21d:8b49:6138 with SMTP id
 o18-20020adfead2000000b0021d8b496138mr13033418wrn.138.1657894460100; Fri, 15
 Jul 2022 07:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220715084442.115021-1-jinghung.chen3@hotmail.com> <SG2PR03MB5006FEBF794767B52DD80152CC8B9@SG2PR03MB5006.apcprd03.prod.outlook.com>
In-Reply-To: <SG2PR03MB5006FEBF794767B52DD80152CC8B9@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Jul 2022 07:14:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vad82p+Oz6kxJpiB9NLan67qF1+bDfiOmSEE9NaTEs2A@mail.gmail.com>
Message-ID: <CAD=FV=Vad82p+Oz6kxJpiB9NLan67qF1+bDfiOmSEE9NaTEs2A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
To:     Jimmy Chen <jinghung.chen3@hotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Fri, Jul 15, 2022 at 1:45 AM Jimmy Chen <jinghung.chen3@hotmail.com> wrote:
>
> This adds LTE skus for villager device tree files.
>
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> ---
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
>  .../qcom/sc7280-herobrine-herobrine-r1-lte.dts  | 14 ++++++++++++++

Your v5 accidentally added the file
"sc7280-herobrine-herobrine-r1-lte.dts". Please remove it.
