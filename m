Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4E25826F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiG0Mr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiG0Mr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:47:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359BF1C109
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:47:54 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LtD565KcPzjXSb;
        Wed, 27 Jul 2022 20:44:58 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 20:47:52 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 20:47:51 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] bus: fsl-mc: dprc: replace strncpy() with strscpy_pad()
Date:   Wed, 27 Jul 2022 20:54:32 +0800
Message-ID: <20220727125432.160233-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following warning when using W=1 to build kernel,

   drivers/bus/fsl-mc/dprc.c: In function 'dprc_get_obj':
   drivers/bus/fsl-mc/dprc.c:453:9: warning: 'strncpy' output may be truncated copying 15 bytes from a string of length 15 [-Wstringop-truncation]
     453 |         strncpy(obj_desc->type, rsp_params->type, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/fsl-mc/dprc.c:455:9: warning: 'strncpy' output may be truncated copying 15 bytes from a string of length 15 [-Wstringop-truncation]
     455 |         strncpy(obj_desc->label, rsp_params->label, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/fsl-mc/dprc.c: In function 'dprc_set_obj_irq':
   drivers/bus/fsl-mc/dprc.c:494:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
     494 |         strncpy(cmd_params->obj_type, obj_type, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/fsl-mc/dprc.c: In function 'dprc_get_obj_region':
   drivers/bus/fsl-mc/dprc.c:567:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
     567 |         strncpy(cmd_params->obj_type, obj_type, 16);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/bus/fsl-mc/dprc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index d129338b8bc0..dd1b5c0fb7e2 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -450,10 +450,8 @@ int dprc_get_obj(struct fsl_mc_io *mc_io,
 	obj_desc->ver_major = le16_to_cpu(rsp_params->version_major);
 	obj_desc->ver_minor = le16_to_cpu(rsp_params->version_minor);
 	obj_desc->flags = le16_to_cpu(rsp_params->flags);
-	strncpy(obj_desc->type, rsp_params->type, 16);
-	obj_desc->type[15] = '\0';
-	strncpy(obj_desc->label, rsp_params->label, 16);
-	obj_desc->label[15] = '\0';
+	strscpy_pad(obj_desc->type, rsp_params->type, 16);
+	strscpy_pad(obj_desc->label, rsp_params->label, 16);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dprc_get_obj);
@@ -491,8 +489,7 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
 	cmd_params->irq_addr = cpu_to_le64(irq_cfg->paddr);
 	cmd_params->irq_num = cpu_to_le32(irq_cfg->irq_num);
 	cmd_params->obj_id = cpu_to_le32(obj_id);
-	strncpy(cmd_params->obj_type, obj_type, 16);
-	cmd_params->obj_type[15] = '\0';
+	strscpy_pad(cmd_params->obj_type, obj_type, 16);
 
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
@@ -564,8 +561,7 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	cmd_params = (struct dprc_cmd_get_obj_region *)cmd.params;
 	cmd_params->obj_id = cpu_to_le32(obj_id);
 	cmd_params->region_index = region_index;
-	strncpy(cmd_params->obj_type, obj_type, 16);
-	cmd_params->obj_type[15] = '\0';
+	strscpy_pad(cmd_params->obj_type, obj_type, 16);
 
 	/* send command to mc*/
 	err = mc_send_command(mc_io, &cmd);
-- 
2.35.3

