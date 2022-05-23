Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4398A531EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiEWWrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiEWWrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D252B0B;
        Mon, 23 May 2022 15:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86B726154C;
        Mon, 23 May 2022 22:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3A3C385A9;
        Mon, 23 May 2022 22:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653346033;
        bh=dM9xjGcIELwAk7SXfwRMkmck1pzZU48ZxvNuSCmz8to=;
        h=From:To:Cc:Subject:Date:From;
        b=NNT3O4KskyBq7fc/YZH4aWnVJknHVxdhCxk8QLMu7cr109aCMGdNOPLSN6TTna3FY
         0NHWg5sWrQDIyEMBQokGHB0Y6FVWnzzt14g5Ks9n7SrZVBHbBmV74DuRtAcrrZBFQa
         WpeSuQ28M29oJlrJh6hu57EfqYCtkCLPnaUm/o0a6/aaeQ7ZE/GAWXtW2Iv2/J5jyF
         NvSRBm7MLKFohnofWfFWk/5+N9b1kJ+4oUDlDpHll2kX2Hyq2zBF8x4b9sb5No2qmO
         i0wIfuK8DroytBp3gTZzei6xPv+FSI6n/MLU1TXYKWk5An8KXzQOJ0IRjG1qnBT3G4
         5r0zZq146hOEw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] mailbox: qcom-ipcc: Fix -Wunused-function with CONFIG_PM_SLEEP=n
Date:   Mon, 23 May 2022 15:47:02 -0700
Message-Id: <20220523224702.2002652-1-nathan@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM_SLEEP is not set, there is a warning that
qcom_ipcc_pm_resume() is unused:

  drivers/mailbox/qcom-ipcc.c:258:12: error: 'qcom_ipcc_pm_resume' defined but not used [-Werror=unused-function]
    258 | static int qcom_ipcc_pm_resume(struct device *dev)
        |            ^~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old
ones") reworked the PM_OPS macros to avoid this problem. Use
NOIRQ_SYSTEM_SLEEP_PM_OPS directly so that qcom_ipcc_pm_resume() always
appears to be used to the compiler, even though it will be dead code
eliminated in the !CONFIG_PM_SLEEP case.

Fixes: c25f77899753 ("mailbox: qcom-ipcc: Log the pending interrupt during resume")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/mailbox/qcom-ipcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 2583b20cdeb7..31d58b7d55fe 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -344,7 +344,7 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
 
 static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
 };
 
 static struct platform_driver qcom_ipcc_driver = {

base-commit: bca1a1004615efe141fd78f360ecc48c60bc4ad5
-- 
2.36.1

