Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AB354E67B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377293AbiFPP64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiFPP6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:58:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1289111C2F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:58:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 187so1865731pfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dt7moyOGq/wGPX6up0TVePAZeRh2KcSmjYDlmf94HxE=;
        b=etAzaLvBUF3LEk3BYYPg9CD5v+EkBJJTvunVknq9iG/wLOY/Le32cBqexS0UkwiMlm
         ETzSnFjod9eT57QJBIyjiwXD7Ji0tFwwKHTkKj1Ize6vtPyw2HENYoBzT1QYSCFPVmH1
         oC8sYIl2DMZmXaRla94BaQApJ2Rdu8zrT5qdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dt7moyOGq/wGPX6up0TVePAZeRh2KcSmjYDlmf94HxE=;
        b=t4nDHNVFGgrPxkvRUJ9poQjfyEOEAxGvdSOpdkj0TAPam7YBI4pquhHx1xZgFzVf7r
         P4sjQb3qvUWdYHfqu8xoERgEOA9gF64uXLEVqpjqWwY7noC9hBWVls4htx+vU9aAx4b7
         0mEfc4JhIIA6aCM5i+001aiaERxX6otkoM7op4es+PjNvj0CUKGZxv40L2P6capKE9wm
         JwIPKAMEZVdq7be8fIZBPtIvo4bRkyGaDzVpGNRSf86ftd223ZyC3MOHWreffUb0LeZB
         Ddsjc4kZw4/tmrV5LCiEnbsQDUus9Ht53VKbWcGebYpc41dGf7Ln4CRscdkXO4dMiPmj
         YFOw==
X-Gm-Message-State: AJIora9CQLPeAPGI/ZsPwial1QPdtU5DBhN799V3yNKDgG0D4nh+1Igy
        J/Ncap0CeIx7ha/Rw3k0VIj1yQ==
X-Google-Smtp-Source: AGRyM1t0X7UHlN5X6Tiqx+yKhBWm7VLeGVTI8ighHLTVurpkRre+vuBb+6E5+wGZ4rm7QDhfp1ipTg==
X-Received: by 2002:aa7:888c:0:b0:505:7832:98fc with SMTP id z12-20020aa7888c000000b00505783298fcmr5333501pfe.0.1655395133562;
        Thu, 16 Jun 2022 08:58:53 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b00161478027f5sm1779797pln.150.2022.06.16.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:58:53 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v2 0/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Date:   Thu, 16 Jun 2022 15:58:33 +0000
Message-Id: <20220616155836.3401420-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches series is to fix the unexpected large
DC output voltage of Max98357a to burn the speakers 
on rockchip platform when BCLK and SD_MODE are ON but LRCLK is OFF.

Changes Since V2:
    -- Add documents of i2s pinctrl-names.
    -- Fix dtsi syntax error.
    -- Include the dtsi change and the driver change in the same series.
    -- Ensure that driver gets both bclk_on and bclk_off states before using them.

Judy Hsiao (3):
  ASoC: rockchip: i2s: switch BCLK to GPIO
  arm64: dts: rk3399: i2s: switch BCLK to GPIO
  ASoC: dt-bindings: rockchip: Document pinctrl-names for i2s

 .../bindings/sound/rockchip-i2s.yaml          |   7 +
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  10 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  25 +++-
 sound/soc/rockchip/rockchip_i2s.c             | 134 ++++++++++++++----
 4 files changed, 149 insertions(+), 27 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

