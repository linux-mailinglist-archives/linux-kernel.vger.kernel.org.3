Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B038C58A75C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbiHEHpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHEHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFE9FE5;
        Fri,  5 Aug 2022 00:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDEAD616C5;
        Fri,  5 Aug 2022 07:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AC1C433B5;
        Fri,  5 Aug 2022 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659685502;
        bh=3uWbqT42BniSI/9bdvMcYnJrSiBwh8YbURul3ZSw2bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9ctC4AwDDvOGGvvqHHTcCKdJ18IT2l89Z2bKpC3S1FCkMH6XZZ/S0vmLKWdtrstG
         83JSZmS/Q7SFRD77DvRaLq8a59WG4+HD6mwjrOEQvhUEy6cRVF5tZ4Rz8XVdFtPLex
         9CNpePfAGtkgbw9w9+ygWjKIo4oTxiMc2p+f4mij7OkMmLAGm9I3GKRDVtPGbKJDYu
         e8QZLkXwYzyYo4xbuMuXKxUfnFQ1JC+0gqUFi8mKnGHKkrWHkGeHsmxq1jhMsiXFoY
         DdADwwK22saoLW3+P+ubCvuPdCmyneEgRKhGxFCIYmTQvK9D5QyAGZH1ZZy9G1kX96
         sVXxMGuSyLxUw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJs1O-0005ah-15; Fri, 05 Aug 2022 09:45:26 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] usb: dwc3: qcom: only parse 'maximum-speed' once
Date:   Fri,  5 Aug 2022 09:44:59 +0200
Message-Id: <20220805074500.21469-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805074500.21469-1-johan+linaro@kernel.org>
References: <20220805074500.21469-1-johan+linaro@kernel.org>
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

Add a temporary variable to the interconnect-initialisation helper to
avoid parsing and decoding the 'maximum-speed' devicetree property
twice.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 6814861bed6c..196efa9f2545 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -243,6 +243,7 @@ static int dwc3_qcom_interconnect_disable(struct dwc3_qcom *qcom)
  */
 static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
 {
+	enum usb_device_speed max_speed;
 	struct device *dev = qcom->dev;
 	int ret;
 
@@ -263,8 +264,8 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
 		return PTR_ERR(qcom->icc_path_apps);
 	}
 
-	if (usb_get_maximum_speed(&qcom->dwc3->dev) >= USB_SPEED_SUPER ||
-			usb_get_maximum_speed(&qcom->dwc3->dev) == USB_SPEED_UNKNOWN)
+	max_speed = usb_get_maximum_speed(&qcom->dwc3->dev);
+	if (max_speed >= USB_SPEED_SUPER || max_speed == USB_SPEED_UNKNOWN)
 		ret = icc_set_bw(qcom->icc_path_ddr,
 			USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
 	else
-- 
2.35.1

