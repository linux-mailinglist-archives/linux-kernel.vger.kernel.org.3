Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967A45AE141
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiIFHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiIFHji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:39:38 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE83E0C5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662449973; x=1693985973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qM4br7msd94mIardao6ZSlhF1fdL3fJcAnMyZj5ax9s=;
  b=Qvw22Jtf3RvMuG8SeEYTMdAn3wI7XVDLBHTyp1SItDnc8xbKNhh9YgCN
   ZXcJpVvjhRw5AnyYUDwBQejF0ddm9ZlheKutpTPjw4jtq3wdkoEKf9CgU
   ugT0QUIWgZ1U1T040Z0KNb3mnRx8F3F9tj98RnbtjFUd3BgIYXsKdjCJj
   NMlXxlTAWyQTIAU/RFGST7WlfzDjftx2mz1DFzwI4OCvy14sUXNMa28bS
   N1AFryjFLa+4jPQ+M5AyU/aR6kmX8Bgg9MofRM+caa3X/C5iBhhKtiNLo
   qxXy3sb8i9NtdAhWRjy8/xehmRbLSAZl6JuoX5qRzTYYIrmEJhQc5IWTe
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,293,1654531200"; 
   d="scan'208";a="215765001"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2022 15:39:32 +0800
IronPort-SDR: gBNvcWGFlwOln7OdiYqOektQWLfS3P3byJLaAVZPISoOShN2KzJCCZbNIb4FyS4pTjnY1zvxTm
 lVSc+3p8ueCuJ5YR3qD3NZdHx3adG7SC+D/kVMKXHPm68EkyOj1wHAUaEBq2eecxTI4/xfLcp+
 C97x8UpnxK5cs1r1mFdjk/AmEvCjx3FKozC0ocLAd47N9nuKFtrSFRlpD7j0zrIVRUxMoD9EtE
 zuaFN8gKE6JhKqQS5o3vZC7wz1ZW+i2l/OdvkHJXBfSanAN7+DlLlewh6v0UPnM3Nx3jCrg1l/
 yz/0mA1oD+7VBhkLU0MlnEQ/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2022 23:59:57 -0700
IronPort-SDR: Wnq75+XBAxLJJUeIO6lT8YWaMU1mTQX900G6CNL3z/at4WdSp9iGMJCMebkQBJ3Jyc/4gcjGtP
 JcImDJohIs4FRCqkmi/KFoaxLAzUoHhhe+k0RXMzOKinqqfadTg2d9HzuVRhIs6Ck9naRKG8ru
 2SM/gn8BMnFfSoqyrBn/ZIsewKt+ggIKN11EG3lMkrh5u0eNOcPEKW8gJjysxGbUeBi//rr/vU
 dmlICTNkS0Kz0RUPGjnaIt90ICldpOu98nyIjOP6DYzrgMMHSbmLRABo1sQDPOc3kzJmTuk91J
 by8=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO dellx4.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2022 00:39:32 -0700
From:   Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>
To:     linux-nvme@lists.infradead.org
Cc:     Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmet: fix mar and mor off-by-one errors
Date:   Tue,  6 Sep 2022 09:39:28 +0200
Message-Id: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>

Maximum Active Resources (MAR) and Maximum Open Resources (MOR) are 0's
based vales where a value of 0xffffffff indicates that there is no limit.

Decrement the values that are returned by bdev_max_open_zones and
bdev_max_active_zones as the block layer helpers are not 0's based.
A 0 returned by the block layer helpers indicates no limit, thus convert
it to 0xffffffff (U32_MAX).

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Suggested-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
---
Changes in v2:
    - Add explicit check if block layer helpers return a 0 and if so
    convert it to U32_MAX.
    - Add Fixes tag.

 drivers/nvme/target/zns.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c7ef69f29fe4..eae81f939067 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -100,6 +100,7 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	struct nvme_id_ns_zns *id_zns;
 	u64 zsze;
 	u16 status;
+	u32 mar, mor;
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
@@ -130,8 +131,20 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
-	id_zns->mor = cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
-	id_zns->mar = cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
+
+	mor = bdev_max_open_zones(req->ns->bdev);
+	if (!mor)
+		mor = U32_MAX;
+	else
+		--mor;
+	id_zns->mor = cpu_to_le32(mor);
+
+	mar = bdev_max_active_zones(req->ns->bdev);
+	if (!mar)
+		mar = U32_MAX;
+	else
+		--mar;
+	id_zns->mar = cpu_to_le32(mar);
 
 done:
 	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
-- 
2.25.1

