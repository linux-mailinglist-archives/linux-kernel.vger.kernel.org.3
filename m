Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941E1518866
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiECPZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbiECPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:25:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0A15722
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:21:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ba17so183248edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SRegSipmA3f+livG8EQAkZ1mqxGwmQV1biD+cfEfPU=;
        b=RV+7/9pLq3i5ZHClYS5+MqYa/4jK7RKH1HWKMNKtvJlr5kZmv9VPR0V9bgm01ojljT
         Iosn5fuOzndhYmU4bTFc0bEwwVQ9kxKScTVZ6dKw2LdkHEuAZsd4mwnnAE+rAF16Cy3n
         EjgHLW/Dq+40EnZScCRz/+cekYydcOWDrLOLMK8qyMaWSgabbiJ9FrXQqXaAC8yX37Mq
         SQ4YQH2v/DvCy6Nl3IQ7Lilh8nYTW0IpQe5Ecw8Kg2xecZMFe9e2r3Gw2ZYdWnfvxz2I
         FUVc8/JFg/YeqT0AnXqoxwH+pcSLVYkwTrgUdi89L0VqNm48aQJIRoUcQWawvk0ZBqOW
         zeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SRegSipmA3f+livG8EQAkZ1mqxGwmQV1biD+cfEfPU=;
        b=0+Ea/jjsP2jqLWjgCJNuGey0iyqTbt4T4Zi86j3kt4D5VWcF41zAz7clFDoYkpR9Tm
         4O29IcwhQqjNK3zHm1TS/nzhDuJPBd5I/MTm5o96526/wNvdPhwxYx88g/HetmaEfIjT
         sq7JSvS/ZUqoblglhuvxsKliWGJuPsWUdyax3Z2sc9voZGISPwHSYGS7Tb6ysTzBQBkv
         yo7wVRaIJatuXFdEOKbralAdTKDzt9yGQ8vyxfZH5htfpRschvUJTWzLhVNwFNWwlEEq
         Li7J0G9Q3kMhlpD7Vk8+FGdKj1QKHjFXNiCDAEYGCEyBrKlS23bEWpHGxbvnU9ZDm9gZ
         H2Fg==
X-Gm-Message-State: AOAM533wIY/v8y9UpNqPRoElPTlEvG+KpgYj4e8inWr1rVhSsHflHCz2
        ZCgLb6ttYLN9kO8MsX9TkLdAcA==
X-Google-Smtp-Source: ABdhPJxm36UHhUz/BRpusNOZ88zhVJ7lJutFJ0FQWwv3HyIR5yNeFXEwhQWqRpQHOsa2kqQKCBovDA==
X-Received: by 2002:aa7:c49a:0:b0:425:d526:98ad with SMTP id m26-20020aa7c49a000000b00425d52698admr18232526edq.352.1651591288681;
        Tue, 03 May 2022 08:21:28 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e2fsm4794460ejc.149.2022.05.03.08.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:21:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: exynos: add atmel,24c128 fallback to Samsung EEPROM
Date:   Tue,  3 May 2022 17:21:26 +0200
Message-Id: <165159127802.229291.2960326490699633014.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426183443.243113-1-krzysztof.kozlowski@linaro.org>
References: <20220426183443.243113-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 20:34:43 +0200, Krzysztof Kozlowski wrote:
> The Samsung s524ad0xd1 EEPROM should use atmel,24c128 fallback,
> according to the AT24 EEPROM bindings.
> 
> 

Applied, thanks!

[1/1] ARM: dts: exynos: add atmel,24c128 fallback to Samsung EEPROM
      commit: f038e8186fbc5723d7d38c6fa1d342945107347e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
