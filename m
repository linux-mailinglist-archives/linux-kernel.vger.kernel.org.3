Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40A64F130D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357571AbiDDK0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiDDK0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:26:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 488783C71E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:24:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF55E1FB;
        Mon,  4 Apr 2022 03:24:36 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECE1B3F718;
        Mon,  4 Apr 2022 03:24:35 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] firmware: arm_scmi: Fix sparse warnings in OPTEE transport driver
Date:   Mon,  4 Apr 2022 11:24:19 +0100
Message-Id: <20220404102419.1159705-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse checker complains about converting pointers between address
spaces.  We correctly stored an __iomem pointer in struct scmi_optee_channel,
but discarded the __iomem when returning it from get_channel_shm, causing one
warning. Then we passed the non-__iomem pointer return from get_channel_shm
at tow other places, where an __iomem pointer is expected, causing couple of
other warnings

Add the appropriate __iomem annotations at all places where it is missing.

optee.c:414:20: warning: incorrect type in return expression (different address spaces)
optee.c:414:20:    expected struct scmi_shared_mem *
optee.c:414:20:    got struct scmi_shared_mem [noderef] __iomem *shmem
optee.c:426:26: warning: incorrect type in argument 1 (different address spaces)
optee.c:426:26:    expected struct scmi_shared_mem [noderef] __iomem *shmem
optee.c:426:26:    got struct scmi_shared_mem *shmem
optee.c:441:30: warning: incorrect type in argument 1 (different address spaces)
optee.c:441:30:    expected struct scmi_shared_mem [noderef] __iomem *shmem
optee.c:441:30:    got struct scmi_shared_mem *shmem

Cc: Etienne Carriere <etienne.carriere@linaro.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/optee.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 734f1eeee161..8302a2b4aeeb 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -405,8 +405,8 @@ static int scmi_optee_chan_free(int id, void *p, void *data)
 	return 0;
 }
 
-static struct scmi_shared_mem *get_channel_shm(struct scmi_optee_channel *chan,
-					       struct scmi_xfer *xfer)
+static struct scmi_shared_mem __iomem *
+get_channel_shm(struct scmi_optee_channel *chan, struct scmi_xfer *xfer)
 {
 	if (!chan)
 		return NULL;
@@ -419,7 +419,7 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
 				   struct scmi_xfer *xfer)
 {
 	struct scmi_optee_channel *channel = cinfo->transport_info;
-	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
+	struct scmi_shared_mem __iomem *shmem = get_channel_shm(channel, xfer);
 	int ret;
 
 	mutex_lock(&channel->mu);
@@ -436,7 +436,7 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 				      struct scmi_xfer *xfer)
 {
 	struct scmi_optee_channel *channel = cinfo->transport_info;
-	struct scmi_shared_mem *shmem = get_channel_shm(channel, xfer);
+	struct scmi_shared_mem __iomem *shmem = get_channel_shm(channel, xfer);
 
 	shmem_fetch_response(shmem, xfer);
 }
-- 
2.35.1

