Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFB566A18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiGELpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiGELpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:45:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745617066
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:45:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y16so20049370lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 04:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=saFvUNutIkwJIKsbwz8el/rLQChL+0J42iD0Z120Xzc=;
        b=Cim0tg3iFz2KhUJTKw3IyP80HUNfdvp5Agu8fvMVkk1HcwZhott9laYab/fNuaBCGa
         903nQG8cEHoV61S2FQ2hdCw6aLoD4ClzIk3+FOLWZKt6FuySDmVlpjhhVKQO38SMB/2H
         fJduhDoF7T41KrGkj8kbaEOTPlWpiI69h3frLX1MD18LbaTZ129W1ymX5aVSyWa4OtI2
         IhhES0TJq23BuA9ipFDUTCcZddCU6oF5SHPIsXsv/MaYTouo64/JwVKGiGG9k4FA0hrj
         b643syRu+XZjy/ilRtfXetpxM/pKbvMLoCmLolYDI4v54wbwXUn1x2/848H6XbPwdxzT
         7W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saFvUNutIkwJIKsbwz8el/rLQChL+0J42iD0Z120Xzc=;
        b=4dwOEM1WcmMclXyQYQQpnKHXk9przE2HMeeQr0RvzEBY9RtCsn5vK84iibmR7iqhWq
         BLyNJS5eCGORukjphcABn3c8svJWqlqoPD9cLV8KYLhy/dU6CGsN0MYMijQ8Xwud8f0O
         eS007xepwuf3iwV7yCOkqBK+rWwixjOK069WGizktBmmCJz8lGFLirWvjBiOREUvC7J2
         SqcMVjRKC7rJJ3G5V3wmrZK/T+8mE1wfw4jS3wydv4it8KkutnWC900mHLQvRVM+UKtJ
         LuME4iN25YwAtKIatG8VheP8q2yjgCi3N9/OehC/KXGm1VorYbYTjs5W2YrzEuHK7PfK
         27ag==
X-Gm-Message-State: AJIora/FcT4coW+pQ2hvDWjaQ1IRUK3N9qMzRXTyduLPyYazWztwgVLD
        IFTrGghIcM/eBKBNHlGDYwO8hQ==
X-Google-Smtp-Source: AGRyM1tuXKUJiOGHda53Ozd2LS6VSQPa3uTR2aZkiqj9hvpwiZLHrKaLXbCvgJN5f2K1LhTPfr9Dhg==
X-Received: by 2002:ac2:4a63:0:b0:47f:9e6d:603b with SMTP id q3-20020ac24a63000000b0047f9e6d603bmr21856388lfp.404.1657021547120;
        Tue, 05 Jul 2022 04:45:47 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512374c00b0048137a6486bsm3543694lfs.228.2022.07.05.04.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 04:45:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     olof@lixom.net, krzysztof.kozlowski@linaro.org, arm@kernel.org,
        andrew@aj.id.au, soc@kernel.org, joel@jms.id.au,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 37/40] ARM: dts: aspeed: correct gpio-keys properties
Date:   Tue,  5 Jul 2022 13:45:43 +0200
Message-Id: <165702154046.92998.13819034081421883351.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-37-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-37-krzysztof.kozlowski@linaro.org>
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

On Wed, 15 Jun 2022 17:53:30 -0700, Krzysztof Kozlowski wrote:
> gpio-keys children do not use unit addresses.
> 
> 

Applied, thanks!

[37/40] ARM: dts: aspeed: correct gpio-keys properties
        https://git.kernel.org/krzk/linux/c/bafd5bb5ea496c8fc443e6b9de70af840bec0b9c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
