Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3110D4B3C77
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiBMRTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:19:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiBMRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:19:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61440517F9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644772763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Cs2m1Vvu+oQk/NE0TT+2XutYU+ypiTepICSeJZfpASo=;
        b=FGxqrDtfha2NZldPy8GIhdupZdcY5LHtgtJPmy/n2gEGzKe97lJVtshmrIikWstxqFCVvc
        M1+9SOYTZUsYu1BTg2tNOZfkdlQC2OWRD7p4nOJBYV5w9Wa1xONK/AYc4l26D6H6URlPkG
        vN0hBxa9Y/8TiyrOPeRw4CdB6wdPXdY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-0KItqQ-EM2WF2-x1dl6ndw-1; Sun, 13 Feb 2022 12:19:22 -0500
X-MC-Unique: 0KItqQ-EM2WF2-x1dl6ndw-1
Received: by mail-oo1-f70.google.com with SMTP id y20-20020a4acb94000000b003185ebeeffdso6494469ooq.15
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cs2m1Vvu+oQk/NE0TT+2XutYU+ypiTepICSeJZfpASo=;
        b=qA6uY/VJif/8dxJUGNBy5nbC4f6DQCpB683qjZnD1kPpnuz7ld+5sMpb8qT+XVM/bD
         TY1vEyFDJqBTmQXvhZ/BYXwoT3cPJQFtxcMRSLkbrEIIWeYhH6k8P4f0GsOeg46CtllM
         fbYzmjsDFhpEM/AV9gKu0WMOONQpyhxyhSRzdklq3F51903JlJLRuqHjP5NMmvPVneEo
         VgAnC7i3vHbLmgyJRf3AudzozrVyLRMIsbtwuESAAYJzO1AilJcDdxoGXz+ZgJBEnW+M
         KB5wtFB++JATn1ynj61h0peZ++QS57QBcVf39BeK4lZ8zPKiycRjiKxQa77SJcY19mr0
         mTcA==
X-Gm-Message-State: AOAM531MLulltLDtsR+OakFdn5pmDWb8r6BqdrGw+yydxys++u4qgq+E
        +XmzsKj6LPed+VX+pSDpScZr+OzRJk23wMa+q6rPGr1sW2wbuNUT1p+4PVS8sAg0o6mDqLtrgIw
        mNs2bXVrvuYNcRVz8e7u0HkqU
X-Received: by 2002:aca:eb55:: with SMTP id j82mr3993212oih.134.1644772761654;
        Sun, 13 Feb 2022 09:19:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoHXf1CDEAvFygYy5P7c6hfLThkDvIvyHvPi6MymSLfK+RMIM5MUrhuhvu44S69J3VKRQOsw==
X-Received: by 2002:aca:eb55:: with SMTP id j82mr3993202oih.134.1644772761430;
        Sun, 13 Feb 2022 09:19:21 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w9sm11766781ool.31.2022.02.13.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 09:19:21 -0800 (PST)
From:   trix@redhat.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        kai.heng.feng@canonical.com, ricky_wu@realtek.com,
        christophe.jaillet@wanadoo.fr
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] misc: rtsx: conditionally build rtsx_pm_power_saving()
Date:   Sun, 13 Feb 2022 09:19:07 -0800
Message-Id: <20220213171907.2786442-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

On s390 allyesconfig, there is this build error
rtsx_pcr.c:1084:13: error: 'rtsx_pm_power_saving'
  defined but not used
 1084 | static void rtsx_pm_power_saving(struct rtsx_pcr *pcr)
      |             ^~~~~~~~~~~~~~~~~~~~

rtsx_pm_power_saving() is only used by rtsx_pci_runtime_idle()
which is conditional on CONFIG_PM.  So conditionally build
rtsx_pm_power_saving() and the similar
rtsx_comm_pm_power_saving() and rtsx_enable_aspm().

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 64 +++++++++++++++---------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 1cb6425e8369..2a2619e3c72c 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1054,38 +1054,6 @@ static int rtsx_pci_acquire_irq(struct rtsx_pcr *pcr)
 	return 0;
 }
 
-static void rtsx_enable_aspm(struct rtsx_pcr *pcr)
-{
-	if (pcr->ops->set_aspm)
-		pcr->ops->set_aspm(pcr, true);
-	else
-		rtsx_comm_set_aspm(pcr, true);
-}
-
-static void rtsx_comm_pm_power_saving(struct rtsx_pcr *pcr)
-{
-	struct rtsx_cr_option *option = &pcr->option;
-
-	if (option->ltr_enabled) {
-		u32 latency = option->ltr_l1off_latency;
-
-		if (rtsx_check_dev_flag(pcr, L1_SNOOZE_TEST_EN))
-			mdelay(option->l1_snooze_delay);
-
-		rtsx_set_ltr_latency(pcr, latency);
-	}
-
-	if (rtsx_check_dev_flag(pcr, LTR_L1SS_PWR_GATE_EN))
-		rtsx_set_l1off_sub_cfg_d0(pcr, 0);
-
-	rtsx_enable_aspm(pcr);
-}
-
-static void rtsx_pm_power_saving(struct rtsx_pcr *pcr)
-{
-	rtsx_comm_pm_power_saving(pcr);
-}
-
 static void rtsx_base_force_power_down(struct rtsx_pcr *pcr)
 {
 	/* Set relink_time to 0 */
@@ -1701,6 +1669,38 @@ static int __maybe_unused rtsx_pci_resume(struct device *dev_d)
 
 #ifdef CONFIG_PM
 
+static void rtsx_enable_aspm(struct rtsx_pcr *pcr)
+{
+	if (pcr->ops->set_aspm)
+		pcr->ops->set_aspm(pcr, true);
+	else
+		rtsx_comm_set_aspm(pcr, true);
+}
+
+static void rtsx_comm_pm_power_saving(struct rtsx_pcr *pcr)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+
+	if (option->ltr_enabled) {
+		u32 latency = option->ltr_l1off_latency;
+
+		if (rtsx_check_dev_flag(pcr, L1_SNOOZE_TEST_EN))
+			mdelay(option->l1_snooze_delay);
+
+		rtsx_set_ltr_latency(pcr, latency);
+	}
+
+	if (rtsx_check_dev_flag(pcr, LTR_L1SS_PWR_GATE_EN))
+		rtsx_set_l1off_sub_cfg_d0(pcr, 0);
+
+	rtsx_enable_aspm(pcr);
+}
+
+static void rtsx_pm_power_saving(struct rtsx_pcr *pcr)
+{
+	rtsx_comm_pm_power_saving(pcr);
+}
+
 static void rtsx_pci_shutdown(struct pci_dev *pcidev)
 {
 	struct pcr_handle *handle = pci_get_drvdata(pcidev);
-- 
2.26.3

