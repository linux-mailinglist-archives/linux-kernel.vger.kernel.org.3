Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7694C015A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiBVSc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiBVScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:32:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8403BA7F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d28so7342607wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2IntjpP6aGlRoP92/2s3f+MRINe2OeBdydIabsC62Q=;
        b=fa6fU0ur9L169TRYp27zAxmivEOazbzaB4rd/kLtLTMVeweV7BnaVM3VgK6MW3IYKc
         +mLLQ5oUeYRHgNP1xo2p6QRJIg9q6yt9bo6AvhELaktVmDZpaQO2gRxEjoVYCb+mvT0e
         iKvDJy/rTGkHwzIQJWsJOQlHG2uh6jMpSxF11PY7JuGG3NoFeE4oitT4nhAJYHo8cMqE
         brCEUFzoCQBDtxLkWu/la0p+tn9eyvCEPujnYqPCH5pnq5YbbV1v8pbtrVnJ3keijSNj
         0Dho05wNjuKGci7QugL0DXnHBJYf0VONFAoJdGMbkIxpg7Fuq4LoV2OAKeWBfvhRC93C
         uKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2IntjpP6aGlRoP92/2s3f+MRINe2OeBdydIabsC62Q=;
        b=qIuj+O17nDt8ANos3+VQmaFW9ZiUzh/sTipL+UHyD8dnwt+qM3QBMAFSsX4g6JBBEe
         GPFAziLXSH0Kz8ZYFxKA+WJjAhQIk2w8IsMppgbWdtHNQRPfh8jhDAUPO5c6xD3ly3Fi
         B5QHbmsXRoIbKlEXZhjoMGB/qGcWD/3g7vl6KNJvOBe3lHJYfQB4DtuH2iAOt6Se9UoX
         LaLmn8AyzSMLnvm4P4XP43TECbyYHrqWN4Nlpu4Jr1EI9hzEBzntkrnQwCXu1s6a+thx
         ZOPJUiSwPttylm6+GZUD3HLIy52f/b4tq3MewyAjr2fe07oxDYY4rcIoxCl6QC7SdKp+
         T4Sg==
X-Gm-Message-State: AOAM531m8nONXhK3i9JbcJynfkC2461EUdD+D/SkRLTCjcYpLGxuRfv4
        PdJhSncDH1Gd3TrxXAssdFpdPgE8qTrjgQ==
X-Google-Smtp-Source: ABdhPJzkFkr4gCWqEerHsP3/wvheZekWZ2fcKAHOo/mOTIilwJkpleU3K3VsYUQJRRfUkpNNoUdvwQ==
X-Received: by 2002:a5d:5988:0:b0:1e8:b518:ad7f with SMTP id n8-20020a5d5988000000b001e8b518ad7fmr20021303wri.193.1645554747227;
        Tue, 22 Feb 2022 10:32:27 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:32:26 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/9] ASoC: codecs: rx-macro: fix accessing compander for aux
Date:   Tue, 22 Feb 2022 18:32:04 +0000
Message-Id: <20220222183212.11580-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
References: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
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

AUX interpolator does not have compander, so check before accessing
compander data for this.

Without this checkan array of out bounds access will be made in
comp_enabled[] array.

Fixes: 4f692926f562 ("ASoC: codecs: lpass-rx-macro: add dapm widgets and route")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 2b272a82eabf..32e85d2e9b90 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2039,6 +2039,10 @@ static int rx_macro_load_compander_coeff(struct snd_soc_component *component,
 	int i;
 	int hph_pwr_mode;
 
+	/* AUX does not have compander */
+	if (comp == INTERP_AUX)
+		return 0;
+
 	if (!rx->comp_enabled[comp])
 		return 0;
 
-- 
2.21.0

