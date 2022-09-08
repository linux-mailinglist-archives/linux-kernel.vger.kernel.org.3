Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3955B251E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiIHRrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiIHRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:46:47 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 061BE63E2;
        Thu,  8 Sep 2022 10:46:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,300,1654527600"; 
   d="scan'208";a="132135180"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Sep 2022 02:46:43 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3B68C400C9E6;
        Fri,  9 Sep 2022 02:46:39 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] thermal/core: Add a check before calling set_trip_temp()
Date:   Thu,  8 Sep 2022 18:46:10 +0100
Message-Id: <20220908174610.7837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal driver [0] for Renesas RZ/G2L SoC does not implement
set_trip_temp() callback but has trips commit 9326167058e8
("thermal/core: Move set_trip_temp ops to the sysfs code") changed
the behaviour which causes the below panic when trying to set the
trip temperature:

root@smarc-rzg2l:~# echo 51000 > /sys/class/thermal/thermal_zone0/trip_point_0_temp
[   92.461521] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   92.470958] Mem abort info:
[   92.474311]   ESR = 0x0000000086000004
[   92.478546]   EC = 0x21: IABT (current EL), IL = 32 bits
[   92.484290]   SET = 0, FnV = 0
[   92.487693]   EA = 0, S1PTW = 0
[   92.491153]   FSC = 0x04: level 0 translation fault
[   92.496461] user pgtable: 4k pages, 48-bit VAs, pgdp=000000004e885000
[   92.503736] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[   92.510869] Internal error: Oops: 86000004 [#3] PREEMPT SMP
[   92.516556] CPU: 0 PID: 290 Comm: sh Tainted: G      D            6.0.0-rc4-next-20220906-arm64-renesas-00124-g84633c87c5f6-dirty #509
[   92.528814] Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
[   92.535441] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   92.542516] pc : 0x0
[   92.544764] lr : trip_point_temp_store+0x84/0x140
[   92.549582] sp : ffff80000a92bc10
[   92.552961] x29: ffff80000a92bc10 x28: ffff00000d8a45c0 x27: 0000000000000000
[   92.560249] x26: 0000000000000000 x25: ffff8000082b53e8 x24: ffff00000eaffc20
[   92.567532] x23: ffff80000a92bd68 x22: ffff00000d3e0f80 x21: 0000000000000006
[   92.574814] x20: ffff800009149000 x19: ffff00000b8ab000 x18: 0000000000000000
[   92.582097] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaab028cdee0
[   92.589378] x14: 0000000000000000 x13: 0000000000000000 x12: ffff80000a92bbd0
[   92.596659] x11: ffff00000d3e0f80 x10: ffff800009149eb8 x9 : 000000000000000a
[   92.603940] x8 : 00000000ffffffc9 x7 : 0000000000000005 x6 : 000000000000002a
[   92.611220] x5 : 000000000000c738 x4 : 00000000ffffffd3 x3 : 0000000000000000
[   92.618500] x2 : 000000000000c738 x1 : 0000000000000000 x0 : ffff00000b8ab000
[   92.625781] Call trace:
[   92.628282]  0x0
[   92.630176]  dev_attr_store+0x14/0x28
[   92.633935]  sysfs_kf_write+0x4c/0x70
[   92.637681]  kernfs_fop_write_iter+0x160/0x1e0
[   92.642213]  vfs_write+0x474/0x540
[   92.645703]  ksys_write+0x68/0xf8
[   92.649100]  __arm64_sys_write+0x18/0x20
[   92.653111]  invoke_syscall+0x40/0xf8
[   92.656866]  el0_svc_common.constprop.3+0x88/0x110
[   92.661758]  do_el0_svc+0x20/0x78
[   92.665158]  el0_svc+0x3c/0x90
[   92.668291]  el0t_64_sync_handler+0x90/0xb8
[   92.672563]  el0t_64_sync+0x148/0x14c
[   92.676322] Code: bad PC value
[   92.679453] ---[ end trace 0000000000000000 ]---
/bin/start_getty: line 40:   290 Segmentation fault      ${setsid:-} ${getty} -L $1 $2 $3

Poky (Yocto Project Reference Distro) 3.2.1 smarc-rzg2l ttySC0

smarc-rzg2l login:

This patch fixes the above issue by adding a check to see if
set_trip_temp() callback is implemented before calling it.

[0] drivers/thermal/rzg2l_thermal.c

Fixes: 9326167058e8 ("thermal/core: Move set_trip_temp ops to the sysfs code")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note: Patch applies on top of [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next
---
 drivers/thermal/thermal_sysfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 78c5841bdfae..ec495c7dff03 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -128,9 +128,11 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
-	ret = tz->ops->set_trip_temp(tz, trip, temperature);
-	if (ret)
-		return ret;
+	if (tz->ops->set_trip_temp) {
+		ret = tz->ops->set_trip_temp(tz, trip, temperature);
+		if (ret)
+			return ret;
+	}
 
 	if (tz->trips)
 		tz->trips[trip].temperature = temperature;
-- 
2.25.1

