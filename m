Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A3050D372
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiDXQao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiDXQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:30:17 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5C8597F;
        Sun, 24 Apr 2022 09:27:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bg9so11438714pgb.9;
        Sun, 24 Apr 2022 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=uKZTe7yQ+O8BqMJZ1XBsdEQMbjgQxMztKFfEfSP4DbA=;
        b=ezJI2puFVbW14r0youAGJ7L4Rbt+34wxknV7H2XhIyuChx42XaummsijV3sb2EPzw1
         TIEqbG2HIlaQFoKWseMdxMOXbsjSuvlFu8idGeWSnpwUR93pO30zgLS4ZboyZaV8x13y
         0eUEAJZjX0Glmkx8iPztla0wn7KwhijZFbt5SwC+sxfGrZR28vSSMyaXdndpsz6fDxd8
         VA7ZVYTV5QsNYASFHgDeFgfRBqL215Y77b8HL8hOU4cnRDpGfobWzT8CNkWk8Z7XFZPx
         MVaBKHFJDvoxrzxeLRkpYA6Az/3/LZlC3koUonq4OjQTlerxpJNyFabIVGozlXqSpIQp
         dcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uKZTe7yQ+O8BqMJZ1XBsdEQMbjgQxMztKFfEfSP4DbA=;
        b=tELkYBZxFEYc3fUy1ujzXyBCAe+5JeIxu1GJiNkh5Oy/VpIdjvXvoaBlbYelFp3EUd
         jf4hBDVrtx+6a9FEcnLcLcW0rT7bySXZdktGUqPhVDBu1X3eSuWtiJlp+CF/6/JUurid
         ij9J90fq9H7J6HM+t5vyBytVdaMXpFfmjaM/YQKYw9UGSf8K/m9sJifUoj1D5PRhATcJ
         BiUJ7Fwfs4sY2sOX9o4MuAeCt3P3cHjeUELasDUr9/IWP/7HCjc1r3UQgyS/2sRTe2PP
         SG5ynbcx79+6qUEd5d5S+dX+X/WYb42CIiyhLVD+H04ykZPxfLsvbhLr9ZxEvtb8Amzf
         5n6g==
X-Gm-Message-State: AOAM533cUcUUgexFGGMaH8LteEoIb2KyxkKWVoeqCF/gxs8+no2+LsrG
        uat3QCZCOCU2wbgxCAPX8kaRRO7bFLGp3/XwpeiE5GdQTmr3Ig==
X-Google-Smtp-Source: ABdhPJwLNsx+d0aJZw4U4/z/k9FtHQPg0byXIPMF1uN6Dht7jX5WsY40i8IlyBdo6ij6cXUmujzbZD/+vAf8LEhzeq0=
X-Received: by 2002:a05:6a00:1814:b0:50d:3ccc:653f with SMTP id
 y20-20020a056a00181400b0050d3ccc653fmr2020994pfa.70.1650817633197; Sun, 24
 Apr 2022 09:27:13 -0700 (PDT)
MIME-Version: 1.0
From:   jin young choi <ychoijy@gmail.com>
Date:   Mon, 25 Apr 2022 01:27:02 +0900
Message-ID: <CAM36TBuKy=6JRbAS352nBYsLCj=J09tWmte0yarv0A7xaOJmRw@mail.gmail.com>
Subject: [PATCH v2] scsi: ufs: wb: Add Manual Flush sysfs and cleanup toggle functions
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        adrian.hunter@intel.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        asutoshd@codeaurora.org, Avri Altman <Avri.Altman@wdc.com>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        j-young.choi@samsung.com, beanhuo@micron.com,
        Bart Van Assche <bvanassche@acm.org>, cang@codeaurora.org,
        Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is the following quirk to bypass "WB Manual Flush" in Write
Booster.

  - UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL

If this quirk is not set, there is no knob that can control "WB Manual Flush".

There are three flags that control Write Booster Feature.
1. WB ON/OFF
2. WB Hibern Flush ON/OFF
3. WB Flush ON/OFF

The sysfs that controls the WB was implemented. (1)

In the case of "Hibern Flush", it is always good to turn on.
Control may not be required. (2)

Finally, "Manual flush" may be determined that it can affect
performance or power consumption.
So the sysfs that controls this may be necessary. (3)

In addition, toggle functions for controlling the above flags are cleaned.

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/scsi/ufs/ufs-sysfs.c | 46 +++++++++++++++++++++-
 drivers/scsi/ufs/ufshcd.c    | 76 ++++++++++++++++++------------------
 drivers/scsi/ufs/ufshcd.h    |  7 ++++
 3 files changed, 89 insertions(+), 40 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 5c405ff7b6ea..e0f6ba7ffefc 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -229,7 +229,7 @@ static ssize_t wb_on_store(struct device *dev,
struct device_attribute *attr,
  * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
  * on/off will be done while clock scaling up/down.
  */
- dev_warn(dev, "To control WB through wb_on is not allowed!\n");
+ dev_warn(dev, "It is not allowed to control WB!\n");
  return -EOPNOTSUPP;
  }

@@ -253,6 +253,48 @@ static ssize_t wb_on_store(struct device *dev,
struct device_attribute *attr,
  return res < 0 ? res : count;
 }

+static ssize_t wb_buf_flush_en_show(struct device *dev,
+     struct device_attribute *attr,
+     char *buf)
+{
+ struct ufs_hba *hba = dev_get_drvdata(dev);
+
+ return sysfs_emit(buf, "%d\n", hba->dev_info.wb_buf_flush_enabled);
+}
+
+static ssize_t wb_buf_flush_en_store(struct device *dev,
+      struct device_attribute *attr,
+      const char *buf, size_t count)
+{
+ struct ufs_hba *hba = dev_get_drvdata(dev);
+ unsigned int wb_buf_flush_en;
+ ssize_t res;
+
+ if (!ufshcd_is_wb_buf_flush_allowed(hba)) {
+ dev_warn(dev, "It is not allowed to control WB buf flush!\n");
+ return -EOPNOTSUPP;
+ }
+
+ if (kstrtouint(buf, 0, &wb_buf_flush_en))
+ return -EINVAL;
+
+ if (wb_buf_flush_en != 0 && wb_buf_flush_en != 1)
+ return -EINVAL;
+
+ down(&hba->host_sem);
+ if (!ufshcd_is_user_access_allowed(hba)) {
+ res = -EBUSY;
+ goto out;
+ }
+
+ ufshcd_rpm_get_sync(hba);
+ res = ufshcd_wb_toggle_buf_flush(hba, wb_buf_flush_en);
+ ufshcd_rpm_put_sync(hba);
+out:
+ up(&hba->host_sem);
+ return res < 0 ? res : count;
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -261,6 +303,7 @@ static DEVICE_ATTR_RO(spm_target_dev_state);
 static DEVICE_ATTR_RO(spm_target_link_state);
 static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
+static DEVICE_ATTR_RW(wb_buf_flush_en);

 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
  &dev_attr_rpm_lvl.attr,
@@ -271,6 +314,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
  &dev_attr_spm_target_link_state.attr,
  &dev_attr_auto_hibern8.attr,
  &dev_attr_wb_on.attr,
+ &dev_attr_wb_buf_flush_en.attr,
  NULL
 };

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3f9caafa91bf..153a625b3111 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -248,8 +248,7 @@ static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
 static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
  struct ufs_vreg *vreg);
 static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
-static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set);
-static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable);
+static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
bool set);
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
 static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);

@@ -269,16 +268,17 @@ static inline void ufshcd_disable_irq(struct ufs_hba *hba)
  }
 }

-static inline void ufshcd_wb_config(struct ufs_hba *hba)
+static void ufshcd_wb_set_default_flags(struct ufs_hba *hba)
 {
  if (!ufshcd_is_wb_allowed(hba))
  return;

  ufshcd_wb_toggle(hba, true);

- ufshcd_wb_toggle_flush_during_h8(hba, true);
- if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
- ufshcd_wb_toggle_flush(hba, true);
+ ufshcd_wb_toggle_buf_flush_during_h8(hba, true);
+
+ if (ufshcd_is_wb_buf_flush_allowed(hba))
+ ufshcd_wb_toggle_buf_flush(hba, true);
 }

 static void ufshcd_scsi_unblock_requests(struct ufs_hba *hba)
@@ -1274,9 +1274,10 @@ static int ufshcd_devfreq_scale(struct ufs_hba
*hba, bool scale_up)
  }
  }

- /* Enable Write Booster if we have scaled up else disable it */
  downgrade_write(&hba->clk_scaling_lock);
  is_writelock = false;
+
+ /* Enable Write Booster if we have scaled up else disable it */
  ufshcd_wb_toggle(hba, scale_up);

 out_unprepare:
@@ -5693,9 +5694,13 @@ static int __ufshcd_wb_toggle(struct ufs_hba
*hba, bool set, enum flag_idn idn)
 {
  u8 index;
  enum query_opcode opcode = set ? UPIU_QUERY_OPCODE_SET_FLAG :
-    UPIU_QUERY_OPCODE_CLEAR_FLAG;
+ UPIU_QUERY_OPCODE_CLEAR_FLAG;
+
+ if (!ufshcd_is_wb_allowed(hba))
+ return -EPERM;

  index = ufshcd_wb_get_query_index(hba);
+
  return ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
 }

@@ -5703,60 +5708,51 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 {
  int ret;

- if (!ufshcd_is_wb_allowed(hba))
- return 0;
-
- if (!(enable ^ hba->dev_info.wb_enabled))
+ if (hba->dev_info.wb_enabled == enable)
  return 0;

  ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
  if (ret) {
- dev_err(hba->dev, "%s Write Booster %s failed %d\n",
+ dev_err(hba->dev, "%s: failed to %s WB %d\n",
  __func__, enable ? "enable" : "disable", ret);
  return ret;
  }

  hba->dev_info.wb_enabled = enable;
- dev_info(hba->dev, "%s Write Booster %s\n",
- __func__, enable ? "enabled" : "disabled");

  return ret;
 }

-static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set)
+static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
+ bool enable)
 {
  int ret;

- ret = __ufshcd_wb_toggle(hba, set,
- QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
- if (ret) {
- dev_err(hba->dev, "%s: WB-Buf Flush during H8 %s failed: %d\n",
- __func__, set ? "enable" : "disable", ret);
- return;
- }
- dev_dbg(hba->dev, "%s WB-Buf Flush during H8 %s\n",
- __func__, set ? "enabled" : "disabled");
+ ret = __ufshcd_wb_toggle(hba, enable,
+ QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
+ if (ret)
+ dev_err(hba->dev, "%s: failed to %s WB buf flush during H8 %d\n",
+ __func__, enable ? "enable" : "disable", ret);
 }

-static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable)
+int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable)
 {
  int ret;

- if (!ufshcd_is_wb_allowed(hba) ||
-     hba->dev_info.wb_buf_flush_enabled == enable)
- return;
+ if (hba->dev_info.wb_buf_flush_enabled == enable)
+ return 0;

- ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN);
+ ret = __ufshcd_wb_toggle(hba, enable,
+ QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN);
  if (ret) {
- dev_err(hba->dev, "%s WB-Buf Flush %s failed %d\n", __func__,
- enable ? "enable" : "disable", ret);
- return;
+ dev_err(hba->dev, "%s: failed to %s WB buf flush %d\n",
+ __func__, enable ? "enable" : "disable", ret);
+ return ret;
  }

  hba->dev_info.wb_buf_flush_enabled = enable;

- dev_dbg(hba->dev, "%s WB-Buf Flush %s\n",
- __func__, enable ? "enabled" : "disabled");
+ return ret;
 }

 static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
@@ -5790,10 +5786,10 @@ static bool
ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,

 static void ufshcd_wb_force_disable(struct ufs_hba *hba)
 {
- if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
- ufshcd_wb_toggle_flush(hba, false);
+ if (ufshcd_is_wb_buf_flush_allowed(hba))
+ ufshcd_wb_toggle_buf_flush(hba, false);

- ufshcd_wb_toggle_flush_during_h8(hba, false);
+ ufshcd_wb_toggle_buf_flush_during_h8(hba, false);
  ufshcd_wb_toggle(hba, false);
  hba->caps &= ~UFSHCD_CAP_WB_EN;

@@ -8178,7 +8174,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba,
bool init_dev_params)
  */
  ufshcd_set_active_icc_lvl(hba);

- ufshcd_wb_config(hba);
+ /* Enable UFS Write Booster if supported */
+ ufshcd_wb_set_default_flags(hba);
+
  if (hba->ee_usr_mask)
  ufshcd_write_ee_control(hba);
  /* Enable Auto-Hibernate if configured */
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 94f545be183a..69b5f33d5746 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -991,6 +991,12 @@ static inline bool ufshcd_is_wb_allowed(struct
ufs_hba *hba)
  return hba->caps & UFSHCD_CAP_WB_EN;
 }

+static inline bool ufshcd_is_wb_buf_flush_allowed(struct ufs_hba *hba)
+{
+ return ufshcd_is_wb_allowed(hba) &&
+ !(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL);
+}
+
 static inline bool ufshcd_is_user_access_allowed(struct ufs_hba *hba)
 {
  return !hba->shutting_down;
@@ -1209,6 +1215,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
       enum query_opcode desc_op);

 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
+int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
 int ufshcd_suspend_prepare(struct device *dev);
 int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
 void ufshcd_resume_complete(struct device *dev);
-- 
2.25.1
