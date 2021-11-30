Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0585F463AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhK3QIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243355AbhK3QIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:08:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AEDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:05:20 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso19929070wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OIAtVnx0ZzlGmfdsJR+Ltr1BjxuMXS7lSNZkDDd+8oo=;
        b=r5D0WzBwgwvEJ6qvAb7BParzqYivB9ouS4MM1hgX9ewjK+4Qt+7UHp/G2VN98fimd/
         ez3cnnPWNlFk1GS8ee2zvMSGNp72n9smLAo1lQB/YHHfmgHaN7VYM7oSPSF6o2HQZ/Vw
         uI7soY74pafLImmmT5SEw230VCq9hixIKgWWbIGz0gNo3GBowQhK3C6X26RhLRBJ11a8
         n2WipiZs4aYPgvG25D77SToLUsPTgOBFPcnSjejmOHHhHCErnQ999MGSHmH5HsWxq6pe
         dm9mafM038ERfza6Mo9kr5xW5F13r9R9kyfu6HwzH8CAB6QyUPloaeFIKBGVbFdrkEO3
         mnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIAtVnx0ZzlGmfdsJR+Ltr1BjxuMXS7lSNZkDDd+8oo=;
        b=PHthiWSMnMx4omdBm5+IaxjyOJe3GJexSyhX11ofTMlzvuL1oDpn9uq1I6V0JJF0dz
         VLQ2npawSjy1eJikqvKaaGzOuD76pSMBjV7TzHLy69QYbvLP2i49Kr0y3JjYOGFoXosG
         dDlwZk6mLgolt+nnLANr/IrGx2ASzHlqyZVZfXe+NWDP35nMJP9X4vhjxuyaDqIJNREk
         +Gt7aT6NJ/Tx6dN/pgF8+/FN5YhFvD60/SJWwoDVLVgmUVyS4n3OPkbPx6I+pa++isSX
         0zzmW+CFP37lbttZ4hCjmjGrhyTULrB26OEKcE4+CNqBkcBZI4S7ZsjQuAfES27iLAnC
         XU/w==
X-Gm-Message-State: AOAM531IWIQ7VW+ntp55lmU3uy/meLQlaR/iyvX69rfjJCSRg1aSNa5k
        zuXYycv8EG9pxtaVCJp5AmD4rw==
X-Google-Smtp-Source: ABdhPJwReuuxUsxNupkQZHuNCtvWOALK8zItA8DvAQk1ne0jY1pHEqrMNHn0ZRnUx0d1pg514SymPA==
X-Received: by 2002:a1c:9a89:: with SMTP id c131mr394569wme.80.1638288318600;
        Tue, 30 Nov 2021 08:05:18 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id g18sm16719409wrv.42.2021.11.30.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:05:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] ASoC: codecs: wcd934x: return correct value from mixer put
Date:   Tue, 30 Nov 2021 16:05:06 +0000
Message-Id: <20211130160507.22180-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
References: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wcd934x_compander_set() currently returns zero eventhough it changes the value.
Fix this, so that change notifications are sent correctly.

Fixes: 1cde8b822332 ("ASoC: wcd934x: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 3294c685d4d8..6c468527fec6 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3256,6 +3256,9 @@ static int wcd934x_compander_set(struct snd_kcontrol *kc,
 	int value = ucontrol->value.integer.value[0];
 	int sel;
 
+	if (wcd->comp_enabled[comp] == value)
+		return 0;
+
 	wcd->comp_enabled[comp] = value;
 	sel = value ? WCD934X_HPH_GAIN_SRC_SEL_COMPANDER :
 		WCD934X_HPH_GAIN_SRC_SEL_REGISTER;
@@ -3279,10 +3282,10 @@ static int wcd934x_compander_set(struct snd_kcontrol *kc,
 	case COMPANDER_8:
 		break;
 	default:
-		break;
+		return 0;
 	}
 
-	return 0;
+	return 1;
 }
 
 static int wcd934x_rx_hph_mode_get(struct snd_kcontrol *kc,
-- 
2.21.0

