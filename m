Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83754896AF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbiAJKsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiAJKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:47:54 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA90C06173F;
        Mon, 10 Jan 2022 02:47:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m13so12867159pji.3;
        Mon, 10 Jan 2022 02:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QoPQbPDSwmhcCclXn3wTkRYXJo86fSVvmFTmCUeMKdo=;
        b=fjmbYiE4EINPTC/2l3ddI5ufeI2VGM2uRQC/awt/KKVrHw48JrS1CryzAMa81x7M1Q
         bp0aScuAqPfZ4J48pityNe35L5ScCqkG+/gNGlTuBG70faN2mMDrU5VWRlOhZ15hSzaJ
         5/MpGAbwqlA4BWayyJhdh8Ef3uRLVOpsC/QFyKuBxNdy7yJU5LduxEM+BPfyt7F7hrmP
         2HcYkUrDumSud+F4/cRa7yH4mOfQv9dE8UDwPzYr6ZsDF1qb4xHkz8iXrkwcyiOQ8PJG
         VyC1JiA11+6RNhiFYERPSZG15252PGD6RW/QuM02buY9bMGC1sazjiKMfRbp0ctvj1wP
         9ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QoPQbPDSwmhcCclXn3wTkRYXJo86fSVvmFTmCUeMKdo=;
        b=wVj4EivQo00auMyBFrahLXsqghXzIBmeyA7afcrxYA2cuUPxpoCjtkHCSqQvwGZwA6
         dvFskGhbZ955Eis6hDsIHdvvJ1FawcSVln7NyAQREjsoJy3kf6uMoy9NVIYLQtd7lWD+
         dIoxaT+eVyq2v3KMPjn+bUbOIOa8qcwgq4WmOgwNGc/H3eM8kYxfB36B/Mv2HTnvPdd6
         0OxcwfJAqhbjqv5fNDOdbX4CuRQtwNkK0SBKLz8ghgvRCoQqqNnzgcxPYAp9dh2GrZob
         DUu2adPyz7J3ibQi9Ocl2h3QddlNj5QfcXbiypIjiTrlRfG5lTLYNNooJHB6sqoH6cS9
         G5RQ==
X-Gm-Message-State: AOAM533onVBNICrDyNMnir1F1Dry02g2s/9ibnUwrFtda7Yxj3Oo2NnD
        oN6WgDY67SQ6/W6sJzbDT+4=
X-Google-Smtp-Source: ABdhPJw+g4r1x0H35i02mrlXLUcvFmFtV6s2lhQJGIluU3rhzIKyBu7BhAvb7M/NXzDsrqks8doznQ==
X-Received: by 2002:a17:90a:9f95:: with SMTP id o21mr15744318pjp.44.1641811673860;
        Mon, 10 Jan 2022 02:47:53 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h17sm6376122pfv.217.2022.01.10.02.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 02:47:53 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/soundwire: remove redundant val variable
Date:   Mon, 10 Jan 2022 10:47:49 +0000
Message-Id: <20220110104749.646995-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from SWRM_REG_VAL_PACK() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/soundwire/qcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 54813417ef8e..77f9c90370be 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -235,7 +235,6 @@ static int qcom_swrm_cpu_reg_write(struct qcom_swrm_ctrl *ctrl, int reg,
 static u32 swrm_get_packed_reg_val(u8 *cmd_id, u8 cmd_data,
 				   u8 dev_addr, u16 reg_addr)
 {
-	u32 val;
 	u8 id = *cmd_id;
 
 	if (id != SWR_BROADCAST_CMD_ID) {
@@ -245,9 +244,8 @@ static u32 swrm_get_packed_reg_val(u8 *cmd_id, u8 cmd_data,
 			id = 0;
 		*cmd_id = id;
 	}
-	val = SWRM_REG_VAL_PACK(cmd_data, dev_addr, id, reg_addr);
 
-	return val;
+	return SWRM_REG_VAL_PACK(cmd_data, dev_addr, id, reg_addr);
 }
 
 static int swrm_wait_for_rd_fifo_avail(struct qcom_swrm_ctrl *swrm)
-- 
2.25.1

