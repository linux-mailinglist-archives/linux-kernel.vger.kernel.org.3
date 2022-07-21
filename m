Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98A357CAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiGUMeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGUMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:33:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA5974E39
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:33:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso1336221pja.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=cYpDgQvonooDDthKtgEfzURcBA7QX408IxvSSxQbC6Q=;
        b=ePl/LLyRQvcoO7qe77cz00BP+ly56GjNwpqm/xbRbuspxN/MmwsuUmWDEThe7vMWF+
         TVfoNEooFA1WrWZdipGQnPswFjhF1Q82NcfcToaMxk57/hfBgN+lHNCv6csodlxMQOer
         49HglPV0vKz5Lzik5tVmbESJkE5oJ3yFHJdVhO3NO27zowZbUNxqIGK8XKZQvoX0gTNc
         5CaxjlVtU0eLEBelBvQbYWT6NytbI0B0Ia87szEtv6JAdYD6dGVy2+JBRL/G62cXZB1N
         7IZFFBtIrmUf3yDjyP2ieNHHTAnX+9fCJvslMpT/AXqt4TapKiBYsSUIG5OIlde//8Tk
         H7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cYpDgQvonooDDthKtgEfzURcBA7QX408IxvSSxQbC6Q=;
        b=5vbH6y2ZkP5jnSdQrfkxDZ4WTQlBBwH5MRpEyY8h3i2pMcMjtcXkrxsv6Ll3+ilMcn
         t8XFevlTCb0h1NWB3yQ/vz40DhGgHYs/VfI+9Az0Uypcm339q4O8uZ4LYMXHCVhglffx
         7xi5GbBYWBiukzl3i1IuVKNQaB+NDyO1XXmor2zjKiHaJcnmfqY6TpSOaPiCqaMbV0tB
         SPjcBkh5dxmqn/ov2fdCQIXL4XN4T9RevDkDR5YRbCu9zl97wLQCuyz7d+qMF0hlAI7G
         Tak2F8uEGy6BhgoitAy9R06dUlgmmH7sUJDDfgOR8Y8REvIAfD6Jbnnd1tKCchs1TxNb
         7qag==
X-Gm-Message-State: AJIora9ZGObG33/Gw8RQRbmibZ+CPlQOP6MLtvNRWTJQokIcOoVitWje
        xcRt86QnJnOgOVNDqcF7DWg=
X-Google-Smtp-Source: AGRyM1tAEhNPhWZLfLrHMLn23pzzUDngdAzya9wqkFMeHRFYanlNlboKkNXzouKNkS2LGWx/fVHtCg==
X-Received: by 2002:a17:90a:a796:b0:1ef:85de:6d9c with SMTP id f22-20020a17090aa79600b001ef85de6d9cmr10831477pjq.201.1658406837086;
        Thu, 21 Jul 2022 05:33:57 -0700 (PDT)
Received: from localhost ([58.33.57.226])
        by smtp.gmail.com with ESMTPSA id i2-20020a63d442000000b0040d287f1378sm1407593pgj.7.2022.07.21.05.33.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jul 2022 05:33:56 -0700 (PDT)
From:   "Jiazi.Li" <jqqlijiazi@gmail.com>
X-Google-Original-From: "Jiazi.Li" <jiazi.li@transsion.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Jiazi.Li" <jiazi.li@transsion.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Do not add a device that has been removed in device_shutdown to devices_kset list again.
Date:   Thu, 21 Jul 2022 20:33:25 +0800
Message-Id: <20220721123325.4675-1-jiazi.li@transsion.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between device_shutdown and devices_kset_move_last:
1. device_shutdown remove dev from devices_kset, unlock list_lock

2. supplier call device_link_add move this consummer dev to
last of devices_kset:
devices_kset_move_last+0x184/0x1fc
device_reorder_to_tail+0x50/0x17c
device_link_add+0x670/0x9c0
phy_get+0x88/0x300

3. device_shutdown call dev->bus->shutdown first time

4. in next loop, device_shutdown pick this dev from devices_kset
again, and call dev->bus->shutdown for the second time.

If the protection mechanism of dev->bus->shutdown is not perfect,
the following crash will occur:
[37.366651] [T1000001] Unable to handle kernel NULL pointer
dereference at virtual address 0000000000000070
[37.414053] [T1600001] Kernel Offset: 0x2c73800000 from 0xffffffc010000000
[37.414908] [T1600001] PHYS_OFFSET: 0x40000000
[37.415458] [T1600001] pstate: 60400005 (nZCv daif +PAN -UAO)
[37.416172] [T1600001] pc : [0xffffffec83eccd40] kernfs_find_ns+0x18/0x154
[37.417025] [T1600001] lr : [0xffffffec83ed8714] sysfs_unmerge_group+0x70/0x2e0
[37.417931] [T1600001] sp : ffffffc01008ba90
[37.418456] [T1600001] x29: ffffffc01008ba90 x28: ffffffec863c1000
[37.419221] [T1600001] x27: ffffffec85234e30 x26: ffffffec86490000
[37.419985] [T1600001] x25: ffffff80c854a4c0 x24: ffffff80c854a428
[37.420750] [T1600001] x23: 0000000000400100 x22: ffffffec85c4c5c8
[37.421514] [T1600001] x21: ffffffec85c4c5a0 x20: 0000000000000000
[37.422277] [T1600001] x19: ffffff80c0178000 x18: ffffffc010083068
[37.423043] [T1600001] x17: 0000000000000000 x16: 00000000000000d8
[37.423807] [T1600001] x15: ffffffec842b9314 x14: ffffffec85b04050
[37.424572] [T1600001] x13: 0000000000000000 x12: 000000000000000a
[37.425336] [T1600001] x11: 0000000000000000 x10: ffffffec863e9000
[37.426102] [T1600001] x9 : 0000000000000001 x8 : 0000000000000000
[37.426869] [T1600001] x7 : 332e37332020205b x6 : ffffffec863e6e7e
[37.427633] [T1600001] x5 : ffffffffffffffff x4 : 0000000000000000
[37.428396] [T1600001] x3 : 000000000000003c x2 : 0000000000000000
[37.429161] [T1600001] x1 : ffffffec85c4c5c8 x0 : 0000000000000000
[37.612410] [T1600001] Call trace:
[37.612831] [T1600001]  dump_backtrace.cfi_jt+0x0/0x8
[37.613457] [T1600001]  dump_stack_lvl+0xc4/0x140
[37.614038] [T1600001]  dump_stack+0x1c/0x2c
[37.614588] [T1600001]  mrdump_common_die+0x3a8/0x544 [mrdump]
[37.615326] [T1600001]  ipanic_die+0x24/0x38 [mrdump]
[37.615951] [T1600001]  die+0x344/0x748
[37.616425] [T1600001]  die_kernel_fault+0x84/0x94
[37.617016] [T1600001]  __do_kernel_fault+0x230/0x27c
[37.617642] [T1600001]  do_page_fault+0xb4/0x754
[37.618212] [T1600001]  do_translation_fault+0x48/0x64
[37.618846] [T1600001]  do_mem_abort+0x6c/0x164
[37.619406] [T1600001]  el1_abort+0x44/0x68
[37.619921] [T1600001]  el1_sync_handler+0x58/0x88
[37.620512] [T1600001]  el1_sync+0x8c/0x140
[37.621028] [T1600001]  kernfs_find_ns+0x18/0x154
[37.621608] [T1600001]  sysfs_unmerge_group+0x70/0x2e0
[37.622246] [T1600001]  device_del+0x198/0xd00
[37.622794] [T1600001]  device_unregister+0x1c/0x3c
[37.623409] [T1600001]  charger_device_unregister+0x40/0x54 [charger_class]
[37.624277] [T1600001]  sgm41516d_shutdown+0x54/0x84 [sgm41516d]
[37.625021] [T1600001]  i2c_device_shutdown+0x68/0x118
[37.625656] [T1600001]  device_shutdown+0x234/0x614
[37.626259] [T1600001]  kernel_restart+0x74/0x1e8
[37.626840] [T1600001]  __arm64_sys_reboot+0x3b0/0x424
[37.627475] [T1600001]  el0_svc_common+0xd4/0x270
[37.628056] [T1600001]  el0_svc+0x28/0x88
[37.628549] [T1600001]  el0_sync_handler+0x8c/0xf0
[37.629141] [T1600001]  el0_sync+0x1b4/0x1c0

because dev->kobject.sd has been set to NULL in fisrt shutdown.

Signed-off-by: Jiazi.Li <jiazi.li@transsion.com>
---
 drivers/base/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 753e7cca0f40..301c75639d85 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2850,6 +2850,12 @@ void devices_kset_move_last(struct device *dev)
 	if (!devices_kset)
 		return;
 	pr_debug("devices_kset: Moving %s to end of list\n", dev_name(dev));
+	/*
+	 * if dev has been removed from devices_kset in device_shutdown,
+	 * just return.
+	 */
+	if (list_empty(&dev->kobj.entry))
+		return
 	spin_lock(&devices_kset->list_lock);
 	list_move_tail(&dev->kobj.entry, &devices_kset->list);
 	spin_unlock(&devices_kset->list_lock);
-- 
2.17.1

