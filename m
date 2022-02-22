Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580FF4C0161
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiBVSdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiBVSdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:33:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D206D1070BA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d3so19460795wrf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SOM2m1l2t9AVsCxObqTWKpNPnvoS4HHumlCtnLuW+M=;
        b=sfphTkw+TIFpSiVfPCDWpMWe0C1Hsg7TxDv/6tfs6owKtzUL1mTcl48e3eStB74Lry
         uIssrDlUyTqB/NWDuogXlOJicUGDIxOIRoOklIWCxm/G59moqOpR/KO2kpdJAvB9Dbjb
         OpNJsrrUggRFjN3EJ9mi+XzfPV36vrKFTxix6WBQRJGaphTeLj837GYeNQ+67NZZRZ33
         CzFcOzTK8yOoOIh8/noDccHBda9/RW/EpdSy7Lkoh7h9ohKJDcJzrlGWNx/N6TrPhC0p
         Nyon9yBws48hbyhjumRz7VOjjcOhMGNOShwsB/3BQnJYZCi+3FsHMYCACVW+rdSr7KNB
         1p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SOM2m1l2t9AVsCxObqTWKpNPnvoS4HHumlCtnLuW+M=;
        b=oTWbervQLTLZphC3+qcoetxFd28xJFOaWeFdaK7ukL/CPEIe3kM1DDGl6bp4CPvKuL
         LxZCKzH/El4jRrQKz02NXuHStrBt/b/PWXtdCASRJuHKmvH7aTcJT+hI5H1H1XVoCFoq
         ad0R9lF16Z4LJsStbBmsODHm6+SxyQq9iWg81HymQMBm4SKHQnRShdsbTakWtTsRuE66
         EXjCHQDb2rSgoEsmbFwISaYJujIrU0QG5vUWKcYA0lwNfq5xzve2LVk1UsCKL4xK/kdc
         N/OuqxcjY/u4jgupx0BBvHusuUOPCvk6jD/WEA5gxOesOD/1pt/uvCv1ktHwRMLijXdP
         rY+A==
X-Gm-Message-State: AOAM530cpYfZWgSw2V6EADGxbMd+NQ2Vbr1S4d87lsyqeOmAaD9G0Gtc
        hC7123nxvLeN6m3xNDJvWOaJFg==
X-Google-Smtp-Source: ABdhPJzB9kZCiPNVRCRgOj5KpMPtb6jZTEiWIL2vVd2Ge5yGwr0q0OgrFnxxtDDpv23Msgbzlkcb2Q==
X-Received: by 2002:a05:6000:3c6:b0:1e4:a380:bb53 with SMTP id b6-20020a05600003c600b001e4a380bb53mr20490779wrg.559.1645554754454;
        Tue, 22 Feb 2022 10:32:34 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:32:34 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 8/9] ASoC: codecs: wcd934x: fix kcontrol max values
Date:   Tue, 22 Feb 2022 18:32:11 +0000
Message-Id: <20220222183212.11580-9-srinivas.kandagatla@linaro.org>
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

