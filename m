Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA1254EF14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379570AbiFQCGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiFQCGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:06:04 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401DA61633
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 19:06:03 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id LYX00100;
        Fri, 17 Jun 2022 10:06:00 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2308.27; Fri, 17 Jun 2022 10:05:59 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] iommu: Remove usage of the deprecated ida_simple_xxx API
Date:   Thu, 16 Jun 2022 22:05:55 -0400
Message-ID: <20220617020555.2361-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022617100600453ddd2e082b575ad03dc12b7589ef45
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc_xxx()/ida_free() instead of
ida_simple_get()/ida_simple_remove().
The latter is deprecated and more verbose.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/iommu/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 847ad47a2dfd..cdc86c39954e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -600,7 +600,7 @@ static void iommu_group_release(struct kobject *kobj)
 	if (group->iommu_data_release)
 		group->iommu_data_release(group->iommu_data);
 
-	ida_simple_remove(&iommu_group_ida, group->id);
+	ida_free(&iommu_group_ida, group->id);
 
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
@@ -641,7 +641,7 @@ struct iommu_group *iommu_group_alloc(void)
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
 
-	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&iommu_group_ida, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(group);
 		return ERR_PTR(ret);
@@ -651,7 +651,7 @@ struct iommu_group *iommu_group_alloc(void)
 	ret = kobject_init_and_add(&group->kobj, &iommu_group_ktype,
 				   NULL, "%d", group->id);
 	if (ret) {
-		ida_simple_remove(&iommu_group_ida, group->id);
+		ida_free(&iommu_group_ida, group->id);
 		kobject_put(&group->kobj);
 		return ERR_PTR(ret);
 	}
-- 
2.27.0

