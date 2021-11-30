Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B134628CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhK3AHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhK3AHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:07:41 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E3CC061714;
        Mon, 29 Nov 2021 16:04:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m24so13480529pls.10;
        Mon, 29 Nov 2021 16:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9pNr1OrMIuWpwcubj+PM70XpS6JrRpbmtiPPGsXVKHM=;
        b=chdKzV6Q4ln/wVoAza1s3xXLFZkBBVaP+xRRhodstSxfvR7HPqrTrRElHDrJtK/MtT
         QMRhAlKjz6KjTyBUTjAcwHme7u/rqCmve8jIoqARak/gyePOyzrsdnFvDZmldqHn4Teh
         NbVnIsNF3io2j441w5LA4/x1uOUArR7EbOx3W6NWJ+YzPQ755sDv3PaxXEhd6++pNv3Z
         /tkS0V3vxIeZxqEeuYqNLr3Q5BSgY10ssXM+/S3YYpOrl65qsfE4gYhY33R0N65kesES
         9ExoFsYLoksrGX7B/8fzjCbS3oupicuLJ2zjqCyGXrU9ttCcaDIOa+cMEIYrjC8huiAs
         qGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9pNr1OrMIuWpwcubj+PM70XpS6JrRpbmtiPPGsXVKHM=;
        b=the2ue8uUp3neHQGwWGqMzfxwXaHlYXlH4brfFh50bfq4IvyUp0hhGLKH7UFQkc+xg
         hmZQg732F0SPpO1RhXwEIE2qeohf8Oc9VXWe3sAIyD8KIHsN9kaBHo32YH2Evz3xXEJi
         2h4Dc+bGLH5cwY3vL2pQwE34ut9lGTGpnFoq2EKbkTI+0iAOHJJ+1jgHxzIzN4wC5ep3
         flnTaklCd1bFzT3G5jwRz6vrHagPLm2mXDTBCQvFrB/9fIbSNgDsmM6G2NVKeLJNxdIE
         VOHV5D79CV+DYhzViegUkv81cu91IZxJ+IGbQZZVlEMmXVO3Ad3uUeDVJsKvDZH9xB2b
         8Hjg==
X-Gm-Message-State: AOAM5309ykR4dWS/lEqDNtwcaIyUDW9no3ea2k6FkxJ8kDFkCyuQweVP
        s5IbEXiA4OCnfDKq/sNhsvB7nHvIZ7s=
X-Google-Smtp-Source: ABdhPJz9FJluBVQ/MraKVDVcpWDTgrQ2f9aWuGlUuFl+vFUrHgVuAe3oW0ewoak9x1vOJspCNOvJ3Q==
X-Received: by 2002:a17:902:c3cc:b0:141:be17:405e with SMTP id j12-20020a170902c3cc00b00141be17405emr64624405plj.76.1638230663320;
        Mon, 29 Nov 2021 16:04:23 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id j16sm20463257pfj.16.2021.11.29.16.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:04:22 -0800 (PST)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     damien.lemoal@opensource.wdc.com
Cc:     davidcomponentone@gmail.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ata: replace snprintf in show functions with sysfs_emit
Date:   Tue, 30 Nov 2021 08:04:11 +0800
Message-Id: <2fbce7707eff3bfebf38138899e900ee8c619931.1638155918.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report：
./drivers/ata/libata-sata.c:830:8-16: 
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/ata/libata-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 5b78e86e3459..b9c77885b872 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -827,7 +827,7 @@ static ssize_t ata_scsi_lpm_show(struct device *dev,
 	if (ap->target_lpm_policy >= ARRAY_SIZE(ata_lpm_policy_names))
 		return -EINVAL;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 			ata_lpm_policy_names[ap->target_lpm_policy]);
 }
 DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
-- 
2.30.2

