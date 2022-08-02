Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C905878DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbiHBITK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbiHBITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:19:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D520133E11
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:19:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m13so12935526wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k1v0I/t5P/hSD33gJqjfBsIbcLoYYmNPd4gYpkQXBYs=;
        b=Qw1VF5pDquL5NlPKG4G/WCWoaU4CVtu1B/yse4mN7O6RMrAgNHmQMDOZIjD5ZUEb5W
         hPl6xuHO2OPRKv1gQNajRTwEqkRN8Us5taih5PZYQPO69HeGVj/0NyG6+6Vf2J4wk6mD
         npWHnw2KHP1NUdjQnjaG9foIs+aQJOZ6usaBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k1v0I/t5P/hSD33gJqjfBsIbcLoYYmNPd4gYpkQXBYs=;
        b=EoQOm52xDzX+lSnEl6I9ZIyh0CptOYyytgWObR+ohK0gZtAdDFDpA3wPnd92hm8eyK
         /xpiCQ/Z1eCWzsxtqnJM0mpf5rPjsoDLxQ3yQwL/dVHxX2PLNDvBEyCIqUgcH1pH3MUA
         CIb5YGmeaMT1HJiHQzvciOLQ7OTNZJ62ssItJTSCmyNWFZdB2CdnjX8K3RdKqxzoJtrX
         5wsVh7l8lg87FZn1mcaImrh5P1SydFnBp9Ey6UYbuMcpJbFcr32yiLGTzC7Lt1GpU/yK
         9UYwutxLV1bZ0c2A4mU0/39Kg6KquiB2YToQWAz5PYNNRea6giJbm7ysdMBmADa8lf3z
         UpFQ==
X-Gm-Message-State: ACgBeo0wLIqIr5SEmBAS1vRKCG8ZEUFK/bbPHh7tMzzKTmcyJ9Y9I3NY
        XNo+ZBmLbgqEVF6W6BxGuF6HPzCOshm3LzsC
X-Google-Smtp-Source: AA6agR7LCGgO6HcG0Phj0Cm6xPzKMTi0/QvFDoDkzot6Ch+RwHjRRuoOCHt3Tn7Mm6Mai5Uup6Xjrg==
X-Received: by 2002:a5d:42c7:0:b0:21f:916e:a6bf with SMTP id t7-20020a5d42c7000000b0021f916ea6bfmr9097347wrr.443.1659428346182;
        Tue, 02 Aug 2022 01:19:06 -0700 (PDT)
Received: from panicking.amarulasolutions.com ([2.196.208.4])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe44d000000b0021e2fccea97sm14358023wrm.64.2022.08.02.01.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 01:19:05 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:DESIGNWARE USB2 DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     linux-usb@vger.kernel.org (open list:DESIGNWARE USB2 DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH] usb: dwc2: Call core_init after disconnect
Date:   Tue,  2 Aug 2022 10:19:02 +0200
Message-Id: <20220802081903.384867-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call dwc2_hsotg_core_init_disconnected in order to restart
the gadget device session, otherwise the device will remain
in unconsistent state. I have tested on 4.4 kernel but I did
not find any reason how should work now. Basically what happen
is the ep0 has a startup request enqueue but the connected state
is not still get. The session End Detected does not kill any pending
urb so, the complete for the urb was not delivered, the core is not
able to complete the setup because urb is on the queue, and the
core is unable to restart.

Testing was done on PX30 cpu with g_multi gadget (enable ethernet, usb
storage)

[46250.026071] dwc2 ff300000.usb: gintsts=0400802c  gintmsk=d0bc3cc4
[46250.026114] dwc2 ff300000.usb: ++OTG Interrupt gotgint=4 [b_peripheral]
[46250.026142] dwc2 ff300000.usb:  ++OTG Interrupt: Session End Detected++ (b_peripheral)
[46250.026159] call disconnect
[46250.026197] dwc2 ff300000.usb: dwc2_hsotg_irq: 04008028 00000000 (d0bc3cc4) retry 8
[46253.391509] dwc2 ff300000.usb: gintsts=44008028  gintmsk=d0bc3cc4
[46253.391551] dwc2 ff300000.usb: Session request interrupt - lx_state=0
[46253.391595] dwc2 ff300000.usb: dwc2_hsotg_irq: 04008028 00000000 (d0bc3cc4) retry 8
[46253.406548] dwc2 ff300000.usb: dwc2_hsotg_irq: 04809028 00801000 (d0bc3cc4) retry 8
[46253.406587] dwc2 ff300000.usb: dwc2_hsotg_irq: USBRstDet
[46253.406616] dwc2 ff300000.usb: dwc2_hsotg_irq: USBRst
[46253.406642] dwc2 ff300000.usb: GNPTXSTS=00080010
[46253.409549] dwc2 ff300000.usb: dwc2_hsotg_irq: 04008428 00000400 (d0bc3cc4) retry 8
[46253.409585] dwc2 ff300000.usb: GINTSTS_ErlySusp
[46253.412604] dwc2 ff300000.usb: gintsts=04008828  gintmsk=d0bc3cc4
[46253.412641] dwc2 ff300000.usb: USB SUSPEND
[46253.412668] dwc2 ff300000.usb: DSTS=0x31103
[46253.412696] dwc2 ff300000.usb: DSTS.Suspend Status=1 HWCFG4.Power Optimize=1
[46253.412722] dwc2 ff300000.usb: ignore suspend request before enumeration
[46253.412757] dwc2 ff300000.usb: dwc2_hsotg_irq: 04008028 00000000 (d0bc3cc4) retry 8
[46253.612215] phy phy-ff2c0000.syscon:usb2-phy@100.0: charger = USB_SDP_CHARGER
[46253.615388] dwc2 ff300000.usb: dwc2_hsotg_irq: 0400a028 00002000 (d0bc3cc4) retry 8
[46253.615428] dwc2 ff300000.usb: EnumDone (DSTS=0x00431102)
[46253.615456] dwc2 ff300000.usb: new device is full-speed
[46253.615492] dwc2 ff300000.usb: dwc2_hsotg_enqueue_setup: queueing setup request
[46253.615518] dwc2 ff300000.usb: dwc2_hsotg_enqueue_setup already queued???
[46253.615547] dwc2 ff300000.usb: EP0: DIEPCTL0=0x00028000, DOEPCTL0=0x80028000
[46253.617420] dwc2 ff300000.usb: dwc2_hsotg_irq: 04008428 00000400 (d0bc3cc4) retry 8
[46253.617456] dwc2 ff300000.usb: GINTSTS_ErlySusp
[46253.620472] dwc2 ff300000.usb: gintsts=04008828  gintmsk=d0bc3cc4
[46253.620508] dwc2 ff300000.usb: USB SUSPEND
[46253.620535] dwc2 ff300000.usb: DSTS=0x431103
[46253.620563] dwc2 ff300000.usb: DSTS.Suspend Status=1 HWCFG4.Power Optimize=1
[46253.620589] dwc2 ff300000.usb: ignore suspend request before enumeration
[46253.620624] dwc2 ff300000.usb: dwc2_hsotg_irq: 04008028 00000000 (d0bc3cc4) retry 8
[46253.757245] dwc2 ff300000.usb: dwc2_hsotg_irq: 04809028 00801000 (d0bc3cc4) retry 8
[46253.757285] dwc2 ff300000.usb: dwc2_hsotg_irq: USBRstDet
[46253.757312] dwc2 ff300000.usb: dwc2_hsotg_irq: USBRst
[46253.757338] dwc2 ff300000.usb: GNPTXSTS=00080010
[46253.814352] dwc2 ff300000.usb: dwc2_hsotg_irq: 0400a028 00002000 (d0bc3cc4) retry 8
[46253.814395] dwc2 ff300000.usb: EnumDone (DSTS=0x00188800)
[46253.814421] dwc2 ff300000.usb: new device is high-speed
[46253.814456] dwc2 ff300000.usb: dwc2_hsotg_enqueue_setup: queueing setup request
[46253.814483] dwc2 ff300000.usb: dwc2_hsotg_enqueue_setup already queued???
[46253.814512] dwc2 ff300000.usb: EP0: DIEPCTL0=0x00028000, DOEPCTL0=0x80028000
[46253.885421] dwc2 ff300000.usb: dwc2_hsotg_irq: 04088028 00080000 (d0bc3cc4) retry 8
[46253.885463] dwc2 ff300000.usb: dwc2_hsotg_irq: daint=00010000
[46253.885496] dwc2 ff300000.usb: dwc2_hsotg_epint: ep0(out) DxEPINT=0x00008001
[46259.108181] dwc2 ff300000.usb: dwc2_hsotg_irq: 04008428 00000400 (d0bc3cc4) retry 8
[46259.108221] dwc2 ff300000.usb: GINTSTS_ErlySusp
[46259.108600] dwc2 ff300000.usb: dwc2_hsotg_irq: 04009028 00001000 (d0bc3cc4) retry 8
[46259.108632] dwc2 ff300000.usb: dwc2_hsotg_irq: USBRst
[46259.108659] dwc2 ff300000.usb: GNPTXSTS=00080010
[46259.162264] dwc2 ff300000.usb: dwc2_hsotg_irq: 0400a028 00002000 (d0bc3cc4) retry 8
[46259.162304] dwc2 ff300000.usb: EnumDone (DSTS=0x000b1800)
[46259.162332] dwc2 ff300000.usb: new device is high-speed
[46259.162367] dwc2 ff300000.usb: dwc2_hsotg_enqueue_setup: queueing setup request
[46259.162393] dwc2 ff300000.usb: dwc2_hsotg_enqueue_setup already queued???
[46259.162423] dwc2 ff300000.usb: EP0: DIEPCTL0=0x00028000, DOEPCTL0=0x80028000
[46259.344960] dwc2 ff300000.usb: dwc2_hsotg_irq: 04088028 00080000 (d0bc3cc4) retry 8
[46259.345002] dwc2 ff300000.usb: dwc2_hsotg_irq: daint=00010000
[46259.345036] dwc2 ff300000.usb: dwc2_hsotg_epint: ep0(out) DxEPINT=0x00008001
[46264.481549] dwc2 ff300000.usb: dwc2_hsotg_irq: 04088028 00080000 (d0bc3cc4) retry 8
[46264.481592] dwc2 ff300000.usb: dwc2_hsotg_irq: daint=00010000
[46264.481625] dwc2 ff300000.usb: dwc2_hsotg_epint: ep0(out) DxEPINT=0x00008001
[46269.605279] dwc2 ff300000.usb: dwc2_hsotg_irq: 04088028 00080000 (d0bc3cc4) retry 8
[46269.605322] dwc2 ff300000.usb: dwc2_hsotg_irq: daint=00010000
[46269.605356] dwc2 ff300000.usb: dwc2_hsotg_epint: ep0(out) DxEPINT=0x00008001
[46274.724165] dwc2 ff300000.usb: dwc2_hsotg_irq: 04008428 00000400 (d0bc3cc4) retry 8
[46274.724205] dwc2 ff300000.usb: GINTSTS_ErlySusp
[46274.724574] dwc2 ff300000.usb: dwc2_hsotg_irq: 04009028 00001000 (d0bc3cc4) retry 8
[46274.724606] dwc2 ff300000.usb: dwc2_hsotg_irq: USBRst
[46274.724632] dwc2 ff300000.usb: GNPTXSTS=00080010
[46274.778137] dwc2 ff300000.usb: dwc2_hsotg_irq: 0400a028 00002000 (d0bc3cc4) retry 8
[46274.778179] dwc2 ff300000.usb: EnumDone (DSTS=0x00331800)
[46274.778207] dwc2 ff300000.usb: new device is high-speed
[46274.778242] dwc2 ff300000.usb: dwc2_hsotg_enqueue_setup: queueing setup request
[46274.778268] dwc2 ff300000.usb: dwc2_hsotg_enqueue_setup already queued???
[46274.778297] dwc2 ff300000.usb: EP0: DIEPCTL0=0x00028000, DOEPCTL0=0x80028000

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/usb/dwc2/gadget.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index fe2a58c75861..4c1e10a62bde 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3732,7 +3732,6 @@ static irqreturn_t dwc2_hsotg_irq(int irq, void *pw)
 
 	if (gintsts & (GINTSTS_USBRST | GINTSTS_RESETDET)) {
 		u32 usb_status = dwc2_readl(hsotg, GOTGCTL);
-		u32 connected = hsotg->connected;
 
 		dev_dbg(hsotg->dev, "%s: USBRst\n", __func__);
 		dev_dbg(hsotg->dev, "GNPTXSTS=%08x\n",
@@ -3746,7 +3745,7 @@ static irqreturn_t dwc2_hsotg_irq(int irq, void *pw)
 		/* Reset device address to zero */
 		dwc2_clear_bit(hsotg, DCFG, DCFG_DEVADDR_MASK);
 
-		if (usb_status & GOTGCTL_BSESVLD && connected)
+		if (usb_status & GOTGCTL_BSESVLD)
 			dwc2_hsotg_core_init_disconnected(hsotg, true);
 	}
 
-- 
2.34.1

