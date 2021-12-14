Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2705A474780
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhLNQS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbhLNQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:16:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F7BC061401
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:51 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso16629202wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsNFpY1RRkr+DNPQxSAx+z1PDhyA43H0wT6kfJ2Z97I=;
        b=r2KgfOmb4y/Ab/0mkI4tt7WWdvvqhTCbve13AEruCqs1m8cQ6GMW+iCB/Nl6T5ijHd
         0z4TqVTqnOgCtgoIuSJY4qua46CSaPqxrBroEKC0DS2/cbRyJsDHLVEUFZ2w4XI/sISG
         GRGuoTT+PWiukf+Mwr0Pvo2HWRekn6wf6nLvUNXED/Qyi/sukQulC+kMqMfWhh27c0B4
         c3FoRy/+MeswvAkJjeZx4mzPMCe5my7ZV1UTwPBHEWZCJJMQ0GbtT9DaTz8z6IpeQs+o
         flflL1EmId2IOw0bTo6RF/u7+MlVdm+bC50+2yG5Enx1auGOeI7g3eXHbv7vrViv2obm
         HkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsNFpY1RRkr+DNPQxSAx+z1PDhyA43H0wT6kfJ2Z97I=;
        b=Gy/GjjQt4JvcK6LKhBGAQ5xR9qGY6TMR4ZiQktmtQzPBimNG/R4IQwFcgMgzk8Xve7
         a0DXNQXp6q9+EYhz/WgKqHmeoTK+Xu4/TnC10AhNLpOEGILjxJgkxboed4lnYJaThUQ4
         bjbTGNnWbPlB38hj2hBgZLVzyMypxpqOCImXVNJowURNCwcqO7Gf8OF6qyNwnnUAqxFP
         OEjr6MhU5VzDmocaP8ObiNgdAYhHQnxpt46kv21bVZqWyU9iHvbFAjQSdklkfTDmzBCK
         i+AhWIOeaGIhzJzgsk+T8ghyS3JQ76wy2qmXpORsze0uces5P6vI7l6IkDghAhqfdtFQ
         1IfQ==
X-Gm-Message-State: AOAM531JfOid3mprHgAlJTXu7n2/mPWnJ8Z/9uqJo4G6nlL4wdSNcXoG
        ++hMXLWok7eigTownHcsAHJ0xQ==
X-Google-Smtp-Source: ABdhPJx37pLCNLvqnCrEl6O5Qe/Rq60aJvQbHzOdJsWEFbxCtoEvmyIGJewcsg/q1i3nBKkL4mAsxw==
X-Received: by 2002:a1c:9d13:: with SMTP id g19mr47517867wme.41.1639498610376;
        Tue, 14 Dec 2021 08:16:50 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a9sm295116wrt.66.2021.12.14.08.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:16:50 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 11/18] staging: media: zoran: fix usage of vb2_dma_contig_set_max_seg_size
Date:   Tue, 14 Dec 2021 16:16:29 +0000
Message-Id: <20211214161636.1886900-12-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214161636.1886900-1-clabbe@baylibre.com>
References: <20211214161636.1886900-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vb2_dma_contig_set_max_seg_size need to have a size in parameter and not
a DMA_BIT_MASK().
While fixing this issue, also fix error handling of all DMA size
setting.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: d4ae3689226e5 ("media: zoran: device support only 32bit DMA address")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index a00ad40244d0..4ea2fbf189b9 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -1282,8 +1282,10 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err)
-		return -ENODEV;
-	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+		return err;
+	err = vb2_dma_contig_set_max_seg_size(&pdev->dev, U32_MAX);
+	if (err)
+		return err;
 
 	nr = zoran_num++;
 	if (nr >= BUZ_MAX) {
-- 
2.32.0

