Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F195A48A7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348294AbiAKGtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:49:07 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33005 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiAKGtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641883746; x=1673419746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tKnoJzErsAHJm+nQCMMaPbpfpKiRq/oaK90dtIuEypY=;
  b=Hp+plgT04CkEESb6D2vUwflGK5M302A4vj9KrvO/bwsAV4k1MVWcnjES
   UDrFiofQ8r/f4pB7t79rmC+mqtPmV7N7mBqJqYim2O2hmhqJYb0SMdwjz
   VLF5BJqnGgp9np+L3GhgQXk+iIc9N2TIAvtLMtVzQL/Y0DqH1Eh0MrxMw
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 10 Jan 2022 22:49:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 22:49:05 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 22:49:05 -0800
Received: from wcheng-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 22:49:04 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH] usb: gadget: f_serial: Ensure gserial disconnected during unbind
Date:   Mon, 10 Jan 2022 22:48:50 -0800
Message-ID: <20220111064850.24311-1-quic_wcheng@quicinc.com>
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

Some UDCs may return an error during pullup disable as part of the
unbind path for a USB configuration.  This will lead to a scenario
where the disable() callback is skipped, whereas the unbind() still
occurs.  If this happens, the u_serial driver will continue to fail
subsequent binds, due to an already existing entry in the ports array.
Ensure that gserial_disconnect() is called during the f_serial unbind,
so the ports entry is properly cleared.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/gadget/function/f_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/f_serial.c b/drivers/usb/gadget/function/f_serial.c
index 1ed8ff0ac2d3..a9480b9e312e 100644
--- a/drivers/usb/gadget/function/f_serial.c
+++ b/drivers/usb/gadget/function/f_serial.c
@@ -345,6 +345,10 @@ static void gser_free(struct usb_function *f)
 
 static void gser_unbind(struct usb_configuration *c, struct usb_function *f)
 {
+	struct f_gser	*gser = func_to_gser(f);
+
+	/* Ensure port is disconnected before unbinding */
+	gserial_disconnect(&gser->port);
 	usb_free_all_descriptors(f);
 }
 
