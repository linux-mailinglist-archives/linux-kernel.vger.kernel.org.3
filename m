Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A35A4F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiH2OU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiH2OUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:20:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD4D54C8F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:20:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b16so10356635edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=F9yNwthvDThYN8PozFUnGZoAmSBhQ3+M5Ob8cdnJ9E0=;
        b=UffHqoG7mxNZ+09NcRTvmauGvuRAlQxfBG3YjS42aMP4Xh5RLRU0qBqKGJtYmWI4UY
         WTl0UN/p716/FEmlZKu+J1fjOHbxyymf4yHoDBoLNu/H1N8jSunLZyi77z2D9rJbueoA
         tOe0k9xsI7JGHRoYDFDCNONP7HSwMcmwarbdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=F9yNwthvDThYN8PozFUnGZoAmSBhQ3+M5Ob8cdnJ9E0=;
        b=268DBDVNh5PhN/sgn1hjgQJg8PagMG80HuDauYnm/Y6yxrrC3oBmExDmutohIMSOcU
         q2gOn7X3OWbnC05hsmck+lpHkwxrlvgqR615C/cam2Ng40wjl+++p5tEb0Mj7unu4ea2
         igAU1F/cqUKwGE387hzqnrnVKZWZELngBFnc6YqYCxB3cTFh5gMRiWAkFyHnMzzsxLmD
         UMzeRpL9qpb+2AjD9TfSTkVr5L19DwP851FPxIZzV8NNBqWNp+N5kruErszZUztuSG6t
         ZSl3cx9tX4mVTyH7p/jtrelny6hID4g2iUe4tleg5u71VRk/d2V0xPpblQMapxMm1P7F
         w2iw==
X-Gm-Message-State: ACgBeo06H0nxOT/3dzGbaxtLmogVEHptsBkbDx2Rox7gTE/BfOWjLsfG
        pTfRmv6/b7XiXqroCKwe90wAJwvZyeKwbQLU
X-Google-Smtp-Source: AA6agR7Woamdq4bqBYn9tAXYZU2BpZ0/159CkwPZa07W3DWILQva7tZxDeYM74t/V2jWHJq/nImABQ==
X-Received: by 2002:a05:6402:241d:b0:443:39c5:808b with SMTP id t29-20020a056402241d00b0044339c5808bmr16893992eda.39.1661782847505;
        Mon, 29 Aug 2022 07:20:47 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id 22-20020a508756000000b0044780b6debasm5815786edv.32.2022.08.29.07.20.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 07:20:46 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id n17so10405911wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:20:46 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr6500366wrr.583.1661782846549; Mon, 29
 Aug 2022 07:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220829030823.v2.1.If97ef7a7d84bcc2cf20e0479b3e00c4a8fb5a2fd@changeid>
 <20220829030823.v2.2.I99d43de4a80223dee58ea1bc5b4fd3aaadc5e3c1@changeid>
In-Reply-To: <20220829030823.v2.2.I99d43de4a80223dee58ea1bc5b4fd3aaadc5e3c1@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Aug 2022 07:20:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZoh-4uSWViciUgXCnTAz6HhQkOt2un_tTa1GY755TDA@mail.gmail.com>
Message-ID: <CAD=FV=VZoh-4uSWViciUgXCnTAz6HhQkOt2un_tTa1GY755TDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add sc7180-pazquel360
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 28, 2022 at 8:09 PM Yunlong Jia
<yunlong.jia@ecs.corp-partner.google.com> wrote:
>
> Create first version device tree for pazquel360
> pazquel360 is convertible and the pazquel it is based on is clamshell.
> sku 20 for lte & wifi
> sku 21 for wifi only
> sku 22 for lte w/o esim & wifi
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> ---
>
> Changes in v2:
> - Remove the touchscreen setting, as a follow-up patch
>
>  arch/arm64/boot/dts/qcom/Makefile             |  2 +
>  .../qcom/sc7180-trogdor-pazquel360-lte.dts    | 22 ++++++++
>  .../qcom/sc7180-trogdor-pazquel360-wifi.dts   | 17 +++++++
>  .../dts/qcom/sc7180-trogdor-pazquel360.dtsi   | 50 +++++++++++++++++++
>  4 files changed, 91 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
