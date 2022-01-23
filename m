Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D79C497155
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbiAWLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:46:57 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38884
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236155AbiAWLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:46:55 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 99BF94004F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642938414;
        bh=xW+YGmQiJJj1p1WWiVxHQ1OgGBd61Y3FjFC1VcuSj1s=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=K+Y6HjLOPFh7cYPZKSkZglf1xG6ndj4QQ4CL/gGjiEoQt9f5aQPxrBosJ0UhZVptj
         1lwRXJv7vzGlSjnc3iPENHvm3kYs2F4XB4FVaFzFGTQsZV/Dh4vbF8dR6ccmPg4Ofi
         yiIancG+h0ytxJ8qWSbKEkRgSvo0SgFTKPfjIDMPE7mXylWeR91D7tdMKAIiG4TX1M
         /8ZIaLJP2KVdrArsFeBM4A7RR1BHVwED0Y1nFf1NwAaEq02UDNi0OjI4NA0IvowTSi
         udKX6JZQzv69mCkNI6RSQbLVsdfNlluPuQHOONDNDWRcBZKaq2d97guKJ2yA/H0lH1
         Q3O73Eeq7yFbQ==
Received: by mail-wm1-f70.google.com with SMTP id v190-20020a1cacc7000000b0034657bb6a66so5336122wme.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xW+YGmQiJJj1p1WWiVxHQ1OgGBd61Y3FjFC1VcuSj1s=;
        b=CZkIEVZDwlXJbAe76UfDxxDohsWAaXCPBPuzpxSopMnoup4MvyXZZMGUFBpqAexQLn
         770mqHuZC6R/F96qayRu1oN2YPpJzaGIQbbtDcMcvrC7Hs3fe7b0G70+catjz/QPAzJt
         v5kev65u32U5byg++3OCMqsh17sg80llSvIOcJvP+Teb/3APReJTrq/Z3JHz+eiedJAZ
         7r8pMskKR5uOEFI+ticudAcheJlJbjJCqwstaZnJgNWNnKOc7UXUbAwnbtRO7fQxtIPT
         asfLqq74Kp4d1DJGCwJ5Jwtk9aYEpRmYuBCWGWBggTLxJgKCqYlbvAYGFm9oG7GPji+W
         11zw==
X-Gm-Message-State: AOAM530rN8W4UesEbZNxilnzomDz5w3/TouzetnqXqyUHpPkcXONORHV
        MBJgHYVvor+QtJtRXk2F02hMga2eMGId8Ro/KX/4KEuQxgdlp4jl9iUPjUQEG21NKGqmoMnHb6k
        cZheqqXUOgEUisAmmof8/2mqMZo/VIqbBPZVZeQBWhw==
X-Received: by 2002:a5d:6309:: with SMTP id i9mr10510310wru.515.1642938414029;
        Sun, 23 Jan 2022 03:46:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3gjHuMG1cgKk2JjQFpBr5NwSCrmFi2W4JFjaulRbsjBoBRumkkLusFOIf5vI9TOY/6CyUzA==
X-Received: by 2002:a5d:6309:: with SMTP id i9mr10510299wru.515.1642938413887;
        Sun, 23 Jan 2022 03:46:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r2sm16992751wrz.99.2022.01.23.03.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:46:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH v2 00/28] pinctrl: dt-bindings: samsung: convert to dtschema
Date:   Sun, 23 Jan 2022 12:46:50 +0100
Message-Id: <164293835975.31601.16562955007803362485.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 21:13:58 +0100, Krzysztof Kozlowski wrote:
> Changes since v1
> ================
> 1. Patch #1: add missing pin assignment (Alim).
> 2. Patch #2: correct double sizeof() (Alim).
> 3. Patch #7, #8: put label-override in proper patch (Alim).
> 4. Patch #24: Extend doc, change the 'if' clause for wake-up interrupts.
> 5. New patches: #25 - #28.
>    Exynos850 and ExynosAutov9 seems to be different in pin ctrl interrupt
>    handling, so they need their own compatibles.
>    Please kindly review and provide feedback on these as I do not have
>    details.
> 6. Add review tags.
> 
> [...]

Applied, thanks!

To Samsung pinctrl tree:

[01/28] pinctrl: samsung: drop pin banks references on error paths
        commit: 50ebd19e3585b9792e994cfa8cbee8947fe06371
[02/28] pinctrl: samsung: accept GPIO bank nodes with a suffix
        commit: a29681b0cc3778c9ff6abdbcad579cba776dbb81
[24/28] dt-bindings: pinctrl: samsung: convert to dtschema
        commit: af030d83da1dc0d750d7bcc88d57dd1cae5f6b61
[25/28] dt-bindings: pinctrl: samsung: describe Exynos850 and ExynosAutov9 wake-ups
        commit: 1755e227c21636ade047dc9b920f647c1d53b4e9
[26/28] pinctrl: samsung: add support for Exynos850 and ExynosAutov9 wake-ups
        commit: 832ae134ccc1c78a2f5ec81b7010dd24c3c49535

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
