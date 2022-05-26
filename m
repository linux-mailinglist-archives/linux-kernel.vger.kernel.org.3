Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0A953534B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348371AbiEZSWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237708AbiEZSVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:21:51 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F684DF2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:21:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id v29so2145574qtc.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wvru1v94Z3LpfaUeEixaS62JjWjiVp1HvAWwWWK5xg=;
        b=ZZUJiu/rOG/YOu2+5oV05xYD3LBrN4nPp3juCeQHXDJ+SCSC77GJj5kNHEbuK2/KFU
         MXfIOq87Rg8b7sNLtnqSwlOBDvMJjxQnoMQ9arUiZlI3KmGxno7GEaaHNKmlJKRXBWXD
         IuDnx6aL7dPX1/5kwyQyfqYF27IwKmMUdOkKlJG7FBXivK+ymwCDuyA71nXK859rImrq
         Cy9jJGwAOpeKSWLklDkUjACh5gLxgv1jclMgXZVZ/Ia2Esn8WeeNN2GV9pN+K9+3NgCz
         SM1TvNeTc5H4Ki+9Ukd4pgj9Zwb1EoB8ZLsfyaoYnE0/S5YEBB11TMF3bPgbs07tSMBQ
         AS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wvru1v94Z3LpfaUeEixaS62JjWjiVp1HvAWwWWK5xg=;
        b=KnKO99eht4mjxg7YCy9K9+5EqrlRAvvtarYzK8fAwfyW+vKfeFktcd9D0dhOD0BXZZ
         0K6o6YhBXT5hBGiXqVwFjmfEQI3/eXajZYyQl01mCD6Qh+unPyqX4uZoB5Qp/wO1/MIx
         /0GM2RmU4hW90cYrnmLPxfxc2KIoLL8u3RuYX5M7cmEDR4i2eZprtqg7GtguhdkEBj7m
         XExC5HUHd1Vya8WQVtrmNcC9jiXSkJuTxVHO/enJjqh8kyH4FDAY7aeSqUZy3h2UHjWw
         zhOV9uoiLiGI+qJGqguJh0GTo+i8cKiXms8KJjFFtbPmxCCXiaHiFZZm0gnGCseqJzza
         TFtw==
X-Gm-Message-State: AOAM533uEjf0P+uaPwmpzIl87FXVwwfVOODNKQRYGGInTE9SHfILkVLR
        c9k0dRWa9XzzdFuvgS+LCMM=
X-Google-Smtp-Source: ABdhPJz6KfaUIhhaiWIH+q2OcHNSg6YVhoH0ms+eBOB/eGyVnd1i5HBvYIonid4BZbj0kpvhB+QHbg==
X-Received: by 2002:ac8:5750:0:b0:2f9:410b:7101 with SMTP id 16-20020ac85750000000b002f9410b7101mr12262760qtx.291.1653589307429;
        Thu, 26 May 2022 11:21:47 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id s22-20020a05622a1a9600b002f39b99f69fsm1395859qtc.57.2022.05.26.11.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:21:46 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        patches@opensource.cirrus.com (open list:WOLFSON MICROELECTRONICS
        DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: wm8962: Fix suspend while playing music
Date:   Thu, 26 May 2022 13:21:28 -0500
Message-Id: <20220526182129.538472-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the audio CODEC is playing sound when the system is suspended,
it can be left in a state which throws the following error:

wm8962 3-001a: ASoC: error at soc_component_read_no_lock on wm8962.3-001a: -16

Once this error has occurred, the audio will not work again until rebooted.

Fix this by configuring SET_SYSTEM_SLEEP_PM_OPS.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 34cd5a2a997c..5cca89364280 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3868,6 +3868,7 @@ static int wm8962_runtime_suspend(struct device *dev)
 #endif
 
 static const struct dev_pm_ops wm8962_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(wm8962_runtime_suspend, wm8962_runtime_resume, NULL)
 };
 
-- 
2.25.1

