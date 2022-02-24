Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377BB4C2AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiBXLTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiBXLSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:18:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D61D16E7D2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:40 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r10so746515wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfKStxRvgTEmdqhNQGyq07ydIW9Hyz4sxw/jfz5hVYw=;
        b=r7/l65/1oIcrXfeQMVC71/5ogGArMOi/oLoSasc+FcBBcXlOrqSYFlPWedgjDjMnhb
         gJmBZPCFhf71QLIyP9+ilt7CBR2VUVRTLRCr26CThISQ0VBSERN11vsNDHWjlHRgxrkD
         iInDeLhpIy1O4W/EuP2sxdzBVIyuOM5FQ0JgZakch9wTfzx7N88xoJcfl3B1iPtNRmW0
         3wuTRxjxYWr7DjdNt6Bde8ukt47mSQWK8R2m+BwzXpzoyejcUo2XAo02FPoOyMU9kpTM
         yaNA4iW3xIKaNLZ7S2vvWNQh9PLo7AFZ8cFCp2eZVC6mgT8D0uej0iayS4bTrbmCiIqA
         uclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfKStxRvgTEmdqhNQGyq07ydIW9Hyz4sxw/jfz5hVYw=;
        b=vpqqez3A9aTDtIhUjkPI8vfFXXKaH2qMpTENmMpZUcWa40J++4sohyjI3c4mUFZY4o
         Y+jMzQ52j/MZZJENwQfr1KbdZJs3SV0K8vr+aKAlf1xlqMsnZ1bOWCZqtIOz25qkuFli
         eT6H368/xRCfdsGcdhOdk+15vG7qZRUgQRDjQFl+MIUlOXTD8eB3M/6phMFAGeIVzzru
         mj+PB0EOvHIn1SPb8NfPnKxdFj/KK9k3ZGOELsSn9M57lb2rM/VjdvYCiKQyUWZIgg2O
         Iu7lgxV+X+dZEqhFNi58ZpPxS0vjdd9uCxnZJLn+QIbuDpamv5v7h0IBjLqoafxgoa6x
         F+0w==
X-Gm-Message-State: AOAM533MO6cPuif+MoRbQuIdHhUOGKy8WmiA/u5cWJ+cy7LBR7oomG2e
        hsH579H+1r/SNZvNvnH9IgBj1w==
X-Google-Smtp-Source: ABdhPJzYjVTN9x+GL1LFM9oLjla4Nv5U4uIq7XL0Lqv3bedGcqZkNI5nSpYhXrImHNanSLu+5Isiog==
X-Received: by 2002:a1c:a7ca:0:b0:380:e40f:c31a with SMTP id q193-20020a1ca7ca000000b00380e40fc31amr1874845wme.85.1645701459163;
        Thu, 24 Feb 2022 03:17:39 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm2245737wmj.10.2022.02.24.03.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:17:38 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 15/16] ASoC: codecs: wcd938x: add simple clk stop support
Date:   Thu, 24 Feb 2022 11:17:17 +0000
Message-Id: <20220224111718.6264-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
References: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
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

mark WCD938x as clock stop capable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x-sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 1fa05ec7459a..1bf3c06a2b62 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -249,6 +249,7 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 					SDW_SCP_INT1_BUS_CLASH |
 					SDW_SCP_INT1_PARITY;
 	pdev->prop.lane_control_support = true;
+	pdev->prop.simple_clk_stop_capable = true;
 	if (wcd->is_tx) {
 		pdev->prop.source_ports = GENMASK(WCD938X_MAX_SWR_PORTS, 0);
 		pdev->prop.src_dpn_prop = wcd938x_dpn_prop;
-- 
2.21.0

