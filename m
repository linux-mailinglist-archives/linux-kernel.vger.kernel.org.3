Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CE7588945
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiHCJU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiHCJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:20:47 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAD14E613
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:20:45 -0700 (PDT)
X-QQ-mid: bizesmtp66t1659518435tcy4ogi5
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 03 Aug 2022 17:20:25 +0800 (CST)
X-QQ-SSF: 01400000002000C0K000B00C0000000
X-QQ-FEAT: W+onFc5Tw4Oqh24lEr6B3ZCNdcvNCXFqy6OaiwkY2QHg01q4ATXn1a1pNwxZ9
        Y6Gu1Bpl97AUGZvxhHIP+g7kk06IUPlPHByajYAGo06oAZOf1moP64qya5i8AF+rMvwTu0c
        fOiF7LF6TFeHqp+KAC/DwjxbHnXlHsfeM5syB9KMliraFdhiGM9Tryw9TMLvT0n1LmM5cWo
        23KPdWlp/YqFVsqcCp5wGN6eh/syehFN1+ay2w5I6hAcda9xZdaoJatO6SiGOAHTQ8matE2
        BhF9NJQo+x2dRjc4/lMjyudv3erE6bwhSpvvS1Do4eFwxkwuwWecFGnCk8wOYVoufGLLQve
        Qf47s0f8g1mOZzxk+lnDamh+3YLdyEmyY1Q9vTDrEeAqUsEiROmPTN0msvW8CRyH39ixVez
        lVSqgX7xUN15830BtoV87w==
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH 2/2] drm/amd/pm: Fix a potential gpu_metrics_table memory leak
Date:   Wed,  3 Aug 2022 17:19:59 +0800
Message-Id: <20220803091959.10030-2-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220803091959.10030-1-nizhen@uniontech.com>
References: <20220803091959.10030-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory is allocated for gpu_metrics_table in
smu_v13_0_5_init_smc_tables(), but not freed in
smu_v13_0_5_fini_smc_tables(). This may cause memory leaks, fix it.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index b81711c4ff33..267c9c43a010 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -167,6 +167,9 @@ static int smu_v13_0_5_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
+	kfree(smu_table->gpu_metrics_table);
+	smu_table->gpu_metrics_table = NULL;
+
 	return 0;
 }
 
-- 
2.20.1



