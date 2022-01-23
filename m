Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F41049736F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiAWRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:10:44 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43070
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236887AbiAWRKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:10:43 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C62DD3FFFD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642957842;
        bh=oATqwnnt1psqOh66KQd7jqPYNnGRg6p0+5NzS2CTiIc=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Hj/JFfC886d/d7CHa/VgQL+DY7TcpnX1xprqOnsHzTbXCwfrh30HPjIUjAuPmEDe5
         44DW+y4x5l/bJEMKNuR0m51k1YM5I67DoNA6bdPP8tOfg5tXOBCSsmMjtIDvFz7Jye
         OKfTjRZD9qvor4qotMZvbrUCfX8qYr9qb0sIdMRgY47h1dgKECBz8nwiGTBpS5wbVd
         zu9LqOroW4aWj3ImyFEjmwt26m9W/kkStFrAERDmW8kOu+6T9rd//hk8S+bo+JItv9
         awWnU8dy8kNWTLXBp0X57vrJBriWBuKeBaB5NNJGB5LmT/ROTb/8ql10HAC3UrfSSc
         xcAqczkwT5wgQ==
Received: by mail-ed1-f71.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso11658309edw.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 09:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oATqwnnt1psqOh66KQd7jqPYNnGRg6p0+5NzS2CTiIc=;
        b=kjFTdC/COQotJiZgqDeisJnNAFYZ5ripGA0JUhVchLzdEgoz9sawN3nS4TY95YYJko
         XrRDb1oOar8wn1qqSnTQwXoef+zuLWCFqK/zL7IF68K/LakDVz/FNbYohxvvvEVcLX0H
         xrModcuIiqJgzR516qZNOXhcKNeoT8FHjTUUeGFH49JbDlEfoFW+boD427fUCbEH/Nke
         KL9U7Pb+z5TzDGUt0HT6Jydqh3CbBmiqfb5DiV55Vnk2ihc7z8fJQr7p3BUAZCmIEwAH
         RRufGhkLuI69quTWuJ2JdkCP0kg6Hz3Zchjrk3N7ac+arT3KJHoEz8fcFrDhRlIjh2+Q
         4Bew==
X-Gm-Message-State: AOAM531zIkn3l5yZQoUoO53mYTYxN1U8T5CPFJUZ41veGzcSRl1WwPX0
        EUfwa1/yvHbM1N93d2pMIRXmf2rDXFENzJohe3NZWnwV1/Xih9DtHIsdG/9oA6buVBUnZCiSwG7
        VKc30mHUioVoW1C1FPzhHQzkEGJKSKk8Z4nqF5HpavA==
X-Received: by 2002:a05:6402:27c7:: with SMTP id c7mr12386184ede.374.1642957842414;
        Sun, 23 Jan 2022 09:10:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYzOwXpiIcmy0TMEcsWeUpUssbAvC3Y0LO9o1XWtKWmkgSFkP1GQNwRqbSopfXFwEGiLHajg==
X-Received: by 2002:a05:6402:27c7:: with SMTP id c7mr12386176ede.374.1642957842232;
        Sun, 23 Jan 2022 09:10:42 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l2sm5208665eds.28.2022.01.23.09.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 09:10:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 2/8] ARM: dts: exynos: add necessary clock controller inputs in Exynos5260
Date:   Sun, 23 Jan 2022 18:10:35 +0100
Message-Id: <164295777264.25838.15093344260237063219.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220102115356.75796-2-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com> <20220102115356.75796-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jan 2022 12:53:50 +0100, Krzysztof Kozlowski wrote:
> Exynos5260 bindings require to feed clock controllers with certain clock
> inputs.  The IO clocks are expected to be provided by the board.  The
> PHY clocks are usually followed by mux which can choose between the PHY
> clock and main 24 MHz oscillator, so skip defining them and just use the
> latter one.
> 
> 
> [...]

Applied, thanks!

[2/8] ARM: dts: exynos: add necessary clock controller inputs in Exynos5260
      commit: 9eb8090f95e2ef8d19ebce6a77e87b26b56fc831

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
