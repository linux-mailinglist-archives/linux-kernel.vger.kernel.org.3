Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD2A4E5F72
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348624AbiCXHcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348602AbiCXHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:32:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED230996A3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:31:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d10so7315159eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQP0V9OY5aQsKT4SJO0KH8YjFqWZFbeNBTnB8MCoLgM=;
        b=p+j6YAY2V68RpdPuWD726VDdObgITxMOArazNEZ+vBFzd/Yyzwxf7UJRhHGjLOx/c1
         eu1r3a2tAJa+O0Xm+a8k8wWrz0K1QtaHKUUXgXzazpXSr9PZHYwFApajJSNiqRk7dXT9
         qhSfvDxpciDHZ37jtEgKCyxERlB6a8N55D9jmEVLDj4XXhjlNAD2r/EaHDsB3uNOiywZ
         oUVDeeb2xy6h3jGTYWpTGOzUX4Lef6xyIeC2tFMn49ZkHq/Zvcuh8lqJlyTYpsuTEGBV
         NGwQXEisS/3JAiNA4XN9ackHlaGaCXkKwnQ/iOybWRtaY0k+rk0pYcUTpH31XoCr7cz+
         6/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQP0V9OY5aQsKT4SJO0KH8YjFqWZFbeNBTnB8MCoLgM=;
        b=08ZiMzmXPQ2v2TXE4suZQCgfcOe/UQ7kp0rFf5iZifjfWbUVYg72AV46duYElxfBOC
         I4Wsq1jhz5QCNEeCviBaXr3OAEVioSEHaeHJCkXycfpxvALIeRy9ms4tsG79tXFQFdD6
         0+67DPH2wUUBlGdXfmjwiRfmm5nXABY2WN+3oBEhMb+nxsf31UUdBxxAjxEMpKDULbOP
         P3fAM+D0n1qfH71XOlYEpX7myVIrUhOZTnl2FF+HONSXDIcowCGG5HF0K1yVAhi5Aavq
         J6xL1GK5T+QHsFojDT3zGupr6pzzsmihEC5dfQHaOBbtdbMAT8RvWFY7gFFImG+L5Isj
         U9Vg==
X-Gm-Message-State: AOAM531H+/QHf+aBeIA314pAyuVrx9fABU+fyV3ljCNciCY50c7FlKTX
        L+kPNuOEv4UAD8pWCueou6pT2k89/EDxV2Xv
X-Google-Smtp-Source: ABdhPJyjdhPveqm4nFYih/ZGNZbOl5jnnO+9D7Pg2jNePkk0xBvxhyvs3MM/lXT8Rx/g8O09rT6I4g==
X-Received: by 2002:a17:906:ae0b:b0:6df:c7d6:9235 with SMTP id le11-20020a170906ae0b00b006dfc7d69235mr4366763ejb.664.1648107060275;
        Thu, 24 Mar 2022 00:31:00 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id sa13-20020a1709076d0d00b006ce3ef8e1d4sm776972ejc.31.2022.03.24.00.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:30:59 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] staging: vchiq: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:30:24 +0100
Message-Id: <20220324073024.65943-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c   | 13 ++++++-------
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c   | 13 ++++++-------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3a2e4582db8e..f27ff246a672 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -908,8 +908,7 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 	struct vchiq_instance *instance;
 	struct vchiq_service *service;
 	enum vchiq_status status;
-	struct bulk_waiter_node *waiter = NULL;
-	bool found = false;
+	struct bulk_waiter_node *waiter = NULL, *iter;
 
 	service = find_service_by_handle(handle);
 	if (!service)
@@ -920,16 +919,16 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data, unsigned int size,
 	vchiq_service_put(service);
 
 	mutex_lock(&instance->bulk_waiter_list_mutex);
-	list_for_each_entry(waiter, &instance->bulk_waiter_list, list) {
-		if (waiter->pid == current->pid) {
-			list_del(&waiter->list);
-			found = true;
+	list_for_each_entry(iter, &instance->bulk_waiter_list, list) {
+		if (iter->pid == current->pid) {
+			list_del(&iter->list);
+			waiter = iter;
 			break;
 		}
 	}
 	mutex_unlock(&instance->bulk_waiter_list_mutex);
 
-	if (found) {
+	if (waiter) {
 		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
 
 		if (bulk) {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 2325844b0880..5102750dbabc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -290,8 +290,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 				      enum vchiq_bulk_mode __user *mode)
 {
 	struct vchiq_service *service;
-	struct bulk_waiter_node *waiter = NULL;
-	bool found = false;
+	struct bulk_waiter_node *waiter = NULL, *iter;
 	void *userdata;
 	int status = 0;
 	int ret;
@@ -310,16 +309,16 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		userdata = &waiter->bulk_waiter;
 	} else if (args->mode == VCHIQ_BULK_MODE_WAITING) {
 		mutex_lock(&instance->bulk_waiter_list_mutex);
-		list_for_each_entry(waiter, &instance->bulk_waiter_list,
+		list_for_each_entry(iter, &instance->bulk_waiter_list,
 				    list) {
-			if (waiter->pid == current->pid) {
-				list_del(&waiter->list);
-				found = true;
+			if (iter->pid == current->pid) {
+				list_del(&iter->list);
+				waiter = iter;
 				break;
 			}
 		}
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		if (!found) {
+		if (!waiter) {
 			vchiq_log_error(vchiq_arm_log_level,
 					"no bulk_waiter found for pid %d", current->pid);
 			ret = -ESRCH;

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

