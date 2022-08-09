Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757CA58D5E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbiHII5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbiHII4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:56:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B528C22501
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:56:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h13so13562864wrf.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=x3LAwxQixbirt9XaznuF2BMc0lzOuvCPnP/nz7piIPA=;
        b=y1UiaG7mgsxxxkHnliUc3V8iryz12DjSbv11GtTXD23OEibQT/XAqSoQKUw1FwtP0a
         4PB6f8dcAvqUXBldjTJ/HOZlpXYjgwkFgPqZyA6xgbqqtw3MuMTxIoxBy11TW+tezsMW
         2K+EroHeyLUojbWRl4p6oJdLzXQM24WSHMYmp2ieA58bdAssSyQ9jaMO8FckuonPcoS5
         8o5jCUwCZY4ghfg1159eLT3VYm9sLSpjvDYCMFkE21Hq+LCtQjG1mwmbN+bcpCR8b+YH
         Q4ioh3CAQqruy2aXfBXa+KFs4DdUs73sq2XWs8V2CjPQx58tgMpu5OC393sK9GFVAT0p
         j+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=x3LAwxQixbirt9XaznuF2BMc0lzOuvCPnP/nz7piIPA=;
        b=Xuc50sR/G/IeHSSsXdfZbHEeHV37+KE2E3ohh3dR2w0DSmV0qD73v3QHOgn/lf77rO
         ajwr401z1Gk1BGMdj70oAd0wWTpz3c7DfZjbSzwKnoDMn77E3VfalyZpE61MlXcm5Be+
         CYvTEcHzj8AS1eNtwUVgrXoa8zFjuGXO9QJjKn9Nu41GMjVF6+Cw5GgeQzvyZTr02b7o
         u2KCOiODTca7wjrvWSrp5aYQVCIPvc0dhv5Ayn6k6k3phSRvKZ3EiRoYi31zl9G+vy5E
         PCK8EXJ0pLaL6LVNCxSPqztJaohe2ebeTMiDIaQz0YfqKa6CZtihImyOzhzr+2ePUq57
         R3Cw==
X-Gm-Message-State: ACgBeo14TmY8EXApEX8RUt/t/TuhoUMGXBKB0MiMYvbe9JKnrghOq+n3
        wQOMdi41AaUkE5jrEYMlgTRr3Q==
X-Google-Smtp-Source: AA6agR4QnB1mLDfIpQIOqHx/tKNQwqELMOrfwW0X/9YINERn8kfF19WXMyx+PJyM+67u+QoAeBdf9Q==
X-Received: by 2002:a5d:5483:0:b0:220:6b87:8f79 with SMTP id h3-20020a5d5483000000b002206b878f79mr13962163wrv.17.1660035398746;
        Tue, 09 Aug 2022 01:56:38 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c5-20020adfe705000000b0021f1522c93bsm15746147wrm.45.2022.08.09.01.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 01:56:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 4/4] thermal/of: Fix free after use in thermal_of_unregister()
Date:   Tue,  9 Aug 2022 10:56:29 +0200
Message-Id: <20220809085629.509116-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809085629.509116-1-daniel.lezcano@linaro.org>
References: <20220809085629.509116-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone is freed after being unregistered. The release method
devm_thermal_zone_device_register() calls
  -> thermal_of_zone_device_unregister()

This one calls thermal_zone_device_unregister() which frees the
thermal zone. However, thermal_of_zone_device_unregister() does access
this freed pointer to free different resources allocated by the
thermal_of framework which is invalid.

It results in a kernel panic:

[    1.915140] thermal_sys: Failed to find thermal zone for tmu id=2
[    1.921279] qoriq_thermal 1f80000.tmu: Failed to register sensors
[    1.927395] qoriq_thermal: probe of 1f80000.tmu failed with error -22
[    1.934189] Unable to handle kernel paging request at virtual address 01adadadadadad88
[    1.942146] Mem abort info:
[    1.944948]   ESR = 0x0000000096000004
[    1.948708]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.954042]   SET = 0, FnV = 0
[    1.957107]   EA = 0, S1PTW = 0
[    1.960253]   FSC = 0x04: level 0 translation fault
[    1.965147] Data abort info:
[    1.968030]   ISV = 0, ISS = 0x00000004
[    1.971878]   CM = 0, WnR = 0
[    1.974852] [01adadadadadad88] address between user and kernel address ranges
[    1.982016] Internal error: Oops: 96000004 [#1] SMP
[    1.986907] Modules linked in:
[    1.989969] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-next-20220808-00080-g1c46f44502e0 #1697
[    1.999135] Hardware name: Kontron KBox A-230-LS (DT)
[    2.004199] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.011185] pc : kfree+0x5c/0x3c0
[    2.014516] lr : devm_thermal_of_zone_release+0x38/0x60
[    2.019761] sp : ffff80000a22bad0
[    2.023081] x29: ffff80000a22bad0 x28: 0000000000000000 x27: ffff800009960464
[    2.030245] x26: ffff800009a16960 x25: 0000000000000006 x24: ffff800009f09a40
[    2.037407] x23: ffff800009ab9008 x22: ffff800008d0eea8 x21: 01adadadadadad80
[    2.044569] x20: 6b6b6b6b6b6b6b6b x19: ffff00200232b800 x18: 00000000fffffffb
[    2.051731] x17: ffff800008d0eea0 x16: ffff800008d07d44 x15: ffff800008d0d154
[    2.056647] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    2.058893] x14: ffff800008d0cddc x13: ffff8000088d1c2c x12: ffff8000088d5034
[    2.072597] x11: ffff8000088d46d4 x10: 0000000000000000 x9 : ffff800008d0eea8
[    2.079759] x8 : ffff002000b1a158 x7 : bbbbbbbbbbbbbbbb x6 : ffff80000a0f53b8
[    2.086921] x5 : ffff80000a22b960 x4 : 0000000000000000 x3 : 0000000000000000
[    2.094082] x2 : fffffc0000000000 x1 : ffff002000838040 x0 : 01adb1adadadad80
[    2.101244] Call trace:
[    2.103692]  kfree+0x5c/0x3c0
[    2.106666]  devm_thermal_of_zone_release+0x38/0x60
[    2.111561]  release_nodes+0x64/0xd0
[    2.115146]  devres_release_all+0xbc/0x350
[    2.119253]  device_unbind_cleanup+0x20/0x70
[    2.123536]  really_probe+0x1a0/0x2e4
[    2.127208]  __driver_probe_device+0x80/0xec
[    2.131490]  driver_probe_device+0x44/0x130
[    2.135685]  __driver_attach+0x104/0x1b4
[    2.139619]  bus_for_each_dev+0x7c/0xe0
[    2.143465]  driver_attach+0x30/0x40
[    2.147048]  bus_add_driver+0x160/0x210
[    2.150894]  driver_register+0x84/0x140
[    2.154741]  __platform_driver_register+0x34/0x40
[    2.159461]  qoriq_tmu_init+0x28/0x34
[    2.163133]  do_one_initcall+0x50/0x250
[    2.166979]  kernel_init_freeable+0x278/0x31c
[    2.171349]  kernel_init+0x30/0x140
[    2.174847]  ret_from_fork+0x10/0x20
[    2.178433] Code: b25657e2 d34cfc00 d37ae400 8b020015 (f94006a1)
[    2.184546] ---[ end trace 0000000000000000 ]---

Store the allocated resource pointers before the thermal zone is free
and use them to release the resource after unregistering the thermal
zone.

Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Michael Walle <michael@walle.cc>
---
 drivers/thermal/thermal_of.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 3effc729be4b..fd2fb84bf246 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -596,11 +596,15 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
  */
 void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
+	struct thermal_trip *trips = tz->trips;
+	struct thermal_zone_params *tzp = tz->tzp;
+	struct thermal_zone_device_ops *ops = tz->ops;
+
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
-	kfree(tz->trips);
-	kfree(tz->tzp);
-	kfree(tz->ops);
+	kfree(trips);
+	kfree(tzp);
+	kfree(ops);
 }
 EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
 
-- 
2.34.1

