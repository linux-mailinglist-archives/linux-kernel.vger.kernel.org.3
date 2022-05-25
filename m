Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E153417F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245447AbiEYQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiEYQ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:27:35 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D67A1AB;
        Wed, 25 May 2022 09:27:34 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4L7c1163zvzDrgH;
        Wed, 25 May 2022 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1653496054; bh=wu6xEaXOL0trEsdjhmzYXfb4lvQfG+o2d5deXcMtdk4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZTi51qNEh1CF+IHWU7pTR81tAtn95nnw3fJ4XMr3CbOX43kLfaOv4I4B7GzMaOWm3
         GcOkJUm030VkyOOA67zTlB0aV0e7yUTAp7J8T3+0hHRhLcS9K4xlIFIsfkZm9Hnf6G
         orIjgOPszQTuBFDrYwpdBnGUf/j23/NCWxNOtpu0=
X-Riseup-User-ID: CE90C1541A4B1DC364A0A41ACD3E0D74BA5125FD1E1CAF2C6B3680EE9D35C382
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4L7c0w6WH0z1yXB;
        Wed, 25 May 2022 09:27:28 -0700 (PDT)
From:   Nia Espera <a5b6@riseup.net>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Nia Espera <a5b6@riseup.net>
Subject: [PATCH] add sysfs support for writing to boot lun
Date:   Wed, 25 May 2022 19:24:40 +0300
Message-Id: <20220525162440.90918-1-a5b6@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expands sysfs boot_lun attribute to be writable. Necessary to enable
proper support for LUN switching on some UFS devices.

Signed-off-by: Nia Espera <a5b6@riseup.net>
---
 drivers/scsi/ufs/ufs-sysfs.c | 67 +++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 5c405ff7b6ea..7bf5d6c3d0ec 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -1047,6 +1047,71 @@ static inline bool ufshcd_is_wb_attrs(enum attr_idn idn)
 		idn <= QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE;
 }
 
+static ssize_t boot_lun_enabled_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u32 slot;
+	int ret;
+	u8 index = 0;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		up(&hba->host_sem);
+		return -EBUSY;
+	}
+	if (ufshcd_is_wb_attrs(QUERY_ATTR_IDN_BOOT_LU_EN))
+		index = ufshcd_wb_get_query_index(hba);
+	ufshcd_rpm_get_sync(hba);
+
+	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+		QUERY_ATTR_IDN_BOOT_LU_EN, index, 0, &slot);
+
+	ufshcd_rpm_put_sync(hba);
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = sysfs_emit(buf, "0x%08X\n", slot);
+out:
+	up(&hba->host_sem);
+	return ret;
+}
+
+static ssize_t boot_lun_enabled_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	u32 slot;
+	int ret;
+	u8 index = 0;
+
+	if (kstrtouint(buf, 0, &slot) < 0)
+		return -EINVAL;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		up(&hba->host_sem);
+		return -EBUSY;
+	}
+	if (ufshcd_is_wb_attrs(QUERY_ATTR_IDN_BOOT_LU_EN))
+		index = ufshcd_wb_get_query_index(hba);
+	ufshcd_rpm_get_sync(hba);
+
+	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+				      QUERY_ATTR_IDN_BOOT_LU_EN, index, 0, &slot);
+	ufshcd_rpm_put_sync(hba);
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+out:
+	up(&hba->host_sem);
+	return ret ? ret : count;
+}
+
 #define UFS_ATTRIBUTE(_name, _uname)					\
 static ssize_t _name##_show(struct device *dev,				\
 	struct device_attribute *attr, char *buf)			\
@@ -1077,8 +1142,8 @@ out:									\
 	return ret;							\
 }									\
 static DEVICE_ATTR_RO(_name)
+static DEVICE_ATTR_RW(boot_lun_enabled);
 
-UFS_ATTRIBUTE(boot_lun_enabled, _BOOT_LU_EN);
 UFS_ATTRIBUTE(max_data_size_hpb_single_cmd, _MAX_HPB_SINGLE_CMD);
 UFS_ATTRIBUTE(current_power_mode, _POWER_MODE);
 UFS_ATTRIBUTE(active_icc_level, _ACTIVE_ICC_LVL);
-- 
2.36.1

