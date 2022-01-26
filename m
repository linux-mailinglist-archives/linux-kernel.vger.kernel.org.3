Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB0149C5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiAZI5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiAZI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:57:40 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84556C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:57:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so46763444ybp.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lwgxdYwkYYoV60lC8eOCPlgo4Kltdl+GrrvrUKoXqeE=;
        b=GCHZoL2KMYN56Bb9bArQotAcUIaGcFRa4jJ0xMUOzCWB9X1/MdLNz/kq9Eud0X6jQR
         OItIooe8ERGMPdHPWn3T2DvWBEBvVwttzLV9fJbfUp++vVxM2nsV9AQTeGPXR2vk/KP0
         VpBiTkPR9Vplkpa4chZkwDEk6Lpe53fthwT9JbX2Kbi7rZyl4BLiF5B08Ww2wv8Z2X3y
         XDx69Pt0QAjeonxrtPJu6R7M1Ca3PoSpoSK4+zQ4UPo4dIhDkdua0AkRIbIKQRq2NNAK
         Wb3griZiPsq3QsJ1CFiYegt1R43GczSoObqOUZ3xh8PDwR95RF6uMioikK2bJ213wfFG
         VVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lwgxdYwkYYoV60lC8eOCPlgo4Kltdl+GrrvrUKoXqeE=;
        b=adBUIEeX5/LJVv7KRqxF9Pm0FmS6qu9Tv3X5EBMCsbwc6ua8yQGDcQoePxCL1CrPiZ
         bhEaJA/VKvVey4vCcLO/p26GZmOM07UQM/upvO4EBE6AeYOgmDbPg5pCjRLLdEPFuD+T
         FN/JEp+8RUZsbru8iGFvt0Z09s1H8mni1cYgNhgDpjRWw/bWmi6ECJqN23B3bph7+2Mm
         j773OqppTB7VOFrJma2oM2788nRyJ63ROUvjjjYqdg/CUMY7W5dB9TWm64kJ6IdXGLlp
         9EZyA1iujuclOFfOOORVVBBwZcU1QEOQj7r80C1OWI//DNocx9rU4l/urjMjLRNzZyjj
         N5JA==
X-Gm-Message-State: AOAM531SsRjPxaIRF4Na22m5grJ+K0QZWlpRerXxFANVAxbEjbMup9ko
        laAXsNmA7LZrHgQJm9A76kSMXhPHP/e++k6flHTLO4LAmwFXOudRFQIWn+u8pwd7gJMIh8VpUqV
        QLvoOr2xfE40zvtwgCqjHikB1Enguq2rNWnt/OH7YpmSdlh7QxAjMDkrHg04X7yHw5+M=
X-Google-Smtp-Source: ABdhPJxcNL7P3y0SVGcvCOiZCO4BPDNhBNML9s720/dkl9zginGY5V7+nVvKQmx6XPU7EOLpV8e748k2fQ==
X-Received: from decot.svl.corp.google.com ([2620:15c:2c5:11:bb79:635d:80b2:3c02])
 (user=decot job=sendgmr) by 2002:a81:a89:0:b0:2ca:287c:6d32 with SMTP id
 00721157ae682-2ca287c6f7bmr6600087b3.471.1643187459021; Wed, 26 Jan 2022
 00:57:39 -0800 (PST)
Date:   Wed, 26 Jan 2022 00:57:35 -0800
Message-Id: <20220126085735.575625-1-decot+git@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH RFC v1 1/1] mtd_blkdevs: avoid soft lockups with some mtd/spi devices
From:   David Decotigny <decot+git@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        David Decotigny <ddecotig@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Decotigny <ddecotig@google.com>

With some spi devices, the heavy cpu usage due to polling the spi
registers may lead to netdev timeouts, RCU complaints, etc. This can
be acute in the absence of CONFIG_PREEMPT. This patch allows to give
enough breathing room to avoid those false positives.

Signed-off-by: David Decotigny <ddecotig@google.com>
---

I tested this on a 5.10 base (lockdep).

 drivers/mtd/mtd_blkdevs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 243f28a3206b4..64d2b093f114b 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -158,6 +158,7 @@ static void mtd_blktrans_work(struct mtd_blktrans_dev *dev)
 		}
 
 		background_done = 0;
+		cond_resched();
 		spin_lock_irq(&dev->queue_lock);
 	}
 }
-- 
2.35.0.rc0.227.g00780c9af4-goog

