Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08835AB127
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiIBNFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiIBNDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:03:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9206C110D8B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:42:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA961516;
        Fri,  2 Sep 2022 05:40:53 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 947543F766;
        Fri,  2 Sep 2022 05:40:45 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH v2 03/10] firmware: arm_ffa: Remove ffa_dev_ops_get()
Date:   Fri,  2 Sep 2022 13:40:25 +0100
Message-Id: <20220902124032.788488-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902124032.788488-1-sudeep.holla@arm.com>
References: <20220902124032.788488-1-sudeep.holla@arm.com>
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

The only user of this exported ffa_dev_ops_get() was OPTEE driver which
now uses ffa_dev->ops directly, there are no other users for this.

Also, since any ffa driver can use ffa_dev->ops directly, there will be
no need for ffa_dev_ops_get(), so just remove ffa_dev_ops_get().

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 9 ---------
 include/linux/arm_ffa.h           | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 213665e5ad0e..04e7cbb1b9aa 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -644,15 +644,6 @@ static const struct ffa_dev_ops ffa_ops = {
 	.memory_lend = ffa_memory_lend,
 };
 
-const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev)
-{
-	if (ffa_device_is_valid(dev))
-		return &ffa_ops;
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(ffa_dev_ops_get);
-
 void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
 {
 	int count, idx;
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 91b47e42b73d..556f50f27fb1 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -55,7 +55,6 @@ int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
 			const char *mod_name);
 void ffa_driver_unregister(struct ffa_driver *driver);
 bool ffa_device_is_valid(struct ffa_device *ffa_dev);
-const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev);
 
 #else
 static inline
@@ -79,11 +78,6 @@ static inline void ffa_driver_unregister(struct ffa_driver *driver) {}
 static inline
 bool ffa_device_is_valid(struct ffa_device *ffa_dev) { return false; }
 
-static inline
-const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev)
-{
-	return NULL;
-}
 #endif /* CONFIG_ARM_FFA_TRANSPORT */
 
 #define ffa_register(driver) \
-- 
2.37.3

