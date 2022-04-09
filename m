Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0164FA911
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiDIOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiDIOmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:42:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233C235846
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 07:40:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 66so10241022pga.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JU41SxMqoMbPQ8QDWJHCi79lbMEbsjN5J5bWfMPCK44=;
        b=FcErb1/aURM81N0KQMBD4HiiOBV3ZvN/fKTZEZCoVKB4fpu3Yz2xPUczF6QvdYRNoF
         l+8SzpOuuPgzj9fkGjH7uHoEDVg6+VdDH3GC1qA12fmXurrcYKgEoPirQCHDPkJu4dXQ
         5rL0z9yh/sslZFzBAJzMffuqGGMwyMD2W6lKYPxOhQY18mH85wVuYt05zPRxlAZy+YL0
         7YUyl9TJAHE+6zeWsNamzUdjJrZ2COO12vYK50DkZRQ8W/qF6LLVd8sfozz2w9YtxjcD
         2Jew7Cb4adTIRU62EqpBj28FQcMTLFaTchc3ZaKVl28JgkAhGkyx8mH2l/9dXfP+ah1v
         JDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JU41SxMqoMbPQ8QDWJHCi79lbMEbsjN5J5bWfMPCK44=;
        b=CyZ8PX0obPcVfftCAqX96rMlBzhrm577A4usdPPal16Ej2huJOOG2/zxgvQ+2cdmVt
         uE98NBzI//G1DlU2GtWqe3EeFaBhAWthf3ERfS2m8/fJRIKXH8KqH2mqme0lrAMLdNKP
         byMirKHFYLMyDi37x4W54q3An7aZUTQqEe34mrnsqPYVQEhk4ssTzYB+vnUYJZ4b19rp
         oSZYAHG0PVetAiHVM1Fdfi/M6sqVvY+vyfg58FoqBqYH4mlZhyfmNhH+SUAuk/ZhWQec
         UpwIMDwbwx+o67N+rT0q/l/6w46+CYzYsgfjkgCMFz3fCq8Erj2ag5b83J7b8ZJbdZw5
         zt9A==
X-Gm-Message-State: AOAM531N1Q+S++qABmtJv+X0E0WpTcT7+BDHas+JRTudVLylLeoMOJZi
        2au/AlN2vskbV+H1t/AI5g==
X-Google-Smtp-Source: ABdhPJzsW+eToTWCrP8SHQ9RBgakFlrWo4D3JSdC6x9/gCg055Ug42/f1pZhPJGIslBLxzrw0/4W8A==
X-Received: by 2002:a05:6a00:b47:b0:4fd:a5b5:a279 with SMTP id p7-20020a056a000b4700b004fda5b5a279mr24556558pfo.19.1649515204528;
        Sat, 09 Apr 2022 07:40:04 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id f15-20020a056a001acf00b004fb2ad05521sm29225307pfv.215.2022.04.09.07.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 07:40:03 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        peter.ujfalusi@linux.intel.com
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] ASoC: SOF: Intel: Check the bar size before remapping
Date:   Sat,  9 Apr 2022 22:39:50 +0800
Message-Id: <20220409143950.2570186-1-zheyuma97@gmail.com>
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

The driver should use the pci_resource_len() to get the actual length of
pci bar, and compare it with the expect value. If the bar size is too
small (such as a broken device), the driver should return an error.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 sound/soc/sof/intel/pci-tng.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/pci-tng.c b/sound/soc/sof/intel/pci-tng.c
index 6efef225973f..7d502cc3ca80 100644
--- a/sound/soc/sof/intel/pci-tng.c
+++ b/sound/soc/sof/intel/pci-tng.c
@@ -75,7 +75,11 @@ static int tangier_pci_probe(struct snd_sof_dev *sdev)
 
 	/* LPE base */
 	base = pci_resource_start(pci, desc->resindex_lpe_base) - IRAM_OFFSET;
-	size = PCI_BAR_SIZE;
+	size = pci_resource_len(pci, desc->resindex_lpe_base);
+	if (size < PCI_BAR_SIZE) {
+		dev_err(sdev->dev, "error: I/O region is too small.\n");
+		return -ENODEV;
+	}
 
 	dev_dbg(sdev->dev, "LPE PHY base at 0x%x size 0x%x", base, size);
 	sdev->bar[DSP_BAR] = devm_ioremap(sdev->dev, base, size);
-- 
2.25.1

