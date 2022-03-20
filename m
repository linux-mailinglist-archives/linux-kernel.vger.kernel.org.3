Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57DD4E1B40
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbiCTLHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbiCTLHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1AB483B7;
        Sun, 20 Mar 2022 04:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 903D761024;
        Sun, 20 Mar 2022 11:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE91C340E9;
        Sun, 20 Mar 2022 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647774385;
        bh=SP5ZRF6K2CwwSMhfOFPEhqyOMkG4BmnjUX8ER/LN6KI=;
        h=From:To:Cc:Subject:Date:From;
        b=iNEbPirAIpNppN6yZr4kSqeQlf0HXpdHKmiMwhSHm9en3gzX9g0NThzW2Zgsr0w/q
         r+r6cUUGAMqUQ8IUw3kKqXmmSJYXr+rMtWrP8VanGT3Zztch5LJqKeOhxjBvyAEYUC
         K9kd36B4o4gWryTFeBsT15pPu9XMLFdoF4IPVvW8FESeFeaLg2+PtgcqdeakOtP2n3
         KuHWnfCGZr83T5PWQW58fGj0++SxJogkcqjaf7A7/ldCz6i29TfC+iwK6MRT4E/3Ir
         WCJxun7ISWsLv44gx9ocITZmAqmuQ9dUH9vMkfrmdiZBpo3aDkA3Vl9i94qJI/wBP4
         uI87uaJTPDQ4w==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Subject: [RFT] ufs: qcom: drop custom Android boot parameters
Date:   Sun, 20 Mar 2022 12:06:16 +0100
Message-Id: <20220320110616.18355-1-krzk@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QCOM UFS driver requires an androidboot.bootdevice command line
argument matching the UFS device name.  If the name is different, it
refuses to probe.  Thise androidboot.bootdevice is provided by
stock/vendor (from an Android-based device) bootloader.

This does not make sense from Linux point of view.  Driver should be
able to boot regardless of bootloader.  Driver should not depend on some
Android custom environment data.

Cc: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested, please kindly provide tests.

See also:
https://lore.kernel.org/linux-devicetree/f61abc2b-3ce8-7b1f-3d28-8a4a03ec58eb@kernel.org/T/#u
---
 drivers/scsi/ufs/ufs-qcom.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 0d2e950d0865..586c0e567ff9 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -957,18 +957,6 @@ static const struct reset_control_ops ufs_qcom_reset_ops = {
 	.deassert = ufs_qcom_reset_deassert,
 };
 
-#define	ANDROID_BOOT_DEV_MAX	30
-static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
-
-#ifndef MODULE
-static int __init get_android_boot_dev(char *str)
-{
-	strlcpy(android_boot_dev, str, ANDROID_BOOT_DEV_MAX);
-	return 1;
-}
-__setup("androidboot.bootdevice=", get_android_boot_dev);
-#endif
-
 /**
  * ufs_qcom_init - bind phy with controller
  * @hba: host controller instance
@@ -988,9 +976,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	struct resource *res;
 	struct ufs_clk_info *clki;
 
-	if (strlen(android_boot_dev) && strcmp(android_boot_dev, dev_name(dev)))
-		return -ENODEV;
-
 	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
 	if (!host) {
 		err = -ENOMEM;
-- 
2.32.0

