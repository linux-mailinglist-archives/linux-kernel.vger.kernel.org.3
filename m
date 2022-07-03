Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA37564434
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiGCD5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiGCD5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:57:22 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED94B4B7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:18 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 73-20020a9d084f000000b00616b04c7656so5096267oty.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s77EFLX3f4858K5Tvi5UUeX7uxQG/9+kOd7qmZZ+6fk=;
        b=W/Pd0vH2xSJvq3gQP6djtfxi5SwISkVzQzOHq0lYXWT42suNyTMJwJfG4prFfB55gh
         iXnvDjn2GweiV6vu8xE0sFMqLgUKI7vAlYmDS868OaEFfOBXzKFjOiFfQmQoeD/jjB3j
         /2ZuTkrJoVA+jVKsY254BFW8C2HMQPgDOolfZV/XknEc1zAP1gj34FYABEs8VZlEgwt2
         UsErZrYSy1tdNmahCs4qwBRlZ5h0TofgoK4s0AzOfxdVyDH+ZvAVoOuB9yjIJrwMyxvI
         ZiRrGmEBE3h7XGRmzNgdAmpwFXm6Jgvl+eJXg6Mkpi7WhFVAAD5YGO7JT0wx8L+oEn8g
         fJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s77EFLX3f4858K5Tvi5UUeX7uxQG/9+kOd7qmZZ+6fk=;
        b=rN6pBzS6vSk8SM4szSKO/eQiZZi075sgMmrX3+ZLgCwIxBRFwl9u8DX6NmCT9d3BIE
         hkwPzriCpW0Wv7iCuNRL5fJoasBiHTKqSaZxEzqOXC5KSlyGa30qu3bct19YANtnLwTo
         LbVn8yNdSdAgd7YBcCssC2brbNDwVBo1/+P1zXYfv0rL14jky0IKuK0nD8TPGP0Iy7sc
         GDzmmh61DKia+1qHL+oR9ZiMs87ITn9xpGHMEnw3aoZQzgyZWoDWDk6VB4z/nSIJ5HYi
         0R+qE6SKIugTtuXxAI+AGGVISMUu1WUiK0uFWTjRrxlfPwmgBM0Umn5A8voJ7fAVJp16
         t+FA==
X-Gm-Message-State: AJIora9tglJsMsa56D4k9rvRS/AgdaErTCZbafvlbNNw2+aJ9cJRdFPj
        GZMLwR2L5wf7sjN5sF5sQLAAKA==
X-Google-Smtp-Source: AGRyM1twvMNTNa1pndDJEyMJm4cm8fdhKmc7/AnG+g8lqE3uPrr4ZSC1Bi+8lVgvImh21osIIZln1Q==
X-Received: by 2002:a05:6830:1f42:b0:616:bacf:5d5f with SMTP id u2-20020a0568301f4200b00616bacf5d5fmr9612328oth.341.1656820638075;
        Sat, 02 Jul 2022 20:57:18 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 00/13] dt-bindings/arm64: dts: qcom: minor cleanups with DT schema
Date:   Sat,  2 Jul 2022 22:56:14 -0500
Message-Id: <165682055968.445910.10567681463445860902.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 15:19:10 +0200, Krzysztof Kozlowski wrote:
> The patches are independent, so they can be picked up as is (or everything
> through Qualcomm SoC tree).
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (13):
>   dt-bindings: soc: qcom: aoss: document qcom,sm8450-aoss-qmp
>   dt-bindings: soc: qcom: qcom,smd-rpm: add power-controller
>   dt-bindings: usb: qcom,dwc3: add IPQ8074, MSM8994, QCS404 and SM6125
>   dt-bindings: usb: qcom,dwc3: fix clock matching
>   arm64: dts: qcom: add missing AOSS QMP compatible fallback
>   arm64: dts: qcom: correct DWC3 node names and unit addresses
>   arm64: dts: qcom: ipq8074: add dedicated qcom,ipq8074-dwc3 compatible
>   arm64: dts: qcom: msm8994: add dedicated qcom,msm8994-dwc3 compatible
>   arm64: dts: qcom: sm6125: add dedicated qcom,sm6125-dwc3 compatible
>   arm64: dts: qcom: qcs404: add dedicated qcom,qcs404-dwc3 compatible
>   arm64: dts: qcom: msm8996: add clock-names to DWC3 USB node
>   arm64: dts: qcom: align DWC3 USB clocks with DT schema
>   arm64: dts: qcom: align DWC3 USB interrupts with DT schema
> 
> [...]

Applied, thanks!

[05/13] arm64: dts: qcom: add missing AOSS QMP compatible fallback
        commit: 6ba93ba9f63fbc44c3a6af7fe6f2536d009cfd5a
[07/13] arm64: dts: qcom: ipq8074: add dedicated qcom,ipq8074-dwc3 compatible
        (no commit info)
[08/13] arm64: dts: qcom: msm8994: add dedicated qcom,msm8994-dwc3 compatible
        (no commit info)
[09/13] arm64: dts: qcom: sm6125: add dedicated qcom,sm6125-dwc3 compatible
        (no commit info)
[10/13] arm64: dts: qcom: qcs404: add dedicated qcom,qcs404-dwc3 compatible
        (no commit info)
[11/13] arm64: dts: qcom: msm8996: add clock-names to DWC3 USB node
        (no commit info)
[12/13] arm64: dts: qcom: align DWC3 USB clocks with DT schema
        (no commit info)
[13/13] arm64: dts: qcom: align DWC3 USB interrupts with DT schema
        (no commit info)

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
