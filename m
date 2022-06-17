Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822D454F058
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379758AbiFQEnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiFQEm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:42:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53077175B6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:42:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a17so954396pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4V37PzSSXKazOVmuV/1IU57ztToNtg94rlJAvJFD1sQ=;
        b=dQmHVotLw4IesOZ7luY0HR/iX+MrLDKT0ZKGWEPGigCk429QtveK90O7Q50azInkN2
         LdghawqCiFx8bDhHgYBUkHrRGvSpcMnMtmkWqO6MJh6vKH5PO9fTMMZEn4XjZGmOi7Gk
         UddI65vmRAWvgoqiD296wWV9lO1yfEKCTUmbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4V37PzSSXKazOVmuV/1IU57ztToNtg94rlJAvJFD1sQ=;
        b=0OI6WFhgsBEaQjznzXaGfl9PhtymByNxLug8M/Uevot0k1QqdfypPj+UmCH1xfjuce
         ViweFc1nWYWe/eR6GEUxQL9uarA7m+OWs3ChhEVXgycX36Tpkol80yB8HdImchMKFXBa
         Nn8BJYb93r3yzjojfYCly3CJ+agezKzNjR1aSLKY/+o2Vx36Ex9DsC+Qdo9/0/qf/sva
         vO4zMZijmMfZVgBTLXXtK4SzUYj9wlE6qGnlZ/9ru0Hz71kN/Mettm5ZYGifAXWFIDPu
         Fl6kb8r2Uz0/CJvn83ObThKbjgzTg7ZwMBePXSwblT221hpe8dGCVelGAuOqcGfHF8+8
         XnOw==
X-Gm-Message-State: AJIora/kZelyKz0N0UsY2tbkDZ6VhJ3qjXtvrDI4ATbPCPOaNDth+rgM
        8Pi2Xg4w0HKUzeCI8HvOWgfKHQ==
X-Google-Smtp-Source: AGRyM1vSY638NYPK/58DYP7fId8cCruqCOjRTvP813l6kM7Fv/q2/SYgdJpIpHsRjUmSGDZua0Ht+A==
X-Received: by 2002:a17:90a:7841:b0:1ea:3f61:7673 with SMTP id y1-20020a17090a784100b001ea3f617673mr8761152pjl.110.1655440977740;
        Thu, 16 Jun 2022 21:42:57 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a778800b001eab0a27d92sm4491030pjk.51.2022.06.16.21.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 21:42:56 -0700 (PDT)
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
Subject: [PATCH v3 0/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Date:   Fri, 17 Jun 2022 04:42:48 +0000
Message-Id: <20220617044251.4029697-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220616155836.3401420-1-judyhsiao@chromium.org>
References: <20220616155836.3401420-1-judyhsiao@chromium.org>
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

Changes Since V3:
    -- Fix indentation in the documentation.
    -- Put pinctrl-1 right after pinctrl-0 in dtsi.
    -- Fix indentation in the driver.
    -- Remove unnecessary dev_dbg() in the driver.
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
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  25 ++-
 sound/soc/rockchip/rockchip_i2s.c             | 167 +++++++++++++-----
 4 files changed, 162 insertions(+), 47 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

