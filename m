Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6384459E6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbiHWQVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244692AbiHWQVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:21:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA6109745;
        Tue, 23 Aug 2022 05:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89764B81D49;
        Tue, 23 Aug 2022 12:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BBCC433C1;
        Tue, 23 Aug 2022 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661258478;
        bh=naPVwxGYbOYYyYosNtCVBq58s8P4rzIXiMSSJRznwe4=;
        h=From:To:Cc:Subject:Date:From;
        b=R7FTOCr4h1JoaCkrMlZ9fqNUP3DfBay71sLq1XvZQ3NUewTcilIU/xqvj/Yr7/oXq
         VqnpWWspTB5+3rgdeFPA5PzjcWn+8fLKxOgxJUbKJ3AQdupRTyqtjTHHgAjArTrPNH
         UyKB3R9E27+q2I/FosGXGN5sNKneM7B/K7OmtXR15zefZ/oeUYQO5wtDf3B6Iy3FkM
         oUiWyRYkYyuUw0wCnjLb0FMpUUjyETTsgSOCNvg/ZgDZJqz7MoWff2qApOzanQrCLI
         4EKPiWZFdb0fSKL7dc5hm2YIezxSXaO+m/MjhrejYIV7iHgfoYgW+Zy6xBw4u1Cnqq
         jG+LieKNP7o4w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oQTDZ-0003ob-KH; Tue, 23 Aug 2022 14:41:18 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] usb: dwc3: keep PHYs disabled during suspend
Date:   Tue, 23 Aug 2022 14:40:47 +0200
Message-Id: <20220823124047.14634-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system
suspend") started leaving the PHYs enabled during suspend for
wakeup-capable controllers even though it turns out this had nothing to
do with wakeup.

Rather, the wakeup capability flag was (ab-)used as a proxy to configure
the suspend behaviour in an attempt to reduce power leakage on some
platforms.

Stop abusing the wakeup configuration and restore the 5.19 behaviour of
keeping the PHYs powered off during suspend. If needed, a dedicated
mechanism for configuring the PHY power state during suspend can be
added later.

Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
Link: https://lore.kernel.org/r/Yuv7AM/5jtO/pgcm@google.com
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/core.c      | 4 ++--
 drivers/usb/dwc3/dwc3-qcom.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8c8e32651473..0cdb6be720e1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1983,7 +1983,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
+		if (!PMSG_IS_AUTO(msg)) {
 			dwc3_core_exit(dwc);
 			break;
 		}
@@ -2044,7 +2044,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
+		if (!PMSG_IS_AUTO(msg)) {
 			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 9a94b1ab8f7a..9995395baa12 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -904,7 +904,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
 	device_init_wakeup(&pdev->dev, wakeup_source);
-	device_init_wakeup(&qcom->dwc3->dev, wakeup_source);
 
 	qcom->is_suspended = false;
 	pm_runtime_set_active(dev);
-- 
2.35.1

