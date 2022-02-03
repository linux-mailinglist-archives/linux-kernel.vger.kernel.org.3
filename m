Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F594A8016
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiBCIAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:00:38 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:12472 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbiBCIAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643875234; x=1675411234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=utbvqXQyBkzZG663gcqksR4PHSbgvTPxbsM5EvgKhcQ=;
  b=ctsG6UDF/SDSmw9SzP3s/72ci6K5huKw86cJDo9QByP0sa9piADT6fek
   jMeVs909Q0cHzEHgo2JgvvozejWj/SZFKWXqgT+eiXebPDy987AgTO8wm
   VwKcHUueCFL+b5wPv08SLc3oc92gQOgJUUC58UBukLDZmz+Soo4lqTkOl
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 03 Feb 2022 00:00:33 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 00:00:33 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 00:00:32 -0800
Received: from wcheng-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 00:00:32 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH 0/3] Fix enumeration issues during composition switching
Date:   Thu, 3 Feb 2022 00:00:14 -0800
Message-ID: <20220203080017.27339-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses a few enumeration issues being seen during fast
composition switching test cases:
  - Missing DWC3 core soft reset before run/stop enable.  Recommended by the
    Synopsis databook to do this during the pullup enable case.
  - Endxfer command timeouts leading to controller halt failures in the pullup
    disable path.
  - Endxfer command timeouts leading to EP dequeue to never return a completion
    to the function drivers, which can cause to unbind issues depending on
    function driver implementation.

With regards to the endxfer timeout, it was communicated to us that if there is
a pending setup/control transfer in progress, the DWC3 controller is unable to
service the endxfer command for other endpoints.  USB bus sniffer and USB ftrace
logs confirmed that when the endxfer timeouts occurred, there was a SETUP token
being sent by the host, while the pullup routine was in progress, as during the
pullup disable, we should not see any ftrace logs since IRQs are disabled.

It was recommended by Synopsis to ensure that packets on EP0 are always handled,
and the only way to drain the dedicated control transfer internal memory is to
issue a startxfer command.  With this in mind, the pullup disable case is able
to discard any cached setup packets (as disconnect would pursue), so the
approach to issue a startxfer after an unsuccessful endxfer is possible.
Test logs show the subsequent endxfer is successful:

[004] d..1 15631.849982: dwc3_gadget_ep_cmd: ep1out: cmd 'End Transfer' [20c08] params 00000000 00000000 00000000 --> status: Timed Out
[004] d..1 15631.850008: dwc3_prepare_trb: ep0out: trb ffffffc019dad000 (E0:D0) buf 00000000efffa000 size 8 ctrl 00000c23 (HLcs:SC:setup)
[004] d..1 15631.850024: dwc3_gadget_ep_cmd: ep0out: cmd 'Start Transfer' [406] params 00000000 efffa000 00000000 --> status: Successful
[004] d..1 15631.857380: dwc3_gadget_ep_cmd: ep1out: cmd 'End Transfer' [20c08] params 00000000 00000000 00000000 --> status: Successful
[004] d..1 15631.857409: dwc3_gadget_giveback: ep1out: req ffffff8789212300 length 0/16384 zsI ==> -108

Attempts to ensure EP0 transfers don't happen during pullup disable were added
as well.

For the dequeue path, since usb_ep_dequeue() can be called from the function
driver at any time, the same approach can not be used.  In this case, if there
is an endxfer failure observed when dequeuing a request, mark the endpoint w/ a 
flag, which will be later checked when the control transfer is complete.  From
there it will traverse through all EPs to service the ones that need to
re-issue the endxfer command.  This logic will only trigger if there is at least
one EP that needs servicing.

Wesley Cheng (3):
  usb: dwc3: Flush pending SETUP data during stop active xfers
  usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue
  usb: dwc3: Issue core soft reset before enabling run/stop

 drivers/usb/dwc3/core.c   |   4 +-
 drivers/usb/dwc3/core.h   |  14 ++++++
 drivers/usb/dwc3/ep0.c    |  23 ++++++---
 drivers/usb/dwc3/gadget.c | 100 +++++++++++++++++++++++++++++++++-----
 4 files changed, 118 insertions(+), 23 deletions(-)

