Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B6155098E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiFSJxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 05:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiFSJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 05:53:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1975DB874
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 02:53:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso8228933pjg.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kR0nPmihBKg/JVQtdlu4B3iD3y1xFJeR/L3hKnfirkg=;
        b=Ujfw05oCO6CQHlxIt9U1/Vw2jZz2wiVAu2MidO2JcQLF7s5nkeLtX+pXVg0r+JG7Rq
         bspYGi4fxvj/xaZ96AGR+/2wKEL8/NTtY2c8USzvxw8l9fcUpS41zrHtRVsNA/M50cgw
         jGn6RF4QAyzCyK8+RxV6AHBAabXA7pT2Kp29w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kR0nPmihBKg/JVQtdlu4B3iD3y1xFJeR/L3hKnfirkg=;
        b=Tx8LugoZ3tRsaXXeUdF/bbgcHeIKht3vj+SXqQ0q9Wx9set33E59dxSGdf3UEV3eAQ
         O/a1fRop/L3+5tYY3DHe6tHABnubxwcgnWHpfy49+VhBw+F7Plyj9IejeoAA0HPTUqE8
         GX4L7Xqb8Gonr624Dp86kvJ5b9ZpC76aAGl6yImeOmqWWx2ERnV1FaVFBdEOlvxrWeFi
         REdaP3S6xov9n+l0FZcJxLyGzBUC9eBc6nD7az8cdM55Hz3aavUv5JWa9H47v5HAoZFV
         jvalXWXDqLq/G/7XIXz65tv1XVv+b+pheia4HssbS6r9635TYZ9eONzOkPdRCHn2NCGF
         Ln0A==
X-Gm-Message-State: AJIora8kLnIv3nyJh8uMzrU0Hws0jF0pUgByeOzbQjTKeahkl+XW+J+h
        jvvTcmTvyy9+K2avDvcT+NvkYw==
X-Google-Smtp-Source: AGRyM1v7zPmyGbZPOSnbb98hniYzON8YpxLeYV5xLE/gaU76OD8LpMvcKXf8EiPwhBviJK2jxy4o0Q==
X-Received: by 2002:a17:90a:e418:b0:1ec:9908:d5f0 with SMTP id hv24-20020a17090ae41800b001ec9908d5f0mr3170210pjb.7.1655632411623;
        Sun, 19 Jun 2022 02:53:31 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id 135-20020a62178d000000b0050dc762817esm6799971pfx.88.2022.06.19.02.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 02:53:30 -0700 (PDT)
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
Subject: [PATCH v4 0/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Date:   Sun, 19 Jun 2022 09:53:21 +0000
Message-Id: <20220619095324.492678-1-judyhsiao@chromium.org>
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

The patches series is to fix the unexpected large DC output
voltage of Max98357a that burns the speakers on the rockchip
platform when BCLK and SD_MODE are ON but LRCLK is OFF.

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
2.36.1.476.g0c4daa206d-goog

