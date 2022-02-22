Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18BA4BF791
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiBVMBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiBVMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:26 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7574C156C6B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o24so32757530wro.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PovLFlAjWbVecaLj2Jyj4ZWgXRh7VtxF4soiFyKrJgg=;
        b=RPo2H0r344YT+gcGkz/K6ZQ4DgEydlk2KAkMh1T6kF+gXl17FFLgt4QiphRmGmCOwf
         tDv69AMM0cOWCQa55Kx4ax2/HI56fhYMoZrGMY1mxbWLG5d8DKRIeRO94RGN/cIEN81U
         7RTJcwumUoW3P6Rp2knoV76ajl/ent7tOHK5zuYamkLnwipiWtmkKOE3SSC3wQHkH5GF
         kRDbRGyqkiL1F6+FFLNLde/c7lne+amzDqyhxrCi8gAxrtFykuRXoukliI3ptsqWw23G
         0+z2Z3hl0g2CCT4TVBAbuDZ2CQcJdTayk4DM6PDoK8D/hx9xoBch1YiJa5Qk8fPIVrRf
         srpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PovLFlAjWbVecaLj2Jyj4ZWgXRh7VtxF4soiFyKrJgg=;
        b=6txVWO2QnKBLnWCzC7leiZC7EozcFYNzi72UcUr/QmUfscixTRROwM7T+lYof3uvDo
         kkXui/cBv1MLnMn1uzN81qI7jgLCFXFzMzPQ/LQC08zd9ak26FwW9MsLX7Dz+MO90m0a
         bDlGTNdl8GBdjMZ6cIT/yd8kMAAbZ5kHuUL2tWOb1wZyI2PvfzM2UuYEhHug/3IQXAVe
         ciGWmUTIaCgKcOzA2eF0Lb1mduwV9JDr5sJMiiUPdDgsgtxja4gOocYwoJYHomDC+u4W
         5cRYrTE58o14qPA5OsETnkXBGPBusW/og3yIZs7ble9DtWTNoEcy+DLEGKjsFPneQVvI
         9Lrw==
X-Gm-Message-State: AOAM533FrIaWZS7mqrcPkIZRRvR5w3fXVFGom1epDjJ7Fmq+YLIzFffZ
        YWr64mTIm9EdKpnrPOmNdfqHsw==
X-Google-Smtp-Source: ABdhPJxoRUq2WzjRe6cKbSthqOXk77aleSu329nCmKU4CL67S3d0nugmziFoGclsdJjqwrFWUzbMxA==
X-Received: by 2002:a5d:5986:0:b0:1ea:75c6:3d0a with SMTP id n6-20020a5d5986000000b001ea75c63d0amr4634125wri.166.1645531199050;
        Tue, 22 Feb 2022 03:59:59 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/16] ASoC: codecs: tx-macro: fix tlv min max range
Date:   Tue, 22 Feb 2022 11:59:28 +0000
Message-Id: <20220222115933.9114-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on Qualcomm codecs gain tlv control specifies min max range as both
negative to positive numbers like

SOC_SINGLE_S8_TLV("... Volume", ..,  -84, 40, gain)

However with recent boundary checks added in commit 817f7c9335ec0
("ASoC: ops: Reject out of bounds values in snd_soc_put_volsw())
setting a value above 40 gain will fail.

So fix this min max range correctly to
SOC_SINGLE_S8_TLV("... Volume", ..,  0, 124, gain)
so that users can now set gain correctly

Fixes: c39667ddcfc5 ("ASoC: codecs: lpass-tx-macro: add support for lpass tx macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index f90786100d1a..56c1f3cf73f8 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1600,28 +1600,28 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 static const struct snd_kcontrol_new tx_macro_snd_controls[] = {
 	SOC_SINGLE_S8_TLV("TX_DEC0 Volume",
 			  CDC_TX0_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("TX_DEC1 Volume",
 			  CDC_TX1_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("TX_DEC2 Volume",
 			  CDC_TX2_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("TX_DEC3 Volume",
 			  CDC_TX3_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("TX_DEC4 Volume",
 			  CDC_TX4_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("TX_DEC5 Volume",
 			  CDC_TX5_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("TX_DEC6 Volume",
 			  CDC_TX6_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("TX_DEC7 Volume",
 			  CDC_TX7_TX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 
 	SOC_ENUM_EXT("DEC0 MODE", dec_mode_mux_enum[0],
 			tx_macro_dec_mode_get, tx_macro_dec_mode_put),
-- 
2.21.0

