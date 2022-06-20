Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7598B5524B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245403AbiFTTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245089AbiFTTl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:41:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B1A1C920
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:41:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v1so23032429ejg.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=irViqR2aLfIqGGKI3mM+On/x/6a/N5wukKqpLu13A/Q=;
        b=oh56rtalDW1TUqG2EIUDC0sdz/BYCDO2Yj6mpfwBJwAbongOSsPpXZ69AzbzKaI4uA
         XoObsFJRGIFBGuqvSx79HfYzLyPbHBYzk8k765c9ASel25i81VseNnGUbep3A32IZakG
         zRgHuUFVNfrO0okeamMaxlwQIqE32I/TlCJr0xAhwP6EXHuIFR6LHsGZmGNZZSK4wUc3
         lKGMwn/MB32cfP20f/C3lbBVgeTVDKFlpNxeVO6Ka0lIRptU+9Yqj2BtOIyqbdtgZhdt
         ldpGbvBqwlE14eB3yi2euFPgWVw9hgWcNjaMoQE0ZO7wo37zImAPpYFwHoHI3/G3cfyl
         7C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irViqR2aLfIqGGKI3mM+On/x/6a/N5wukKqpLu13A/Q=;
        b=nDBZzDFgkKXx4cYiIXUTHm47rSCyXGFOO0eUtYf32RTeE1dF06BNOoIJXMRW/J0ate
         w55/wjEjUKTqXbVZ/JC47v+9NDWqPBVoUk1Ece5Z94wjps5fCUhnFctwz/e4W5lk86Rv
         318GNPbmw/w95t2JCnksPL3Nk6o8L+BGJeIN6ohePFQ4wLxRbD3PLuWCqE/t0tQQzBTb
         Ge0N5QUqH0UQCpmjpU/6I7B2/+mt0eof2UsPdlGTAKE6JaniIoMtPOMxOOjnfjgsjaxa
         i3MnL83jh4W2LDeF4MUGOTxTfUgNEcQy2ybZ47KRCarQVVsn3zo6eNeVf2Rv7htnBN/x
         v/+Q==
X-Gm-Message-State: AJIora9Ljj1EYkC65OyLYQmLmY20JdXy/LBkcEk5mM6fnniw2/X/Dyer
        mDQkM+LnCm6QDlfzbTi4TkdgPvIk6JlxIA==
X-Google-Smtp-Source: AGRyM1t4c91x+8SrrBIG4J0iDuTJ5rar7wRCFbMJTSLdXZq/f6hGZFPc5DijwkwkgRiJ1zY2qK3flg==
X-Received: by 2002:a17:906:51de:b0:712:23e0:df84 with SMTP id v30-20020a17090651de00b0071223e0df84mr22029675ejk.453.1655754115078;
        Mon, 20 Jun 2022 12:41:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o18-20020a056402439200b0042fbc23bfcesm11448549edc.46.2022.06.20.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 12:41:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH qcom v2] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects
Date:   Mon, 20 Jun 2022 21:41:47 +0200
Message-Id: <165575403864.144830.16259521514833113384.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220505065233.28476-1-krzysztof.kozlowski@linaro.org>
References: <20220505065233.28476-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 5 May 2022 08:52:33 +0200, Krzysztof Kozlowski wrote:
> Recent Qualcomm Geni SPI nodes, e.g. on SM8450, come also with three
> interconnects.  This fixes dtbs_check warnings like:
> 
>   sm8450-qrd.dtb: spi@a98000: interconnects: [[46, 1, 0, 46, 4, 0], [47, 2, 0, 48, 12, 0], [49, 1, 0, 50, 1, 0]] is too long
>   sm8450-qrd.dtb: spi@a98000: interconnect-names: ['qup-core', 'qup-config', 'qup-memory'] is too long
> 
> 
> [...]

Applied, thanks!

[1/1] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects
      https://git.kernel.org/krzk/linux-dt/c/56cf5b7fde546f0203a91e002e1cfb3f51804db4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
