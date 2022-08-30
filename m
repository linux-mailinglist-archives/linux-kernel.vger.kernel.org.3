Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5525A605F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiH3KMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiH3KLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:11:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93CA6EA14F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:07:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBCE31474;
        Tue, 30 Aug 2022 03:07:38 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81EEF3F766;
        Tue, 30 Aug 2022 03:07:31 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH 4/9] firmware: arm_ffa: Add support for querying FF-A features
Date:   Tue, 30 Aug 2022 11:06:55 +0100
Message-Id: <20220830100700.344594-5-sudeep.holla@arm.com>
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

Add support for FFA_FEATURES to discover properties supported at the
FF-A interface. This interface can be used to query:
 - If an FF-A interface is implemented by the component at the higher EL,
 - If an implemented FF-A interface also implements any optional features
   described in its interface definition, and
 - Any implementation details exported by an implemented FF-A interface
   as described in its interface definition.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 04e7cbb1b9aa..de94073f4109 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -571,6 +571,29 @@ static int ffa_memory_reclaim(u64 g_handle, u32 flags)
 	return 0;
 }
 
+static int ffa_features(u32 func_feat_id, u32 input_props, u32 *if_props)
+{
+	ffa_value_t id;
+
+	if (!ARM_SMCCC_IS_FAST_CALL(func_feat_id) && input_props) {
+		pr_err("%s: Invalid Parameters: %x, %x", __func__,
+		       func_feat_id, input_props);
+		return ffa_to_linux_errno(FFA_RET_INVALID_PARAMETERS);
+	}
+
+	invoke_ffa_fn((ffa_value_t){
+		.a0 = FFA_FEATURES, .a1 = func_feat_id, .a2 = input_props,
+		}, &id);
+
+	if (id.a0 == FFA_ERROR)
+		return ffa_to_linux_errno((int)id.a2);
+
+	if (if_props)
+		*if_props = id.a2;
+
+	return 0;
+}
+
 static u32 ffa_api_version_get(void)
 {
 	return drv_info->version;
-- 
2.37.2

