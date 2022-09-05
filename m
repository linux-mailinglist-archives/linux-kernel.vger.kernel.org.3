Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45E5AD24C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbiIEMXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbiIEMXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:23:46 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10444B0C8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662380625; x=1693916625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZUsJNKl9kM4XrO+bzq6rMd4l+h94hGBCGq7tktFiIIQ=;
  b=Cjx1s/DoN1GQmFDeln88NTLAuCAXOP6slCqrvUonnOuPYFvQOETYel21
   EHrHh8fpQF7orWaXMVgKgqCwUmTiPkstXUCYSCQUPRUCVfNf3JR0C3Woc
   5fMG/I6zCyGoced/CWNz49oWm4mFMk/z45DApR1ujX7T6KWgxDp/yCgmj
   bnA5Y5Yab+8r/FS+gnI/SADLtvIPtLWG42BuyG9biuNQkPlQLJ0A7FE3s
   Itc/Me9hAAZ4QdI7ir3CsYNadfD53XMEtfxB1TVqZucZSPSTIiofIkFh+
   BY82LultKK8crxZh1I0ffS+OPQj3g6l2reBhtIdCCDVP1ov2LoO9/eBRA
   w==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654531200"; 
   d="scan'208";a="215694369"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 20:23:44 +0800
IronPort-SDR: M79f1SmzuCwMNXJRzYzQAwMWX8tiRvDBToKyNBR9uB0WSmyahwbOZj1Q1rF5NxZrPw8DyzTTmV
 eIZxemfvP7OD40kWma539d7GVuLD60xK4+3Czhi5Alhxd4FxD/1vnCZXh0ASRx1Zxf2qW+qKHP
 u4M5r6IxzWGjgT/LcBHqCRDEMg9GfXNsuwkwU+M1ZlI65XhT59TQkmE0fIaIv8ZD7GdDIovQZh
 tD/Shpm8EvKOXPAUpK++D+Rv9LHliRr0uP7Kc+i8n2MTc0R8nYGzk2Q+sWd06bmJXjx4Kc8J8D
 SYFWdx3lHb8haQMjJpZV6R/I
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2022 04:38:45 -0700
IronPort-SDR: 8dcfSLnIvZGdzY/wgFlmxn9ul7k1JgAU4lPkFxVrWiWs3OHLEzJMFKX+hCGBOxrZJxSe98SF+i
 kOgib49keGaFjuR5lmQKiPLm+Iq+mvm2JU4aCaAIqchI60k15kdGtpNTXn+GY2cu638ZWtNyrD
 YHMldbx7IZv8fUtGtVBsZ1ETnfvs7+eY9qMVm5D+9L/HCJVKY7kXyhXoIHxgtYhDkRN2eQCtMe
 CHclfAFhL/PGcmTBrowym8Rw0WO7kQgsXTxTKHeEneqzoAad46MNzi+xqqG3rNbGRZBlyRSXAL
 1qs=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO dellx4.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Sep 2022 05:23:44 -0700
From:   Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>
To:     linux-nvme@lists.infradead.org
Cc:     Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: fix mar and mor off-by-one errors
Date:   Mon,  5 Sep 2022 14:21:16 +0200
Message-Id: <20220905122116.2678206-1-Dennis.Maisenbacher@wdc.com>
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

Cast the unsigned int values that are returned by bdev_max_open_zones and
bdev_max_active_zones into u32 vales which need to be decremented as the
returned values of the block layer helpers are not 0's based.
The cast to u32 is necessary because the size of unsigned int is
architecture dependent and a 0 reported by the block layer helpers
indicates no limit, thus it needs to be converted to 0xffffffff which
happens by underflowing the u32.

Suggested-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
---
 drivers/nvme/target/zns.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c7ef69f29fe4..606f21ee21bf 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -100,6 +100,7 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	struct nvme_id_ns_zns *id_zns;
 	u64 zsze;
 	u16 status;
+	u32 mar, mor;
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
@@ -130,8 +131,10 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
-	id_zns->mor = cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
-	id_zns->mar = cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
+	mor = bdev_max_open_zones(req->ns->bdev);
+	id_zns->mor = cpu_to_le32(--mor);
+	mar = bdev_max_active_zones(req->ns->bdev);
+	id_zns->mar = cpu_to_le32(--mar);
 
 done:
 	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
-- 
2.25.1

