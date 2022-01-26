Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8849C711
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiAZKGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:06:31 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49686
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239581AbiAZKGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:06:30 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C05140049
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643191589;
        bh=Sjgv+P4vErk8QuuLdD8vbkXOQssB6budl50epcjkaFo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=sY/OKKObgKMy0bQ11LA7cvkAeF1qzK55GtLZPteC1Tbs9M0Uh3dapQhLxBEBSU5dG
         7+W5cAqTY91plhuDqDtHGrsy8msJHDEiaijH7qiMyiHvFhdYYGHtrDDNkFXifWI8Dm
         MEEZGYoUDWPh/3zGkLyb9IAZ/LMLXC8RfedmxyMhAxdVABSJi3AhUzlGjxV9Csr/Nv
         /0WyIBl10+GwMjQopA34Ku2xzbhLE6ei+Yn4vwvI5F1fPHzFL20lkwI5kClEc6Ic4d
         ogi3gQPAPencdi5eZAfFAIWXyV7SrymNO8xckgSY1HARMv5nATXNtihz6PRfSxD6/Z
         waWZPMLSFMOew==
Received: by mail-wr1-f70.google.com with SMTP id c9-20020adfa709000000b001dde29c3202so230308wrd.22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sjgv+P4vErk8QuuLdD8vbkXOQssB6budl50epcjkaFo=;
        b=8Bt1qaAliK0+QkIEm7urralrDFTSjYqW1rPedXoYFZRMbjzCp71PGBS61UZTWiEqDD
         RZ3sVIFRTgyYkBBctnJZiAx8eIOg0wqni2TdYcoEccYckNNSUXRdf+p15siWIu3xtPX3
         G67B7OQipnKQ21KofMDjJb9ERags/P9K07G/yTtL4TkzqDeQmpl44d1WeTiF9K1bFqrA
         VjZn2mVr9TL2NotZsRkj2DYUJcjtnua1P24wysRgfUbyLChx12kOxm6nieLvMNgKfNah
         aPXSJHmQyVOKpSb5ph1ImB+t8NetYjg5xI7blNFBZ42+G3o7QQ+cUzF/l1HoynORZcwt
         E9Cg==
X-Gm-Message-State: AOAM532oxvDmYm7s/LWhtn2a/D9X99a1Wetq4LTtIkuvpqrNRlGg3Dwt
        8+3YbEsSrvVMqP1O5nX+id1AA8iCksa+lWktwz+R50BfH8NhITuQOwybs7K8G6xlv068SY1qPwO
        H5XZdD6O+AD620sFYeFHDoAEeOo8j3lNkiSS4gPTwWg==
X-Received: by 2002:a5d:6f08:: with SMTP id ay8mr6187702wrb.296.1643191586510;
        Wed, 26 Jan 2022 02:06:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQWxymgwDG/P6gJ5lAlxBJfkupquZBQk77a4LSrbyGJvYoG0Zub8FJabFUyrBLH4OAJL4WfQ==
X-Received: by 2002:a5d:6f08:: with SMTP id ay8mr6187677wrb.296.1643191586317;
        Wed, 26 Jan 2022 02:06:26 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m8sm10165544wrn.106.2022.01.26.02.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 02:06:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, s.nawrocki@samsung.com, arnd@arndb.de,
        pankaj.dubey@samsung.com, linux-clk@vger.kernel.org,
        linus.walleij@linaro.org, olof@lixom.net, sboyd@kernel.org
Subject: Re: [PATCH v5 00/16] Add support for Tesla Full Self-Driving (FSD) SoC (clock parts)
Date:   Wed, 26 Jan 2022 11:05:49 +0100
Message-Id: <164319151879.214823.14786470465879458997.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
References: <CGME20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b@epcas5p2.samsung.com> <20220124141644.71052-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 19:46:28 +0530, Alim Akhtar wrote:
> Adds basic support for the Tesla Full Self-Driving (FSD)
> SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
> as well as several IPs.
> 
> Patches 1 to 9 provide support for the clock controller
> (which is designed similarly to Exynos SoCs).
> 
> [...]

Applied also clock parts, thanks!

[01/16] dt-bindings: add vendor prefix for Tesla
        commit: a5a93e9b9ab9b4f367a773b32bbe1687006d75b7
[02/16] dt-bindings: clock: Add bindings definitions for FSD CMU blocks
        commit: d6dc675377261472adda696da456b4ebcc5bb9d9
[03/16] dt-bindings: clock: Document FSD CMU bindings
        commit: ed68db7b7f2fd01e930fa3e6fbb75954dc25e41c
[04/16] clk: samsung: fsd: Add initial clock support
        commit: 4f346005aaed641042ca18171c4383a6a85f6a8b
[05/16] clk: samsung: fsd: Add cmu_peric block clock information
        commit: e3f3dc3810d3765128d28b241f4afb761d81678a
[06/16] clk: samsung: fsd: Add cmu_fsys0 clock information
        commit: a15e367b02543f96ae845baf7be4526080437305
[07/16] clk: samsung: fsd: Add cmu_fsys1 clock information
        commit: bfbce52e4649b9a2c7296a6296ffbdfc3b07de2e
[08/16] clk: samsung: fsd: Add cmu_imem block clock information
        commit: ca0fdfd131c7d33984d8feeda23a99e883ffb0cb
[09/16] clk: samsung: fsd: Add cmu_mfc block clock information
        commit: 75c50afaa0d9a3e8f96940451bed6d0ccc6a0a03
[10/16] clk: samsung: fsd: Add cam_csi block clock information
        commit: b826c3e4de1a44ad8e5536d86d5ef062a54ed2b2
[13/16] dt-bindings: arm: add Tesla FSD ARM SoC
        commit: d25c5eb511df3439cd91517bcbce4b274f8972b9
[14/16] arm64: dts: fsd: Add initial device tree support
        commit: 18b1db6a162c29695920fdf212ccb8d7d5c07e9a
[15/16] arm64: dts: fsd: Add initial pinctrl support
        commit: 684dac402f212d8ededbe7d97bc42a5e49533f40
[16/16] arm64: defconfig: Enable Tesla FSD SoC
        commit: 0d525a653b03a25190650f783026c8e655268b48

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
