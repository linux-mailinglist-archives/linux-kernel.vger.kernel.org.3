Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8D456C3FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiGHWTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGHWTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:19:08 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65244A2E5C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 15:19:07 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id s16-20020a0568301c7000b0061c283d6c37so122538otg.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9Ki8kH0MaYR9B1B1eMqo83Dvn85AY+LXjVhqfA7f38=;
        b=ppPb4iwjhfCxSN2JWaotYlMM/YX2VYZjwuZc0J32CxvKPZ+JXtj9b7dD0r63W/lOEf
         v5o6TtM0p98iXy0EIn5pAWeXj1K1WK4IssePEqm6UKgQ4z49BYvqHksZODT+f/7JPjtu
         r9llW19+QcCouSM9Hoqi6tPNGNB6mUxyI2EQC1LFBxvhPrE0BuMfEwiiYrkWj7emTJoH
         pU5e6Lv3tu/2tEL3O0fdtr2PrVYcvfhPBZfJBj9jXLkpYYjbp6Pn356G8Btj6pChEPS3
         VZKAs4wWNPSKxo44bioACn8inEgOWxQBlf0f+dVvRt1est5BVkcSKpxakSAoHWg7HKOh
         AimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9Ki8kH0MaYR9B1B1eMqo83Dvn85AY+LXjVhqfA7f38=;
        b=XmIR2QxyOMM1vZY6UGyzHr8686Tt3lOG3v20lSRSD5W4oUff/4q2Z+dmLfEaBNLtZa
         XkfxK6cXYdc5Izl/MGWDpe+XlT1Cn+kDXs4D6aFnESApRixe0FlCngbSyiNBQtPhZLpG
         WIuN8dF762IewgPZEk9jBboIWMFRbbjrPKIf6dF9oLA6fYd17ZFXNnEk9e32DMHwi51E
         LR23E6Rkv94wqQ4KVvwOQfiCKVc0Qvy+s5DHppEGqItuVzkuAJpPVCrdAkP1rPEK/XdV
         OWFePrGkg6Tg0GhgO3n62Y25UKmxIj7Z4K3uH8HOitRI1xO3mALkliSgZk43rDHPJ9VQ
         sF8w==
X-Gm-Message-State: AJIora+OJyaDePN7/aFt4Gl4YNn6KMzI8foZeQFpwqgbDps9j/oxj2ys
        mdEy+93fs7Gw7z5SSSKBRBkTVw==
X-Google-Smtp-Source: AGRyM1t1/ItNQs24IPO08P8hmqBmPlF4m4Zyt/BXKl/SABvTzA4DKCiwaciFdavT7sFFme8fr/F6dA==
X-Received: by 2002:a05:6830:40c5:b0:60b:39c0:750b with SMTP id h5-20020a05683040c500b0060b39c0750bmr2500196otu.97.1657318746789;
        Fri, 08 Jul 2022 15:19:06 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y10-20020a9d518a000000b00616a2aa298asm48907otg.75.2022.07.08.15.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:19:06 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix DP PHY node unit addresses
Date:   Fri,  8 Jul 2022 17:19:02 -0500
Message-Id: <165731872888.1018153.17061250329124504141.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220708072556.4687-1-johan+linaro@kernel.org>
References: <20220708072556.4687-1-johan+linaro@kernel.org>
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

On Fri, 8 Jul 2022 09:25:56 +0200, Johan Hovold wrote:
> Fix up the DP PHY node which had the wrong unit address.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: fix DP PHY node unit addresses
      commit: abf61f7e66c15e00f40ca7e10367f4149639bc57

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
