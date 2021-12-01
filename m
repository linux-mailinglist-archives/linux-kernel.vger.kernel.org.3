Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CAE464B24
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348446AbhLAKFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:05:40 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:44518 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229950AbhLAKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638352939; x=1669888939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tka4C/qQG4GxPIkwSGYvi6KGHehlqrc0CkkTseIRnuM=;
  b=WgWEhTmLdscu2LDZ+kxe73yur2aEEm19ZxJMMajHVmNkBU3xDPUunjE+
   BSD+OT9n1dHoOD5Lg5uRhioCEy36WCiedwNTRcRlND4IZcu3+9vbkG7U4
   1BtVKIwrrJakJHDX/EZQgPdVUZe0bRI2tEmG90ePe7EizdIf3POUaXNzJ
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 02:02:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 02:02:19 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 02:02:19 -0800
Received: from wcheng-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 02:02:18 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH] usb: gadget: f_fs: Wake up IO thread during disconnect
Date:   Wed, 1 Dec 2021 02:02:05 -0800
Message-ID: <20211201100205.25448-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During device disconnect or composition unbind, applications should be
notified that the endpoints are no longer enabled, so that it can take
the proper actions to handle its IO threads.  Otherwise, they can be
left waiting for endpoints until EPs are re-enabled.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/gadget/function/f_fs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 3c584da9118c..0b0747d96378 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -957,10 +957,12 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 		if (file->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
-		ret = wait_event_interruptible(
-				epfile->ffs->wait, (ep = epfile->ep));
+		ret = wait_event_interruptible(epfile->ffs->wait,
+				(ep = epfile->ep) || !epfile->ffs->func);
 		if (ret)
 			return -EINTR;
+		if (!epfile->ffs->func)
+			return -ENODEV;
 	}
 
 	/* Do we halt? */
@@ -3292,6 +3294,7 @@ static int ffs_func_set_alt(struct usb_function *f,
 	if (alt == (unsigned)-1) {
 		ffs->func = NULL;
 		ffs_event_add(ffs, FUNCTIONFS_DISABLE);
+		wake_up_interruptible(&ffs->wait);
 		return 0;
 	}
 
