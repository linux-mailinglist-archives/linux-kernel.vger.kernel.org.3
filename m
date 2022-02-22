Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B24BF792
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiBVMBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiBVMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC59158D9E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:02 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso1621508wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQBKVZb4u7024qTgLZ2s864oDNFbW3uHg+4te5BtCOE=;
        b=NYMWNbipBHYZahgQldqX2PZzyaPbcRUJoLxmAPDUeUPfy5PNMVxXp0eSsSO2WzlHjO
         Ebg5DrRYGU6SGuiK88+kTtiVolqzZbtTqH4KOxvVat6cVeLM0+zHnRCl+ED4GBpIFFaB
         ARwwm+kk4Pd0P6FNhJDthT4UoPdUlzia+rVbbp6w2r2U075/4k3SS2PL3OBujcXZ8Zc+
         mwYp2McLJSiJCzEVuZxeg2/H5b3gnZ9E6kY4PXGZE6Sro8a68IHIFI40yvDVHPvqSkI6
         udI0pHlccfsH5bIi3uNUcV8bhIQ+0shbrzMfGV84lMYiGAOoy5y/cNDoNdE4Z5Y2bwQ7
         vzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQBKVZb4u7024qTgLZ2s864oDNFbW3uHg+4te5BtCOE=;
        b=TB6Uue9GCOUBmh03i9XcZA/4+zKbB6UhZRVFTJDJfWrr1vubdkB6jlhNYsVwE8x0YH
         A5wsW8UUSKCsTu0sSJi7ANAXpbiJ9oC/JlT2kIWf46nc9pyUqdwhiKC0Hm82INQlXCfX
         XVsbMtrLFmrNI/h5/TTa5SW0xfcFpT3poh16KpaI5uJLVkvBmUZo/p+LLXtDPbLLPfUZ
         wIoX4Pi59T4vw+83Pyku6ZmvdcsxR9LELOOAWCN8lJjW7/HIyJltuXgytOpN90VXyNz6
         JZ5JUpdV2kkcM/1dam9o+KHNWJz+m2wasgJKSZoJx9s+XqQg7Fg9sKMMOIYVClwqQMCA
         8+yA==
X-Gm-Message-State: AOAM531Rl8adDSllGMP36SuWhcbaEA9xHRRxplYQdXWBtxBy8pJaXXbP
        ytTxlFr3A2d4icAT7iNJ9AnOYw==
X-Google-Smtp-Source: ABdhPJz7QFBQZkBwyxemqJekiErYbd5W8OP3oWFf3xc+jJ27/6at0TozdCdAYIg/aUnO/t13yodIqA==
X-Received: by 2002:a05:600c:4e12:b0:37b:ebf6:3d17 with SMTP id b18-20020a05600c4e1200b0037bebf63d17mr3061640wmq.44.1645531200990;
        Tue, 22 Feb 2022 04:00:00 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.04.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 04:00:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/16] ASoC: codecs: wsa-macro: fix tlv min max range
Date:   Tue, 22 Feb 2022 11:59:30 +0000
Message-Id: <20220222115933.9114-14-srinivas.kandagatla@linaro.org>
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

Fixes: 809bcbcecebf ("ASoC: codecs: lpass-wsa-macro: Add support to WSA Macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 7de09c46264b..b769fb2ef2f6 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1929,9 +1929,9 @@ static const struct snd_kcontrol_new wsa_macro_snd_controls[] = {
 			wsa_macro_soft_clip_enable_put),
 
 	SOC_SINGLE_S8_TLV("WSA_RX0 Digital Volume", CDC_WSA_RX0_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 	SOC_SINGLE_S8_TLV("WSA_RX1 Digital Volume", CDC_WSA_RX1_RX_VOL_CTL,
-			  -84, 40, digital_gain),
+			  0, 124, digital_gain),
 
 	SOC_SINGLE("WSA_RX0 Digital Mute", CDC_WSA_RX0_RX_PATH_CTL, 4, 1, 0),
 	SOC_SINGLE("WSA_RX1 Digital Mute", CDC_WSA_RX1_RX_PATH_CTL, 4, 1, 0),
-- 
2.21.0

