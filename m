Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D54F4A79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456895AbiDEWqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380217AbiDEMxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:53:41 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D3CE095;
        Tue,  5 Apr 2022 04:53:38 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2358i9ao002139;
        Tue, 5 Apr 2022 13:52:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=ahMNFWxzpaVmVp3viku9IaBrdSUCBM3LW49uPEPbvxU=;
 b=AOxt4YrYB/LoekLRTWYYtVuMG3+PLFJzeUn29lBTkGZa3ek7xYQZnOOGVb7exI9rDJGo
 EmbWbNLQYZU05k5hGR9B9IGQlM9eJJSvNfOBVjVCwj+uCTubQb+U/fzk4qYEbVXJA4Xx
 OTPm7FsfKjPSWMl5QdTxw+M1nWXQ6trXXL9g4AhGy0kUO1l8YgWsVXg6i4UlKXoeAOyh
 2d/dysRHJgXKEM7Vcxe8UUzu8iMDAkxaL3ZM5THKOp8zPn51c3CJ4GyTd1V8rgLB06a/
 elErddY4//H/Nnoj0AWanhffmXC3EgtYuohqqXd9T+kHG5m2sgHsOt/lc+f+RieA4Kg9 Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f6dcgsr66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 13:52:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09BEE10002A;
        Tue,  5 Apr 2022 13:52:55 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EFBFF21A239;
        Tue,  5 Apr 2022 13:52:54 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 5 Apr 2022 13:52:54
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Russell King <linux@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <arnaud.pouliquen@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
Subject: [PATCH v2] arm: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
Date:   Tue, 5 Apr 2022 13:52:36 +0200
Message-ID: <20220405115236.1019955-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-05_02,2022-04-05_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
By default give everyone who had the old driver enabled the rpmsg_ctrl
driver too.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---

This patch is extracted from the series [1] that has been partially
integrated in the Linux Kernel 5.18-rc1.

Update vs previous version:
- remove "Fixes:" tag in commit, requested by Mathieu Poirier in [2]

[1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
[2]https://lore.kernel.org/linux-arm-kernel/CANLsYky1_b80qPbgOaLGVYD-GEr21V6C653iGEB7VCU=GbGvAQ@mail.gmail.com/T/
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 9981566f2096..2e7e9a4f31f6 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -241,6 +241,7 @@ CONFIG_QCOM_Q6V5_PAS=y
 CONFIG_QCOM_Q6V5_PIL=y
 CONFIG_QCOM_WCNSS_PIL=y
 CONFIG_RPMSG_CHAR=y
+CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_QCOM_GLINK_SMEM=y
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_QCOM_COMMAND_DB=y
-- 
2.25.1

