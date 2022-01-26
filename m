Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B79749C8BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbiAZLgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbiAZLgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:36:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D91AC061744
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:36:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h21so7692217wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uYgTZ5BWUKo6IE+sW0nmQRKJ/VMJrPvYdN9IXE2AoE=;
        b=tjF30mrNbfIzk9FPTeX9J+dohxsUXSuKLTpvowq4NkQs7XXPyy0M+fLUJ6zaj1aXI2
         YwZuiaDdIgkZfqcLqE4+8nDkxG5NtFFrLI9pmcnH7i5UREo86cBacs+Zlnurdhdb0Yak
         zuslFv6w1StuZdOS+QPFhjNlfs0LVJFwRYAm6k3ywUa6nwUP1Vs7qHTu6F32ZWKuO57u
         3zECYns5cwwfv6XfWpvfDK55sprfdwbdNJeubp42tWGUrAr/QjzfwwKN+mA/uJWeMTqI
         5TpedkJzs/NJjndJNKluqYxXc0n2PDWpYCydQXVC+4ebSi8P4xgunld09FeMN7c9M2t6
         //5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uYgTZ5BWUKo6IE+sW0nmQRKJ/VMJrPvYdN9IXE2AoE=;
        b=YQ0xOn/urdfprlqh15nubbq10DqIZJt/qMo6+4VfR+zxaLzOAKnDCACIY4hVoC8/It
         KNxAz1ASHJuv3/96f2DGUTZmDOZM1bgANsy8sOYhfNtO5o/96HLEUpE4J9SWV34d6NSi
         xQRVZ9EmilYNmLWyDL4it7bbo0Bre7RvqdfGoDzmsVz7WIG7rmzgasdKDd9XihTwoLQv
         dq/1kR6BVSI1kKmlDpZajw0PtS0YJW287V0kJdBVkFBvvRcRijIgdQrzcsFry3lwkli6
         CsNj/bRccxqRFE0dIcGlznVn1BxjAOlMEXbCpzufpy8GV09UaAv/K6ifGb5DF5IJ/bXA
         Hmng==
X-Gm-Message-State: AOAM532gKiCSbOHvwqInwbD5HLTpprUjdcpfouArUwTWdNO3+ihk7P7r
        3jOm2VDQ5+1jzxzHMkoOSDX9Cw==
X-Google-Smtp-Source: ABdhPJz6AtCx7kIVacdAi8UodwIfH2dJGXhPMfuTNLL92yJFCgM1jmsiUIBBy9uhJx15WnbhGriiBg==
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr13793463wry.481.1643196961852;
        Wed, 26 Jan 2022 03:36:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n14sm11999188wri.75.2022.01.26.03.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:36:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] ASoC: codecs: wcd938x: fix return value of mixer put function
Date:   Wed, 26 Jan 2022 11:35:48 +0000
Message-Id: <20220126113549.8853-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
References: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wcd938x_ear_pa_put_gain, wcd938x_set_swr_port and  wcd938x_set_compander
currently returns zero eventhough it changes the value.
Fix this, so that change notifications are sent correctly.

Fixes: e8ba1e05bdc01 ("ASoC: codecs: wcd938x: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 5994644c8702..36cbc66914f9 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2559,7 +2559,7 @@ static int wcd938x_ear_pa_put_gain(struct snd_kcontrol *kcontrol,
 				      WCD938X_EAR_GAIN_MASK,
 				      ucontrol->value.integer.value[0]);
 
-	return 0;
+	return 1;
 }
 
 static int wcd938x_get_compander(struct snd_kcontrol *kcontrol,
@@ -2610,7 +2610,7 @@ static int wcd938x_set_compander(struct snd_kcontrol *kcontrol,
 	else
 		wcd938x_connect_port(wcd, portidx, mc->reg, false);
 
-	return 0;
+	return 1;
 }
 
 static int wcd938x_ldoh_get(struct snd_kcontrol *kcontrol,
@@ -2917,7 +2917,7 @@ static int wcd938x_set_swr_port(struct snd_kcontrol *kcontrol,
 
 	wcd938x_connect_port(wcd, portidx, ch_idx, enable);
 
-	return 0;
+	return 1;
 
 }
 
-- 
2.21.0

