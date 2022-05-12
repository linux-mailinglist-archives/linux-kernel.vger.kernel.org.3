Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA3A524954
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352209AbiELJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350593AbiELJnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:43:40 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0436D69703;
        Thu, 12 May 2022 02:43:35 -0700 (PDT)
Received: from jleng.ambarella.net (unknown [180.169.129.130])
        by mail-app3 (Coremail) with SMTP id cC_KCgB3G7iS1nxi0gENAA--.40474S2;
        Thu, 12 May 2022 17:42:49 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     gregkh@linuxfoundation.org, corbet@lwn.net,
        laurent.pinchart@ideasonboard.com, balbi@kernel.org,
        rdunlap@infradead.org, mchehab+huawei@kernel.org, bilbao@vt.edu
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Jing Leng <jleng@ambarella.com>
Subject: [PATCH v2] usb: gadget: uvc: add bulk transfer support
Date:   Thu, 12 May 2022 17:42:36 +0800
Message-Id: <20220512094236.10937-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225070006.15090-1-3090101217@zju.edu.cn>
References: <20220225070006.15090-1-3090101217@zju.edu.cn>
X-CM-TRANSID: cC_KCgB3G7iS1nxi0gENAA--.40474S2
X-Coremail-Antispam: 1UD129KBjvAXoWfXr18GrW7GFWUur4DtFW3GFg_yoW8CFW8Jo
        WUXFs8W3W8Zr1rXFn3CF1qg3y5Ar4Ikrn8tws8Jr45W3W0v39Iq343Ja18WF43uF47JFyk
        Gw10qrs8Was5Ka45n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOr7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
        1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0
        I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAac4AC6xC2jxv24VCS
        YI8q64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64
        k0F24lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
        43ZEXa7IU5ZYFtUUUUU==
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIIBVNG3GszGAAAsF
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

The video data endpoint of uvc can be implemented as either an
isochronous or a bulk endpoint.

The transmission speed of bulk mode is faster than isochronous mode.
I tested the speed with cdns3 (USB 3.2 Gen1), it's difficult to reach
2 Gbps in the isochronous mode, and it can exceed 4 Gbps in the bulk
mode.

A VideoStreaming interface with isochronous endpoints must have alternate
settings that can be used to change certain characteristics of the
interface and underlying endpoint(s). A typical use of alternate settings
is to provide a way to change the bandwidth requirements an active
isochronous pipe imposes on the USB.

A VideoStreaming interface containing a bulk endpoint for streaming shall
support only alternate setting zero. Additional alternate settings
containing bulk endpoints are not permitted in a device that is compliant
with the Video Class specification.

In user space, isochronous/bulk modes are handled a little differently:

1. APP prepares buffers and streams when it receives an UVC_EVENT_STREAMON
message in the isochronous mode, but APP should do them when it receives a
SET_CUR request of UVC_VS_COMMIT_CONTROL due to no UVC_EVENT_STREAMON
message reported from the kernel in the bulk mode (Do them only once).

2. In Addition, APP should set the value of dwMaxPayloadTransferSize to
streaming_maxpacket in the isochronous mode or streaming_bulk_mult * 1024
in the bulk mode.

Here shows an example of the configfs differences:
  if [ $BULK -eq 1 ]; then
      echo 128 > functions/$FUNC/streaming_bulk_mult
  else
      echo 1024 > functions/$FUNC/streaming_maxpacket
  fi

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
ChangeLog v1->v2:
- Handle imagesize in uvc_v4l2_set_format. If it's not handled,
- switching from low resolution to high resolution will fail to play.
---
 .../ABI/testing/configfs-usb-gadget-uvc       |   1 +
 Documentation/usb/gadget-testing.rst          |   4 +
 drivers/usb/gadget/function/f_uvc.c           | 245 ++++++++++++------
 drivers/usb/gadget/function/u_uvc.h           |   1 +
 drivers/usb/gadget/function/uvc_configfs.c    |   2 +
 drivers/usb/gadget/function/uvc_queue.c       |   4 +-
 drivers/usb/gadget/function/uvc_v4l2.c        |   8 +
 7 files changed, 183 insertions(+), 82 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
index 889ed45be4ca..52ca04a619ff 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
@@ -7,6 +7,7 @@ Description:	UVC function directory
 		streaming_maxburst	0..15 (ss only)
 		streaming_maxpacket	1..1023 (fs), 1..3072 (hs/ss)
 		streaming_interval	1..16
+		streaming_bulk_mult	0..0x3fffffU
 		===================	=============================
 
 What:		/config/usb-gadget/gadget/functions/uvc.name/control
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index c6d034abce3a..2cbe3e2e05c3 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -787,6 +787,10 @@ The uvc function provides these attributes in its function directory:
 	streaming_maxpacket maximum packet size this endpoint is capable of
 			    sending or receiving when this configuration is
 			    selected
+	streaming_bulk_mult Multiples to configure max_payload_size. If it's
+			    0, the transport mode is isochronous; otherwise
+			    the transport mode is bulk and max_payload_size
+			    is equal to streaming_bulk_mult * 1024.
 	=================== ================================================
 
 There are also "control" and "streaming" subdirectories, each of which contain
diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 71bb5e477dba..61a05aa301ec 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -178,19 +178,19 @@ static struct usb_ss_ep_comp_descriptor uvc_ss_streaming_comp = {
 	 */
 };
 
-static const struct usb_descriptor_header * const uvc_fs_streaming[] = {
+static const struct usb_descriptor_header *uvc_fs_streaming[] = {
 	(struct usb_descriptor_header *) &uvc_streaming_intf_alt1,
 	(struct usb_descriptor_header *) &uvc_fs_streaming_ep,
 	NULL,
 };
 
-static const struct usb_descriptor_header * const uvc_hs_streaming[] = {
+static const struct usb_descriptor_header *uvc_hs_streaming[] = {
 	(struct usb_descriptor_header *) &uvc_streaming_intf_alt1,
 	(struct usb_descriptor_header *) &uvc_hs_streaming_ep,
 	NULL,
 };
 
-static const struct usb_descriptor_header * const uvc_ss_streaming[] = {
+static const struct usb_descriptor_header *uvc_ss_streaming[] = {
 	(struct usb_descriptor_header *) &uvc_streaming_intf_alt1,
 	(struct usb_descriptor_header *) &uvc_ss_streaming_ep,
 	(struct usb_descriptor_header *) &uvc_ss_streaming_comp,
@@ -251,9 +251,12 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 
 void uvc_function_setup_continue(struct uvc_device *uvc)
 {
+	struct f_uvc_opts *opts = fi_to_f_uvc_opts(uvc->func.fi);
 	struct usb_composite_dev *cdev = uvc->func.config->cdev;
 
-	usb_composite_setup_continue(cdev);
+	/* delayed_status in bulk mode is 0, so it doesn't need to continue. */
+	if (!opts->streaming_bulk_mult)
+		usb_composite_setup_continue(cdev);
 }
 
 static int
@@ -278,6 +281,7 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 	struct usb_composite_dev *cdev = f->config->cdev;
 	struct v4l2_event v4l2_event;
 	struct uvc_event *uvc_event = (void *)&v4l2_event.u.data;
+	struct f_uvc_opts *opts = fi_to_f_uvc_opts(f->fi);
 	int ret;
 
 	uvcg_info(f, "%s(%u, %u)\n", __func__, interface, alt);
@@ -310,49 +314,72 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 	if (interface != uvc->streaming_intf)
 		return -EINVAL;
 
-	/* TODO
-	if (usb_endpoint_xfer_bulk(&uvc->desc.vs_ep))
-		return alt ? -EINVAL : 0;
-	*/
+	if (opts->streaming_bulk_mult) {
+		switch (alt) {
+		case 0:
+			if (uvc->state != UVC_STATE_CONNECTED)
+				return 0;
 
-	switch (alt) {
-	case 0:
-		if (uvc->state != UVC_STATE_STREAMING)
-			return 0;
+			if (!uvc->video.ep)
+				return -EINVAL;
 
-		if (uvc->video.ep)
+			uvcg_info(f, "reset UVC\n");
 			usb_ep_disable(uvc->video.ep);
 
-		memset(&v4l2_event, 0, sizeof(v4l2_event));
-		v4l2_event.type = UVC_EVENT_STREAMOFF;
-		v4l2_event_queue(&uvc->vdev, &v4l2_event);
+			ret = config_ep_by_speed(f->config->cdev->gadget,
+					&(uvc->func), uvc->video.ep);
+			if (ret)
+				return ret;
+			usb_ep_enable(uvc->video.ep);
 
-		uvc->state = UVC_STATE_CONNECTED;
-		return 0;
-
-	case 1:
-		if (uvc->state != UVC_STATE_CONNECTED)
+			memset(&v4l2_event, 0, sizeof(v4l2_event));
+			v4l2_event.type = UVC_EVENT_STREAMOFF;
+			v4l2_event_queue(&uvc->vdev, &v4l2_event);
 			return 0;
 
-		if (!uvc->video.ep)
+		default:
 			return -EINVAL;
+		}
+	} else {
+		switch (alt) {
+		case 0:
+			if (uvc->state != UVC_STATE_STREAMING)
+				return 0;
 
-		uvcg_info(f, "reset UVC\n");
-		usb_ep_disable(uvc->video.ep);
+			if (uvc->video.ep)
+				usb_ep_disable(uvc->video.ep);
 
-		ret = config_ep_by_speed(f->config->cdev->gadget,
-				&(uvc->func), uvc->video.ep);
-		if (ret)
-			return ret;
-		usb_ep_enable(uvc->video.ep);
+			memset(&v4l2_event, 0, sizeof(v4l2_event));
+			v4l2_event.type = UVC_EVENT_STREAMOFF;
+			v4l2_event_queue(&uvc->vdev, &v4l2_event);
 
-		memset(&v4l2_event, 0, sizeof(v4l2_event));
-		v4l2_event.type = UVC_EVENT_STREAMON;
-		v4l2_event_queue(&uvc->vdev, &v4l2_event);
-		return USB_GADGET_DELAYED_STATUS;
+			uvc->state = UVC_STATE_CONNECTED;
+			return 0;
 
-	default:
-		return -EINVAL;
+		case 1:
+			if (uvc->state != UVC_STATE_CONNECTED)
+				return 0;
+
+			if (!uvc->video.ep)
+				return -EINVAL;
+
+			uvcg_info(f, "reset UVC\n");
+			usb_ep_disable(uvc->video.ep);
+
+			ret = config_ep_by_speed(f->config->cdev->gadget,
+					&(uvc->func), uvc->video.ep);
+			if (ret)
+				return ret;
+			usb_ep_enable(uvc->video.ep);
+
+			memset(&v4l2_event, 0, sizeof(v4l2_event));
+			v4l2_event.type = UVC_EVENT_STREAMON;
+			v4l2_event_queue(&uvc->vdev, &v4l2_event);
+			return USB_GADGET_DELAYED_STATUS;
+
+		default:
+			return -EINVAL;
+		}
 	}
 }
 
@@ -598,57 +625,90 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	uvcg_info(f, "%s()\n", __func__);
 
 	opts = fi_to_f_uvc_opts(f->fi);
-	/* Sanity check the streaming endpoint module parameters.
-	 */
-	opts->streaming_interval = clamp(opts->streaming_interval, 1U, 16U);
-	opts->streaming_maxpacket = clamp(opts->streaming_maxpacket, 1U, 3072U);
-	opts->streaming_maxburst = min(opts->streaming_maxburst, 15U);
-
-	/* For SS, wMaxPacketSize has to be 1024 if bMaxBurst is not 0 */
-	if (opts->streaming_maxburst &&
-	    (opts->streaming_maxpacket % 1024) != 0) {
-		opts->streaming_maxpacket = roundup(opts->streaming_maxpacket, 1024);
-		uvcg_info(f, "overriding streaming_maxpacket to %d\n",
-			  opts->streaming_maxpacket);
-	}
 
-	/* Fill in the FS/HS/SS Video Streaming specific descriptors from the
-	 * module parameters.
-	 *
-	 * NOTE: We assume that the user knows what they are doing and won't
-	 * give parameters that their UDC doesn't support.
-	 */
-	if (opts->streaming_maxpacket <= 1024) {
-		max_packet_mult = 1;
-		max_packet_size = opts->streaming_maxpacket;
-	} else if (opts->streaming_maxpacket <= 2048) {
-		max_packet_mult = 2;
-		max_packet_size = opts->streaming_maxpacket / 2;
+	/* Handle different transfer mode for stream endpoints */
+	if (opts->streaming_bulk_mult) {
+		uvc_fs_streaming_ep.bmAttributes = USB_ENDPOINT_XFER_BULK;
+		uvc_hs_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
+		uvc_ss_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
+
+		opts->streaming_maxburst = min(opts->streaming_maxburst, 15U);
+
+		uvc_fs_streaming_ep.wMaxPacketSize = cpu_to_le16(64);
+		uvc_fs_streaming_ep.bInterval = 0;
+
+		uvc_hs_streaming_ep.wMaxPacketSize = cpu_to_le16(512);
+		uvc_hs_streaming_ep.bInterval = 0;
+
+		uvc_ss_streaming_ep.wMaxPacketSize = cpu_to_le16(1024);
+		uvc_ss_streaming_ep.bInterval = 0;
+
+		uvc_ss_streaming_comp.bmAttributes = 0;
+		uvc_ss_streaming_comp.bMaxBurst = opts->streaming_maxburst;
+		uvc_ss_streaming_comp.wBytesPerInterval = 0;
+
+		uvc->video.max_payload_size = opts->streaming_bulk_mult * 1024;
 	} else {
-		max_packet_mult = 3;
-		max_packet_size = opts->streaming_maxpacket / 3;
-	}
+		uvc_fs_streaming_ep.bmAttributes = USB_ENDPOINT_SYNC_ASYNC
+						| USB_ENDPOINT_XFER_ISOC;
+		uvc_hs_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
+		uvc_ss_streaming_ep.bmAttributes = uvc_fs_streaming_ep.bmAttributes;
+
+		/* Sanity check the streaming endpoint module parameters.
+		 */
+		opts->streaming_interval = clamp(opts->streaming_interval, 1U, 16U);
+		opts->streaming_maxpacket = clamp(opts->streaming_maxpacket, 1U, 3072U);
+		opts->streaming_maxburst = min(opts->streaming_maxburst, 15U);
+
+		/* For SS, wMaxPacketSize has to be 1024 if bMaxBurst is not 0 */
+		if (opts->streaming_maxburst &&
+			(opts->streaming_maxpacket % 1024) != 0) {
+			opts->streaming_maxpacket = roundup(opts->streaming_maxpacket, 1024);
+			uvcg_info(f, "overriding streaming_maxpacket to %d\n",
+				opts->streaming_maxpacket);
+		}
 
-	uvc_fs_streaming_ep.wMaxPacketSize =
-		cpu_to_le16(min(opts->streaming_maxpacket, 1023U));
-	uvc_fs_streaming_ep.bInterval = opts->streaming_interval;
+		/* Fill in the FS/HS/SS Video Streaming specific descriptors from the
+		 * module parameters.
+		 *
+		 * NOTE: We assume that the user knows what they are doing and won't
+		 * give parameters that their UDC doesn't support.
+		 */
+
+		if (opts->streaming_maxpacket <= 1024) {
+			max_packet_mult = 0;
+			max_packet_size = opts->streaming_maxpacket;
+		} else if (opts->streaming_maxpacket <= 2048) {
+			max_packet_mult = 1;
+			max_packet_size = opts->streaming_maxpacket / 2;
+		} else {
+			max_packet_mult = 2;
+			max_packet_size = opts->streaming_maxpacket / 3;
+		}
 
-	uvc_hs_streaming_ep.wMaxPacketSize =
-		cpu_to_le16(max_packet_size | ((max_packet_mult - 1) << 11));
+		uvc_fs_streaming_ep.wMaxPacketSize =
+			cpu_to_le16(min(opts->streaming_maxpacket, 1023U));
+		uvc_fs_streaming_ep.bInterval = opts->streaming_interval;
 
-	/* A high-bandwidth endpoint must specify a bInterval value of 1 */
-	if (max_packet_mult > 1)
-		uvc_hs_streaming_ep.bInterval = 1;
-	else
-		uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
+		uvc_hs_streaming_ep.wMaxPacketSize =
+			cpu_to_le16(max_packet_size | (max_packet_mult << 11));
+		/* A high-bandwidth endpoint must specify a bInterval value of 1 */
+		if (max_packet_mult > 0)
+			uvc_hs_streaming_ep.bInterval = 1;
+		else
+			uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
+
+		uvc_ss_streaming_ep.wMaxPacketSize = cpu_to_le16(max_packet_size);
+		uvc_ss_streaming_ep.bInterval = opts->streaming_interval;
 
-	uvc_ss_streaming_ep.wMaxPacketSize = cpu_to_le16(max_packet_size);
-	uvc_ss_streaming_ep.bInterval = opts->streaming_interval;
-	uvc_ss_streaming_comp.bmAttributes = max_packet_mult - 1;
-	uvc_ss_streaming_comp.bMaxBurst = opts->streaming_maxburst;
-	uvc_ss_streaming_comp.wBytesPerInterval =
-		cpu_to_le16(max_packet_size * max_packet_mult *
-			    (opts->streaming_maxburst + 1));
+		uvc_ss_streaming_comp.bmAttributes = max_packet_mult;
+		uvc_ss_streaming_comp.bMaxBurst = opts->streaming_maxburst;
+		uvc_ss_streaming_comp.wBytesPerInterval =
+			cpu_to_le16(max_packet_size * (max_packet_mult + 1) *
+				(opts->streaming_maxburst + 1));
+
+		uvc->video.max_payload_size = 0;
+	}
 
 	/* Allocate endpoints. */
 	ep = usb_ep_autoconfig(cdev->gadget, &uvc_control_ep);
@@ -662,7 +722,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 		ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_ss_streaming_ep,
 					  &uvc_ss_streaming_comp);
 	else if (gadget_is_dualspeed(cdev->gadget))
-		ep = usb_ep_autoconfig(cdev->gadget, &uvc_hs_streaming_ep);
+		ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_hs_streaming_ep, NULL);
 	else
 		ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
 
@@ -703,6 +763,28 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	uvc->streaming_intf = ret;
 	opts->streaming_interface = ret;
 
+	/* Handle different transfer mode for descriptors */
+	i = 0;
+	if (opts->streaming_bulk_mult) {
+		uvc_streaming_intf_alt0.bNumEndpoints = 1;
+	} else {
+		uvc_streaming_intf_alt0.bNumEndpoints = 0;
+
+		uvc_fs_streaming[i] = USBDHDR(&uvc_streaming_intf_alt1);
+		uvc_hs_streaming[i] = USBDHDR(&uvc_streaming_intf_alt1);
+		uvc_ss_streaming[i] = USBDHDR(&uvc_streaming_intf_alt1);
+		++i;
+	}
+	uvc_fs_streaming[i] = USBDHDR(&uvc_fs_streaming_ep);
+	uvc_hs_streaming[i] = USBDHDR(&uvc_hs_streaming_ep);
+	uvc_ss_streaming[i] = USBDHDR(&uvc_ss_streaming_ep);
+	++i;
+	uvc_fs_streaming[i] = NULL;
+	uvc_hs_streaming[i] = NULL;
+	uvc_ss_streaming[i] = USBDHDR(&uvc_ss_streaming_comp);
+	++i;
+	uvc_ss_streaming[i] = NULL;
+
 	/* Copy descriptors */
 	f->fs_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_FULL);
 	if (IS_ERR(f->fs_descriptors)) {
@@ -866,6 +948,7 @@ static struct usb_function_instance *uvc_alloc_inst(void)
 
 	opts->streaming_interval = 1;
 	opts->streaming_maxpacket = 1024;
+	opts->streaming_bulk_mult = 0;
 
 	ret = uvcg_attach_configfs(opts);
 	if (ret < 0) {
diff --git a/drivers/usb/gadget/function/u_uvc.h b/drivers/usb/gadget/function/u_uvc.h
index 9a01a7d4f17f..5607a239d55e 100644
--- a/drivers/usb/gadget/function/u_uvc.h
+++ b/drivers/usb/gadget/function/u_uvc.h
@@ -24,6 +24,7 @@ struct f_uvc_opts {
 	unsigned int					streaming_interval;
 	unsigned int					streaming_maxpacket;
 	unsigned int					streaming_maxburst;
+	unsigned int					streaming_bulk_mult;
 
 	unsigned int					control_interface;
 	unsigned int					streaming_interface;
diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 77d64031aa9c..9b08e7b25168 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -2422,6 +2422,7 @@ UVC_ATTR(f_uvc_opts_, cname, cname)
 UVCG_OPTS_ATTR(streaming_interval, streaming_interval, 16);
 UVCG_OPTS_ATTR(streaming_maxpacket, streaming_maxpacket, 3072);
 UVCG_OPTS_ATTR(streaming_maxburst, streaming_maxburst, 15);
+UVCG_OPTS_ATTR(streaming_bulk_mult, streaming_bulk_mult, 0x3fffffU);
 
 #undef UVCG_OPTS_ATTR
 
@@ -2429,6 +2430,7 @@ static struct configfs_attribute *uvc_attrs[] = {
 	&f_uvc_opts_attr_streaming_interval,
 	&f_uvc_opts_attr_streaming_maxpacket,
 	&f_uvc_opts_attr_streaming_maxburst,
+	&f_uvc_opts_attr_streaming_bulk_mult,
 	NULL,
 };
 
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 2cda982f3765..98d0e933b5e1 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -135,7 +135,9 @@ int uvcg_queue_init(struct uvc_video_queue *queue, struct device *dev, enum v4l2
 	queue->queue.buf_struct_size = sizeof(struct uvc_buffer);
 	queue->queue.ops = &uvc_queue_qops;
 	queue->queue.lock = lock;
-	if (cdev->gadget->sg_supported) {
+
+	/* UDC supports scatter gather and transfer mode isn't bulk. */
+	if (cdev->gadget->sg_supported && !video->max_payload_size) {
 		queue->queue.mem_ops = &vb2_dma_sg_memops;
 		queue->use_sg = 1;
 	} else {
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a2c78690c5c2..767f1a2ace04 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -119,6 +119,14 @@ uvc_v4l2_set_format(struct file *file, void *fh, struct v4l2_format *fmt)
 	bpl = format->bpp * fmt->fmt.pix.width / 8;
 	imagesize = bpl ? bpl * fmt->fmt.pix.height : fmt->fmt.pix.sizeimage;
 
+	/*
+	 * Bulk mode only allocates memory once, so user should give the
+	 * maximum image size in all formats and kernel should not decrease
+	 * the imagesize.
+	 */
+	if (video->max_payload_size && imagesize < fmt->fmt.pix.sizeimage)
+		imagesize = fmt->fmt.pix.sizeimage;
+
 	video->fcc = format->fcc;
 	video->bpp = format->bpp;
 	video->width = fmt->fmt.pix.width;
-- 
2.17.1

