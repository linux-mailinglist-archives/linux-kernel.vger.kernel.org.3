Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB51463BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbhK3Qen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbhK3Qem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:34:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733F8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:31:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s13so45767531wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W10woHZpi0yaDIjYw0FpzhAqwn1F6zlCzTC2v3vpIcc=;
        b=LObOyDUuFFkHoDoRVHkoP6QvDsbJhcNuOM6BtpA0qdm5n4tfBcNIW+GstxjF7LntQq
         jyyxsk88JUGpEbzg9hnQdAbZErNRf2fcheQwkGPPu6NTHH+6pJYLEY92YGBZ2+Cj09Rq
         CgtIZ0DBFZWerBYK7EW+NfgPzuSnuxNmYhqt0zaK7AB35onfxsnC210TCAlQRH6MZcpH
         e/H4mbDFqCa7CUXIKSVCI/lpVvfEKggGJ8UZf0GdQPXDQAiUwKxsG9OOoWGVsx73siA4
         sq0D5Y9rOfI3QF82mEFhW0//KzgzGud9eedun+CshQ9AA9OltdmPylhWt5er96rONPl5
         pcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W10woHZpi0yaDIjYw0FpzhAqwn1F6zlCzTC2v3vpIcc=;
        b=MmNmVENnMXGnn8y29bnpRkPSehK3pNueI6WHzPV0fvxw3nJ5eeto/RqWbFNwB45uEV
         9xgw46Dy2U7Yk7JbWWYI6PGesqFPDxYtnhCTDMlU9BdQ2paVw7dLBkMF0AMWZlZ7Dx5T
         dj2IxERvhXx6Zxe80+gLm/p8Up4T4Sc7EONmnJrwUDYq5ebWCtL06OgqL7uoN0+JYAo8
         b8Tw0r2rkcQvhCXBkF6/wSxyahkY4LpuNrS+xrX57922I3lguZeGiLatkSIwoRrxm3WD
         PHiFcoo3ocZjThUjD0+ptz135B1o47EJnZ+0TMRE6+tuESR+s+2n2hoaPYiACitzR9g2
         EzfQ==
X-Gm-Message-State: AOAM532NPfDYXM6Ccm9on8hyJh4E5Pg/s1TNe+WzZRNG+wPg2hpe6unD
        k5prCdHyseE9CJ+q0SqLZSYJ0Tt4xfsFnA==
X-Google-Smtp-Source: ABdhPJy2/6mcj0f9rWAnlluxbk1tHyaWCLL7ZqCSP8Lh+AcZ82VRWGNDeET8o4erufcgaZXybp0Ozw==
X-Received: by 2002:adf:dd87:: with SMTP id x7mr7667wrl.158.1638289881104;
        Tue, 30 Nov 2021 08:31:21 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l26sm3335900wms.15.2021.11.30.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:31:20 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] ASoC: qdsp6: q6routing: Fix return value from msm_routing_put_audio_mixer
Date:   Tue, 30 Nov 2021 16:31:10 +0000
Message-Id: <20211130163110.5628-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm_routing_put_audio_mixer() can return incorrect value in various scenarios.

scenario 1:
amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 1
amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 0

return value is 0 instead of 1 eventhough value was changed

scenario 2:
amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 1
amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 1

return value is 1 instead of 0 eventhough the value was not changed

scenario 3:
amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 0
return value is 1 instead of 0 eventhough the value was not changed

Fix this by adding checks, so that change notifications are sent correctly.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index cd74681e811e..928fd23e2c27 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -498,14 +498,16 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 	struct session_data *session = &data->sessions[session_id];
 
 	if (ucontrol->value.integer.value[0]) {
+		if (session->port_id == be_id)
+			return 0;
+
 		session->port_id = be_id;
 		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, update);
 	} else {
-		if (session->port_id == be_id) {
-			session->port_id = -1;
+		if (session->port_id == -1 || session->port_id != be_id)
 			return 0;
-		}
 
+		session->port_id = -1;
 		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, update);
 	}
 
-- 
2.21.0

