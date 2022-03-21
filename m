Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED074E2C06
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350073AbiCUPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350143AbiCUPV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:21:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743A4616F;
        Mon, 21 Mar 2022 08:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CF3060F7F;
        Mon, 21 Mar 2022 15:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B188DC340E8;
        Mon, 21 Mar 2022 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647875945;
        bh=Mpf9l4QtYNeu7tz12esx3WrDN3+PTig3fwTFp3UV+Uo=;
        h=From:To:Cc:Subject:Date:From;
        b=C2mV8/Qd4eCvgZvmf75OYoJTK1w/EbyEQjLsMsbmLdPsmMcigLfnDo+H9CqFIOx9Y
         z1I9VfjxCJawAwVDEBKivzN1q/667cH+nXwWWVaUimI0CMp7RYKVUgzcHNGZXMYhX6
         xHVD/8yPxDqNpLpcU1B3WtB6HYYNOv3/hvWT6/9qHSVQNxOFPj5qU0bqg5CisN9tzM
         7qUsACTVmgVHwZ44iKTEhIOgUAeiY2ElUrTgQouXlnY6lIwrpPRc0A5GRFbIfWlxtg
         iOcmbFUIZWm1aMMGMMQHU7h2lahlXS0lptFhd9FLiMtqhevdwzZLqkzumliavQ8wVW
         5Gc7dIXJZZkBg==
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
        Amit Pundir <amit.pundir@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Brian Masney <bmasney@redhat.com>
Subject: [PATCH v2] ufs: qcom: drop custom Android boot parameters
Date:   Mon, 21 Mar 2022 16:18:53 +0100
Message-Id: <20220321151853.24138-1-krzk@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
refuses to probe.  This androidboot.bootdevice is provided by
stock/vendor (from an Android-based device) bootloader.

This does not make sense from Linux point of view.  Driver should be
able to boot regardless of bootloader.  Driver should not depend on some
Android custom environment data.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Amit Pundir <amit.pundir@linaro.org>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

---

Changes since v1
1. Fix commit msg typo (Alim).
2. Add tags.

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

