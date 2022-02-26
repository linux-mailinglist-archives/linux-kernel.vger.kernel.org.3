Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319F84C55E8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 13:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiBZMtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 07:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBZMto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 07:49:44 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D981EC9B5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 04:49:10 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p9so8311527wra.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 04:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HKu7Nq9ada9Q0GKmhF6FBkxxAo4IU+EPX6BvNCYFox8=;
        b=6x5jrcANK5bD433NpXdRCtV2c9jgfqOJGU64yg75fTDWaDeT/J8OqFELBHUX9vT1Se
         oK42PtAp4iyPsW1+RThNiQceWnDxFQocHUI1YQNNpacxdjF0NeFt7XnYroEuh7qhCYKL
         XA7xgflUsxVRJdDBtLzeDqiOnTf/JiY+lkAwam377yZwG9iFHu7hNyXIHWvdNBU4VAsU
         iEmgA3dKOh7X7T6iMGC/wkno8gU5rOnUK+ay+Cthnj8xrqr5tbwQF+drdgMdj5aWqLRm
         LPWx8+QuuDiXMBSSkBEcmKsWsWcKXr42pXfjS0E96N1QdZ2DGd6Ws75zyf7h4EXCySEx
         gcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HKu7Nq9ada9Q0GKmhF6FBkxxAo4IU+EPX6BvNCYFox8=;
        b=ZMFeQ5KOsFwtbY72EENhYhAF5oPSaqu9NiGhFpIrUU8Yd+HxzqD0ll7SEt/VdY+6Lj
         bFO+Y4B5LWSif/pAcVDTQHx9aY63AOzVSAjDqGcah2hrBIvpWQd+SX9ude+aNYGJwnfm
         WZAfzdBiO7dKn9SjTD45xm2zFD/Ng9HKKo+egaSpBr8gr+XIXAzL/S1YfI9lN7sTYp41
         5jRZ7B1QUsugt68ObRholMEcHi0OHHF8l0fO3J5S9qdoS3Do+xMl6RZtBRndZk5P6pVg
         p/stgwRPHOgHeKcYqBduHci5ZdU6bENK/AdIlM3jQCMe0rpo1uJJ/CUt9023Z0k/3FWC
         dhGw==
X-Gm-Message-State: AOAM531xvU3fwfPxjSxhg/OG+LtIbg83X6/JaYTtBsMF0g9QF22m7n26
        r7EyKJlrXcNwniQaFnMDRV5GAw7VYYceNTqCjlW+Xw==
X-Google-Smtp-Source: ABdhPJxM8vLs9v8y3p3R9aQurSHHEe5oH3GDF05PcnuiNTk/vV5hbRaFoSBOSeClmdHZ3ck3kCKnoA==
X-Received: by 2002:adf:9f0f:0:b0:1ed:c016:dfe5 with SMTP id l15-20020adf9f0f000000b001edc016dfe5mr9200390wrf.675.1645879748687;
        Sat, 26 Feb 2022 04:49:08 -0800 (PST)
Received: from spud.. ([109.76.226.172])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c7404000000b0038140136ff6sm5027696wmc.5.2022.02.26.04.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 04:49:08 -0800 (PST)
From:   Conor Dooley <mail@conchuod.ie>
To:     conor.dooley@microchip.com, nicolas.ferre@microchip.com
Cc:     arnd@arndb.de, olof@lixom.net, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Conor Dooley <mail@conchuod.ie>
Subject: [PATCH] soc: microchip: make mpfs_sys_controller_put static
Date:   Sat, 26 Feb 2022 12:48:27 +0000
Message-Id: <20220226124826.1564871-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

dsafsdfd0054 ("soc: add microchip polarfire soc system controller")
incorrectly exported mpfs_sys_controller_put. Remove the export and make
the function static instead. This fixes the "no previous prototype
for 'mpfs_sys_controller_put'" warning spotted by the kernel test robot.

Fixes: dsafsdfd0054 ("soc: add microchip polarfire soc system
controller")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <mail@conchuod.ie>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 2f4535929762..31f3f29fc1ae 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -73,13 +73,12 @@ static void mpfs_sys_controller_delete(struct kref *kref)
 	kfree(sys_controller);
 }
 
-void mpfs_sys_controller_put(void *data)
+static void mpfs_sys_controller_put(void *data)
 {
 	struct mpfs_sys_controller *sys_controller = data;
 
 	kref_put(&sys_controller->consumers, mpfs_sys_controller_delete);
 }
-EXPORT_SYMBOL(mpfs_sys_controller_put);
 
 static struct platform_device subdevs[] = {
 	{
-- 
2.32.0

