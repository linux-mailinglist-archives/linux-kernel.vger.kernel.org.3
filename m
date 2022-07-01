Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA2B5628CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiGACOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiGACOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:14:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D5B60529
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:14:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y141so1108361pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nG6eb4+X5Ja/3xTBDEgAUy+rU3+Q7DlGcjeg+QB5NE=;
        b=AhRwhX3qb9Gd5pjZU3Ju6++wdDeh9TWEcwxe7bHgCzd2uV4SQi6lmZjo/YF93Keivu
         nppBG2JkTguvnOU2sKHsipgtfl7GIDry14WJl07b4OcAOSRUuxdFebUItxXO/SHmei2x
         Na8FewAQ1/FvgOHmArf8p6ak4Dcvc3Dq0r1lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nG6eb4+X5Ja/3xTBDEgAUy+rU3+Q7DlGcjeg+QB5NE=;
        b=Wkp0TEEOlidEIlLDaM2UmIdfgpNFO/agIe6h8h370nLTOmxUIFlU50JtPoIXyTvV0T
         DpaUmo6ZnQ7yL/qFUIJY1JzO58dyfbqauTXh0X69PeZa4+JcmaE8QWFdCOHSBDMaL56k
         P+rAtXdlKNpPktvocfKzeD3G+CnEhlffbRk+0IeUbwr1dxZerHQ+5VZLf1lX4m0M69iq
         fIFr/rlAmEfxhGO33NFiUtgjBHZwEW6GyybrzVC1yccl+lmPg3yE3B5pkEZBgMxmxxGN
         dPgfLD6fnB7JV17YCEEjnckVrbDhrnUb9e1D3gWYEay0RSpOGOR5YlHEm8QIVTHvrUsG
         aqSw==
X-Gm-Message-State: AJIora9iT9GNjUqO5KAuzKRNGaowUwG6Ra7ctt7HV9NyfCTeE9+QG5i2
        w7s83IFFL9uPnrbQAE6/sysGoQ==
X-Google-Smtp-Source: AGRyM1vT575BCyuGLho/NbkSLyh3jD8NuJm0rgeF42h3/GJvEzoiIL/ra/yU9Bj42AjH05umGXxiJw==
X-Received: by 2002:a63:4d4f:0:b0:3fd:f4a1:93db with SMTP id n15-20020a634d4f000000b003fdf4a193dbmr10451410pgl.374.1656641674280;
        Thu, 30 Jun 2022 19:14:34 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7949d000000b0052515e20df8sm14423596pfk.152.2022.06.30.19.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 19:14:33 -0700 (PDT)
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
Subject: [PATCH v1] FROMGIT: ASoC: rockchip: i2s: Fix error code when fail to read I2S_CLR
Date:   Fri,  1 Jul 2022 02:14:27 +0000
Message-Id: <20220701021427.3120549-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the error code '-EBUSY' when fail to read I2S_CLR
in rockchip_snd_rxctrl() and rockchip_snd_txctrl()

Fixes: 44f362c2cc6d ("ASoC: rockchip: i2s: switch BCLK to GPIO")
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index f783994cc16a..fd36c0bacc43 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -171,6 +171,7 @@ static int rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 				retry--;
 				if (!retry) {
 					dev_warn(i2s->dev, "fail to clear\n");
+					ret = -EBUSY;
 					break;
 				}
 			}
@@ -232,6 +233,7 @@ static int rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 				retry--;
 				if (!retry) {
 					dev_warn(i2s->dev, "fail to clear\n");
+					ret = -EBUSY;
 					break;
 				}
 			}
-- 
2.37.0.rc0.161.g10f37bed90-goog

