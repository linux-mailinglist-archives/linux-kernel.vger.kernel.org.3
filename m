Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B657760D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 14:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiGQMHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 08:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGQMHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 08:07:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128D915813;
        Sun, 17 Jul 2022 05:07:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l22-20020a05600c4f1600b003a2e10c8cdeso6337761wmq.1;
        Sun, 17 Jul 2022 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyGGShEtJ5QngHNH1K1pLBz5li6ed+QkJBaQv+XwZiI=;
        b=PWIdhjoscQZbm5ADgJnYohKqIsKWLtf9ju97xPrnOXe+r+K6GZUSF3tfsj/aCbTqrb
         F/LbLCCQTTCfifo/RD8KSt2dPqPFzcpyMPeS8ctW8SHsQQKsrU8IErMhKKxRMWgj/359
         e6DjlWf1J82stxHU+kwgV7Exl/oOfeJL9vg9dWjL1t4qiC8HnmwcovSlVCPDyrGRNwzq
         OmznekccZqI7RrC5O/7ENb1H7RL4UyL2nS1Uqp4vcw38H7liMHVo8J0XFo804hctVutq
         hfesxY3bwOgYGyFEVNY02dN+nH0wrGJidrxkOkAQxUmq/Ixf2Mypvhz+iTPPLHGwc2v7
         WQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyGGShEtJ5QngHNH1K1pLBz5li6ed+QkJBaQv+XwZiI=;
        b=xKgCWtuHZB7JcFRJ2amlYTtoMQQMFz3PW2CEQhu49FAj80b3T1dMZBwkdFIU1C49Bf
         44Sdjb0H2vE+GgD7UpEP+K3cw5L2tc0osCe2TNPIKeBnkBQ2kioh3wtqT/omXjkCy1mV
         /+CBnbRQhtBdFuQelBXgmQLIbnPWVwCFd3Si0rLkk4+HtVn+LUu/LGlwuAY6gEhml7Xt
         U90HwGvrBuRJW7WdsWrirWDW0QDt/v6K96SFoIGGqK+F82fe5pnaQIKwyJd1GEaRaW3s
         e1oFuK9KVYuKNSlGUQRKqJTPf2/iilaxfsdeUR5d3kIWv/yADO9Wle6fdbW3+qT8C2dL
         XG5w==
X-Gm-Message-State: AJIora9P/rW7gi/O14KuEJWSzb5RNG/j79kY8ZN0LrsHq2WTfxouZwMV
        b/rPO8ACMNf/Z5s9J15O5z4=
X-Google-Smtp-Source: AGRyM1tO7vuOsF+0/JqzXCNNfyASqaxGNaareyrNlCthAXRzf8BXtQqQNdPj+tFxw9k15VtGTCoZaw==
X-Received: by 2002:a7b:c381:0:b0:3a2:fe96:2ce4 with SMTP id s1-20020a7bc381000000b003a2fe962ce4mr19633955wmj.70.1658059663508;
        Sun, 17 Jul 2022 05:07:43 -0700 (PDT)
Received: from xws.localdomain (pd9ea330d.dip0.t-ipconnect.de. [217.234.51.13])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c154700b003a2fcc32031sm16584324wmg.3.2022.07.17.05.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 05:07:43 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] platform/surface: tabletsw: Fix __le32 integer access
Date:   Sun, 17 Jul 2022 14:07:35 +0200
Message-Id: <20220717120735.2052160-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sources.count field is a __le32 inside a packed struct. So use the
proper functions to access it.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9f794056db5b ("platform/surface: Add KIP/POS tablet-mode switch driver")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_tabletsw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
index 596ca6c80681..27d95a6a7851 100644
--- a/drivers/platform/surface/surface_aggregator_tabletsw.c
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -410,7 +410,7 @@ static int ssam_pos_get_source(struct ssam_tablet_sw *sw, u32 *source_id)
 	if (status)
 		return status;
 
-	if (sources.count == 0) {
+	if (get_unaligned_le32(&sources.count) == 0) {
 		dev_err(&sw->sdev->dev, "no posture sources found\n");
 		return -ENODEV;
 	}
@@ -422,7 +422,7 @@ static int ssam_pos_get_source(struct ssam_tablet_sw *sw, u32 *source_id)
 	 * is a device that provides multiple sources, at which point we can
 	 * then try to figure out how to handle them.
 	 */
-	WARN_ON(sources.count > 1);
+	WARN_ON(get_unaligned_le32(&sources.count) > 1);
 
 	*source_id = get_unaligned_le32(&sources.id[0]);
 	return 0;
-- 
2.37.0

