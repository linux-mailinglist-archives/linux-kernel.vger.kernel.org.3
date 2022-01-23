Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2E0497371
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiAWRKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:10:46 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59222
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239136AbiAWRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:10:44 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DF2633F1BE
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642957843;
        bh=9aUVeDHijgpk/gPdmhnxkt4h8TZ5fsPsv2xLl017ipQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=HBF8rJH647PAOgyAXPxRwd4FzBWJimgJQINeSKLo1u4WZtdHM+BHlNHJ7mIaP6alM
         oBZyoL8d/hzo6Ga+njWrakX+T8c4bcqlAoXGlA3iPyXz79mUhB7F2Tj3X/7lsDqikM
         xv70tsNCkGJj9JIdMgvPh8UnS3s/9q9zmdysgl9/r7ZfwLsJS5N22g8uqC805rnfth
         TLb4N+t7GfM+IMDFhP+lOwMjbraH2fGwzID9GUHimYbrTpcHRiH7MWUQab4nWytD4y
         pxrR1aPy6GG59y7xXSdrhJX9Rd5fbrH3cn3O4fajQd0aJjyz0Znl9gNndhGeYQiDUj
         ATQUfg/U20Uig==
Received: by mail-ej1-f72.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso1525429ejj.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 09:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aUVeDHijgpk/gPdmhnxkt4h8TZ5fsPsv2xLl017ipQ=;
        b=553f6MHWkjlciOVXXiF3PNZSkhgipbxvySK9dViNBsvCAgL7a3jY2BuEo3jsemy/pz
         YAnnoMD5d3z3t9Di0rR+d2xu8yK67+05AMIkvJBeOBLVgXpfw2JfmTrM4N2PLsWJXACD
         S9UVGEUd1agsKr4NLOsTa0pQyEIJ7b/sg7z5572QQUD0ahMNJhmJnPZWudiSk9wzjN7E
         bH6wcfQ0gtK+PKEEV659+38Nkkt59erK18k5AZF1VEPHxfQLC0i5vgKfh6U8hcAo9act
         sISeKLdB1CaJ2SgSk3zg9/ebkwogH+S6m55FRYe9xR04Ci3Nr1Ke4YnM001OlhPNqerr
         8dHw==
X-Gm-Message-State: AOAM532vpokeqeuhfwXhK/BfCfprE9t7LEVcL0fnhbsOk7Vss/lP/zC+
        ND6XwmV1mpAuHfTRaG74xJTtVJsiT9jRDGkbyFNl1OaGnU6m+mtkU1cxrRT5ps3C8ukmua4BR3w
        NbbhNuXqIrFEJqHvC103sFRhhmBpZpLNwtDDvisoUng==
X-Received: by 2002:a17:906:4ccb:: with SMTP id q11mr10028609ejt.398.1642957843644;
        Sun, 23 Jan 2022 09:10:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMefem0jCf3PJq8lnGfLau04Ms1Hd+SIUWXl64m0Pg5L2zvBjINugQgs92nw/gH+x7IuW1rQ==
X-Received: by 2002:a17:906:4ccb:: with SMTP id q11mr10028597ejt.398.1642957843504;
        Sun, 23 Jan 2022 09:10:43 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l2sm5208665eds.28.2022.01.23.09.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 09:10:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/4] ARM: dts: exynos: Align MAX77836 nodes with dtschema on Monk and Rinato
Date:   Sun, 23 Jan 2022 18:10:36 +0100
Message-Id: <164295777264.25838.2090071538223607341.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174337.223320-2-krzysztof.kozlowski@canonical.com>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com> <20220111174337.223320-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 18:43:34 +0100, Krzysztof Kozlowski wrote:
> The newly introduced dtschema for MAX77836 MUIC requires proper naming
> of extcon child node.
> 
> This should not have actual impact on MFD children driver binding,
> because the max77836 MFD driver uses compatibles.
> 
> 
> [...]

Applied, thanks!

[1/4] ARM: dts: exynos: Align MAX77836 nodes with dtschema on Monk and Rinato
      commit: 8d6f5af71e2ada6214df028441d479e1925e105b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
