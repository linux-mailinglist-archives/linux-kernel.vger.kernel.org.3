Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4844DAF02
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355399AbiCPLmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355386AbiCPLmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A346179
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66A56616BD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4A2C340EC;
        Wed, 16 Mar 2022 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430895;
        bh=SiqnoWJ+RTXYiOm9OPw9loTSyWFf3JblJDHAXZJ7mb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kab3zzf8u3mysnQTp7rPlr2B17VfGNtP54W2j93TE03K6S+TIjikiJekwkvzdE/ri
         6NM8g2DImYk4Fnogw5we4Mv3OxNBsGe3YG2tBOPlGMoc+jpNPk+uyXepLCphhgsKZX
         I3RNbg6viVixoN/JIxbfXyONTCgOSIFwJiI3e/BffRq1e1P1B04Rt+cjY6byZPTy7U
         lH89R2lAsujes6WK+ay2P/2tP8OW50S0UEVabROlrhRjVNDOpJjvLEGaSoR/olosMn
         lxVaAHTq67ngz7Fl7Uk+lo/vof/TPJ46v390TBJEnhQ68y3+lkBWPEMVc0lzrX/Vis
         VIHFHN6FMYprw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 02/11] habanalabs: add DRAM default page size to HW info
Date:   Wed, 16 Mar 2022 13:41:20 +0200
Message-Id: <20220316114129.2520107-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316114129.2520107-1-ogabbay@kernel.org>
References: <20220316114129.2520107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

When using the device memory allocation API the user ought to know what
is the default allocation page size.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 1 +
 include/uapi/misc/habanalabs.h                    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index c13a3c2a7013..14c58579b9cd 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -76,6 +76,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	if (hw_ip.dram_size > PAGE_SIZE)
 		hw_ip.dram_enabled = 1;
 	hw_ip.dram_page_size = prop->dram_page_size;
+	hw_ip.device_mem_alloc_default_page_size = prop->device_mem_alloc_default_page_size;
 	hw_ip.num_of_events = prop->num_of_events;
 
 	memcpy(hw_ip.cpucp_version, prop->cpucp_info.cpucp_version,
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 1d6b4f0c4159..ae2441521467 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -409,6 +409,7 @@ enum hl_server_type {
  * @dram_page_size: The DRAM physical page size.
  * @number_of_user_interrupts: The number of interrupts that are available to the userspace
  *                             application to use. Relevant for Gaudi2 and later.
+ * @device_mem_alloc_default_page_size: default page size used in device memory allocation.
  */
 struct hl_info_hw_ip_info {
 	__u64 sram_base_address;
@@ -436,6 +437,8 @@ struct hl_info_hw_ip_info {
 	__u32 reserved3;
 	__u16 number_of_user_interrupts;
 	__u16 pad2;
+	__u64 reserved4;
+	__u64 device_mem_alloc_default_page_size;
 };
 
 struct hl_info_dram_usage {
-- 
2.25.1

