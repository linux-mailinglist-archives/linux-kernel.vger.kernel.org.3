Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB68569834
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiGGCb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiGGCbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:31:35 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728402F3A9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:31:34 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u9so21896130oiv.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 19:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYOkpM5mbqkB6w2x0txJabn++Zuea/JIjpE53NC7Ovs=;
        b=O/OphLNHTV2yePG++ANiG2XlmcHB8S5c/24sNkjLMerXy5rbKaOIGR0LTF3mr9aFoM
         Wt5op3owZiw2d3/jCHtOw4QllvcqJjlEoizzeqwPw63mX/ojOvEKPpP+lZODEyoCB1FO
         hBNLQlvqixm2RPeJ+v0UF5zBrnbfW7w7Okn3HMTBNZbYH0IokQ/lwSGqOgQdla4DFy9V
         PcTfRP0XzE5749OuSOlRoNsSaD4Irse+S4p202DlA9tkWZ3EssW9A0SKrrVzIP6PONiF
         xz2h3SdfWkGN5zm8QnAIWvWhQOjxTP+yxYpVizQbYO+3B37sS3Qr24ltWsfF4ahiTMNI
         n/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYOkpM5mbqkB6w2x0txJabn++Zuea/JIjpE53NC7Ovs=;
        b=b6hlaQ2Kw4aVCWSg9qTaF1BPELBc5m/TXkgBOy2dX4PlCJle/L8O606kHvivUpw5w9
         1B4mI8sBCMDXWCUwD60av+8zJp9bgP+U3HwrQI1nr41TfjCLctpajdVb5+q8xGIeDBtK
         UqUHz7xXiqtg2xSrwjAZzIy7VlQ56R0hngTxul15TF6zaUFTtQ0r0WQHgUB69gDsZu/R
         TJ6H7NuInmwqdWoksWr8rJlWC1+St9W4lH/Iv3pmB+dx68I9oFzYLFMMGR1CtouHBkOb
         Tn4WZ604wweCMG5MfC5PXasulm8PmPWp/MxSgGtRdE6HvW/U1hQWHEWwOaPtGqEPQwoe
         K7FA==
X-Gm-Message-State: AJIora8JIxSeJl6L9IbyPZ5PlMwlR9SuAyurH8bxDYEPAnoTSZWiSglz
        spFG2PovUSuKBza/e0eJCmkHAQ==
X-Google-Smtp-Source: AGRyM1uZ1j3GL+HHiRiUjzP4ZuNVvEGnWjez1sGZv/1hQL7mFmHwohrXD6uOZp7rHHg3HTWQXn9V2A==
X-Received: by 2002:a05:6808:1392:b0:335:a45d:81fe with SMTP id c18-20020a056808139200b00335a45d81femr1066080oiw.213.1657161093777;
        Wed, 06 Jul 2022 19:31:33 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x48-20020a056830247000b006168c71ca4asm17024469otr.56.2022.07.06.19.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 19:31:33 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: (subset) [PATCH v8 0/4] soc/arm64: qcom: Add initial version of bwmon
Date:   Wed,  6 Jul 2022 21:31:11 -0500
Message-Id: <165716107315.864223.10956904970767999578.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220704121730.127925-1-krzysztof.kozlowski@linaro.org>
References: <20220704121730.127925-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 4 Jul 2022 14:17:26 +0200, Krzysztof Kozlowski wrote:
> Changes since v7
> ================
> 1. After discussions with Bjorn and Rajendra, go back to "SoC-bwmon"
>    compatible, so without "llcc".  The other bwmon instance - between
>    LLCC and DDR - should be called LLCC.
> 
> Changes since v6
> ================
> 1. Patch #2 (driver): use MSM8998 compatible.
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
      commit: d3ef125cf844ab2f6365d8645d7468cec709170a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
