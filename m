Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1732A4978B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 06:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbiAXFst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 00:48:49 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44964
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235331AbiAXFss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 00:48:48 -0500
Received: from HP-EliteBook-840-G7.. (36-229-235-192.dynamic-ip.hinet.net [36.229.235.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D3E2B40D2E;
        Mon, 24 Jan 2022 05:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643003327;
        bh=0mfLOaA0QQIAEmHXcjtr90LdNJaD3sn4R/3ByXK4cRk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=s/I6OgUhSL1ei3Afecqm7SM5A4sAaghlyIbCXCw1C/qvtdIlZO2JRJt9fH26G3fZv
         R+frUrivUdJZ80fP4hn2UmzaKgwrUkeo6/qYmWuBZNbIraOaEsaZCRd9Iz9PXD7cGO
         hnqc/U8uC6DM6JnEqV3gODKgIAUzHLXeckmba3FvPll3lyheyBnS9MP0IObgXMB9xg
         6U6r6ftEGDcPYtltjWdwwVR1CHljKzNTUJ3B69xNQAUWWsA6nWXigkDkaV3pXy8sxr
         FMdWap2tVa/u3D7Erdsg4Cs4Dwj8Aq2hIh669VB5ZfNWan1w9izxXU8NVy2DjJT5HJ
         hmzZQaWClHUfA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] misc: rtsx: Quiesce rts5249 on system suspend
Date:   Mon, 24 Jan 2022 13:47:41 +0800
Message-Id: <20220124054743.1800655-4-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220124054743.1800655-1-kai.heng.feng@canonical.com>
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
 <20220124054743.1800655-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set more registers in force_power_down callback to avoid S3 wakeup from
hotplugging cards.

This is originally written by Ricky WU.

Link: https://lore.kernel.org/lkml/c4525b4738f94483b9b8f8571fc80646@realtek.com/
Cc: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
v3:
v2:
 - No change.

 drivers/misc/cardreader/rtl8411.c  |  2 +-
 drivers/misc/cardreader/rts5209.c  |  2 +-
 drivers/misc/cardreader/rts5228.c  |  2 +-
 drivers/misc/cardreader/rts5229.c  |  2 +-
 drivers/misc/cardreader/rts5249.c  | 31 ++++++++++++++++++++++++++++--
 drivers/misc/cardreader/rts5261.c  |  2 +-
 drivers/misc/cardreader/rtsx_pcr.c | 14 +++++++-------
 drivers/misc/cardreader/rtsx_pcr.h |  1 +
 include/linux/rtsx_pci.h           |  2 +-
 9 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/cardreader/rtl8411.c b/drivers/misc/cardreader/rtl8411.c
index 4c5621b17a6fb..06457e875a90c 100644
--- a/drivers/misc/cardreader/rtl8411.c
+++ b/drivers/misc/cardreader/rtl8411.c
@@ -76,7 +76,7 @@ static void rtl8411b_fetch_vendor_settings(struct rtsx_pcr *pcr)
 		map_sd_drive(rtl8411b_reg_to_sd30_drive_sel_3v3(reg));
 }
 
-static void rtl8411_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
+static void rtl8411_force_power_down(struct rtsx_pcr *pcr, u8 pm_state, bool runtime)
 {
 	rtsx_pci_write_register(pcr, FPDCTL, 0x07, 0x07);
 }
diff --git a/drivers/misc/cardreader/rts5209.c b/drivers/misc/cardreader/rts5209.c
index 29f5414072bf1..52b0a476ba51f 100644
--- a/drivers/misc/cardreader/rts5209.c
+++ b/drivers/misc/cardreader/rts5209.c
@@ -47,7 +47,7 @@ static void rts5209_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	}
 }
 
-static void rts5209_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
+static void rts5209_force_power_down(struct rtsx_pcr *pcr, u8 pm_state, bool runtime)
 {
 	rtsx_pci_write_register(pcr, FPDCTL, 0x07, 0x07);
 }
diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index ffc128278613b..ffe3afbf8bfed 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -91,7 +91,7 @@ static int rts5228_optimize_phy(struct rtsx_pcr *pcr)
 	return rtsx_pci_write_phy_register(pcr, 0x07, 0x8F40);
 }
 
-static void rts5228_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
+static void rts5228_force_power_down(struct rtsx_pcr *pcr, u8 pm_state, bool runtime)
 {
 	/* Set relink_time to 0 */
 	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
diff --git a/drivers/misc/cardreader/rts5229.c b/drivers/misc/cardreader/rts5229.c
index c748eaf1ec1f9..b0edd8006d52f 100644
--- a/drivers/misc/cardreader/rts5229.c
+++ b/drivers/misc/cardreader/rts5229.c
@@ -44,7 +44,7 @@ static void rts5229_fetch_vendor_settings(struct rtsx_pcr *pcr)
 		map_sd_drive(rtsx_reg_to_sd30_drive_sel_3v3(reg));
 }
 
-static void rts5229_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
+static void rts5229_force_power_down(struct rtsx_pcr *pcr, u8 pm_state, bool runtime)
 {
 	rtsx_pci_write_register(pcr, FPDCTL, 0x03, 0x03);
 }
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 53f3a1f45c4a7..91d240dd68faa 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -74,7 +74,8 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
 
-	pcr->rtd3_en = rtsx_reg_to_rtd3_uhsii(reg);
+	if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
+		pcr->rtd3_en = rtsx_reg_to_rtd3_uhsii(reg);
 
 	if (rtsx_check_mmc_support(reg))
 		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
@@ -143,6 +144,27 @@ static int rts5249_init_from_hw(struct rtsx_pcr *pcr)
 	return 0;
 }
 
+static void rts52xa_force_power_down(struct rtsx_pcr *pcr, u8 pm_state, bool runtime)
+{
+	/* Set relink_time to 0 */
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, MASK_8_BIT_DEF, 0);
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
+				RELINK_TIME_MASK, 0);
+
+	rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3,
+			D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
+
+	if (!runtime) {
+		rtsx_pci_write_register(pcr, RTS524A_AUTOLOAD_CFG1,
+				CD_RESUME_EN_MASK, 0);
+		rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x00);
+		rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x20);
+	}
+
+	rtsx_pci_write_register(pcr, FPDCTL, ALL_POWER_DOWN, ALL_POWER_DOWN);
+}
+
 static void rts52xa_save_content_from_efuse(struct rtsx_pcr *pcr)
 {
 	u8 cnt, sv;
@@ -281,8 +303,11 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
 
 	rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
 
-	if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
+	if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
 		rtsx_pci_write_register(pcr, REG_VREF, PWD_SUSPND_EN, PWD_SUSPND_EN);
+		rtsx_pci_write_register(pcr, RTS524A_AUTOLOAD_CFG1,
+			CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
+	}
 
 	if (pcr->rtd3_en) {
 		if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
@@ -724,6 +749,7 @@ static const struct pcr_ops rts524a_pcr_ops = {
 	.card_power_on = rtsx_base_card_power_on,
 	.card_power_off = rtsx_base_card_power_off,
 	.switch_output_voltage = rtsx_base_switch_output_voltage,
+	.force_power_down = rts52xa_force_power_down,
 	.set_l1off_cfg_sub_d0 = rts5250_set_l1off_cfg_sub_d0,
 };
 
@@ -841,6 +867,7 @@ static const struct pcr_ops rts525a_pcr_ops = {
 	.card_power_on = rts525a_card_power_on,
 	.card_power_off = rtsx_base_card_power_off,
 	.switch_output_voltage = rts525a_switch_output_voltage,
+	.force_power_down = rts52xa_force_power_down,
 	.set_l1off_cfg_sub_d0 = rts5250_set_l1off_cfg_sub_d0,
 };
 
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 1fd4e0e507302..64333347c14a4 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -91,7 +91,7 @@ static void rtsx5261_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_3v3 = rts5261_reg_to_sd30_drive_sel_3v3(reg);
 }
 
-static void rts5261_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
+static void rts5261_force_power_down(struct rtsx_pcr *pcr, u8 pm_state, bool runtime)
 {
 	/* Set relink_time to 0 */
 	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index ec395a33faf8b..7262ef0f1913f 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1086,7 +1086,7 @@ static void rtsx_pm_power_saving(struct rtsx_pcr *pcr)
 	rtsx_comm_pm_power_saving(pcr);
 }
 
-static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
+static void rtsx_base_force_power_down(struct rtsx_pcr *pcr)
 {
 	/* Set relink_time to 0 */
 	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
@@ -1100,7 +1100,7 @@ static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
 	rtsx_pci_write_register(pcr, FPDCTL, ALL_POWER_DOWN, ALL_POWER_DOWN);
 }
 
-static void __maybe_unused rtsx_pci_power_off(struct rtsx_pcr *pcr, u8 pm_state)
+static void __maybe_unused rtsx_pci_power_off(struct rtsx_pcr *pcr, u8 pm_state, bool runtime)
 {
 	if (pcr->ops->turn_off_led)
 		pcr->ops->turn_off_led(pcr);
@@ -1112,9 +1112,9 @@ static void __maybe_unused rtsx_pci_power_off(struct rtsx_pcr *pcr, u8 pm_state)
 	rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, pm_state);
 
 	if (pcr->ops->force_power_down)
-		pcr->ops->force_power_down(pcr, pm_state);
+		pcr->ops->force_power_down(pcr, pm_state, runtime);
 	else
-		rtsx_base_force_power_down(pcr, pm_state);
+		rtsx_base_force_power_down(pcr);
 }
 
 void rtsx_pci_enable_ocp(struct rtsx_pcr *pcr)
@@ -1669,7 +1669,7 @@ static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
 
 	mutex_lock(&pcr->pcr_mutex);
 
-	rtsx_pci_power_off(pcr, HOST_ENTER_S3);
+	rtsx_pci_power_off(pcr, HOST_ENTER_S3, false);
 
 	mutex_unlock(&pcr->pcr_mutex);
 	return 0;
@@ -1708,7 +1708,7 @@ static void rtsx_pci_shutdown(struct pci_dev *pcidev)
 
 	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
 
-	rtsx_pci_power_off(pcr, HOST_ENTER_S1);
+	rtsx_pci_power_off(pcr, HOST_ENTER_S1, false);
 
 	pci_disable_device(pcidev);
 	free_irq(pcr->irq, (void *)pcr);
@@ -1754,7 +1754,7 @@ static int rtsx_pci_runtime_suspend(struct device *device)
 	cancel_delayed_work_sync(&pcr->carddet_work);
 
 	mutex_lock(&pcr->pcr_mutex);
-	rtsx_pci_power_off(pcr, HOST_ENTER_S3);
+	rtsx_pci_power_off(pcr, HOST_ENTER_S3, true);
 
 	mutex_unlock(&pcr->pcr_mutex);
 
diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
index daf057c4eea62..aa0ebd6672277 100644
--- a/drivers/misc/cardreader/rtsx_pcr.h
+++ b/drivers/misc/cardreader/rtsx_pcr.h
@@ -25,6 +25,7 @@
 #define REG_EFUSE_POWEROFF		0x00
 #define RTS5250_CLK_CFG3		0xFF79
 #define RTS525A_CFG_MEM_PD		0xF0
+#define RTS524A_AUTOLOAD_CFG1		0xFF7C
 #define RTS524A_PM_CTRL3		0xFF7E
 #define RTS525A_BIOS_CFG		0xFF2D
 #define RTS525A_LOAD_BIOS_FLAG	0x01
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 89b7d34e25b63..3d780b44e678a 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1095,7 +1095,7 @@ struct pcr_ops {
 	unsigned int	(*cd_deglitch)(struct rtsx_pcr *pcr);
 	int		(*conv_clk_and_div_n)(int clk, int dir);
 	void		(*fetch_vendor_settings)(struct rtsx_pcr *pcr);
-	void		(*force_power_down)(struct rtsx_pcr *pcr, u8 pm_state);
+	void		(*force_power_down)(struct rtsx_pcr *pcr, u8 pm_state, bool runtime);
 	void		(*stop_cmd)(struct rtsx_pcr *pcr);
 
 	void (*set_aspm)(struct rtsx_pcr *pcr, bool enable);
-- 
2.33.1

