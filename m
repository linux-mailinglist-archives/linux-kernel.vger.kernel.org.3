Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9B512A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiD1Dyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiD1Dyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:54:51 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 328968CCFE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KuxEd
        V3VH9xLOauPnO8hQxJT//rN1wAsa32d+NJKS2M=; b=YS9yUDmb3MmpqD8SYVMao
        b5ytGLlndleexJLDm1aU4/Td5y/nScq6bDa7lPBr7FkeFBO0FKQ50+g7v++iLqBi
        Z3sL5qPInPYKIN3J0qdMdS6vt0jJuB4fvL3T2FhzWLe3YajKnZPieV974gMBteSg
        5T0DYtVOnO7K6kj3IZLwWw=
Received: from carlis (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowADXucSHC2piIi4IDg--.61772S2;
        Thu, 28 Apr 2022 11:35:36 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] firewire: core: convert snprintf to sysfs_emit
Date:   Thu, 28 Apr 2022 03:35:33 +0000
Message-Id: <20220428033533.249463-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADXucSHC2piIi4IDg--.61772S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4kAFy8AF1rAr45tF1rCrg_yoW3ZFg_CF
        y7ZF42kr10gr1Iqr15Zry3Z3sIy3WY9FZIqw40yasaka42grykZrWUWr93KryUKryDAryx
        Za4DXw4Svr47WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnAcTPUUUUU==
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/xtbBOQnwhV-PM4LQeAAAsM
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
drivers/firewire/core-device.c:375:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/firewire/core-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 90ed8fdaba75..5ad373419d00 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -372,7 +372,7 @@ static ssize_t rom_index_show(struct device *dev,
 	struct fw_device *device = fw_device(dev->parent);
 	struct fw_unit *unit = fw_unit(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			(int)(unit->directory - device->config_rom));
 }
 
-- 
2.25.1

