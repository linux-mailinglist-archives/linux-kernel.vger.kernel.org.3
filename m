Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61BE5570EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377305AbiFWCML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiFWCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:12:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BAF220F3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:12:01 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso1127124pjn.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRLTpselmSzOmfEMzptO0DKyWBgV2uZm8FqGFEjaV8s=;
        b=BR2naSce8Q38Guq9+xSEESPiRtMPfWntr5oX3C6t9VIHlwzBOfmM9RhSLX9CWTsMYW
         2gUyBX0+UTMKdPEfxtmCJ4CA1pEbwNKXe4xcp3Vq2XvN3KCbwROgQnoECWpG9Sb6mwL5
         ysQgodcgLMBdNiZaq+cVygPxvvgpSBqG3a8w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRLTpselmSzOmfEMzptO0DKyWBgV2uZm8FqGFEjaV8s=;
        b=4CM6bvPU4NUpVjjvzBnFI3NeF0aOrOcUCXJXc9iGUeSQyTrC7vWtHsDxG9XGOk+H+g
         CCmvmPRVQuwTnpJvq359c9NBhf8urBT+MlTujtFGuFPGrFdozuHe6iOKSM+QYVyIpkNf
         +tpJzsd8UTo+5iCcT1n1SE6h81m0X2fOGrY85YRwDqOtMv4VLeptkMx+IY/EeC24sSZc
         Kx/YHEWzyDhEdyMZ1R+8cmdiwqbZV2gn/VshD+ZNAQ8okQtJmStETA4OGIxvApgRZkGb
         ZiS7IR7HujrkyKnhNfXkB/+8hAUzWz3HWEcOF+yps0ebSNwieTqohoQKNwX/Sw2Y4TnS
         GX8g==
X-Gm-Message-State: AJIora822ylT5DCxPt32ZrQVSAzj5TpIyAae2I2TL9BJ2jvpENUXQVxz
        BVYfDAPbeIr/EXW9t7rGKhb6QA==
X-Google-Smtp-Source: AGRyM1to8GFgYWhfCWzgrps3P2NpjJ8gdP3iEDZCUi592P2vqic1MM8S2D55xH9pxFCZWiiBnYgG1A==
X-Received: by 2002:a17:902:e848:b0:167:6ef7:b093 with SMTP id t8-20020a170902e84800b001676ef7b093mr36677142plg.154.1655950320778;
        Wed, 22 Jun 2022 19:12:00 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902768600b0016196bd15f4sm6194000pll.15.2022.06.22.19.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 19:12:00 -0700 (PDT)
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
Subject: [PATCH v5 0/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Date:   Thu, 23 Jun 2022 02:11:50 +0000
Message-Id: <20220623021153.587423-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
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

The patches series is to fix the unexpected large DC output
voltage of Max98357a that burns the speakers on the rockchip
platform when BCLK and SD_MODE are ON but LRCLK is OFF.

Changes Since V5:
    -- Check i2s->pinctrl is valid before using pinctrl_lookup_state.
Changes Since V4:
    -- Fix indentation in the driver. (Align parameters with the parenthesis
       placement.)
    -- Fix incorrect return type of rockchip_snd_rxctrl.
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
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  10 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  25 ++-
 sound/soc/rockchip/rockchip_i2s.c             | 171 +++++++++++++-----
 4 files changed, 165 insertions(+), 48 deletions(-)

-- 
2.37.0.rc0.104.g0611611a94-goog

