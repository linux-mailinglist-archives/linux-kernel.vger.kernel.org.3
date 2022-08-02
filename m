Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034D5588268
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiHBTS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiHBTSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:18:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D312D28;
        Tue,  2 Aug 2022 12:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659467925; x=1691003925;
  h=from:to:cc:subject:date:message-id;
  bh=r/XIqJc2dKNK2b3maiJp5sGmbG73g16hBKrnIKFiztA=;
  b=Nur0TIhOiqGjJwiR047e8XQXxISanqjiVSkLuB/gjr7CDhvJfxD2RuLp
   1lx57Yasp1ohvGWxO4qUlbcyT644Nn8z4BWAE1R/dBiSlx1w8Y+nJd/OR
   LfAzV2p48iecGMSTPmm0KmeZLDeRXCfXre48Y25J1qsZZsuf1PLUi38VL
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 Aug 2022 12:18:42 -0700
X-QCInternal: smtphost
Received: from hu-eserrao-lv.qualcomm.com (HELO hu-devc-lv-c.qualcomm.com) ([10.47.235.164])
  by ironmsg09-lv.qualcomm.com with ESMTP; 02 Aug 2022 12:18:42 -0700
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 706982118B; Tue,  2 Aug 2022 12:18:42 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_mrana@quicinc.com, Thinh.Nguyen@synopsys.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH 0/5] Add function suspend/resume and remote wakeup support 
Date:   Tue,  2 Aug 2022 12:18:35 -0700
Message-Id: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An usb device can initate a remote wakeup and bring the link out of
suspend as dictated by the DEVICE_REMOTE_WAKEUP feature selector.
To achieve this an interface can invoke gadget_wakeup op and wait for the
device to come out of LPM. But the current polling based implementation
fails if the host takes a long time to drive the resume signaling specially
in high speed capable devices. Switching to an interrupt based approach is
more robust and efficient. This can be leveraged by enabling link status
change events and triggering a gadget resume when the link comes to active
state.

If the device is super-speed/super-speed-plus capable, individual
interfaces can also be put into suspend state. An interface can be
in function suspend state even when the device is not in suspend state.
Function suspend state is retained throughout the device suspend entry
and exit process. A function can be put to function suspend through
FUNCTION_SUSPEND feature selector sent by the host. This setup packet also
decides whether that function is capable of initiating a function remote
wakeup. When the function sends a wakeup notification to the host the link
must be first brought to a non-U0 state and then this notification
is sent.

This change adds the infrastructure needed to support the above
functionalities.

Elson Roy Serrao (5):
  usb: dwc3: Add remote wakeup handling
  usb: gadget: Add function wakeup support
  usb: dwc3: Add function suspend and function wakeup support
  usb: gadget: f_ecm: Add suspend/resume and remote wakeup support
  usb: gadget: f_ecm: Add function suspend and wakeup support

 drivers/usb/dwc3/core.h               |  5 ++
 drivers/usb/dwc3/ep0.c                | 16 +++---
 drivers/usb/dwc3/gadget.c             | 99 +++++++++++++++++++++++++++++++++--
 drivers/usb/gadget/composite.c        | 32 +++++++++++
 drivers/usb/gadget/function/f_ecm.c   | 67 ++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.c | 98 ++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.h |  6 +++
 drivers/usb/gadget/udc/core.c         |  9 ++++
 include/linux/usb/composite.h         |  1 +
 include/linux/usb/gadget.h            |  2 +
 10 files changed, 324 insertions(+), 11 deletions(-)

-- 
2.7.4

