Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D39E58EC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiHJMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHJMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:33:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442C07695E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56E461359
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9C8C433B5;
        Wed, 10 Aug 2022 12:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660134798;
        bh=9sNArxE43HC27DrZhFEdq1xfM49KB3btIpC/UhaCjX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MogVNK9LOyRlAFZOAfOSVY4hbvD9HZH23/lTvVSpsF767VAPmIqKpklJjGUtyBp2H
         5KWVqHpotG2QxZvkwS4PFq5sIXW8ndvCoeZIFx2C3DFqeqVPRDtAylN9NkTGSbO75a
         DDzSa1ACUn9zHIBbNNbH1ggwmGLITtoBWbKXthB2Pxx/R+Cqqq2TMp+LDidZYyNrZm
         /7CvjjCNMr/33ybQhwENLqIKdOOPvw4bgNRUwfQqb2GVZpWtDvFTcz8PStvj16KDWb
         Kzz8zS6To8BuyCk1eoXPYxtOqHK/hM18FUYNqLEVdp3MN1o7ShzGonUxHBbcm2C3Vh
         OOh0QfpzElBzQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/3] habanalabs: expose device security status using info ioctl
Date:   Wed, 10 Aug 2022 15:33:11 +0300
Message-Id: <20220810123312.1683716-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810123312.1683716-1-ogabbay@kernel.org>
References: <20220810123312.1683716-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order for the user to know if he is running on a secured device
or not, we add it also to the hw_ip info ioctl.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 1 +
 include/uapi/misc/habanalabs.h                    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index ec55c66fedd6..c7bd000750c8 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -104,6 +104,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 
 	hw_ip.edma_enabled_mask = prop->edma_enabled_mask;
 	hw_ip.server_type = prop->server_type;
+	hw_ip.security_enabled = prop->fw_security_enabled;
 
 	return copy_to_user(out, &hw_ip,
 		min((size_t) size, sizeof(hw_ip))) ? -EFAULT : 0;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index f51c6ae4f94d..3005cc04d4b1 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -840,6 +840,7 @@ enum hl_server_type {
  * @tpc_enabled_mask: Bit-mask that represents which TPCs are enabled. Relevant
  *                    for Goya/Gaudi only.
  * @dram_enabled: Whether the DRAM is enabled.
+ * @security_enabled: Whether security is enabled on device.
  * @mme_master_slave_mode: Indicate whether the MME is working in master/slave
  *                         configuration. Relevant for Greco and later.
  * @cpucp_version: The CPUCP f/w version.
@@ -871,7 +872,7 @@ struct hl_info_hw_ip_info {
 	__u32 psoc_pci_pll_div_factor;
 	__u8 tpc_enabled_mask;
 	__u8 dram_enabled;
-	__u8 reserved;
+	__u8 security_enabled;
 	__u8 mme_master_slave_mode;
 	__u8 cpucp_version[HL_INFO_VERSION_MAX_LEN];
 	__u8 card_name[HL_INFO_CARD_NAME_MAX_LEN];
-- 
2.25.1

