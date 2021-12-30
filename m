Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4477E48188F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhL3CdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhL3CdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:33:02 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2F0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 18:33:01 -0800 (PST)
Received: from localhost.localdomain (83.6.168.106.neoplus.adsl.tpnet.pl [83.6.168.106])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 916BE40268;
        Thu, 30 Dec 2021 03:32:58 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: qcom_smd: Promote to arch_initcall
Date:   Thu, 30 Dec 2021 03:32:53 +0100
Message-Id: <20211230023253.1123142-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_smd's only child, smd-rpm uses arch_initcall and both have to be up
before almost anything else to ensure the MSM SoCs will work fine and
nothing will have to resort to probe defering, as this is the main pillar
of all things DVFS on these machines. Promote it to arch_initcall to avoid
such issues.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/rpmsg/qcom_smd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 7900cc8feadc..a5fb5c0b8d09 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1605,7 +1605,7 @@ static int __init qcom_smd_init(void)
 {
 	return platform_driver_register(&qcom_smd_driver);
 }
-subsys_initcall(qcom_smd_init);
+arch_initcall(qcom_smd_init);
 
 static void __exit qcom_smd_exit(void)
 {
-- 
2.34.1

