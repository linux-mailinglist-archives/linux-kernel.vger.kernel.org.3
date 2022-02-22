Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8763D4BF788
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiBVMAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiBVMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8F156C62
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id p9so32694762wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ht2zsDCw6mTpQAlwd9QIJhSI+uSP7rAlJbSv+42FdW4=;
        b=YSKSCQX8VLsIIuyC0rpsqZIVu8heWghUgpq9tyco/RlMfoMRfvL0TXTGRgj62ydrAC
         C3WqlPBHcTZVpsg2EZlDVsJbq1d3AwyyqN2HLIoyroTXtH8hT09QEZVJJCA9dfOYWVvg
         n0XHBDHlVGZGLjnue046qqwlgxFfVPHHjaRNX8lTueg2stxjhgOv0/5Q601rwSOfvtut
         IZ2zecmhTYgxYuzifrlK06I/9FYAfiP8zhDIZR0M8MYpwKeyKTv0PqTr9+iAJwalaU4x
         z+HWpXfi4FedctzjsaznTVd2Yv1nPrNU430A4MU3MvSeqkbG8O7zAHBYqUMaCXwOiIoW
         CBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ht2zsDCw6mTpQAlwd9QIJhSI+uSP7rAlJbSv+42FdW4=;
        b=av0Weh/rwOn1aejyLXXwmSOKcn0YMKY8y3UTOiLSA6Dp7LBSvKhHxozVnOba6Vqll7
         NMdyMsVQJIGDF7Zfpn73/yVBHyY71tJXlQUY5ebOzihzjpW7nPUoq93npgsdUaQvEGc6
         OsdWOy5b4b2+mPJCYY7nSGwynCTHXXKNb82sofZN8ROuNuzCW3AG921j+vAHVJrE2Xky
         b2vWF2zVahQFvUbc0Uk9sSiIKe7ijUYBRaffzdjv/swZSK1cQGNXoR506PEBh1u5BHgY
         xyq2OvTKqsxIvQBiHHRQ6TBvyNCzrIck/i/i5XXlfloMuNV0k49S0kYOPnPJ8R93QQKs
         6A9w==
X-Gm-Message-State: AOAM5304eu+zWPLCMWuIhADxeVG8Vbky27keYoPxnHJP9EnWJ7lhw+xd
        MQRlLF2s8n02sbMWO/QflhJX/w==
X-Google-Smtp-Source: ABdhPJznEZqGfqmVrP+p0Vldxzh+Nd5LHUSodJxau7eBZeNvoTKPAn+XDsrnpIFSB15jtzso9lZVBQ==
X-Received: by 2002:a05:6000:1ace:b0:1e8:cbe4:9920 with SMTP id i14-20020a0560001ace00b001e8cbe49920mr19167947wry.121.1645531193943;
        Tue, 22 Feb 2022 03:59:53 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/16] ASoC: codecs: wc938x: fix accessing array out of bounds for enum type
Date:   Tue, 22 Feb 2022 11:59:23 +0000
Message-Id: <20220222115933.9114-7-srinivas.kandagatla@linaro.org>
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

Accessing enums using integer would result in array out of bounds access
on platforms like aarch64 where sizeof(long) is 8 compared to enum size
which is 4 bytes.

Fix this by using enumerated items instead of integers.

Fixes: e8ba1e05bdc0 ("ASoC: codecs: wcd938x: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index cf61d23bfb1c..deecc83eb592 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2506,7 +2506,7 @@ static int wcd938x_tx_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = wcd938x->tx_mode[path];
+	ucontrol->value.enumerated.item[0] = wcd938x->tx_mode[path];
 
 	return 0;
 }
@@ -2530,7 +2530,7 @@ static int wcd938x_rx_hph_mode_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = wcd938x->hph_mode;
+	ucontrol->value.enumerated.item[0] = wcd938x->hph_mode;
 
 	return 0;
 }
-- 
2.21.0

