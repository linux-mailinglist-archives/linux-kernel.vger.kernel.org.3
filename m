Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093184FD6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391127AbiDLJ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381489AbiDLIXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:23:43 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8794353E3F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649750199; x=1681286199;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iiMetrZRF3Mkl2sHpTBNl5772P3KvxjKkotXwYt7AYI=;
  b=QIM6/ocqoEl1QiEG8leo+MjNNvJt+WtfhEk58maGaQRCS5b4BceQ1ucV
   9Lx7snmSSiCME34VbyxcZi5+f6AGMCCHLEo59/fHXWg9ov6aDZ6s+Zqrc
   M6d8wDHsI3S2YU6UsCbCwaz00J6YtQ4tcHRd2d8zg32YmB8eAoIeGcaIS
   E34inLwlsBuPVt0IxfyQ4lcpu9nOq5AwiYk2VpP4kKRAWHb9ezwTb9wN5
   GzdKYLTdYOCrMerIGF5nxn6RvD1TsQ1hszeFRvsNlRX41ZyomU4vrvbYe
   Oh0o0GvXXlPoJtwQgfPFtYrLomgKZns4IU8zMnWV6PNFaVdWmIwuBvUoS
   A==;
X-IronPort-AV: E=Sophos;i="5.90,253,1643644800"; 
   d="scan'208";a="202562241"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2022 15:56:37 +0800
IronPort-SDR: r+BaLWVTGuAAAfaPL/ClMScibUJfBEwEXQ24rxmva5AaMvoMNzaopAyR1So3KtpXpqVef4wxnr
 BIqNyofn3vs0IMb9Fq2aw7IsPILdAAUAvMEq11QKjc0GAtxUXyklM0QzPTVtf4m2cVg4uHuZA+
 aVGAa0snb5lr/moXHfxS/zUx9XTAgx5DkedJf1f1Vcnz++4ThmkqxPsrtAQw/2w/Uo8hVRXBnq
 1+jGsrY4HYhq1u+0k9EvFPaWONYO5O9Lbe0hUS4rPTF35s3VJ0hVWWBAAj3T5UoQhn7POpMbAF
 7n4huB1pUqBeJ4iX1ZSrl0m/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 00:27:54 -0700
IronPort-SDR: MSdOdbeaOuCqgvRm57jz46oLAxzGaD1T1PYqcQOdRKVQVB5z431yHMm47kt4gdmiKjtyqDOaw2
 +T5d1dJC4rMC/jyc+ure1NQjGkaKv3rhczv1oiQCRcSp8SYhthDs1YjDol4X41KZSQ7r/0iFty
 6Ab9oyRRp+gxmPwaoA+UncbEbSqIK/7GF0CVksn9rsPXJ07I0bGdUOyiAHISvSxM/v3eiWOXCS
 JFxGDMxrWhin5bBnsXKonkGYZ+1HEsOoPsIkuoSEqRHCoDH0ViocpHLfRPskJClGCGP6XLJktg
 k64=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Apr 2022 00:56:37 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] bus: fsl-mc-msi: fix MSI descriptor mutex lock for msi_first_desc()
Date:   Tue, 12 Apr 2022 16:56:36 +0900
Message-Id: <20220412075636.755454-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.35.1
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

Commit e8604b1447b4 ("bus: fsl-mc-msi: Simplify MSI descriptor
handling") introduced a call to the helper function msi_first_desc(),
which needs MSI descriptor mutex lock before call. However, the required
mutex lock was not added. This resulted in lockdep assert WARNING [1].
Fix this by adding the mutex lock and unlock around the function call.

[1]

[    8.542804] WARNING: CPU: 4 PID: 119 at kernel/irq/msi.c:274 msi_first_desc+0xd0/0x10c
[    8.551428] Modules linked in:
[    8.555184] CPU: 4 PID: 119 Comm: kworker/u32:1 Not tainted 5.18.0-rc1+ #5
[    8.562755] Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS EDK II Aug  9 2021
[    8.571539] Workqueue: events_unbound deferred_probe_work_func
[    8.578079] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    8.585736] pc : msi_first_desc+0xd0/0x10c
[    8.590529] lr : msi_first_desc+0xcc/0x10c
[    8.595321] sp : ffff800009856fb0
[    8.599328] x29: ffff800009856fb0 x28: ffff3018789f0000 x27: ffff3018789f0000
[    8.607175] x26: 1ffff0000130ae2a x25: 1fffe6030f13e0a4 x24: 1fffe6030f13e0a3
[    8.615020] x23: ffff301878a09024 x22: ffff301860993800 x21: ffffc539150ec000
[    8.622865] x20: 0000000000000000 x19: ffff301878a04880 x18: ffff30257b37b588
[    8.630710] x17: 0000000000000000 x16: 1fffe6030c3d89a3 x15: 1fffe6030c3d8982
[    8.638555] x14: 0000000000000004 x13: ffff301861ec4c14 x12: ffff70000130adc3
[    8.646400] x11: 1ffff0000130adc2 x10: ffff70000130adc2 x9 : ffffc53911dd0790
[    8.654245] x8 : ffff800009856e17 x7 : 0000000000000001 x6 : 0000000041b58ab3
[    8.662089] x5 : ffff70000130ada2 x4 : 1ffff0000130add2 x3 : 1fffe6030c3d8802
[    8.669933] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[    8.677778] Call trace:
[    8.680918]  msi_first_desc+0xd0/0x10c
[    8.685364]  fsl_mc_msi_domain_alloc_irqs+0x7c/0xc0
[    8.690938]  fsl_mc_populate_irq_pool+0x80/0x3cc
[    8.696251]  dprc_scan_objects+0x370/0x560
[    8.701042]  dprc_probe+0x54/0x210
[    8.705137]  fsl_mc_driver_probe+0x60/0xc0
[    8.709934]  really_probe+0x328/0x9bc
[    8.714292]  __driver_probe_device+0x268/0x3d0
[    8.719431]  driver_probe_device+0x64/0x154
[    8.724310]  __device_attach_driver+0x194/0x250
[    8.729536]  bus_for_each_drv+0x114/0x190
[    8.734241]  __device_attach+0x198/0x34c
[    8.738859]  device_initial_probe+0x20/0x30
[    8.743738]  bus_probe_device+0x168/0x1e0
[    8.748443]  device_add+0x858/0x12a0
[    8.752713]  fsl_mc_device_add+0x4bc/0x950
[    8.757505]  fsl_mc_bus_probe+0x464/0x740
[    8.762210]  platform_probe+0xd0/0x1b0
[    8.766653]  really_probe+0x328/0x9bc
[    8.771010]  __driver_probe_device+0x268/0x3d0
[    8.776149]  driver_probe_device+0x64/0x154
[    8.781028]  __device_attach_driver+0x194/0x250
[    8.786254]  bus_for_each_drv+0x114/0x190
[    8.790958]  __device_attach+0x198/0x34c
[    8.795576]  device_initial_probe+0x20/0x30
[    8.800455]  bus_probe_device+0x168/0x1e0
[    8.805159]  deferred_probe_work_func+0x16c/0x24c
[    8.810558]  process_one_work+0x69c/0xf40
[    8.815265]  worker_thread+0x3dc/0xc50
[    8.819710]  kthread+0x2cc/0x340
[    8.823635]  ret_from_fork+0x10/0x20
[    8.827909] irq event stamp: 2082
[    8.831915] hardirqs last  enabled at (2081): [<ffffc539131f6670>] _raw_spin_unlock_irqrestore+0x120/0x144
[    8.842267] hardirqs last disabled at (2082): [<ffffc539131d5ef4>] el1_dbg+0x24/0x80
[    8.850708] softirqs last  enabled at (2002): [<ffffc53910d90a38>] __do_softirq+0x528/0x8e0
[    8.859753] softirqs last disabled at (1997): [<ffffc53910e3c3e8>] __irq_exit_rcu+0x3f8/0x680

Fixes: e8604b1447b4 ("bus: fsl-mc-msi: Simplify MSI descriptor handling")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: stable@vger.kernel.org # v5.17+
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
Changes from v1:
* Added a Reviewed-by tag
* Reflected a nit comment on the list

 drivers/bus/fsl-mc/fsl-mc-msi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 5e0e4393ce4d..0cfe859a4ac4 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -224,8 +224,12 @@ int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 	if (error)
 		return error;
 
+	msi_lock_descs(dev);
 	if (msi_first_desc(dev, MSI_DESC_ALL))
-		return -EINVAL;
+		error = -EINVAL;
+	msi_unlock_descs(dev);
+	if (error)
+		return error;
 
 	/*
 	 * NOTE: Calling this function will trigger the invocation of the
-- 
2.35.1

