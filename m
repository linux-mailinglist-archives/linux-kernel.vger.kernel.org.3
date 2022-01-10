Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC988488E13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiAJBbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiAJBbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:31:38 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF1C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 17:31:38 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 78so1324899pfu.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 17:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CyWK7eL2ncEuK4b3GozHvT0wf8XnpipJJkc/URoPADw=;
        b=aWlItH6lBe4BVxh830QaV9ghTzIrJ9dLwRgEzEgWJeYQymMWdXIzM93O6Rc+HiqTLV
         qfLg2C8k/wju3TuFN3pWHyp1u1m1F6i/B2LwDCjG8T49qNFWusqzXmJ0UUBH6U0EXZoH
         /Z3vGfdmwirq41XsBmxT92s3JcnNlz+G8Qdx1GsV0Y/vs+k21gkfwEcvq3iwAxUWipVR
         ij6lJOt4yWSxHhCNC9jrLqyGDks2KNcTe3NVqzIk7uLbsqEuF1kVHynTMqddu+SaON9D
         Nth5BxSR/Gxk2vYGQKTa5aW2/fZcGpfzmSxk1jEScA2/+RZrrstSns5M0QNXqajvNrHM
         F4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CyWK7eL2ncEuK4b3GozHvT0wf8XnpipJJkc/URoPADw=;
        b=2tCEpLDzmfntyxmQqtSGf8riRNoVFUUvBqaRcgh/0JJRFdkrCiOOB2Ywv4l+2GqkGE
         h4gGSjK5wxCQBN93M9LaCrOpgbP7tAfWYp7p7dn3kxKqYJQxZ7628fjgyWoPpZkssoos
         YovlurCpgWAaPN9I3D5GxT+aY+9J9rHj1IqiGpPwBVuwGORBmMxA7YuI/aNJ0F5lnAKc
         S54hl4RnQFTLv324JgNAcKfqhTPxzMuzCUg3I9eI+jkEu2LQHsW1spwd5VHQHz3Jo5xs
         tlUpbGZ4/YiuPnOvan8QXWzKs2tkqa1lGe1mGiG8iHXOCgEYB6PxPE3Z6E/m5VFZOtoj
         3AFA==
X-Gm-Message-State: AOAM532Qi1Phqrg9iO3mFdMSJtle7Y67erjwre+7pift+OiEoqVTahnv
        Htkfxd9jK6LJXxS30AwpaXc=
X-Google-Smtp-Source: ABdhPJwVn/fHGKE7EkI3irKVznAs+Via4WHZ354gb8UCElKRNe+ry8W1QIlBqA96ul5DaKlbh4/40Q==
X-Received: by 2002:a05:6a00:139b:b0:4ba:a476:364e with SMTP id t27-20020a056a00139b00b004baa476364emr73796374pfg.59.1641778298032;
        Sun, 09 Jan 2022 17:31:38 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l12sm4796180pfc.181.2022.01.09.17.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:31:37 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/misc: remove redundant ret variable
Date:   Mon, 10 Jan 2022 01:31:33 +0000
Message-Id: <20220110013133.644124-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from i2c_smbus_write_i2c_block_data() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/misc/bh1770glc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
index 0581bb9cef2e..d9714b2f8f6e 100644
--- a/drivers/misc/bh1770glc.c
+++ b/drivers/misc/bh1770glc.c
@@ -301,7 +301,6 @@ static int bh1770_lux_update_thresholds(struct bh1770_chip *chip,
 					u16 threshold_hi, u16 threshold_lo)
 {
 	u8 data[4];
-	int ret;
 
 	/* sysfs may call this when the chip is powered off */
 	if (pm_runtime_suspended(&chip->client->dev))
@@ -330,11 +329,10 @@ static int bh1770_lux_update_thresholds(struct bh1770_chip *chip,
 	data[2] = threshold_lo;
 	data[3] = threshold_lo >> 8;
 
-	ret = i2c_smbus_write_i2c_block_data(chip->client,
+	return i2c_smbus_write_i2c_block_data(chip->client,
 					BH1770_ALS_TH_UP_0,
 					ARRAY_SIZE(data),
 					data);
-	return ret;
 }
 
 static int bh1770_lux_get_result(struct bh1770_chip *chip)
-- 
2.25.1

