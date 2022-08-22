Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F306859BD56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiHVKH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiHVKHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:07:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D3B31DC2;
        Mon, 22 Aug 2022 03:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 725CEB80EDD;
        Mon, 22 Aug 2022 10:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BE3C433D6;
        Mon, 22 Aug 2022 10:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661162838;
        bh=yYftufhCitw7VdIJ1a8lwLSUpA0zN+6TXeBezXYoObE=;
        h=From:To:Cc:Subject:Date:From;
        b=j1Dl8+h4o6HK+7UsjSVbV1F86sgJPoJg5PysgAQAImj60eYPIsWrAKRvLccYPrFRF
         dhWsK+GtmU/RONqV0adldhXL47lrelU726h8F9/bQB4ZjxCZiLRfNrvftChIT9o942
         7dd5dbLlgN9U5uD0lUA+Tfz7kWPnnw1BpBn42ZoxOesBiNn8hSvPX1/egPP5nIaYm8
         HAfEDmKCE1eWP1EqbWBUc6/BZwDdqLCFGZP5E8VbiMghuSFLshGj+JQ3gSIrhRNP2F
         Iiekpw+qZVATCD+Fe1CDla6wUhXoinP0v7xWdy00x5FKdU/W07/9gRJSgcpkySZpbN
         orZ5d2e+NLJbw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oQ4Kw-0000nw-8y; Mon, 22 Aug 2022 12:07:15 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] usb: dwc3: qcom: suppress unused-variable warning
Date:   Mon, 22 Aug 2022 12:05:50 +0200
Message-Id: <20220822100550.3039-1-johan+linaro@kernel.org>
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

The dwc3_qcom_read_usb2_speed() helper is now only called when the
controller is acting as host, but the compiler will warn that the hcd
variable is unused in gadget-only W=1 builds.

Fixes: c06795f114a6 ("usb: dwc3: qcom: fix gadget-only builds")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index b3ba9aaf876c..8298aebd395e 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -310,7 +310,7 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
 {
 	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
 	struct usb_device *udev;
-	struct usb_hcd *hcd;
+	struct usb_hcd __maybe_unused *hcd;
 
 	/*
 	 * FIXME: Fix this layering violation.
-- 
2.35.1

