Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27A504F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiDRLEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiDRLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:04:33 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77331A04F;
        Mon, 18 Apr 2022 04:01:55 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q75so2220774qke.6;
        Mon, 18 Apr 2022 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MR4XEfbq0g3i3GdpRwVqEKqpyQByj0l2iP24PNQRGxM=;
        b=IzyRlBNFlXcYwJ0AedNUdgtWrX7PK1n2WGgiNRQNsgfpMEpBd9MFe0lnImQRZucIUg
         aMihG21XzUFM4SF0iJvrQRE/IAe8wQoNtGc+VilqfppF7MfWSBiGMQPFp9ANlTcVOQQZ
         KFB9DkLYa57nppe+5cArRptLtNckEpcQcYwuDn3tSOZI8OLP0OpeWqC0tD+JBbMiOFLD
         8wcR5lio0k7OwwCaUDqAF5vWwSCSuHseD9k0l94X4vuw7Az1bDN6/Sxalu/ebWQzomNC
         p8Y575ThG5A+qX8HcWnCBVqG20VXEi9PUq/B9OeGz699wygBSfabRnrJ6OpXC9EpZr3w
         VmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MR4XEfbq0g3i3GdpRwVqEKqpyQByj0l2iP24PNQRGxM=;
        b=IZEinpAkypNuRmVfxVJ1D2keFXg/aCfE7HrYICyuOjFGfR6AvQe/7abZ1kBQ4VGaQ5
         yK4SsaPoMJ+dtsgJ+cazMHq8SrQmeKBzwpGd63ht+0hxoiGX56iB+NXGhS4E8JP3M1Jd
         NETDnPJraLNNR3Bk4tI95LKNRKB2/HBljrP6ioU+ZI3MYYrsARbi8ZiZe5iZOROdvaR9
         FKjqSVUM4ZLXSEJGDPIpkk/RCpfqS/XE071xjOsz8GW1bU1WLuYbLWXl/UmkIikmxCqs
         ubK4x5H9wmV4I90czFHcuaq+av1iBSn+7iu4shHcRAEuu+rXlQJEcQj4maCmJkRD7wJh
         FcEg==
X-Gm-Message-State: AOAM532+VYLwOIr2HRH/qEn8ctFm4tNDGj4KNNOGkM+exHQ4xMG+cMcC
        rWlv3/OlkwW/Bz5LDROX6bM=
X-Google-Smtp-Source: ABdhPJw/y/I+JyfBP/0bm8GE8o3iVm9bTOhtC6PncXm71NvTDTXarYdLBClGa/3tqnMMi6ah5LRAPA==
X-Received: by 2002:a37:8e04:0:b0:69e:6b49:412f with SMTP id q4-20020a378e04000000b0069e6b49412fmr6127791qkd.608.1650279714851;
        Mon, 18 Apr 2022 04:01:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c17-20020ac85a91000000b002e1dd8ae44bsm7476522qtc.29.2022.04.18.04.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:01:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     ldewangan@nvidia.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: spi-tegra20-slink: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 11:01:41 +0000
Message-Id: <20220418110141.2559019-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/spi/spi-tegra20-slink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 80c3787deea9..38360434d6e9 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -749,9 +749,8 @@ static int tegra_slink_setup(struct spi_device *spi)
 		spi->mode & SPI_CPHA ? "" : "~",
 		spi->max_speed_hz);
 
-	ret = pm_runtime_get_sync(tspi->dev);
+	ret = pm_runtime_resume_and_get(tspi->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(tspi->dev);
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
 		return ret;
 	}
@@ -1169,9 +1168,8 @@ static int tegra_slink_resume(struct device *dev)
 	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
 		dev_err(dev, "pm runtime failed, e = %d\n", ret);
 		return ret;
 	}
-- 
2.25.1


