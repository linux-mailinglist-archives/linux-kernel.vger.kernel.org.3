Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B078751AC31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357427AbiEDSGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359561AbiEDSGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:06:11 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EC76D3A3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:21:28 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e9027efe6aso1831288fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUWKIdH/fEUKAxxzAokiJ2q+i9WASUkxei6O8LHC1rU=;
        b=a3TSfVCrQqto9wmhJlB9avSH7Rp2BPHfvLxJNNhi9ciOwVonT/3vyD9qvpnRG+ay/p
         qodVdrmUN8IKY+xc/SwIaS/U9CllguT+CewL9xBoAIC9Y/aeFEng9u/xSDK6UhVeVt+O
         sO+g09lD0i56YTXLqTzDrIsYeJGoIQ+q0uovZ0NRMQADtfZS08DC4ojVdOuGOjK2acsi
         jVmiv3QUseFuu2IDWH00tkMrWer8HKAka2giqqNBfRrwkcAuIinbAEwEJ0Y5HyzQfaPh
         4NF/gMn9Gy/IxS9yXzH99wjHS5ajbfASZKmDgOfbspi4lYoSdUSWNU4uqa0NFqpwu4fK
         LOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DUWKIdH/fEUKAxxzAokiJ2q+i9WASUkxei6O8LHC1rU=;
        b=13l1xLT4NfUihj74C+WFsLsPpTEMSUwNFCkMsPrrYxnrnB6eJkO9Gfehq/U1+dT6j5
         DA6wbhgim3R562cEAzdf3c4iDyqou831y8MI0yBbOTc9aHQAOcXOTEPzAVi9C1Rfpgxd
         CEHw+grxc2MMX1+Syubj7AJ5ly0ndoBeBbDyQ9XwhYSJ7+Sw+iraCZvYgdXV6VZkv5Zu
         zlTVmb+oBQ2ii1z+Te3JJfcbLma8kPnbn7FLQkKzv7htMwjPlxRg+qlSCjjdAuDwfqeu
         7o/8rgDjsmecsJHOcJHqQAVBb6N2aU8MEziB3FFLUmDfK9O6TRBwr5VR8pugJikUlC1D
         kTuA==
X-Gm-Message-State: AOAM531GKgnkkIiAHMPubvb6foDREvZ4ydNlyYgF6/J4BqKNhz39S70D
        2X7M1mkCUF+BgGfCS9Y9wPKVNBbFNewWEkj9
X-Google-Smtp-Source: ABdhPJy2UZOyD3CWXrA/eXvFp3d4iW9ppaYryHuEExwQ7s7wGina9JRPiQs5uxLBRUeni6GHxzzWGA==
X-Received: by 2002:a05:6870:c186:b0:e9:5f39:85b1 with SMTP id h6-20020a056870c18600b000e95f3985b1mr277585oad.144.1651684887889;
        Wed, 04 May 2022 10:21:27 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870b14700b000ead8b89484sm5785452oal.5.2022.05.04.10.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:21:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH V4 0/4] Add PM8350C PMIC PWM support for backlight
Date:   Wed,  4 May 2022 12:21:12 -0500
Message-Id: <165168485227.3730817.2589652211436766434.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
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

On Tue, 22 Feb 2022 11:25:05 +0530, Satya Priya wrote:
> This series depends on [1], which adds driver for Qualcomm LPG.
> 
> [1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=615848
> 
> Satya Priya (4):
>   dt-bindings: leds: Add pm8350c pmic support
>   leds: Add pm8350c support to Qualcomm LPG driver
>   arm64: dts: qcom: pm8350c: Add pwm support
>   arm64: dts: qcom: Enable pm8350c pwm for sc7280-idp2
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: pm8350c: Add pwm support
      commit: 5be66d2dc8873edcf215804067b1c076b00c6887
[4/4] arm64: dts: qcom: Enable pm8350c pwm for sc7280-idp2
      commit: 82096cc644098ab610e6df5238341907ea662164

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
