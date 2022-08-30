Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A065A6059
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiH3KMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiH3KLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:11:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F5E3F8EFC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:07:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74FDC1474;
        Tue, 30 Aug 2022 03:07:34 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1ACC33F766;
        Tue, 30 Aug 2022 03:07:26 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH 1/9] firmware: arm_ffa: Add pointer to the ffa_dev_ops in struct ffa_dev
Date:   Tue, 30 Aug 2022 11:06:52 +0100
Message-Id: <20220830100700.344594-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830100700.344594-1-sudeep.holla@arm.com>
References: <20220830100700.344594-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ffa_dev_ops_get() is the way to fetch the ffa_dev_ops pointer.
It checks if the ffa_dev structure pointer is valid before returning the
ffa_dev_ops pointer.

Instead, the pointer can be made part of the ffa_dev structure and since
the core driver is incharge of creating ffa_device for each identified
partition, there is no need to check for the validity explicitly if the
pointer is embedded in the structure.

Add the pointer to the ffa_dev_ops in the ffa_dev structure itself and
initialise the same as part of creation of the device.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/bus.c    | 4 +++-
 drivers/firmware/arm_ffa/driver.c | 2 +-
 include/linux/arm_ffa.h           | 7 +++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 641a91819088..69328041fbc3 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -167,7 +167,8 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
 	return valid;
 }
 
-struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
+struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
+				       const struct ffa_dev_ops *ops)
 {
 	int ret;
 	struct device *dev;
@@ -183,6 +184,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%04x", vm_id);
 
 	ffa_dev->vm_id = vm_id;
+	ffa_dev->ops = ops;
 	uuid_copy(&ffa_dev->uuid, uuid);
 
 	ret = device_register(&ffa_dev->dev);
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index ec731e9e942b..213665e5ad0e 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -688,7 +688,7 @@ static void ffa_setup_partitions(void)
 		 * as part of the discovery API, we need to pass the
 		 * discovered UUID here instead.
 		 */
-		ffa_dev = ffa_device_register(&uuid_null, tpbuf->id);
+		ffa_dev = ffa_device_register(&uuid_null, tpbuf->id, &ffa_ops);
 		if (!ffa_dev) {
 			pr_err("%s: failed to register partition ID 0x%x\n",
 			       __func__, tpbuf->id);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index e5c76c1ef9ed..91b47e42b73d 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -17,6 +17,7 @@ struct ffa_device {
 	bool mode_32bit;
 	uuid_t uuid;
 	struct device dev;
+	const struct ffa_dev_ops *ops;
 };
 
 #define to_ffa_dev(d) container_of(d, struct ffa_device, dev)
@@ -47,7 +48,8 @@ static inline void *ffa_dev_get_drvdata(struct ffa_device *fdev)
 }
 
 #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
-struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id);
+struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
+				       const struct ffa_dev_ops *ops);
 void ffa_device_unregister(struct ffa_device *ffa_dev);
 int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
 			const char *mod_name);
@@ -57,7 +59,8 @@ const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev);
 
 #else
 static inline
-struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
+struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
+				       const struct ffa_dev_ops *ops)
 {
 	return NULL;
 }
-- 
2.37.2

