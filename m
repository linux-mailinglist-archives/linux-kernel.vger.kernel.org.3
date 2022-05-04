Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB45199BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346288AbiEDIeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346207AbiEDIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:34:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2661573C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:30:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l7so1498769ejn.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9nSUmO56wOXYmjBFWbiARr3Yo6LvELK912YK074Ae4=;
        b=rDwoGUsGdpWqE+oF3FoZI1GRuzsI5kD6Y/IgHYXmHi27Q+fEizBH+DL9kTeEQwlMf6
         aWKE4hEolFZwXfzy8XnWipkEEHbFUGX8GwUJ0XbwKzLyhHJ56+qiKwJeT8QH6pL8Oj/V
         iVmMTVKkuBLNLsOPKG25FTHL75kdaPBSKCn3Jw1MsuDaMssuTxhyUugToLhY4pfQXVx9
         PzIFohW57vp2Kld86GGbR0E4MuiwJsybhjPQROZq139Yr7WThCq00cysQRY7QJoKca51
         KDythCgKaPE+p55Vz7Ph5FDNIjGAXAL33Ui6Lni6CaxNvFCIWGXJ8OgavW2vO+O6Ea22
         VItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9nSUmO56wOXYmjBFWbiARr3Yo6LvELK912YK074Ae4=;
        b=EGZGxh90qAp0YwGkbxr0eKukao+ENodxcth3WqwFQ5pFijF4mK8AN0/8pMiOYEG2Dg
         Mnpnqyd6y5OnxZ4u6ydtQt1ydKhClnq/7u/oprIK7LbHHVkrJNDiO1Rmf/C+S7mH34Yd
         vKiFa+yhyrWmvJ8IbU4qxdXKbY44O08dQtbyVmICgkTwl3CnkvlmHLgvOr+sY/YJcWCk
         LJto3loZAouGOs6ynM5HfvoS7U9sfJ3aBdBQTTxEqsizA66TdGGmg7ZVG9yOdIbMQ6dY
         6GIvwVwIuI/s19t/Kc6gVMyYqaLoRHD66Y9iV/86zBNTNrEepwz/rvP6Ig6Im6OvBnAo
         ECxg==
X-Gm-Message-State: AOAM5301motS71DCexlrdpuAcgiDu412v3cgTe+lBjLMv1jFGYEPNfvw
        6aM0yLoUB+yAAclCSDSVSs0wt8k9FcJ69w==
X-Google-Smtp-Source: ABdhPJyEv6GQnYySZXj3rwiVw3do3ziMR9daRptxqA1ANW1/9stu6aYaRjl1jTIz3L1zxbBNBENjoQ==
X-Received: by 2002:a17:906:1e94:b0:6b9:6fcc:53fd with SMTP id e20-20020a1709061e9400b006b96fcc53fdmr19379605ejj.450.1651653041508;
        Wed, 04 May 2022 01:30:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jz15-20020a17090775ef00b006f3ef214e4fsm5377029ejc.181.2022.05.04.01.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:30:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH] arm64: dts: exynos: move XTCXO clock frequency to board in Exynos Auto v9
Date:   Wed,  4 May 2022 10:30:29 +0200
Message-Id: <165165303186.30033.9483102771477124932.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503092631.174713-1-krzysztof.kozlowski@linaro.org>
References: <20220503092631.174713-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 3 May 2022 11:26:31 +0200, Krzysztof Kozlowski wrote:
> The external oscillator - XTCXO - is an input to the SoC.  It is defined
> in the Exynos Auto v9 SoC DTSI, because all boards will provide it and
> clock controller bindings expect it, however the actual frequency of the
> clock should be determined by the board.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos: move XTCXO clock frequency to board in Exynos Auto v9
      commit: f223095c6e1d20aac831e75016b58ca8adbbf122

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
