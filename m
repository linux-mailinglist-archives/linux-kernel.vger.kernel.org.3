Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF3473426
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbhLMSgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbhLMSgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:36:32 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201FC061574;
        Mon, 13 Dec 2021 10:36:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r25so54689565edq.7;
        Mon, 13 Dec 2021 10:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GdeI+x6ykbfMauYOYbUkavNJiP1mCuqUQa42vQcboQg=;
        b=XxcVAKs7wygQLuSlkFephoyJ89cyxhYH8lB95AbQtVGexC7/ZfLr4piHmAZvydHPVF
         0mUQYkxdrlR7xhr6Kf+x+XJ7bTBEVOphS5H8adNoT9un25q9DctxlM6nddZgxe1I4xwB
         PHPNFzR0Cmkl/MkV1U8jGVSPynzRPEwismhM1MtzD+ygi/Hb/bCRBPk7hfHtVPpgPdcf
         +q6nsPb3COnSEqStJ64imK9+2BFj8ag7iaYIAA/PKKdgwGcto7kDdQYZ8d2acgNftQ33
         63Uh5yWHnppxK7+7J8WJyLtV6U5m4f5MTrYRywVv2OviKJ4oIvS7zZfy3gFd93JmgHCG
         XfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdeI+x6ykbfMauYOYbUkavNJiP1mCuqUQa42vQcboQg=;
        b=K2yf1LzLhqH11G9piRmFln890SGk+L4A/i6AJJOn7wXWjQSJTTOTM0MnWm9DEnAFCx
         aY1R78hryTKs/nqpQYT9dCj+esgx/Lp0dM7VkrfXiOXi+ToDW+mVrYkQt7W0Jj71uhTa
         ToHDa+1daskVqq7Ft6b6s7pJangQoPcYRxIg59NWNcVFnx17yBzjfCErFG2NJVTVufG7
         tgMffJGkx8/DYvbg+8m2+zPMwBZ4TrXUSvxLIsZbj/m27pZA5YMDeBTiTsz7iTwdU87X
         ZHcXkzY8hmSotU9GreblIT5kdFtzTAlWcQQ1dFgZ6DZ7lL5u+2YhJ6y0r9rY29i7JTdQ
         AxdA==
X-Gm-Message-State: AOAM532sbPFbfSU7/N7UUaliVZ+yLylutDNzH0FkJ0U4l1PBJdZWKAu2
        9S7YCcM6596vOJILqAKK21E=
X-Google-Smtp-Source: ABdhPJyL25z2eIMSeBNwqvWC1PnGdlRvW0b9IdP7smIb5qil4fnJd6YLIfMQwNc5fuNoOfJr2wu7bg==
X-Received: by 2002:a17:906:f2c2:: with SMTP id gz2mr48322ejb.731.1639420590506;
        Mon, 13 Dec 2021 10:36:30 -0800 (PST)
Received: from CLU-56K1TB3.ad.garmin.com ([176.223.64.4])
        by smtp.gmail.com with ESMTPSA id q17sm6816793edd.10.2021.12.13.10.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:36:30 -0800 (PST)
From:   Razvan Heghedus <heghedus.razvan@gmail.com>
Cc:     heghedus.razvan@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] usb: misc: ehset: Rework test mode entry
Date:   Mon, 13 Dec 2021 20:36:15 +0200
Message-Id: <20211213183617.14156-2-heghedus.razvan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213183617.14156-1-heghedus.razvan@gmail.com>
References: <20211213183617.14156-1-heghedus.razvan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB2.0 spec chapter 11.24.2.13 says that the USB port which is going
under test needs to be put in suspend state before sending the test
command. Many hubs, don't enforce this precondition and they work fine
without this step. We should follow the specification and put the USB
port in suspend before sending the test command.

Also there are some "special" hubs, which requires to disable the USB
port power instead of putting it in suspend. I found out only three hubs
which requires this step, but if more are found, they can be added to
the list.

Since this changes the default implementation, it raises the posibility
of finding other broken hubs which are not compliant with the spec and
the test command might not work is the port is suspended. If such hubs
are found, a similar workaround like the disable part can be implemented
to skip putting the port in suspend.

Signed-off-by: Razvan Heghedus <heghedus.razvan@gmail.com>
---
 Changes in v4:
  - make a patch series
 Changes in v3:
  - use usb_device_match_id to correctly match the hub based on VID:PID
  - reword commit message to be more explanatory on what the patch does
 Changes in v2:
  - style change regarding multi-line comments and a new black line after
    local variable definitions
  - No more corporate email annotation
 drivers/usb/misc/ehset.c | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/usb/misc/ehset.c b/drivers/usb/misc/ehset.c
index f87890f9cd26..986d6589f053 100644
--- a/drivers/usb/misc/ehset.c
+++ b/drivers/usb/misc/ehset.c
@@ -18,6 +18,52 @@
 #define TEST_SINGLE_STEP_GET_DEV_DESC		0x0107
 #define TEST_SINGLE_STEP_SET_FEATURE		0x0108
 
+extern const struct usb_device_id *usb_device_match_id(struct usb_device *udev,
+						const struct usb_device_id *id);
+
+/*
+ * A list of USB hubs which requires to disable the power
+ * to the port before starting the testing procedures.
+ */
+static const struct usb_device_id ehset_hub_list[] = {
+	{ USB_DEVICE(0x0424, 0x4502) },
+	{ USB_DEVICE(0x0424, 0x4913) },
+	{ USB_DEVICE(0x0451, 0x8027) },
+	{ }
+};
+
+static int ehset_prepare_port_for_testing(struct usb_device *hub_udev, u16 portnum)
+{
+	int ret = 0;
+
+	/*
+	 * The USB2.0 spec chapter 11.24.2.13 says that the USB port which is
+	 * going under test needs to be put in suspend before sending the
+	 * test command. Most hubs don't enforce this precondition, but there
+	 * are some hubs which needs to disable the power to the port before
+	 * starting the test.
+	 */
+	if (usb_device_match_id(hub_udev, ehset_hub_list)) {
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_CLEAR_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_ENABLE,
+					   portnum, NULL, 0, 1000, GFP_KERNEL);
+		/*
+		 * Wait for the port to be disabled. It's an arbitrary value
+		 * which worked every time.
+		 */
+		msleep(100);
+	} else {
+		/*
+		 * For the hubs which are compliant with the spec,
+		 * put the port in SUSPEND.
+		 */
+		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
+					   USB_RT_PORT, USB_PORT_FEAT_SUSPEND,
+					   portnum, NULL, 0, 1000, GFP_KERNEL);
+	}
+	return ret;
+}
+
 static int ehset_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -30,24 +76,36 @@ static int ehset_probe(struct usb_interface *intf,
 
 	switch (test_pid) {
 	case TEST_SE0_NAK_PID:
+		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
+		if (!ret)
+			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
 					   (USB_TEST_SE0_NAK << 8) | portnum,
 					   NULL, 0, 1000, GFP_KERNEL);
 		break;
 	case TEST_J_PID:
+		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
+		if (!ret)
+			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
 					   (USB_TEST_J << 8) | portnum, NULL, 0,
 					   1000, GFP_KERNEL);
 		break;
 	case TEST_K_PID:
+		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
+		if (!ret)
+			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
 					   (USB_TEST_K << 8) | portnum, NULL, 0,
 					   1000, GFP_KERNEL);
 		break;
 	case TEST_PACKET_PID:
+		ret = ehset_prepare_port_for_testing(hub_udev, portnum);
+		if (!ret)
+			break;
 		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
 					   USB_RT_PORT, USB_PORT_FEAT_TEST,
 					   (USB_TEST_PACKET << 8) | portnum,
-- 
2.34.1

