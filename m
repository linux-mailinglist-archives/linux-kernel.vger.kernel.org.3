Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA659D2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbiHWHxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbiHWHxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:53:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9038011819
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:53:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso13722697pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=nEf9h9B8XFcsw7F7FHaP4rxVimh4AhqGZN0e/h8tVmE=;
        b=H6eHdQC9nfpqxyFvScDKeIUMxPQixxwngCfLH06PzVsCieuC0wFtRfbviaHQJOZ2no
         KCFxhv8QDvdg2lmpGanCvawqQssmfLAG/0dof0Milu2TexViPWyQPk7YGFVyCzEYdlt6
         mmjUQqBLQRHNtzu0ceLLg4CKTcLb4WV/i7RWRuJ89FQHYSg1I3Tp8wP/alrEx2Vu3lzG
         MuOiBfI2cgWGEeDFOQg/DxB0fMAMDQpn7qndnPxjbPRKmEawHG+E/cf1iq4ONtmvZZBt
         SbM+vuVZbcUIpHNYo+NvsSPo/mCThabsQNYNurxvrvdB+wNJRtPH2tBuP4K/KXk4VDw3
         hyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nEf9h9B8XFcsw7F7FHaP4rxVimh4AhqGZN0e/h8tVmE=;
        b=qJACfZnQQqkc7Q9ZsG5TcO516/k8BVve6mrHpTVW0GdItVtAolMH67U41tx0AibWdm
         q3eZVDYG4js8fjR0NJu1YeXtqiiXYIbsmsFC/r7/5cHgnMRcWyZSXs/nokPmbRhrWp2I
         31zKyGEcZvcj0mv50fTOpqc401e177pngCBBHdKDKmuuNVU6uwVM51yZzfAy/Ogfpaqd
         opkoifY/5Nm3LI2yfV0jht63ui+adHTyeiLlvDgWZgRC1aLQZM9i+zJP0QldbKBPJbpR
         9betv3IWjaW/PDvBOHf7z+565dXR9DNsN5BLc6BzgstNW62TDLbzPEY+Gm4mycCQg9PX
         FG0A==
X-Gm-Message-State: ACgBeo2bbxhUA6LoG0ZdKhqBm1es/XbDtG8nafYx6pgAGVS9mZJaNRje
        RY14l2Z8MImzmt0/7VZdwms=
X-Google-Smtp-Source: AA6agR5PV7F4Fv1F70NJL2LVcXFE9N4pQkIOk+6vloijP9gA6TFUajv72QAWRFmdHKbokWoX6ssYYg==
X-Received: by 2002:a17:90b:4c08:b0:1fb:66d3:79c with SMTP id na8-20020a17090b4c0800b001fb66d3079cmr1269718pjb.121.1661241220134;
        Tue, 23 Aug 2022 00:53:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b0017269cc60d7sm9737931plx.214.2022.08.23.00.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:53:39 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org, linux-kernel@vger.kernel.org
Cc:     codrin.ciubotariu@microchip.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: atmel_ssc_dai: Remove the unneeded result variable
Date:   Tue, 23 Aug 2022 07:53:35 +0000
Message-Id: <20220823075335.209072-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value from asoc_ssc_init() directly instead of storing it
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 sound/soc/atmel/atmel_ssc_dai.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index e868b7e028d6..3763454436c1 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -891,7 +891,6 @@ static int asoc_ssc_init(struct device *dev)
 int atmel_ssc_set_audio(int ssc_id)
 {
 	struct ssc_device *ssc;
-	int ret;
 
 	/* If we can grab the SSC briefly to parent the DAI device off it */
 	ssc = ssc_request(ssc_id);
@@ -903,9 +902,7 @@ int atmel_ssc_set_audio(int ssc_id)
 		ssc_info[ssc_id].ssc = ssc;
 	}
 
-	ret = asoc_ssc_init(&ssc->pdev->dev);
-
-	return ret;
+	return asoc_ssc_init(&ssc->pdev->dev);
 }
 EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
 
-- 
2.25.1
