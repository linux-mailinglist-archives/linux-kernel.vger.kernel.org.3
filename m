Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4353419C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiEYQkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiEYQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:40:29 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8143656434;
        Wed, 25 May 2022 09:40:28 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4L7cHv6WRZzDq99;
        Wed, 25 May 2022 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1653496828; bh=wu6xEaXOL0trEsdjhmzYXfb4lvQfG+o2d5deXcMtdk4=;
        h=From:To:Cc:Subject:Date:From;
        b=hHFroYoT8tqG8q/7QwK5LNT5bE59m2cUsjw3LMOiFDammb5yNZYOLA4OkGKhOqUZg
         kxbSKTAlaw9e0okNCotspDQ0qXphieOq17JXAPbof91qedu76oVSW2omplUqOelaEZ
         MI5vwN3STBmVUm5rQOWWtfpJzIDI0sQWIreC0dRc=
X-Riseup-User-ID: 5B2B0250F4591D8626F9B624C116C1ECA5390A76FCD21044D81EAEB0BB4E6A36
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4L7cHr1PN4z5vXK;
        Wed, 25 May 2022 09:40:23 -0700 (PDT)
From:   Nia Espera <a5b6@riseup.net>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Nia Espera <a5b6@riseup.net>
Subject: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun attr
Date:   Wed, 25 May 2022 19:40:13 +0300
Message-Id: <20220525164013.93748-1-a5b6@riseup.net>
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

