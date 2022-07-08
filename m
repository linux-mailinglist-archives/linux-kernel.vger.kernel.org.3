Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AA656C22F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbiGHSuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbiGHSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:50:21 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4C631F;
        Fri,  8 Jul 2022 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657306221; x=1688842221;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=/3Xqp4pNnRWsLHtWKiHZgqCLsJeoiiCo8QexGnalDOQ=;
  b=x3sHGPoi7o/QAAcKHNa7Y97WzJuHaxbxF1bed+kRQITdAzwh7RjPvqA+
   VtEDu8qvw24Plhr3EoVM74O2pR5ClrlnQkXzvY7sAZ7o8LMvPULqUUgpL
   2nHPAf6aYdQAR9KaJKCRSQ9AsSPI2xpn5Gvu5SRLFLUSoTie7kSWdNODc
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Jul 2022 11:50:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 11:50:20 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 11:50:20 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 8 Jul 2022 11:50:19 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH 0/5] Fix controller halt and endxfer timeout issues
Date:   Fri, 8 Jul 2022 11:50:02 -0700
Message-ID: <20220708185007.21743-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses some issues seen while testing with the latest
soft disconnect implementation where EP events are allowed to process while
the controller halt is occurring.

#1
Since routines can now interweave, we can see that the soft disconnect can
occur while conndone is being serviced.  This leads to a controller halt
timeout, as the soft disconnect clears the DEP flags, for which conndone
interrupt handler will issue a __dwc3_ep_enable(ep0), that leads to
re-issuing the set ep config command for every endpoint.

#2
Function drivers can ask for a delayed_status phase, while it processes the
received SETUP packet.  This can lead to large delays when handling the
soft disconnect routine.  To improve the timing, forcefully send the status
phase, as we are going to disconnect from the host.

#3
Ensure that local interrupts are left enabled, so that EP0 events can be
processed while the soft disconnect/dequeue is happening.

#4
Modify the DWC3_EP_DELAY_STOP flag management so that if these flags were set
before soft disconnect, that the disconnect routine will be able to properly
issue the endxfer command.

#5
Since EP0 events can occur during controller halt, it may increase the time
needed for the controller to fully stop.

Wesley Cheng (5):
  usb: dwc3: Do not service EP0 and conndone events if soft disconnected
  usb: dwc3: gadget: Force sending delayed status during soft disconnect
  usb: dwc3: gadget: Adjust IRQ management during soft
    disconnect/connect
  usb: dwc3: Allow end transfer commands to be sent during soft
    disconnect
  usb: dwc3: gadget: Increase DWC3 controller halt timeout

 drivers/usb/dwc3/ep0.c    |  9 +++++----
 drivers/usb/dwc3/gadget.c | 31 ++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 13 deletions(-)

