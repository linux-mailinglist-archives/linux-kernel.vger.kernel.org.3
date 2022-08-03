Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7F2588941
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiHCJUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiHCJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:20:38 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D0515819
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:20:32 -0700 (PDT)
X-QQ-mid: bizesmtp66t1659518422tzylbcvz
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 03 Aug 2022 17:20:15 +0800 (CST)
X-QQ-SSF: 01400000002000C0K000B00C0000000
X-QQ-FEAT: SX/WFj88WPUxbTF4fAIy8feA+WbS0O/OdVIzxiN547FytXi3P1FLnwSOmn5Ue
        GLflUhkiIY0OHLxLWqNHfRMF1NyEPY299Fn9TpbE+qsJQvjLbyO9hE/r9hQJEzKE7aQi9yl
        kUY1OiWrmJtReOBNsVxA1j1fgtKTz9ik2D5Es8dIBfgkfRdHkPb/Wjiwokant2XroxS1PZL
        yhIQSbH9aS14LMec+cOSbLFV9f636CiavPxXwc1ONXb2+bEwSkOWMr8U2bhTwTNWH0nJj84
        6/0NgasvDcCWYGCBHWjcfNgomBtqYvf7Y6W8z8Zbd1H5Q+KTotX+Nv2u+oOOwgrFd3sMMk4
        hwqP3a63xmaL41XwJ0j/BFILIHlggrYZbiOnExPqtcaGg4/T1Xyi5Kdu+HFX/NXeW6iZ85V
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH 1/2] drm/amd/pm: Fix a potential gpu_metrics_table memory leak
Date:   Wed,  3 Aug 2022 17:19:58 +0800
Message-Id: <20220803091959.10030-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory is allocated for gpu_metrics_table in
smu_v13_0_4_init_smc_tables(), but not freed in
smu_v13_0_4_fini_smc_tables(). This may cause memory leaks, fix it.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 5a17b51aa0f9..7df360c25d51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -190,6 +190,9 @@ static int smu_v13_0_4_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
+	kfree(smu_table->gpu_metrics_table);
+	smu_table->gpu_metrics_table = NULL;
+
 	return 0;
 }
 
-- 
2.20.1



