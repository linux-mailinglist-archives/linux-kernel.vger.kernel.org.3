Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4744DAC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354427AbiCPIiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243048AbiCPIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:37:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4132A46175
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:36:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n15so1233987plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fY/zaLzCuGHO00tXLKrc5cYu1RxjEzrTCpzH+5kdjtU=;
        b=CNDnNE9KZy+3df6cRpaus30OZLx3PmJ7daQwTY/ZAkNcugLK6uvHFdQ/jm1WRkssdr
         0VemyHlCitsLQ2xxJh9pl0/f3oDCS+l9Z+n3999w628BOOGjsmFsKAyNdt/EPCmMUnlW
         Icb9BPtmYub98o4KGgk66Uqace8bAZ6JbXFHKFWe3O8MM6qrZSUUUwPBCmMxbNY/toWC
         znRCXSqyySHAQzqPI5R2f1IgqsoOzd/3/mv3jbPRB9qfPmHPKw6sqUXHUzahYy+eIZuk
         tDbewJILUS/mmKiBhRfrpCupE4/LPYDgP914mB74jaiAdTpsnRdhnaDIM21DZ5BCXvmp
         y5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fY/zaLzCuGHO00tXLKrc5cYu1RxjEzrTCpzH+5kdjtU=;
        b=MCfz0hnVhI/TNOV7O8qWj94hSVSj9tuhoKfgp6GD632JdoN645wwSUH1xylZvOEhYN
         j8C5dSLGKyA6bEdTaZoQmg76dCQTKyWYy6/ZL2lpZkyXi1iURzU4xeyxx/uhvypvtbKR
         1WGKN1cYiuIV6IxenHODQY7OkGiuc1+QywYrfiX3MfS+Ik8t1yGF6NydS8isKIFfNGFr
         /B1tqaFT2qljUTUZSd2NiI1nwnnuWYha58LokdkEO7CPQ39w5QuClEsVN1yS4jKGTK6H
         gsu4D7g0GoP8DbjVnM7A+bxc3XbKLeBczjKuj7eAMrQ02/kuDGEvAZXPnDe7oIgQAbtL
         rx7Q==
X-Gm-Message-State: AOAM5301rRTUS6pDNRxEui+nz7WVieQuFH79GPbrrp37Ga74pvLwrMHY
        Y20CV604lKH5maHl3+g1FdY=
X-Google-Smtp-Source: ABdhPJyzDQP71kpiZTM8gd8+SZoVddtqgb+feTmdopJLJpiVBmMmFLxFBmLZMo2rnfxTGipeqUpXrw==
X-Received: by 2002:a17:903:244c:b0:151:bb4d:d8d8 with SMTP id l12-20020a170903244c00b00151bb4dd8d8mr32181559pls.121.1647419796782;
        Wed, 16 Mar 2022 01:36:36 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id t7-20020a056a0021c700b004f7916d44bcsm2060381pfj.220.2022.03.16.01.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 01:36:36 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: codecs: wcd934x: Add missing of_node_put() in wcd934x_codec_parse_data
Date:   Wed, 16 Mar 2022 08:36:31 +0000
Message-Id: <20220316083631.14103-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.
This is similar to commit 64b92de9603f
("ASoC: wcd9335: fix a leaked reference by adding missing of_node_put")

Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/codecs/wcd934x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 6c468527fec6..acd344c4a37a 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5883,6 +5883,7 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 	}
 
 	wcd->sidev = of_slim_get_device(wcd->sdev->ctrl, ifc_dev_np);
+	of_node_put(ifc_dev_np);
 	if (!wcd->sidev) {
 		dev_err(dev, "Unable to get SLIM Interface device\n");
 		return -EINVAL;
-- 
2.17.1

