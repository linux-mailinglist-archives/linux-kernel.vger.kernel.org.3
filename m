Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319DB51DB7E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442656AbiEFPH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442612AbiEFPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:07:02 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65CB6B092
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:03:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r185so2930023oih.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGGst/5sLo/Mtz8gaaNmR6S/WriZ7WP7g///+OHqwzk=;
        b=SHhPPKRU8sU0J8uCvrjzujcKeLbQBe1lmFerx7oZ7PYFHt4JwQ6OFFEAK9da4PK6P7
         0nV2qHmOCgx6yPwbnTjQblvibLhClyyvgiUiBCeCXCzRsO53ksyMBSuqWUg5aHlNkpH0
         7t5eka73PAdRPHUTLeRfFkPVTBu6jCilNZh28PONzitOoBuvSHLlALKPBqbN5KY3MW74
         95c2cb77ZFGm2mHwttjuXNuAbUwRuojeIJjxoPaR6c8aP70OwZ9I3KSzRMkC3hYgRSKK
         WmLOM9fAFbEbNn2F9Qjp/ehjfK5MOdCGsY4dye1tga0ao/3pCYMAVO6BXeqlhBdNmfGo
         rb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGGst/5sLo/Mtz8gaaNmR6S/WriZ7WP7g///+OHqwzk=;
        b=16D7JMS7/SBVpd2D+coCseY95SmHxcy/gQ1z60OaVDBTihI86V4gKq6tyziNG974pL
         wZ1fLlX4pBsmI8/FHpzIR2PmccJ71FJW1ObEsmJSTaw6vQ6JBWSBOKSJW/qrY6KUulyf
         fUgwk1gxwwUeTspcCzgIvL5sz8wYmheSk4v4CGLclDr5aixUDHMujNeB+O7PO/bKfB1R
         rVcr2MDA5DYSQrKB7AIYjeQJJkhyj+sAPrgPt5ldrNZqpM3ewQk0EFcqXLrOZHbWamEI
         pQTiLz3b1r5oQpfM7zdm6W/sZ8gk6rzohCpcta4bhItHHC+oNA8bcPcY8G+m8MGEG/pA
         aBMw==
X-Gm-Message-State: AOAM530Wpe2JmTj4mfWEKfrloKe4cKuWDGs0fuCqU0u2srAwEuHaKul3
        SAK8tnlWKVAExqSMPYNrUy+/vw==
X-Google-Smtp-Source: ABdhPJxkaaYSe7OlnRD8O0rwZcj4/X87+eYvhuoIX7qy1/IZXS9BlEGU+IKjuMiZQL7GoM5ssQ8PYw==
X-Received: by 2002:a05:6808:300f:b0:2fa:6fd5:9723 with SMTP id ay15-20020a056808300f00b002fa6fd59723mr1615284oib.202.1651849399425;
        Fri, 06 May 2022 08:03:19 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e21-20020a056808111500b00325cda1ffb9sm1665311oih.56.2022.05.06.08.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:03:18 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Ansuel Smith <ansuelsmth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2] dt-bindings: clock: qcom,gcc-apq8064: Fix typo in compatible and split apq8084
Date:   Fri,  6 May 2022 10:03:07 -0500
Message-Id: <165184936433.73465.8918776302755169232.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426064241.6379-1-krzysztof.kozlowski@linaro.org>
References: <20220426064241.6379-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 26 Apr 2022 08:42:41 +0200, Krzysztof Kozlowski wrote:
> The qcom,gcc-apq8064.yaml was meant to describe only APQ8064 and APQ8084
> should have slightly different bindings (without Qualcomm thermal sensor
> device).  Add new bindings for APQ8084.
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: qcom,gcc-apq8064: Fix typo in compatible and split apq8084
      commit: 4ac7e878c15781286c043cff19ec88d82b8e2014

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
