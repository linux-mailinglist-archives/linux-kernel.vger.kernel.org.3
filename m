Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51329576349
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiGOOA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiGOOAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:00:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBCD422D9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:00:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dn9so9112930ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HJhff+E4NeHVlDobtIdZgmKxifRHzjFEik47oKvdx8=;
        b=Y7wIv9EckNkZ7nGMnE3ATuKJzVp4UCn2jU15kLgbDPjftMPmAMsnamKn1JkD9RzZfi
         jfUutLahgtHSoxCIkCtyXgjCg6LH7guNoIJN7+UvmIOHZTqKXb8x8Zp6MQ+iDHfAIhgF
         0gtZZkF3HWFGMSam6Iq8JeycOTackA+6F5q+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HJhff+E4NeHVlDobtIdZgmKxifRHzjFEik47oKvdx8=;
        b=ww/lI4bB+iFqW1DAaQvfatT/+5BlUOgA60VCPCSk2fCr5erbzeSKRCCcoSa/yk232R
         A6z1ZZGsCWGQI9ik8a8YQLOoVAOzYyDHpn1T7onp9kQc3Tox6Viib4QvlTa963WqG1P1
         ZP8CE2ZNYdntVzidih6zWs+5ZGlaAG6L6ExlT3ivSIVTEJuedSWfBckICKiTaLd6PSYt
         xPGOkP4GliGS3MiTzTQDj9twpP6Zp2XkDzJ6EFPDeongXyviZmKjhjr6FMJ/7LfZtCr6
         U6LN8WZ4MhK1/9JmZ6S0z/dIujW782Dx62T5jLieLMXpaEH138BLC0U+jWjTdiOCc4ho
         R5Ew==
X-Gm-Message-State: AJIora/ZWnMr5UKGJey5O68IW+cEa6d+2YfZyGTQH6m7xYq3Ooxre5Jq
        HH6YErCgfRS22UlW4YmJdArWaFrDoUQzOBk1
X-Google-Smtp-Source: AGRyM1uvvNm8lPIOE0uIOeNXyrdWfhqOSdWI3iTOERArsdATgkjyCsN0pqJFKbFsCpmccfOtHnZ1+Q==
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id f17-20020a1709063f5100b0071239458c0dmr13740754ejj.302.1657893605189;
        Fri, 15 Jul 2022 07:00:05 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id m17-20020a50ef11000000b0043a9144d8ecsm2885016eds.71.2022.07.15.07.00.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 07:00:04 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id q9so6848371wrd.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:00:04 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr12761948wrr.583.1657893603592; Fri, 15
 Jul 2022 07:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220715084442.115021-1-jinghung.chen3@hotmail.com> <SG2PR03MB5006667607216338081A723FCC8B9@SG2PR03MB5006.apcprd03.prod.outlook.com>
In-Reply-To: <SG2PR03MB5006667607216338081A723FCC8B9@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Jul 2022 06:59:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+2oiWOO5=eDZNbsHMgFEb5500tfcO+-m=24WaNiTCRg@mail.gmail.com>
Message-ID: <CAD=FV=U+2oiWOO5=eDZNbsHMgFEb5500tfcO+-m=24WaNiTCRg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: arm: qcom: document sc7280 and
 villager board
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 15, 2022 at 1:45 AM Jimmy Chen <jinghung.chen3@hotmail.com> wrote:
>
> This adds a LTE skus for Chromebook Villager to the yaml.
>
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> -Add this patch
>
>  Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

There were no changes between v4 and v5 and I gave my Reviewed-by tag
on v4. That means you should carry my tag forward to your v5. In any
case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
