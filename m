Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D155A976F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiIAMy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIAMy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:54:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ADC2DC3;
        Thu,  1 Sep 2022 05:54:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso2382514pjk.0;
        Thu, 01 Sep 2022 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZBXyYbYjQ1AsjxuVxx4OCp5VVoXL3nUBzDg8QRR75Cw=;
        b=WnHhs39GjiACyx1YZGfcMNOiD+GKbXQiXCm71Qomry9SIGHoGWdN+80ZFj9VXdhEYI
         dq7PMFNY+y9281NgJD+VbB2thOod2gj5nTmUx+7c9QiZY+d3l3jDo/lYLaqJ+LcKPrY3
         ZuNo0bmvR4FWCpJh3yhmCTKvIY0ZdKoEB4lvhqYdlftEWIjesaQEi6Y4ExeIqDkVSW0y
         TE5o5gIzY3KT2nFpFOGXyXJwWydTTGPKmS2n98hr20yKyvZZJvoxNi+4BVkfu+v5IOZF
         eOm4ObIPC29EcBd8mn+3tB8eiwzQN/5IDQIaz3+uiFtTCHL15yM7PB2l4ecCsvgP+XsK
         SIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZBXyYbYjQ1AsjxuVxx4OCp5VVoXL3nUBzDg8QRR75Cw=;
        b=Df7YmwS/8fBxd5jYlHTbxVV7P0kCK2RRQUHRtf3UvcEqtp1XI0jLP3dx2RLY/SDR07
         Ni1gaA2iTrggppsTlD5lOAe8mVtWXg+UQtHJZf8FrTZ2Y7w5WJl/Ufl2vBVOKQAhZBuQ
         Zy+btVucgj0lwNF4zasnkq+5rAJ5TbL+BNE81lL4puhR+HEX91HCtLpdSo8oNT8Il3g1
         l6rirxxvYpxpThfQTDJgXAbt5uzCuZsAkgwsDmr6VbNNxyoqART7VFIj1csFRwM4Xq2R
         0zFmIX6NFKlXs6jtJJDB9KxnYRtrBdB8lOYMUE1H3kF5/pO1N/A1dRoqfLzrmGt7hu2h
         Ebxw==
X-Gm-Message-State: ACgBeo2a5CAvUXO0iHqHv39VklKtsAJJoQ3mZUu+FcgYwSW5svyzhZjM
        CvQL6d0S9nna9BFtLF5fCwA=
X-Google-Smtp-Source: AA6agR66J9l8BTovYfePaPwqu67KsA/hbYWIKHaprzXv47is6c5uEGMxUGnkuVOEjfvcyxQuY1Xg6w==
X-Received: by 2002:a17:902:e552:b0:16d:2a83:e751 with SMTP id n18-20020a170902e55200b0016d2a83e751mr29383363plf.39.1662036865113;
        Thu, 01 Sep 2022 05:54:25 -0700 (PDT)
Received: from localhost ([166.111.139.139])
        by smtp.gmail.com with ESMTPSA id lj13-20020a17090b344d00b001fac8076cd8sm1507048pjb.46.2022.09.01.05.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:54:23 -0700 (PDT)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        Zixuan Fu <r33s3n6@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] scsi: megaraid: fix a possible double-free bug caused by incorrect error handling in megasas_alloc_cmdlist_fusion()
Date:   Thu,  1 Sep 2022 20:54:18 +0800
Message-Id: <20220901125418.2323348-1-r33s3n6@gmail.com>
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

In megasas_alloc_cmdlist_fusion(), when kzalloc() fails, it frees
fusion->cmd_list but does not clear it. Then, the error is propagated to
its caller megasas_alloc_cmds_fusion(), which calls
megasas_free_cmds_fusion(). In megasas_free_cmds_fusion(), it frees
fusion->cmd_list again, which causes a double-free bug.

To fix this possible bug, in megasas_alloc_cmdlist_fusion(),
fusion->cmd_list should be cleared after it is freed.

The error log in our fault-injection testing is shown as follows:

[ 4152.707452][   T21] BUG: KASAN: use-after-free in megasas_free_cmds_fusion+0x2d0/0x1294 [megaraid_sas]
...
[ 4152.756117][   T21] Call trace:
...
[ 4152.795950][   T21]  megasas_free_cmds_fusion+0x2d0/0x1294 [megaraid_sas]
[ 4152.803329][   T21]  megasas_alloc_cmds_fusion+0x4de0/0x53bc [megaraid_sas]
[ 4152.810887][   T21]  megasas_init_adapter_fusion+0xab4/0x30dc [megaraid_sas]
[ 4152.818539][   T21]  megasas_init_fw+0x4874/0x925c [megaraid_sas]
[ 4152.825245][   T21]  megasas_probe_one+0x978/0x2dd4 [megaraid_sas]
...
[ 4152.864486][   T21] Allocated by task 21:
...
[ 4152.883339][   T21]  megasas_alloc_cmds_fusion+0x2a40/0x53bc [megaraid_sas]
[ 4152.890796][   T21]  megasas_init_adapter_fusion+0xab4/0x30dc [megaraid_sas]
[ 4152.898331][   T21]  megasas_init_fw+0x4874/0x925c [megaraid_sas]
[ 4152.904901][   T21]  megasas_probe_one+0x978/0x2dd4 [megaraid_sas]
...
[ 4152.943038][   T21] Freed by task 21:
...
[ 4152.972830][   T21]  kfree+0x100/0x374
[ 4152.976998][   T21]  megasas_alloc_cmds_fusion+0x45c4/0x53bc [megaraid_sas]
[ 4152.984379][   T21]  megasas_init_adapter_fusion+0xab4/0x30dc [megaraid_sas]
[ 4152.991856][   T21]  megasas_init_fw+0x4874/0x925c [megaraid_sas]
[ 4152.998384][   T21]  megasas_probe_one+0x978/0x2dd4 [megaraid_sas]


Fixes: 70c54e210ee9a ("scsi: megaraid_sas: fix memleak in megasas_alloc_cmdlist_fusion")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 09c5fe37754c..238103e7a028 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -613,6 +613,7 @@ megasas_alloc_cmdlist_fusion(struct megasas_instance *instance)
 			for (j = 0; j < i; j++)
 				kfree(fusion->cmd_list[j]);
 			kfree(fusion->cmd_list);
+			fusion->cmd_list = NULL;
 			dev_err(&instance->pdev->dev,
 				"Failed from %s %d\n",  __func__, __LINE__);
 			return -ENOMEM;
-- 
2.25.1

