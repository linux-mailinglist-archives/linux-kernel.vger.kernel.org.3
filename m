Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4DF587EC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiHBPOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiHBPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:14:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FC418373;
        Tue,  2 Aug 2022 08:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DBF1B81F47;
        Tue,  2 Aug 2022 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB9AC433D6;
        Tue,  2 Aug 2022 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659453256;
        bh=j2nJx8as9UlVhaaVa9FxipRqThk43lXnnVB/YIARXa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbvJQq8pE6Ks5bYHErzelIKTO/zg9HHbBjyIxtk/eXSDKrLiAdSND7WzKypwWeI1G
         HQ5uIzSC7gq7gEYaewaIqKd9K/1xAtioRdg4f36aYJ1Ok36/krOUToQnTV64k18Wup
         vLSDKDFUGoHf1A1A7yr6Q1vnjjG+17jqWpt/ipCEhNHC8wUIQ0oVRfYSiAopFYp75o
         mJpx5DtgibmUZLHzxK//RdcDYevTzrV3jDhI++MVYc8eiO0RZLLQy3bTxUNUR24kJX
         6KBre9MVd47+kyLUQZ+wxsM5gtkKoxE9x6JliFUWTlqYxtLkOcq1hrENCNKbL5idg5
         dQqIq7MhJkw/g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oItbM-0000TY-8k; Tue, 02 Aug 2022 17:14:32 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/8] usb: dwc3: qcom: fix broken non-host-mode suspend
Date:   Tue,  2 Aug 2022 17:13:59 +0200
Message-Id: <20220802151404.1797-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220802151404.1797-1-johan+linaro@kernel.org>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit implementing wakeup support in host mode instead broke
suspend for peripheral and OTG mode.

The hack that was added in the suspend path to determine the speed of
any device connected to the USB2 bus not only accesses internal driver
data for a child device, but also dereferences a NULL pointer when not
in host mode and there is no HCD.

As the controller can switch role at any time when in OTG mode, there's
no quick fix to this, and since reverting would leave us with broken
suspend in host-mode (wakeup triggers immediately), keep the hack for
now and only fix the NULL-pointer dereference.

Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index be2e3dd36440..b75ff40f75a2 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -301,8 +301,17 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
 static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
 {
 	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
-	struct usb_hcd *hcd = platform_get_drvdata(dwc->xhci);
 	struct usb_device *udev;
+	struct usb_hcd *hcd;
+
+	if (qcom->mode != USB_DR_MODE_HOST)
+		return USB_SPEED_UNKNOWN;
+
+	/*
+	 * FIXME: Fix this nasty layering violation which currently only
+	 *        "works" in host mode.
+	 */
+	hcd = platform_get_drvdata(dwc->xhci);
 
 	/*
 	 * It is possible to query the speed of all children of
-- 
2.35.1

