Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC756445A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiGCEAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiGCD7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:59:21 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B9B4B7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:50 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so8768665fac.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7fjxhfrcAd5E9YXX10rRhBbkMnenLUuaD46OS0l1Bqk=;
        b=uWchCE1orcy5/neOuZil7FgjuVZuAxDDpsvDYWcuJHRj08iJNlyst2+dTV8dicqqKb
         bd21T+baWzKcQsu7Mdelx5LVLXLlJawCpM6YZSvW2mFKNlnw+sSb6ezyCcgwqhS+1SIE
         cnN6J/xzSfr2MwwVC+fmUDPHGySDeUB3p6J2FQp/THNTqRgPXFXM3ygDLn5ePSdYidGt
         FqkLfn7XvIv5z8iRWTY2IzyjzvwJsNjwucu4TAUoLc1As6wYq8gXUbJHjpPa5AhTe2tu
         ioEwxhnTwgBhh4K+FbhCpOepF/Ti0K8N1TC8nQYfoljHvKEokzp8ZbqGC/qDz74NwAnp
         AXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7fjxhfrcAd5E9YXX10rRhBbkMnenLUuaD46OS0l1Bqk=;
        b=BbmtVyd+d2kN3cGSTvHNRIquXVe+FTsPw0wY38ae+b+51snle3J1kvi+WAoZ9SEbQ9
         O55Nvfz+tNT0pnXGQ6e/wwS92n/vVgcCgZb87aFhe7qrWwSnjg7UCay9iHidgb9bM8Hh
         qvYM1si1JQm08kAUZqVGi1lYChkMywdDJd88TC+px6H2hfwMhddoajR8aazxRUAMGB54
         sqwS4VyPahRHE6WZEwkDQQ7bvVPJ/Wf1N6J/MdME9wA1lqchRPeEC9BbmINjoTqdA0uA
         tyOvtJl8C2fQmwmknoKJlgh+Jdiv9pUBN/unv8ge1JYy9zo6WRSMJkzkG2XjEin2OgkM
         Kyfg==
X-Gm-Message-State: AJIora8rv+2KSM5VpUEomNGkNvO6ac6d+YoEO3OX1/I+B1hgwlcwPqWK
        rIXjp1UIAkR2ReSfTQRV31bK3g==
X-Google-Smtp-Source: AGRyM1uitoAiFuzW3NKMABJ60JG++lOvVEFMB3qDmMddBY+/TLFF5+5GARAAGDpzP27XPjcG36x5bw==
X-Received: by 2002:a05:6870:3482:b0:e2:d03a:41e8 with SMTP id n2-20020a056870348200b000e2d03a41e8mr15156839oah.79.1656820670055;
        Sat, 02 Jul 2022 20:57:50 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Nikita Travkin <nikita@trvn.ru>, sboyd@kernel.org,
        mturquette@baylibre.com, linus.walleij@linaro.org
Cc:     linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, tdas@codeaurora.org,
        svarbanov@mm-sol.com, linux-gpio@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, agross@kernel.org,
        joonwoop@codeaurora.org
Subject: Re: (subset) [PATCH v2 0/4] Prepare general purpose clocks on msm8916
Date:   Sat,  2 Jul 2022 22:56:43 -0500
Message-Id: <165682055971.445910.1824989891242686339.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220612145955.385787-1-nikita@trvn.ru>
References: <20220612145955.385787-1-nikita@trvn.ru>
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

On Sun, 12 Jun 2022 19:59:51 +0500, Nikita Travkin wrote:
> Some devices make use of general purpose clocks as PWM outputs by
> controlling their duty cycle.
> 
> Notably, many devices (e.g. Samsung A3/A5, LG G Watch R and probably
> many others) use clock based PWM to control the haptic feedback,
> some other can control backlight or flash/torch LED brightness.
> 
> [...]

Applied, thanks!

[1/4] clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is not enabled.
      commit: bdafb609c3bb848d710ad9cd4debd2ee9d6a4049
[2/4] clk: qcom: clk-rcg2: Make sure to not write d=0 to the NMD register
      commit: d0696770cef35a1fd16ea2167e2198c18aa6fbfe
[4/4] clk: qcom: gcc-msm8916: Add rates to the GP clocks
      commit: bf8bb8eaccf4e68d79743da631f61252753ca7cd

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
