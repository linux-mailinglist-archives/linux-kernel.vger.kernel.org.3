Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF253F65E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbiFGGji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiFGGjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:39:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F6B043E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:39:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so33081842ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30/swRoGI7lxOeK/JCZOMenofIQ2Qnwy381c+smb4TA=;
        b=hRvd0fRQ06nsWwDyDjPYxTGsvqvXXrNQMbjT1Em4UrrOfqMzAG5qNorVycW89lVPlM
         /4d395QujBeRwU1UilsC99/3sC3wup/EJDNh4LKuI0DvkhJoZ9tAvIa6Uve607PoFRme
         2i09ToSIIxI+Tdx4TAk40sq2HIPtM52oEOsZwHI3qQtcUe0eBRno4BS+DdEYJGOExBx7
         LqplQKH0pLizRr1ziLYe5MBWbS4swqfviGOjwvMfj5PCWdxXRHy9XXu09/LjaUcphHwV
         9LaZSxuXkKdBAW5a3zSBLlkw/IJjmQEsdUMQxuH6RqPvrDbcc46SxLtUnE6GIRLLH0gq
         6eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30/swRoGI7lxOeK/JCZOMenofIQ2Qnwy381c+smb4TA=;
        b=YWIJZtakRjzUftC5+ivr2xT2eaF7V8dJ1YrnEW95Ps0ekXtYeU4STqwpe3fgmFXpyf
         DkowWXhTpM76pb4miPIE+7FflehFNminmHCQQm4YJbFHr8mhOntHgI9iYqWSJTQAtsyj
         WyAoAJIqb2Y2z7rTK1P9YQrE8HPv5xB8IXD1OsnOY04btcnF+DTp63D8gxAaMoyvk9SH
         RnU1xXB6+JhuylE/DXJyIe+klaGycPo1SRrTsWDnKXFRlc0SAFTmNEfhM+6fyfOOBqA5
         WKZCYltFWygN8petmPWlFtrSI1dXCD4POu2TPm69bcw2hA6zAC4Urb2nhyhq3sE0P6zj
         pYvw==
X-Gm-Message-State: AOAM530w4jWB0o3Ud7nfCdTWkBGJJCtMin6wDqIckJ+itiAKrAAGxq1x
        hCZGttKp8JAhUE9J+/7pAvwrtg==
X-Google-Smtp-Source: ABdhPJxPb4B1+kYdlB7X2PcS4f0mWtob9442OqwnUgNprAost6mEYGoTJP2LBYDLNSUfIEVPMRgI3Q==
X-Received: by 2002:a17:906:b816:b0:708:2e56:97d7 with SMTP id dv22-20020a170906b81600b007082e5697d7mr24712545ejb.502.1654583957338;
        Mon, 06 Jun 2022 23:39:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170906f6cd00b006febc86b8besm7016888ejb.117.2022.06.06.23.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:39:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Chanho Park <chanho61.park@samsung.com>
Subject: Re: (subset) [PATCH v3 2/8] ARM: dts: s3c64xx: use local header for pinctrl register values
Date:   Tue,  7 Jun 2022 08:39:10 +0200
Message-Id: <165458395109.7886.7299681625638246723.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605160508.134075-3-krzysztof.kozlowski@linaro.org>
References: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org> <20220605160508.134075-3-krzysztof.kozlowski@linaro.org>
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

On Sun, 5 Jun 2022 18:05:02 +0200, Krzysztof Kozlowski wrote:
> The DTS uses hardware register values directly in pin controller pin
> configuration.  These are not some IDs or other abstraction layer but
> raw numbers used in the registers.
> 
> These numbers were previously put in the bindings header to avoid code
> duplication and to provide some context meaning (name), but they do not
> fit the purpose of bindings.  It is also quite confusing to use
> constants prefixed with Exynos for other SoC, because there is actually
> nothing here in common, except the actual value.
> 
> [...]

Applied, thanks!

[2/8] ARM: dts: s3c64xx: use local header for pinctrl register values
      https://git.kernel.org/krzk/linux/c/468fff18c3776ced9bb466ae4fb2e30fdf671bef

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
