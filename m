Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38454F1DD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386675AbiDDVmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379389AbiDDREB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:04:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C74F40A2D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:02:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bq8so21252831ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wlQmbWsbwLY4Jm0uWTn3f9S3+SAlsRt/5TjBscaW/ec=;
        b=Q++fS72PqHfuYFjBF7/g/8eYmp6uBJVDEGuLQRS6akI68tCD9V7hqUoKuQx8eCMGP2
         LY111E0bOeFLm1f7/gaAgmur6VHUqL9f+t4L/k2UCtejxKn+AhoPu+s0vZsFqldsCa9Y
         jiY4+moa33mqZ+Z8MEl4DVy/sxOYPiL/F+3Ua7Xr2zesZuXmPMVQRpaH53WjmQmGjX5E
         ghG1kjTtNoQxofdWzIUVj98HP8MQIhPj8LIDnwgxfB1576G4uN+iKtqe9fW+SgqvK1CY
         4RgTKoJZdrU4tcnSGEMZj7gdrGmcwfF+R/nP0xLzY2/r+4C+UsEVAAzEkgwmWOuqjVw7
         PdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlQmbWsbwLY4Jm0uWTn3f9S3+SAlsRt/5TjBscaW/ec=;
        b=SvaQxYHhIQnmBnS99ch3ojnWxZy4Lu5DQsGod5oxCdQMMwGUbQ9JTkjKh2IeI4DNDg
         4xbTbgbL6LIAzDeHMcQpSUT2bQ42M27NPEbv50sh5wdJkdVX3CFOqBaaoBMsOzjK3qut
         cK5eoHOx1HxaQo22kqncyaFTnjCwBpdIQVEKCb1gJ7ulJo8eoXfcCZpi3+/xZbzsYMVN
         +pvB5V4OdrinOkGZQwl3RBJvgqKcNXJGFLlF1YvYchUc14mBFWmRTPpKjYNMiiYrZ1a5
         jeRLCwhuWPiIFoaYdIIYn7eekep7ORnAFFiXJ4e+8vt+8vK0ojBTe8s+tZ8m1nqd1/JE
         Pkcw==
X-Gm-Message-State: AOAM533PCMJqpcLYO20kLbw85Lv+bbprWsvTzZMuF2tRmwnd8AL0jQEX
        UWuSXLYeW5FSj4ElMK3BwnNPrw==
X-Google-Smtp-Source: ABdhPJxsy+zfihA7Fi6o4Ei91Fm+4NalCj1W+rFnZ60rDuEKgLQ1M2JebdUfl1JFAwblr1YXiYMxjw==
X-Received: by 2002:a17:906:4787:b0:6e1:409f:8deb with SMTP id cw7-20020a170906478700b006e1409f8debmr1081940ejc.80.1649091720949;
        Mon, 04 Apr 2022 10:02:00 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm4557770ejz.57.2022.04.04.10.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:02:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 3/4] arm64: dts: exynos: add a specific compatible to MCT
Date:   Mon,  4 Apr 2022 19:01:48 +0200
Message-Id: <164909169270.1688455.15004420209137649762.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304122424.307885-4-krzysztof.kozlowski@canonical.com>
References: <20220304122424.307885-1-krzysztof.kozlowski@canonical.com> <20220304122424.307885-4-krzysztof.kozlowski@canonical.com>
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

On Fri, 4 Mar 2022 13:24:23 +0100, Krzysztof Kozlowski wrote:
> One compatible is used for the Multi-Core Timer on most of the Samsung
> Exynos SoCs, which is correct but not specific enough.  These MCT blocks
> have different number of interrupts, so add a second specific
> compatible to Exynos5433 and Exynos850.
> 
> 

Applied, thanks!

[3/4] arm64: dts: exynos: add a specific compatible to MCT
      commit: 2616922241706ec5c2c5ae95d5ac1d3120575ded

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
