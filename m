Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48FB4BF78C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiBVMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiBVMAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5849A156C65
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w13so10898630wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SOM2m1l2t9AVsCxObqTWKpNPnvoS4HHumlCtnLuW+M=;
        b=Ws7XkwwKIezWgelZILQpFNUflefi0UZ+gNdHXODwz5Wgz6M7G4Lkz03OEg8ypHxZSh
         F1dAdWeyAZAq/ggyhtolZpE13XXYYVaZHSHu1k2Lnk4ASX7aXK8xXL0mj6yGKxZeqbLi
         I+DNvCVWd2qRSyMKkFs1GpZyBSI6fAbUTHA6jzXS2lQHOEn/zrHOBiH+Bad2DUGbq26E
         3CIXJU2YwhumujO1PvGEQFUqWQ3sfAwWig01vvqeznAA+YaHlz/Tzxjrsaz2iZVheRZ6
         DSD2sDIWZpRw0TjFCniFsNcLLfp9VAUbEG37WPP3dlQykVOMA+1ZoESKqRirFR+Qxb0C
         oRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SOM2m1l2t9AVsCxObqTWKpNPnvoS4HHumlCtnLuW+M=;
        b=r9+mpjFPvwj+qm8UP9M7S5I8HQWUPjxMP8e613iHikwXCNcTnTGST75MJV9P8Amt1a
         W+wFa83NHMWiOiQdDvGpGFZWOTBQN7xmkLJ9XdD1vEfD/uje1tdAt2OQyci+rywZVxv5
         FBvSGF3hj/YSL9ssIDlwcCK0t9f9fW8w8XIq/PBttqkn7jkihcoRLLbG15f1MfJjeND1
         yKJ2MSPpFqASaQR8fsafzrE1x5RuBQk+0NpF2l35gKMgb6lni8PAH57stYU6jDQyT3a5
         EqQ5wcZzQOtiZ8ZLzUf7rtAd4rhIqpXsDSb+BkyTK46cJMn48a/aehF0pHOW6KMGsmZa
         UO3A==
X-Gm-Message-State: AOAM530AjXLSiyzIGv0ehTTyV3CtTAD5HA0pdN8BnwWXdbbxdN4idXg1
        tGnmPFUf69LKk9XtDr6o6xn/nw==
X-Google-Smtp-Source: ABdhPJzqXjAvt+WjhqvdqALlx7KBzS2s2u+JGKdes+D0KUZHJe2rkc1SqLbt7miNgQbZuB+oG+Iv1Q==
X-Received: by 2002:a7b:c159:0:b0:37c:c0d5:6534 with SMTP id z25-20020a7bc159000000b0037cc0d56534mr3022313wmi.182.1645531195942;
        Tue, 22 Feb 2022 03:59:55 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:55 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/16] ASoC: codecs: wcd934x: fix kcontrol max values
Date:   Tue, 22 Feb 2022 11:59:25 +0000
Message-Id: <20220222115933.9114-9-srinivas.kandagatla@linaro.org>
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

set "HPH Type" Kcontrol max value of WCD_MBHC_HPH_STEREO instead of UINT_MAX.
set "HPHL/R Impedance" Kcontrols max value to INT_MAX instead of UINT_MAX as
max field is integer type.

Without this patch amixer for these controls will show -1 as max value to userspace.

Fixes: 9fb9b1690f0b ("ASoC: codecs: wcd934x: add mbhc support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 6c468527fec6..f2674905a4a7 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3023,14 +3023,14 @@ static int wcd934x_hph_impedance_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 static const struct snd_kcontrol_new hph_type_detect_controls[] = {
-	SOC_SINGLE_EXT("HPH Type", 0, 0, UINT_MAX, 0,
+	SOC_SINGLE_EXT("HPH Type", 0, 0, WCD_MBHC_HPH_STEREO, 0,
 		       wcd934x_get_hph_type, NULL),
 };
 
 static const struct snd_kcontrol_new impedance_detect_controls[] = {
-	SOC_SINGLE_EXT("HPHL Impedance", 0, 0, UINT_MAX, 0,
+	SOC_SINGLE_EXT("HPHL Impedance", 0, 0, INT_MAX, 0,
 		       wcd934x_hph_impedance_get, NULL),
-	SOC_SINGLE_EXT("HPHR Impedance", 0, 1, UINT_MAX, 0,
+	SOC_SINGLE_EXT("HPHR Impedance", 0, 1, INT_MAX, 0,
 		       wcd934x_hph_impedance_get, NULL),
 };
 
-- 
2.21.0

