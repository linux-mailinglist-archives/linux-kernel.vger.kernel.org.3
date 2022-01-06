Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86D48683D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbiAFRPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbiAFRPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:15:50 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37473C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:15:50 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id w206so1170757vkd.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bv1uj9SjD53aGmIbUH8n5Q+U8y7s+fziMRLJmeNdKdM=;
        b=gCs3l7JycTeYC6LcXnl6STuvVtHSNa+4B7/LnDkjTYZRyjv5hXIzW0af16BserSJbg
         bHzo9udqKoNEb4MC69rkm/tdKG5bXn+6agS5X+ly7RugJJSDXlnyansBTOj+I8iu1sOe
         s8eqx9Io/8BXo4aRXQO7ammsAu/lBJ/DH4TG517SmK89vldrLbzf6FSnHh4IJqtZpzhJ
         KZf04E5nMS8mBv4VEqwaWddK9L0pKHMSz0O/n7VCWw4kyE1jlY8VaaOJfhwGkEEwfO9d
         Ne8/xm0hcZGh5zhazmtkMslgl2kyURPHUJU6/Q6nzjt2FnZTSVz1Oy1JDJ/YtW1KcLCg
         5TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bv1uj9SjD53aGmIbUH8n5Q+U8y7s+fziMRLJmeNdKdM=;
        b=QlAA3r/JvrDPoDseTSTR74Z4b5Q5JntqMYG0XU80kfdWBkWH9rxSZTRpH4YbcJFWuP
         cv4luXCgb4dkZooTC8oLfTE1qG1JiBPDGQw58J/dyMVYPFbGRW049Hb7fkLY+6s1KtMO
         tUg7bzHb6WTeqEjZinzsOXb7gRh8JOUT08QYBAyd4qyTUOmTw7xbxztZQFKEdX1ZC5DZ
         Z9EtFxmVZ9kkVMbcREWizQRqSm9riedGzj/lQxlyxAI+NxoTyYmKHod1kQuzQHIxvw2e
         nEEP5pGCKI5KrW8ZfQnfu5IKcL3BI3rFHz2cIeO1nwuhUgRczh25Yns/5uoYfJpy5pzx
         5o+g==
X-Gm-Message-State: AOAM530R6BedmPJAusmh8NZrMrac4h4Eu9oAGPUSam446C4j6YdR19Li
        MdlLvNma3jpzCBveXidt8lo=
X-Google-Smtp-Source: ABdhPJxSewBmlC+0VLJW9Al5oy6koPdY9GkUNqaPKUqpTHXDum6L2xtcmtSL7GsG8KHccVPpkXBFZA==
X-Received: by 2002:a05:6122:88b:: with SMTP id 11mr21281956vkf.10.1641489349280;
        Thu, 06 Jan 2022 09:15:49 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:485:504a:2169:9589:878d:2b28])
        by smtp.gmail.com with ESMTPSA id u26sm1871781vsj.9.2022.01.06.09.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:15:48 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     matthias.schiffer@ew.tq-group.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] regmap: debugfs: Free the previous allocated debugfs_name buffer
Date:   Thu,  6 Jan 2022 14:15:37 -0300
Message-Id: <20220106171537.3091643-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following error message is seen when booting an imx6q-sabresd:

debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent 'regmap' already present!

By inspecting the duplicate directory name: 

[    0.274418] platform panel: Fixing up cyclic dependency with ldb
[    0.276896] ************ 1: devname is dummy
[    0.276926] ************ 2: name is iomuxc-gpr@20e0000
[    0.276951] ************ 3: Forming the final name
[    0.276979] ************ 3a: Name from map->debugfs_name dummy-iomuxc-gpr@20e0000
[    0.277001] ************ 4: name is dummy-iomuxc-gpr@20e0000
[    0.277022] ************ 5: Final name is dummy-iomuxc-gpr@20e0000
[    0.277746] No ATAGs?
[    0.278355] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.278469] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.282007] ********** gpr succeeded
[    0.282042] ************ 1: devname is 20e0000.pinctrl
[    0.282070] ************ 2: name is gpr
[    0.282093] ************ 3a: Name from map->debugfs_name dummy-iomuxc-gpr@20e0000
[    0.282115] ************ 4: name is dummy-iomuxc-gpr@20e0000
[    0.282138] ************ 5: Final name is dummy-iomuxc-gpr@20e0000
[    0.282185] debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent 'regmap' already present!


The 'dummy-iomuxc-gpr@20e0000' name is caused by a non-freed map->debugfs_name
buffer.

After calling kfree(map->debugfs_name), no more duplicate naming is seen:

After:

[    0.257135] platform 2800000.ipu: Fixing up cyclic dependency with 120000.hdmi
[    0.257460] platform 2800000.ipu: Fixing up cyclic dependency with 20e0000.iomuxc-gpr:ipu2_csi1_mux
[    0.257782] platform 2800000.ipu: Fixing up cyclic dependency with 21dc000.mipi
[    0.273536] platform panel: Fixing up cyclic dependency with ldb
[    0.276013] ************ 1: devname is dummy
[    0.276043] ************ 2: name is iomuxc-gpr@20e0000
[    0.276067] ************ 3: Forming the final name
[    0.276097] ************ 3a: Name from map->debugfs_name dummy-iomuxc-gpr@20e0000
[    0.276119] ************ 4: name is dummy-iomuxc-gpr@20e0000
[    0.276141] ************ 5: Final name is dummy-iomuxc-gpr@20e0000
[    0.276859] No ATAGs?
[    0.277468] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.277580] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.281122] ********** gpr succeeded
[    0.281156] ************ 1: devname is 20e0000.pinctrl
[    0.281184] ************ 2: name is gpr
[    0.281206] ************ 3a: Name from map->debugfs_name 20e0000.pinctrl
[    0.281228] ************ 4: name is 20e0000.pinctrl
[    0.281251] ************ 5: Final name is 20e0000.pinctrl

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/base/regmap/regmap-debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index ad684d37c2da..18f0c7223082 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -589,6 +589,7 @@ void regmap_debugfs_init(struct regmap *map)
 				return;
 		}
 		name = map->debugfs_name;
+		kfree(map->debugfs_name);
 	} else {
 		name = devname;
 	}
@@ -600,6 +601,7 @@ void regmap_debugfs_init(struct regmap *map)
 		if (!map->debugfs_name)
 				return;
 		name = map->debugfs_name;
+		kfree(map->debugfs_name);
 		dummy_index++;
 	}
 
-- 
2.25.1

