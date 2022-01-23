Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F067A497157
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiAWLrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:47:02 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56418
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236141AbiAWLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:46:56 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 972A33F1CF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642938415;
        bh=t1Mr2leewf+dJOw+raj7dTmlAldoGuESwLMLnJL3mUo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=UeSY7HEbDIEI29Yuog5Wc7qmAGEEkRRL4gUX8ShE0tLoKj/CAI5idXe2LkObNTRYT
         GkDg9xVTO3wQ1QLw+ZubpMrqAnrabalTOTE0+qKgkCEstqIUpIqroVNnaVuawms4b/
         AFYThjE8TMfGb6FJLrrVbANly3ZcIns76N0xF0yoJbaUUXlicLDeX1SsHn1Q4H0Hec
         aQDXPRnAIqoH4xYj1E/bgQDS5Z36S39LSv6Fy76kP7o8Qo3Dup3Bkdvw5Bo2qJfx8+
         wNO2IUzae016VE+1eY2mmCdKOSOQfR9yDvlxYpG2RWAM5QPmHYpZxTEvL8cSCYjje1
         U8F4m4n891yzg==
Received: by mail-wm1-f72.google.com with SMTP id t2-20020a1c4602000000b0034f93a88debso76109wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1Mr2leewf+dJOw+raj7dTmlAldoGuESwLMLnJL3mUo=;
        b=MTIFURiKAAGbzzXxgkBbrinoPDnzqGwZRQiWH6qtbHhSIP6Q+t69YWflsxMjbHhsP4
         4LtzRm0eKVYU1gu6JnI1H8dE3Nl4KkHOsxEfn5ewS7NpcRrwNMiC2gL8AgDGx6d8EVJI
         +q/zLoTSfohYqzAH5iuTwumTAvjox1Ile3qaIL4itHQHDsVT5KlcEIKxLt3yUVnv1dad
         UIUMSOA2RZyi1mlxGnx4ZaIOYkAsYMLPkY1VPi6z3N9Qwy51iG4PB4GijBTXUhjrll7m
         AvsMPbCHWwpXKqiU2U35okXeHIsJ0N+WZpXTtgWNvc5/bVZYJkrw8wRcaREmJbOKG85L
         cfvg==
X-Gm-Message-State: AOAM532/jIPkbAFLXz5EoIX/Yk5Yh6eh3uRSt4dn0UcSqKJhMUCczuPR
        E/1Qce8Y6kGalv5TK79YsBEec4EubGIeLk8t/5OXOGjsmyeBh4GsMSsZycMqZGyOx8Bz9GDUBep
        NV/CGugENlR8l1l6jGVJFK4RndE1VzQJcwsH3sIpAGw==
X-Received: by 2002:a5d:6e83:: with SMTP id k3mr10395743wrz.506.1642938415402;
        Sun, 23 Jan 2022 03:46:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzS480IySxN7r/zMW68vwN+Cqc0h0XRSdNUxo2T7syZh+fpKi38vkV6Glz0y+IeA+oKqVXahQ==
X-Received: by 2002:a5d:6e83:: with SMTP id k3mr10395729wrz.506.1642938415273;
        Sun, 23 Jan 2022 03:46:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r2sm16992751wrz.99.2022.01.23.03.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:46:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] pinctrl: samsung: Remove EINT handler for Exynos850 ALIVE and CMGP gpios
Date:   Sun, 23 Jan 2022 12:46:51 +0100
Message-Id: <164293835975.31601.16620899683024964008.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220114203757.4860-1-semen.protsenko@linaro.org>
References: <20220114203757.4860-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 22:37:57 +0200, Sam Protsenko wrote:
> GPIO_ALIVE and GPIO_CMGP blocks in Exynos850 SoC don't have EINT
> capabilities (like EINT_SVC register), and there are no corresponding
> interrupts wired to GIC. Instead those blocks have wake-up interrupts
> for each pin. The ".eint_gpio_init" callbacks were specified by mistake
> for these blocks, when porting pinctrl code from downstream kernel. That
> leads to error messages like this:
> 
> [...]

Applied, thanks!

[1/1] pinctrl: samsung: Remove EINT handler for Exynos850 ALIVE and CMGP gpios
      commit: 96f79935015cf3d7ca6fabf63cd13b8af45a7713

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
