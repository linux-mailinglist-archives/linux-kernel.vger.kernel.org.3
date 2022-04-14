Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425C350054A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbiDNFDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiDNFDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:03:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC991DA5E;
        Wed, 13 Apr 2022 22:00:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so8275433pjb.2;
        Wed, 13 Apr 2022 22:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LAGD0p08t0pfhx7/okB2lBa8nRyuf90wrMSmnkmWG7I=;
        b=nAKm086Zb3y2MriDpFVxXGPZT6ciSeXKBUL3Uh6/K6h3S8y8QnuOq1tT/RltTNk/U/
         LPHEQ5wkpy0up4RRcad40bcnnnWTREy3kCMo/jC8cOfD9qrqEwh35LukDT9A6Ud3iWNx
         GU7c2lG3+Py0kyboHn2xQl6KTuoubMtPfQKW4afmzrj+xGOweiUXERyzQwoe3pmzey+F
         RpOVrpW/WEXzpR6eL0HQ0rOqJPWJydPqe6RidtygRSgZgdKeeyyhbl18efByVGAaBi3B
         FvZacG/MmaE2DmAM809m1tZdY7xajoVxRXjz7DzNZYIdy1eRTiohJAsVBmMRGJqk44qr
         +Vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LAGD0p08t0pfhx7/okB2lBa8nRyuf90wrMSmnkmWG7I=;
        b=lExv+4ucnJsIpEsagv3HdbfeVpfjBshQ7wcFboBD5cgXaWQKJa8jkYxw70wHLIqKuo
         TyQat1trFrs6HehJnN8NGbIQYNEYFtKET3K5MwurlC/MLQATj2bPJCs6jjvcvTWYPCO5
         PQkAKSzk6zv1E2qxswemjRoraH24eXyB4Omoh4rA8btLvyXTKZfi1qC+HrLxt3V1nZFL
         HU61WHhjO4Yq4kpGm1AetuPFaQJ9PvZMcT5ZsbCEQCFLcs/G/jvTFvdHqig1JVuUr6ae
         FxcBGgVJntasGnhRMgEE3hVM9yved9KUWvv9XJxfzF1c7C6EvJXq8CS6W7E68tJEPy9w
         +AUQ==
X-Gm-Message-State: AOAM532TV/apBDASWFveeuAOSExeLm0GMXO8ZBbMDTMutPMtXWQoI5fN
        alsdmyehlNoIEkZVlkEyOok=
X-Google-Smtp-Source: ABdhPJyPZlkvJPxDQp/eENGiurD7t8WJdTPv+ova1KZ+G97lr7ts7vd8m6ADdTz+hV1UFyqB/RnsPw==
X-Received: by 2002:a17:902:d507:b0:158:920c:2761 with SMTP id b7-20020a170902d50700b00158920c2761mr9750208plg.52.1649912442952;
        Wed, 13 Apr 2022 22:00:42 -0700 (PDT)
Received: from ip-172-31-12-67.us-west-1.compute.internal (ec2-54-241-4-221.us-west-1.compute.amazonaws.com. [54.241.4.221])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090a6c9000b001cc3a8b4fd6sm4688616pjj.7.2022.04.13.22.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 22:00:42 -0700 (PDT)
From:   Xiaobing Luo <luoxiaobing0926@gmail.com>
To:     tiny.windzz@gmail.com, rafael@kernel.org, viresh.kumar@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaobing Luo <luoxiaobing0926@gmail.com>
Subject: [PATCH] fix memory leak in sun50i_cpufreq_nvmem_probe
Date:   Thu, 14 Apr 2022 04:59:17 +0000
Message-Id: <20220414045917.3223700-1-luoxiaobing0926@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if sun50i_cpufreq_get_efuse failed, then opp_tables leak.

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
2.25.1

