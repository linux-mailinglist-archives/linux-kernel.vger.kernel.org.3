Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559C64B6A35
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiBOLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:06:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBOLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:06:02 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6585B1074F0;
        Tue, 15 Feb 2022 03:05:52 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21F9Uwof001961;
        Tue, 15 Feb 2022 12:05:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=BzGYCWiuAmnqSDxwbjn+OcaBHSUNhwIWqEfHFMygnKs=;
 b=kgsIoG3L/Uw+MAzaT9hI1A//b5+RnXoRzBJpfo58PjKcBZYXX7loGSVo3Puldfs/H6Eb
 2NpMsoI7RQUgnCG3dQrkkQH2CcYbOE/x1voY/qWJoOzbMgjey1VYQQDbGFeSKCLbnrJq
 64v+7/swPPd0gOo0CQUnzxrbLyqCbDZNToYDWKfLE6y6iZ0bTwgFoBJWS2MVUranJbnc
 bgJlbC4KdH+mHSVe0TYBYlCJ1vkibMkeTk+iYZjCP4TMTMEn44C/mKsv+aZYA/h/XbGy
 OeEkf8eOuQiqAaXloBBesxBhMuAnd7WU82YwlryVZCn5Z8elOKfg9sMUQtffojF8lQD5 ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e7pj7pbrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 12:05:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0BBB610002A;
        Tue, 15 Feb 2022 12:05:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 78C3021D3EC;
        Tue, 15 Feb 2022 12:05:45 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 15 Feb 2022 12:05:45
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2] usb: dwc2: drd: fix soft connect when gadget is unconfigured
Date:   Tue, 15 Feb 2022 12:04:19 +0100
Message-ID: <1644923059-3619-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the gadget driver hasn't been (yet) configured, and the cable is
connected to a HOST, the SFTDISCON gets cleared unconditionally, so the
HOST tries to enumerate it.
At the host side, this can result in a stuck USB port or worse. When
getting lucky, some dmesg can be observed at the host side:
 new high-speed USB device number ...
 device descriptor read/64, error -110

Fix it in drd, by checking the enabled flag before calling
dwc2_hsotg_core_connect(). It will be called later, once configured,
by the normal flow:
- udc_bind_to_driver
 - usb_gadget_connect
   - dwc2_hsotg_pullup
     - dwc2_hsotg_core_connect

Fixes: 17f934024e84 ("usb: dwc2: override PHY input signals with usb role switch support")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Fix build error: 'struct dwc2_hsotg' has no member named 'enabled';
  as reported by the kernel test robot.
  https://lore.kernel.org/all/202202112236.AwoOTtHO-lkp@intel.com/
  Add dwc2_is_device_enabled() macro to handle this.
---
 drivers/usb/dwc2/core.h | 2 ++
 drivers/usb/dwc2/drd.c  | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 8a63da3..8a7751b 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1418,6 +1418,7 @@ void dwc2_hsotg_core_connect(struct dwc2_hsotg *hsotg);
 void dwc2_hsotg_disconnect(struct dwc2_hsotg *dwc2);
 int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsotg, int testmode);
 #define dwc2_is_device_connected(hsotg) (hsotg->connected)
+#define dwc2_is_device_enabled(hsotg) ((hsotg)->enabled)
 int dwc2_backup_device_registers(struct dwc2_hsotg *hsotg);
 int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg, int remote_wakeup);
 int dwc2_gadget_enter_hibernation(struct dwc2_hsotg *hsotg);
@@ -1454,6 +1455,7 @@ static inline int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsotg,
 					   int testmode)
 { return 0; }
 #define dwc2_is_device_connected(hsotg) (0)
+#define dwc2_is_device_enabled(hsotg) (0)
 static inline int dwc2_backup_device_registers(struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg,
diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
index 1b39c47..d8d6493 100644
--- a/drivers/usb/dwc2/drd.c
+++ b/drivers/usb/dwc2/drd.c
@@ -130,8 +130,10 @@ static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
 		already = dwc2_ovr_avalid(hsotg, true);
 	} else if (role == USB_ROLE_DEVICE) {
 		already = dwc2_ovr_bvalid(hsotg, true);
-		/* This clear DCTL.SFTDISCON bit */
-		dwc2_hsotg_core_connect(hsotg);
+		if (dwc2_is_device_enabled(hsotg)) {
+			/* This clear DCTL.SFTDISCON bit */
+			dwc2_hsotg_core_connect(hsotg);
+		}
 	} else {
 		if (dwc2_is_device_mode(hsotg)) {
 			if (!dwc2_ovr_bvalid(hsotg, false))
-- 
2.7.4

