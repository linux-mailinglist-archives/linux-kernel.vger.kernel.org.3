Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3754B9D81
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbiBQKrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:47:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiBQKrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:47:12 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2B313CB928;
        Thu, 17 Feb 2022 02:46:52 -0800 (PST)
Received: from jleng.ambarella.net (unknown [180.169.129.130])
        by mail-app3 (Coremail) with SMTP id cC_KCgB3f_MkJw5ipx9pDQ--.14217S2;
        Thu, 17 Feb 2022 18:44:57 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     gregkh@linuxfoundation.org, balbi@kernel.org, bilbao@vt.edu,
        corbet@lwn.net, laurent.pinchart@ideasonboard.com,
        mchehab+huawei@kernel.org, pawell@cadence.com,
        rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH v2] usb: gadget: uvc: add framebased stream support
Date:   Thu, 17 Feb 2022 18:44:50 +0800
Message-Id: <20220217104450.14372-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216081651.9089-1-3090101217@zju.edu.cn>
References: <20220216081651.9089-1-3090101217@zju.edu.cn>
X-CM-TRANSID: cC_KCgB3f_MkJw5ipx9pDQ--.14217S2
X-Coremail-Antispam: 1UD129KBjvAXoW3uw1UKrWrXF4UAr4UJr47urg_yoW8JrWfCo
        WftwnY9ry8ZryrAFyktrnaga48Zr1q9r15Jw4rGw1DWwnIvr45GryFya1jganYqr43KF4j
        qanaqrn8Aaykt3Z5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOF7k0a2IF6w1UM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
        1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0
        I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWlnxkEFVCFx7IYxxCE
        VcI25VAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rV
        AKj4xxMxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x07jYfOwUUUUU=
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIEBVNG3FjlrQAGsf
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

Currently the uvc gadget can't support H264/HEVC transport, After
adding framebased stream support, the driver can support them.

Framebased stream is a little different from uncompressed stream.
So we can support framebased stream on the basis of uncompressed stream.

Here are the differences:

1. For the format, framebased format has an extra member (
__u8 bVariableSize) than uncompressed format.

2. For the frame, the layout of last three members of framebased frame
is different from uncompressed frame.
a. Last three members of uncompressed frame are:
  u32	dw_max_video_frame_buffer_size;
  u32	dw_default_frame_interval;
  u8	b_frame_interval_type;
b. Last three members of framebased frame are:
  u32	dw_default_frame_interval;
  u8	b_frame_interval_type;
  u32	dw_bytes_perline;

Here is an example of configuring H264:

cd /sys/kernel/config/usb_gadget/g1
ndir=functions/uvc.usb0/streaming/uncompressed/$NAME
mkdir -p $ndir
echo -n "H264" > $ndir/guidFormat  # H264 or HEVC
echo 0 > $ndir/bBitsPerPixel
echo 1 > $ndir/bVariableSize
wdir=functions/uvc.usb0/streaming/uncompressed/$NAME/${HEIGHT}p
mkdir -p $wdir
echo 0 > $wdir/dwBytesPerLine
echo $WIDTH  > $wdir/wWidth
echo $HEIGHT > $wdir/wHeight
echo 29491200 > $wdir/dwMinBitRate
echo 29491200 > $wdir/dwMaxBitRate
cat <<EOF > $wdir/dwFrameInterval
$INTERVAL
EOF

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
ChangeLog v1->v2:
- Use another way to handle frames, previous implementation within
- using union has a warning. (Reported-by: kernel test robot <lkp@intel.com>)
---
 .../ABI/testing/configfs-usb-gadget-uvc       | 13 +++-
 drivers/usb/gadget/function/uvc_configfs.c    | 67 +++++++++++++++++--
 drivers/usb/gadget/function/uvc_v4l2.c        |  2 +
 include/uapi/linux/usb/video.h                |  3 +
 4 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
index 889ed45be4ca..2bf515dad516 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
@@ -243,7 +243,7 @@ Description:	Uncompressed format descriptors
 What:		/config/usb-gadget/gadget/functions/uvc.name/streaming/uncompressed/name
 Date:		Dec 2014
 KernelVersion:	4.0
-Description:	Specific uncompressed format descriptors
+Description:	Specific uncompressed/framebased format descriptors
 
 		==================	=======================================
 		bFormatIndex		unique id for this format descriptor;
@@ -264,12 +264,15 @@ Description:	Specific uncompressed format descriptors
 					frame
 		guidFormat		globally unique id used to identify
 					stream-encoding format
+		bVariableSize		whether the data within the frame is of
+					variable length from frame to frame (
+					only for framebased format)
 		==================	=======================================
 
 What:		/config/usb-gadget/gadget/functions/uvc.name/streaming/uncompressed/name/name
 Date:		Dec 2014
 KernelVersion:	4.0
-Description:	Specific uncompressed frame descriptors
+Description:	Specific uncompressed/framebased frame descriptors
 
 		=========================  =====================================
 		bFrameIndex		   unique id for this framedescriptor;
@@ -283,7 +286,11 @@ Description:	Specific uncompressed frame descriptors
 					   like to use as default
 		dwMaxVideoFrameBufferSize  the maximum number of bytes the
 					   compressor will produce for a video
-					   frame or still image
+					   frame or still image (only for
+					   uncompressed frame)
+		dwBytesPerLine		   the per-line bytes of the framebased
+					   frame, e.g. H264 or HEVC (only for
+					   framebased frame)
 		dwMaxBitRate		   the maximum bit rate at the shortest
 					   frame interval in bps
 		dwMinBitRate		   the minimum bit rate at the longest
diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 77d64031aa9c..695f9b68290f 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/sort.h>
+#include <linux/videodev2.h>
 
 #include "u_uvc.h"
 #include "uvc_configfs.h"
@@ -782,6 +783,8 @@ struct uvcg_format {
 	__u8			bmaControls[UVCG_STREAMING_CONTROL_SIZE];
 };
 
+static u8 uvcg_uncompressed_subtype(struct uvcg_format *fmt);
+
 static struct uvcg_format *to_uvcg_format(struct config_item *item)
 {
 	return container_of(to_config_group(item), struct uvcg_format, group);
@@ -1072,9 +1075,23 @@ struct uvcg_frame {
 		u16	w_height;
 		u32	dw_min_bit_rate;
 		u32	dw_max_bit_rate;
+
+		/*
+		 * The layout of last three members of framebased frame
+		 * is different from uncompressed frame.
+		 *   Last three members of uncompressed frame are:
+		 *     u32	dw_max_video_frame_buffer_size;
+		 *     u32	dw_default_frame_interval;
+		 *     u8	b_frame_interval_type;
+		 *   Last three members of framebased frame are:
+		 *     u32	dw_default_frame_interval;
+		 *     u8	b_frame_interval_type;
+		 *     u32	dw_bytes_perline;
+		 */
 		u32	dw_max_video_frame_buffer_size;
 		u32	dw_default_frame_interval;
 		u8	b_frame_interval_type;
+		u32	dw_bytes_perline;
 	} __attribute__((packed)) frame;
 	u32 *dw_frame_interval;
 };
@@ -1185,6 +1202,7 @@ UVCG_FRAME_ATTR(dw_min_bit_rate, dwMinBitRate, 32);
 UVCG_FRAME_ATTR(dw_max_bit_rate, dwMaxBitRate, 32);
 UVCG_FRAME_ATTR(dw_max_video_frame_buffer_size, dwMaxVideoFrameBufferSize, 32);
 UVCG_FRAME_ATTR(dw_default_frame_interval, dwDefaultFrameInterval, 32);
+UVCG_FRAME_ATTR(dw_bytes_perline, dwBytesPerLine, 32);
 
 #undef UVCG_FRAME_ATTR
 
@@ -1329,6 +1347,7 @@ static struct configfs_attribute *uvcg_frame_attrs[] = {
 	&uvcg_frame_attr_dw_max_video_frame_buffer_size,
 	&uvcg_frame_attr_dw_default_frame_interval,
 	&uvcg_frame_attr_dw_frame_interval,
+	&uvcg_frame_attr_dw_bytes_perline,
 	NULL,
 };
 
@@ -1358,6 +1377,7 @@ static struct config_item *uvcg_frame_make(struct config_group *group,
 	h->frame.dw_max_bit_rate		= 55296000;
 	h->frame.dw_max_video_frame_buffer_size	= 460800;
 	h->frame.dw_default_frame_interval	= 666666;
+	h->frame.dw_bytes_perline		= 0;
 
 	opts_item = group->cg_item.ci_parent->ci_parent->ci_parent;
 	opts = to_f_uvc_opts(opts_item);
@@ -1365,7 +1385,10 @@ static struct config_item *uvcg_frame_make(struct config_group *group,
 	mutex_lock(&opts->lock);
 	fmt = to_uvcg_format(&group->cg_item);
 	if (fmt->type == UVCG_UNCOMPRESSED) {
-		h->frame.b_descriptor_subtype = UVC_VS_FRAME_UNCOMPRESSED;
+		if (uvcg_uncompressed_subtype(fmt) == UVC_VS_FORMAT_UNCOMPRESSED)
+			h->frame.b_descriptor_subtype = UVC_VS_FRAME_UNCOMPRESSED;
+		else
+			h->frame.b_descriptor_subtype = UVC_VS_FRAME_FRAME_BASED;
 		h->fmt_type = UVCG_UNCOMPRESSED;
 	} else if (fmt->type == UVCG_MJPEG) {
 		h->frame.b_descriptor_subtype = UVC_VS_FRAME_MJPEG;
@@ -1425,6 +1448,14 @@ struct uvcg_uncompressed {
 	struct uvc_format_uncompressed	desc;
 };
 
+static u8 uvcg_uncompressed_subtype(struct uvcg_format *fmt)
+{
+	struct uvcg_uncompressed *ch = container_of(fmt,
+					struct uvcg_uncompressed, fmt);
+
+	return ch->desc.bDescriptorSubType;
+}
+
 static struct uvcg_uncompressed *to_uvcg_uncompressed(struct config_item *item)
 {
 	return container_of(
@@ -1466,6 +1497,7 @@ static ssize_t uvcg_uncompressed_guid_format_store(struct config_item *item,
 	struct f_uvc_opts *opts;
 	struct config_item *opts_item;
 	struct mutex *su_mutex = &ch->fmt.group.cg_subsys->su_mutex;
+	u32 fcc;
 	int ret;
 
 	mutex_lock(su_mutex); /* for navigating configfs hierarchy */
@@ -1481,7 +1513,17 @@ static ssize_t uvcg_uncompressed_guid_format_store(struct config_item *item,
 
 	memcpy(ch->desc.guidFormat, page,
 	       min(sizeof(ch->desc.guidFormat), len));
-	ret = sizeof(ch->desc.guidFormat);
+	ret = len;
+
+	fcc = v4l2_fourcc(ch->desc.guidFormat[0], ch->desc.guidFormat[1],
+		ch->desc.guidFormat[2], ch->desc.guidFormat[3]);
+	if (fcc == V4L2_PIX_FMT_H264 || fcc == V4L2_PIX_FMT_HEVC) {
+		ch->desc.bLength		= UVC_DT_FORMAT_FRAMEBASED_SIZE;
+		ch->desc.bDescriptorSubType	= UVC_VS_FORMAT_FRAME_BASED;
+	} else {
+		ch->desc.bLength		= UVC_DT_FORMAT_UNCOMPRESSED_SIZE;
+		ch->desc.bDescriptorSubType	= UVC_VS_FORMAT_UNCOMPRESSED;
+	}
 
 end:
 	mutex_unlock(&opts->lock);
@@ -1581,6 +1623,7 @@ UVCG_UNCOMPRESSED_ATTR(b_default_frame_index, bDefaultFrameIndex, 8);
 UVCG_UNCOMPRESSED_ATTR_RO(b_aspect_ratio_x, bAspectRatioX, 8);
 UVCG_UNCOMPRESSED_ATTR_RO(b_aspect_ratio_y, bAspectRatioY, 8);
 UVCG_UNCOMPRESSED_ATTR_RO(bm_interface_flags, bmInterfaceFlags, 8);
+UVCG_UNCOMPRESSED_ATTR(b_variable_size, bVariableSize, 8);
 
 #undef UVCG_UNCOMPRESSED_ATTR
 #undef UVCG_UNCOMPRESSED_ATTR_RO
@@ -1611,6 +1654,7 @@ static struct configfs_attribute *uvcg_uncompressed_attrs[] = {
 	&uvcg_uncompressed_attr_b_aspect_ratio_y,
 	&uvcg_uncompressed_attr_bm_interface_flags,
 	&uvcg_uncompressed_attr_bma_controls,
+	&uvcg_uncompressed_attr_b_variable_size,
 	NULL,
 };
 
@@ -1644,6 +1688,7 @@ static struct config_group *uvcg_uncompressed_make(struct config_group *group,
 	h->desc.bAspectRatioY		= 0;
 	h->desc.bmInterfaceFlags	= 0;
 	h->desc.bCopyProtect		= 0;
+	h->desc.bVariableSize		= 0;
 
 	h->fmt.type = UVCG_UNCOMPRESSED;
 	config_group_init_type_name(&h->fmt.group, name,
@@ -2038,7 +2083,7 @@ static int __uvcg_cnt_strm(void *priv1, void *priv2, void *priv3, int n,
 				container_of(fmt, struct uvcg_uncompressed,
 					     fmt);
 
-			*size += sizeof(u->desc);
+			*size += u->desc.bLength;
 		} else if (fmt->type == UVCG_MJPEG) {
 			struct uvcg_mjpeg *m =
 				container_of(fmt, struct uvcg_mjpeg, fmt);
@@ -2053,7 +2098,7 @@ static int __uvcg_cnt_strm(void *priv1, void *priv2, void *priv3, int n,
 		struct uvcg_frame *frm = priv1;
 		int sz = sizeof(frm->dw_frame_interval);
 
-		*size += sizeof(frm->frame);
+		*size += sizeof(frm->frame) - 4;
 		*size += frm->frame.b_frame_interval_type * sz;
 	}
 	break;
@@ -2108,8 +2153,8 @@ static int __uvcg_fill_strm(void *priv1, void *priv2, void *priv3, int n,
 
 			u->desc.bFormatIndex = n + 1;
 			u->desc.bNumFrameDescriptors = fmt->num_frames;
-			memcpy(*dest, &u->desc, sizeof(u->desc));
-			*dest += sizeof(u->desc);
+			memcpy(*dest, &u->desc, u->desc.bLength);
+			*dest += u->desc.bLength;
 		} else if (fmt->type == UVCG_MJPEG) {
 			struct uvcg_mjpeg *m =
 				container_of(fmt, struct uvcg_mjpeg, fmt);
@@ -2127,8 +2172,16 @@ static int __uvcg_fill_strm(void *priv1, void *priv2, void *priv3, int n,
 		struct uvcg_frame *frm = priv1;
 		struct uvc_descriptor_header *h = *dest;
 
-		sz = sizeof(frm->frame);
+		sz = sizeof(frm->frame) - 4;
 		memcpy(*dest, &frm->frame, sz);
+		/*
+		 * Framebased frame doesn't have dw_max_video_frame_buffer_size,
+		 * and has dw_bytes_perline, so we should handle the last three
+		 * members of frame descriptor.
+		 */
+		if (frm->frame.b_descriptor_subtype == UVC_VS_FRAME_FRAME_BASED)
+			memcpy((u8 *)*dest + 17, (u8 *)&frm->frame + 21, 9);
+
 		*dest += sz;
 		sz = frm->frame.b_frame_interval_type *
 			sizeof(*frm->dw_frame_interval);
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a2c78690c5c2..3d6217328c50 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -58,6 +58,8 @@ struct uvc_format {
 static struct uvc_format uvc_formats[] = {
 	{ 16, V4L2_PIX_FMT_YUYV  },
 	{ 0,  V4L2_PIX_FMT_MJPEG },
+	{ 0,  V4L2_PIX_FMT_H264 },
+	{ 0,  V4L2_PIX_FMT_HEVC },
 };
 
 static int
diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
index bfdae12cdacf..383980bc9618 100644
--- a/include/uapi/linux/usb/video.h
+++ b/include/uapi/linux/usb/video.h
@@ -468,9 +468,12 @@ struct uvc_format_uncompressed {
 	__u8  bAspectRatioY;
 	__u8  bmInterfaceFlags;
 	__u8  bCopyProtect;
+	/* bVariableSize is only for framebased format. */
+	__u8  bVariableSize;
 } __attribute__((__packed__));
 
 #define UVC_DT_FORMAT_UNCOMPRESSED_SIZE			27
+#define UVC_DT_FORMAT_FRAMEBASED_SIZE			28
 
 /* Uncompressed Payload - 3.1.2. Uncompressed Video Frame Descriptor */
 struct uvc_frame_uncompressed {
-- 
2.17.1

