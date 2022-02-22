Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AF04BF789
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiBVMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiBVMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5A1156C6B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso1613096wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gs0UQYeLXZEFiZSAa7cijQLwxToifauUEWbaq2HVPLo=;
        b=hQhF2lYshRddH8Qmwv6xe2HTRpj9tSjW0CaazwoE+mE1cgElLDzWzmHuTV4JXiPGBV
         AUCQ3FQZjP57GvQ/sZ+mowISk/cqEhdDw1pCl9dnIXJl2h0YmJVZH8FEMvRGK+Bp0jH9
         a3ll4LnZqjVMJeTYMDzK9pS24gsjGYrCqfo7gnOX93w9EYceBMXSKj//bdtpmuDrZlLA
         5pKTIcQPPBLBxiNwOLzcTtlJL0zUTlATc34BKwdBlTN1vBPOyfahVVMyf907TFJAID4z
         1WJ1NElr9prP+F+zAoLIxcCzvfJNyxWSZPliGfYddxe/hfyeA7s3mPhLGtl4kAXUi0n8
         M3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gs0UQYeLXZEFiZSAa7cijQLwxToifauUEWbaq2HVPLo=;
        b=EJE8SB7nZZ4s4ssun4ylmjh969bBKMHOVidqciEzUSRyB/sWkLR0p+WFmFkz5ylZyT
         1CrJBrBBfJZBToy8cZ5zAvVSvs/wTDRHbx7M9a69SwanBGwXCVzYFVhLaIzcl324dAVQ
         8LWUHEy40jJJ1cpQmoJQYJGhjG84lRuUn5pYmQwqhf6gxMqicdoaRQTVwZSbYFx1Ncxg
         vGLuSqm5GDxagVvavhgu5SCmATvmu7WdquWwCpN1ppp+HrfJi2miVQVdSl3s74L2fXIV
         q/26vbbk7WK0NdUXj2lfkWk4gSfROwiSHSJgi+/cwO3MV/xi6wlM/ll/zHL2WGzixyq/
         Zy+Q==
X-Gm-Message-State: AOAM533GdKLwpb8B228LMQQ8QBxqcZ8J1Wje8gIC2Eqe9CacoLqsUGe8
        i5e33IIBTs1m0EuvJdONCstuLw==
X-Google-Smtp-Source: ABdhPJyerxVrI5Q29+9f2FJy6PGgtGJNzvbGOEfw9WxIncxMV/L+KX65i3zEOZrwD0cL3u9DIN+fNw==
X-Received: by 2002:a1c:4d09:0:b0:380:e340:bfba with SMTP id o9-20020a1c4d09000000b00380e340bfbamr888266wmh.80.1645531194962;
        Tue, 22 Feb 2022 03:59:54 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/16] ASoC: codecs: wcd938x: fix kcontrol max values
Date:   Tue, 22 Feb 2022 11:59:24 +0000
Message-Id: <20220222115933.9114-8-srinivas.kandagatla@linaro.org>
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

Fixes: bcee7ed09b8e ("ASoC: codecs: wcd938x: add Multi Button Headset Control support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index deecc83eb592..782877db8c3c 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3577,14 +3577,14 @@ static int wcd938x_hph_impedance_get(struct snd_kcontrol *kcontrol,
 }
 
 static const struct snd_kcontrol_new hph_type_detect_controls[] = {
-	SOC_SINGLE_EXT("HPH Type", 0, 0, UINT_MAX, 0,
+	SOC_SINGLE_EXT("HPH Type", 0, 0, WCD_MBHC_HPH_STEREO, 0,
 		       wcd938x_get_hph_type, NULL),
 };
 
 static const struct snd_kcontrol_new impedance_detect_controls[] = {
-	SOC_SINGLE_EXT("HPHL Impedance", 0, 0, UINT_MAX, 0,
+	SOC_SINGLE_EXT("HPHL Impedance", 0, 0, INT_MAX, 0,
 		       wcd938x_hph_impedance_get, NULL),
-	SOC_SINGLE_EXT("HPHR Impedance", 0, 1, UINT_MAX, 0,
+	SOC_SINGLE_EXT("HPHR Impedance", 0, 1, INT_MAX, 0,
 		       wcd938x_hph_impedance_get, NULL),
 };
 
-- 
2.21.0

