Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E112C4A99C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352018AbiBDNM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350186AbiBDNM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:12:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683DC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:12:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s18so11242124wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZbYJHNx4029ps/19+h4CZdnYRI6KHcst/wEtS01Jdo=;
        b=TyKyYZByUE3jpVhuJ9mUwyFUGomBVpvNhaiNWGG0w8Al4uf8yFaqLcjbyfFqgnDNoP
         yiWyyUpqTstnRV+wIfXZX/rn/TeYTqDp4fjcuBCCa4JWw+Kn8zz/iqTrP176FbTG6J0x
         MiPupOe4nw0D20+TId1bYsLwFp9jqAWbuc9vd8yFc7mUjVtD4A/aWnrEX/43zbReKfzD
         3IX3QySKKUj+lUPiW2C7dWFlq07dtljJy+pq7oQglrIK0Mu7hUpL5boWgKRCk4BYOmpY
         FT62jyWUULzQYJZehkxDNW/SoB+KSFiMI2hvg499iZuKm87zKXvFh46Ew5B6+TkA5Uld
         5bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZbYJHNx4029ps/19+h4CZdnYRI6KHcst/wEtS01Jdo=;
        b=ws1eF1MyXJVd1NlLtok/leu6IdIwNoHoScgWzvLxwtiaC53cD+y/HDJIK7xdBy4n5C
         4yOS6cG3keZ00S+V+4jAPy9FagtPeC2oIqd3KvkiCuaRNeOm0dctdg01dbtY5pQcuJVb
         Kq7iuDfUCVV+f9taokfHjfTWByCfv4wsyEg7+Zx6rBE/UFjPCio6RLJ4YZmReH4TvnkS
         NtfMoGI4xof0aszh78/ojCBDmv0Rb8vYeVXPDtm0RaEuYiGq6D+cGlYylCwESwz7lL1v
         vh6W5lW8k76Bed6a+iufzOyi16l+X92bMWFluOQqfCIUTXe8OYKmMsS20LhWdaDLx2l2
         Nh/g==
X-Gm-Message-State: AOAM5338q66cKVcq/8iFe8xblyL34wdQLj/0gbfHJgCPEKToVoePwxCu
        3mtjkvCM4uWbv+oTd87iNIkCrmTuM3GE0Q==
X-Google-Smtp-Source: ABdhPJyBJFSfzOskZ3dK5bvmtr+IRWoECNPyqbHGeLbc83XvlzGW98cyZv7ax19uTaCxEIMTvLe9BQ==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr2443227wrw.453.1643980375586;
        Fri, 04 Feb 2022 05:12:55 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p42sm9645343wms.28.2022.02.04.05.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:12:55 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     don.brace@microchip.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] scsi: hpsa: prevent hpsa to severly delay boot
Date:   Fri,  4 Feb 2022 13:12:47 +0000
Message-Id: <20220204131247.1684875-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my HPE Proliant microserver gen 10+, modprobing hpsa lead to:
hpsa 0000:01:00.7: unrecognized board ID: 0x00e41590
hpsa 0000:01:00.7: unrecognized board ID: 0x00e41590
hpsa 0000:01:00.7: can't disable ASPM; OS doesnt't have ASPM control
hpsa 0000:01:00.7: board not ready, timed out.

And the boot is severly delayed until the timeout.

The controller is HPE Smart Array S100i SR Gen10

I have tried to add (naivly) to struct board_type products:
	{0x00e41590, "Smart Array S100i SR Gen10", &SA5_access},
but the board still time out.

With further search, I found that the S100i seems to be a fake SW RAID controller usefull for windows only.

So I use the following patch to fix the boot stuck.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/scsi/hpsa.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index a47bcce3c9c7..dbc753a30500 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -231,6 +231,7 @@ static struct board_type products[] = {
 	{0x007D1590, "HP Storage P1228 Array Controller", &SA5_access},
 	{0x00881590, "HP Storage P1228e Array Controller", &SA5_access},
 	{0x333f103c, "HP StorageWorks 1210m Array Controller", &SA5_access},
+	{0x00e41590, "Smart Array S100i SR Gen10", NULL},
 	{0xFFFF103C, "Unknown Smart Array", &SA5_access},
 };
 
@@ -7554,6 +7555,10 @@ static int hpsa_lookup_board_id(struct pci_dev *pdev, u32 *board_id,
 		*legacy_board = false;
 	for (i = 0; i < ARRAY_SIZE(products); i++)
 		if (*board_id == products[i].board_id) {
+			if (!products[i].access) {
+				dev_info(&pdev->dev, "This is a SW RAID controller for windows only\n");
+				return -ENODEV;
+			}
 			if (products[i].access != &SA5A_access &&
 			    products[i].access != &SA5B_access)
 				return i;
@@ -8676,7 +8681,8 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rc = hpsa_lookup_board_id(pdev, &board_id, NULL);
 	if (rc < 0) {
-		dev_warn(&pdev->dev, "Board ID not found\n");
+		if (rc != -ENODEV)
+			dev_warn(&pdev->dev, "Board ID not found\n");
 		return rc;
 	}
 
-- 
2.25.1

