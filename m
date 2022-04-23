Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B8050CB99
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiDWPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiDWPRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:17:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085E15708;
        Sat, 23 Apr 2022 08:14:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t13so9715372pgn.8;
        Sat, 23 Apr 2022 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HaWZYkIToDpIcggCzzIREPknCIirh1Q5Ng9bwQqh7rg=;
        b=Ha1ewV9/ZKH5gNBLigDYDJc8kBXDt5R6ECJk+Zy/i92ysyhtW8u0UPvUblw4r3AeJH
         rDP7i+VKWYNkfzwTLJkO8aP7kpWtjEpQfeVNssBHu8Y0yU0rcDjS9K+vIHAB1JHD7MrI
         HxIZ4ah46XdbA/0FoiPVbgQeILP15MmRpbkkWmxcnpodqBAmbVnjoJLR6Mb2RGUTS5UG
         E7Fad/T/YPKbJ5qzENOMnpSaTeLQMs37WW1M3/s5uzk13on9gyqv9oOaTwVpuHQ7LGqk
         Qr1dV40XjrHOhjJDkr93mgEjXcurO5bYS03bCZP0a3HUx6PcKL3/X7fcL4Lj5zekaXGT
         Fw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HaWZYkIToDpIcggCzzIREPknCIirh1Q5Ng9bwQqh7rg=;
        b=cA/a+cXxqID6TfU3T8k1fethTscM0e/F7LG6g35VFt2gdeT4cf8ISFkKlAHcOTjLHE
         QjVyts+3LdFLJN1600Kh8wytY9of7/Xv1LLdV3KC1GhHJZ4loCgIs3ZNiEWfwbffLvvM
         jDMYHF53EcAH9sPgr7BYqwcWrF8tHH1ycO02MsTK/7srizPnYDTAkkSZKPmSZGj+zR/N
         70JNc+CD8t4zPvfrtgG2HaMeHLxz8WtY8oSgVy1qA35i2Bnf9pIu3mCQh22/gYykMLwq
         WZsqZPtJzsKTKGRmfIlayQz/0DDouRNrH7uohhyIcPIyQ1/LDRtdYqmUdrIuBxlXuZ1F
         ZwwQ==
X-Gm-Message-State: AOAM532nGwKVV13FrMkxxWcxQCcSuq+wD1R+LIIuwxBYp/YNF3ihYUe9
        N9pkpABwBwvhErrlxU0mAf4=
X-Google-Smtp-Source: ABdhPJz2ht11c+e4unTJ3LxGk1NAUDGSSEJtoxC5QD3dzyRSKhzbBCNyqHAFlQgLmXhaU9xciXNGqA==
X-Received: by 2002:a63:f749:0:b0:3aa:361c:8827 with SMTP id f9-20020a63f749000000b003aa361c8827mr8382156pgk.361.1650726895185;
        Sat, 23 Apr 2022 08:14:55 -0700 (PDT)
Received: from ip-172-31-12-67.us-west-1.compute.internal (ec2-54-241-4-221.us-west-1.compute.amazonaws.com. [54.241.4.221])
        by smtp.gmail.com with ESMTPSA id s50-20020a056a001c7200b0050acf7cadc5sm6114680pfw.112.2022.04.23.08.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:14:54 -0700 (PDT)
From:   Xiaobing Luo <luoxiaobing0926@gmail.com>
To:     tiny.windzz@gmail.com, rafael@kernel.org, viresh.kumar@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        mripard@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaobing Luo <luoxiaobing0926@gmail.com>
Subject: [PATCH v2] cpufreq:fix memory leak in sun50i_cpufreq_nvmem_probe
Date:   Sat, 23 Apr 2022 15:12:04 +0000
Message-Id: <20220423151204.2102314-1-luoxiaobing0926@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------------------------------------
unreferenced object 0xffff000010742a00 (size 128):
  comm "swapper/0", pid 1, jiffies 4294902015 (age 1187.652s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000b4dfebaa>] __kmalloc+0x338/0x474
    [<00000000d6e716db>] sun50i_cpufreq_nvmem_probe+0xc4/0x36c
    [<000000007d6082a0>] platform_probe+0x98/0x11c
    [<00000000c990f549>] really_probe+0x234/0x5a0
    [<000000002d9fecc6>] __driver_probe_device+0x194/0x224
    [<00000000cf0b94fa>] driver_probe_device+0x64/0x13c
    [<00000000f238e4cf>] __device_attach_driver+0xf8/0x180
    [<000000006720e418>] bus_for_each_drv+0xf8/0x160
    [<00000000df4f14f6>] __device_attach+0x174/0x29c
    [<00000000782002fb>] device_initial_probe+0x20/0x30
    [<00000000c2681b06>] bus_probe_device+0xfc/0x110
    [<00000000964cf3bd>] device_add+0x5f0/0xcd0
    [<000000004b9264e3>] platform_device_add+0x198/0x390
    [<00000000fa82a9d0>] platform_device_register_full+0x178/0x210
    [<000000009a5daf13>] sun50i_cpufreq_init+0xf8/0x168
    [<000000000377cc7c>] do_one_initcall+0xe4/0x570
--------------------------------------------

if sun50i_cpufreq_get_efuse failed, then opp_tables leak.
Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")

Signed-off-by: Xiaobing Luo <luoxiaobing0926@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 2deed8d8773f..75e1bf3a08f7 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -98,8 +98,10 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = sun50i_cpufreq_get_efuse(&speed);
-	if (ret)
+	if (ret) {
+		kfree(opp_tables);
 		return ret;
+	}
 
 	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
 
-- 
2.36.0

