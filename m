Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5D64E6027
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348882AbiCXIPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348864AbiCXIPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:15:34 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9D36D4FD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:14:01 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220324081359epoutp0423f5a754877a5f06182cdd302046bada~fQvw6eN2u1030710307epoutp04B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:13:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220324081359epoutp0423f5a754877a5f06182cdd302046bada~fQvw6eN2u1030710307epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648109639;
        bh=e2S0AR6UBCgtXFPmuHvVKzU4rCbohW0LJAZA0Loq/YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PULPdX4AwzieW01ilRbW3rfRyeF8GgzoCQ4qhxB1cjnpBI5DeiYWwc280RrdAyuZk
         r2M9XVE+YI2VH/74jF65fT0tRmtSJA40Z3OCvzwMvhIn4T+BgGYbHuVczCxm8SHZQb
         uL02TE37UzQfW3d7g1XtOeGXJBQR1pR178lc440s=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220324081359epcas2p268c4a258c373fb043819c6037a51833c~fQvwhjL4U1822418224epcas2p2g;
        Thu, 24 Mar 2022 08:13:59 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KPJ030Fkcz4x9QG; Thu, 24 Mar
        2022 08:13:55 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.37.33036.F382C326; Thu, 24 Mar 2022 17:13:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220324081350epcas2p227458cb1b530f04a9990bcfc8c3b5703~fQvoosWXC1821118211epcas2p2P;
        Thu, 24 Mar 2022 08:13:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220324081350epsmtrp183017aa0b80e1fb6315d884a03a7b008~fQvon9KXN0419104191epsmtrp1Z;
        Thu, 24 Mar 2022 08:13:50 +0000 (GMT)
X-AuditID: b6c32a48-d10f0a800000810c-6d-623c283f3f2a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.26.03370.E382C326; Thu, 24 Mar 2022 17:13:50 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324081350epsmtip2965a363d8426755261811d2042f20be7~fQvoZtCDH1278212782epsmtip2D;
        Thu, 24 Mar 2022 08:13:50 +0000 (GMT)
From:   Oh Eomji <eomji.oh@samsung.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org (open list),
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Oh Eomji <eomji.oh@samsung.com>
Subject: [PATCH v1 3/3] sound: usb: Exynos usb audio offloading driver
Date:   Thu, 24 Mar 2022 17:10:44 +0900
Message-Id: <1648109444-196321-4-git-send-email-eomji.oh@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmha69hk2Swexb/BZXLh5isji1fCGT
        RfPi9WwWU34tZba4vGsOm8WBP4vZLDp39bNabPi+ltGBw2PD5yY2j52z7rJ7bFrVyeaxf+4a
        do99b5exefRtWcXosX7LVRaPz5vkAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
        LS3MlRTyEnNTbZVcfAJ03TJzgE5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
        F+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnrLmzhrHg9GLGihcXfzA2MH5qZexi5OSQEDCRWLz0
        EQuILSSwg1Fi88O0LkYuIPsTo8S8r8uZIJzPjBK7Lx+B67ix8CAjRGIXo0TTzRaoqh+MEof+
        nGUGqWITUJWYvmw7UBUHh4hAmcSy6ZYgNcwgK568W8oOUiMs4CZx5scjMJsFqL6vv4EVxOYV
        cJW4dPAHK8Q2OYmb5zqZQeZwAtX/eukOMkdC4BG7xJbOL1A1LhKvH3axQNjCEq+Ob2GHsKUk
        Xva3QdnFEgcXPGeDsGsk3h5shYobS8x61g52J7OApsT6XfogpoSAssSRW2ATmQX4JDoO/2WH
        CPNKdLQJQTQqSUxq6mSCsCUkVnxugrI9JKbP3csOCdCZjBLH/jpMYJSbhTB/ASPjKkax1ILi
        3PTUYqMCE3iEJefnbmIEpzwtjx2Ms99+0DvEyMTBeIhRgoNZSYT3/mXrJCHelMTKqtSi/Pii
        0pzU4kOMpsCQm8gsJZqcD0y6eSXxhiaWBiZmZobmRqYG5krivF4pGxKFBNITS1KzU1MLUotg
        +pg4OKUamE78iz+ops0z9aVDfXH22q63s5vCXz09cu1vXpf9FnnFz+X7k+zVw+ven/B0uzDb
        be/Ep9Nkd0klVtnzPNFTKYiUikqatDZoypTyqYtvLJ/2TTS36EH06hW/3gnFZmx+8CtoJ6/z
        xk3nJy1Y+LT/6w8udqOv06cph987bFsYZHuzeK/muUuKEqv6d+7UrflhIX3godp65VXz/lmp
        rBFZxnj06ovNiurfgk9N+nPfd8eGjuUbdO4/ErnR/ux0NGPne4nZM3uN8vb2rbKUnnJlYq9g
        VvoB/bCI3RN4Ellmv51XXmsqJffg31sW6bP+l/mfMx4/t61GSuvxHq/eueeNi9Zv4brgfp43
        7qxhHOMlXtVvSizFGYmGWsxFxYkAkXwGdgIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSvK6dhk2SwY52LYsrFw8xWZxavpDJ
        onnxejaLKb+WMltc3jWHzeLAn8VsFp27+lktNnxfy+jA4bHhcxObx85Zd9k9Nq3qZPPYP3cN
        u8e+t8vYPPq2rGL0WL/lKovH501yARxRXDYpqTmZZalF+nYJXBlr7qxhLDi9mLHixcUfjA2M
        n1oZuxg5OSQETCRuLDwIZHNxCAnsYJTYdW0JO0RCQmJB12tmCFtY4n7LEVYQW0jgG6PEtVk2
        IDabgKrE9GXbwQaJCFRI3Pq6nRlkELPAHkaJpqPNYM3CAm4SZ348AhvKAtTQ198ANohXwFXi
        0sEfrBAL5CRunusEqufg4ASq//XSHWKXq0T/y31sExj5FjAyrGKUTC0ozk3PLTYsMMpLLdcr
        TswtLs1L10vOz93ECA5QLa0djHtWfdA7xMjEwXiIUYKDWUmE9/5l6yQh3pTEyqrUovz4otKc
        1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamARuJKz/V+hYZFb6jCXzIPOyLtPn
        3gd/Z2/ZsehFYcSi//GBT8+F2HF+jCs/LyFoq5//ZiGX936T1x80TFq060UfXFzwbFnDKfNb
        bDrn6kPKJVkvfEz6bnW6VSR2j0rura8LegTv2V8/bi5r7XZt4R4rtsRZ73iMq9ZldRrPzutd
        KG7Nsn/SDf4Enr3sc3UtfKLn+7+QTkh7+9O+4ca+TH2Hbzt522xXm6Y51zrcWlhfvUP36oTQ
        Db/P9Nqw9W+ouvKkufMIo0eTn/JZ06+Ls44FXzphu+9uwlLzsCqFS9YLGf4/7Wh9eWumQe9b
        j74b9udf5kqv98i+dU1RVbHFulHTdLn5f7H7QWmhUZwXlViKMxINtZiLihMBDPe/c78CAAA=
X-CMS-MailID: 20220324081350epcas2p227458cb1b530f04a9990bcfc8c3b5703
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324081350epcas2p227458cb1b530f04a9990bcfc8c3b5703
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
        <CGME20220324081350epcas2p227458cb1b530f04a9990bcfc8c3b5703@epcas2p2.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is for usb audio offloading. usb audio offloading processes usb
audio stream data directly from the audio box even if ap usb enters
suspend, there is no problem in stream data transmission. This obtains
power saving effect while using usb audio device.

AP usb and audio usb f/w communicate via AUDIO IPC. By performing AUDIO
IPC in the vendor operations, abox can access and control the xhci to
transmit the data directly.

The types of commands and data delivered through AUDIO IPC include the
following (AP USB <-> AUDIO USB f/w) :
1. usb audio connection/disconnection status
2. xhci memory information
3. full descriptor for usb audio device
4. UAC(usb audio class) control command

Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
---
 sound/usb/Kconfig            |   9 +
 sound/usb/Makefile           |   2 +
 sound/usb/exynos_usb_audio.c | 560 +++++++++++++++++++++++++++++++++++++++++++
 sound/usb/exynos_usb_audio.h | 150 ++++++++++++
 4 files changed, 721 insertions(+)
 create mode 100644 sound/usb/exynos_usb_audio.c
 create mode 100644 sound/usb/exynos_usb_audio.h

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 059242f..70252a3 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -27,6 +27,15 @@ config SND_USB_AUDIO
 config SND_USB_AUDIO_USE_MEDIA_CONTROLLER
 	bool
 
+config SND_EXYNOS_USB_AUDIO
+	tristate "EXYNOS USB Audio offloading module"
+	depends on SND_USB_AUDIO
+	help
+	 Say Y here to include support for Exynos USB Audio ABOX offloading.
+
+	 To compile this driver as a module, choose M here: the module
+	 will be called exynos-usb-audio-offloading.
+
 config SND_USB_UA101
 	tristate "Edirol UA-101/UA-1000 driver"
 	select SND_PCM
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 9ccb21a..bf019c7 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -28,6 +28,8 @@ snd-usbmidi-lib-objs := midi.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-audio.o snd-usbmidi-lib.o
+obj-$(CONFIG_SND_EXYNOS_USB_AUDIO) += exynos-usb-audio-offloading.o
+exynos-usb-audio-offloading-y += exynos_usb_audio.o
 
 obj-$(CONFIG_SND_USB_UA101) += snd-usbmidi-lib.o
 obj-$(CONFIG_SND_USB_USX2Y) += snd-usbmidi-lib.o
diff --git a/sound/usb/exynos_usb_audio.c b/sound/usb/exynos_usb_audio.c
new file mode 100644
index 0000000..456cc78
--- /dev/null
+++ b/sound/usb/exynos_usb_audio.c
@@ -0,0 +1,560 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   USB Audio offloading Driver for Exynos
+ *
+ *   Copyright (c) 2017 by Kyounghye Yun <k-hye.yun@samsung.com>
+ *
+ */
+
+
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/usb.h>
+#include <linux/usb/audio.h>
+#include <linux/usb/audio-v2.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/completion.h>
+
+#include <sound/pcm.h>
+#include "../../../sound/usb/exynos_usb_audio.h"
+#include "usbaudio.h"
+#include "helper.h"
+#include "card.h"
+#include "quirks.h"
+
+static struct exynos_usb_audio *usb_audio;
+static struct snd_usb_audio_vendor_ops exynos_usb_audio_ops;
+
+struct hcd_hw_info *g_hwinfo;
+EXPORT_SYMBOL_GPL(g_hwinfo);
+int otg_connection;
+EXPORT_SYMBOL_GPL(otg_connection);
+int usb_audio_connection;
+EXPORT_SYMBOL_GPL(usb_audio_connection);
+
+static void exynos_usb_audio_set_device(struct usb_device *udev)
+{
+	usb_audio->udev = udev;
+	usb_audio->is_audio = 1;
+}
+
+static int exynos_usb_audio_unmap_all(void)
+{
+	/*
+	 * TODO: unmapping pcm buffer, usb descriptor, Device Context,
+	 * Input Context, ERST, URAM.
+	 */
+
+	return 0;
+}
+
+static int exynos_usb_audio_pcmbuf(struct usb_device *udev, int iface)
+{
+	if (!usb_audio->is_audio || !otg_connection)
+		return -1;
+
+	/*
+	 * TODO: Transmit the DRAM address that contains the xhci device
+	 * information,and the DMA address required for operation to the abox
+	 * usb f/w.
+	 */
+
+	return 0;
+}
+
+static int exynos_usb_audio_setrate(int iface, int rate, int alt)
+{
+	if (!usb_audio->is_audio || !otg_connection)
+		return -1;
+
+	/*
+	 * TODO: Notify the abox usb f/w the audio sample rate supported by
+	 * the interface of the connected audio device.
+	 */
+
+	return 0;
+}
+
+static int exynos_usb_audio_setintf(struct usb_device *udev, int iface, int alt, int direction)
+{
+	struct hcd_hw_info *hwinfo = g_hwinfo;
+	u64 in_offset, out_offset;
+
+	if (!usb_audio->pcm_open_done)
+		return -EPERM;
+
+	if (!usb_audio->is_audio || !otg_connection)
+		return -1;
+
+	if (direction) {
+		/* IN EP */
+		if (!usb_audio->indeq_map_done ||
+			(hwinfo->in_deq != hwinfo->old_in_deq)) {
+			/* TODO: Transmit pcm interface number, alt setting
+			 * number to abox usb f/w
+			 */
+			usb_audio->indeq_map_done = 1;
+			in_offset = hwinfo->in_deq % PAGE_SIZE;
+		}
+
+		if (hwinfo->fb_out_deq) {
+			if (!usb_audio->fb_outdeq_map_done ||
+					(hwinfo->fb_out_deq != hwinfo->fb_old_out_deq)) {
+				/* TODO: Transmit pcm interface number,
+				 * alt setting number to abox usb f/w
+				 */
+				usb_audio->fb_outdeq_map_done = 1;
+				out_offset = hwinfo->fb_out_deq % PAGE_SIZE;
+			}
+		}
+	} else {
+		/* OUT EP */
+		if (!usb_audio->outdeq_map_done ||
+			(hwinfo->out_deq != hwinfo->old_out_deq)) {
+			/* TODO: Transmit pcm interface number, alt setting
+			 * number to abox usb f/w
+			 */
+			usb_audio->outdeq_map_done = 1;
+			out_offset = hwinfo->out_deq % PAGE_SIZE;
+		}
+
+		if (hwinfo->fb_in_deq) {
+			if (!usb_audio->fb_indeq_map_done ||
+					(hwinfo->fb_in_deq != hwinfo->fb_old_in_deq)) {
+				/* TODO: Transmit pcm interface number,
+				 * alt setting number to abox usb f/w
+				 */
+				usb_audio->fb_indeq_map_done = 1;
+				in_offset = hwinfo->fb_in_deq % PAGE_SIZE;
+			}
+		}
+	}
+
+	/* one more check connection to prevent kernel panic */
+	if (!usb_audio->is_audio || !otg_connection)
+		return -1;
+
+	/* TODO: Notify abox usb f/w a dequeue pointer */
+
+	return 0;
+}
+
+static int exynos_usb_audio_hcd(struct usb_device *udev)
+{
+	struct hcd_hw_info *hwinfo = g_hwinfo;
+
+	/* back up each address for unmap */
+	usb_audio->dcbaa_dma = hwinfo->dcbaa_dma;
+	usb_audio->save_dma = hwinfo->save_dma;
+	usb_audio->in_ctx = hwinfo->in_ctx;
+	usb_audio->out_ctx = hwinfo->out_ctx;
+	usb_audio->erst_addr = hwinfo->erst_addr;
+	usb_audio->speed = hwinfo->speed;
+	usb_audio->use_uram = hwinfo->use_uram;
+
+	/*
+	 * TODO: DCBAA, Device Context, Input Context, URAM, ERST mapping
+	 * and notify abox usb f/w the address about xhci h/w resource to
+	 * directly control the xhci in abox.
+	 */
+
+	return 0;
+}
+
+static int exynos_usb_audio_desc(struct usb_device *udev)
+{
+	int configuration, cfgno, i;
+	unsigned char *buffer;
+	u64 desc_addr;
+	u64 offset;
+
+	configuration = usb_choose_configuration(udev);
+
+	cfgno = -1;
+	for (i = 0; i < udev->descriptor.bNumConfigurations; i++) {
+		if (udev->config[i].desc.bConfigurationValue ==
+				configuration) {
+			cfgno = i;
+			break;
+		}
+	}
+
+	if (cfgno == -1)
+		cfgno = 0;
+
+	/* need to memory mapping for usb descriptor */
+	buffer = udev->rawdescriptors[cfgno];
+	desc_addr = virt_to_phys(buffer);
+	offset = desc_addr % PAGE_SIZE;
+
+	/* store address information */
+	usb_audio->desc_addr = desc_addr;
+	usb_audio->offset = offset;
+
+	desc_addr -= offset;
+
+	/*
+	 * TODO: Notify the abox usb f/w that all descriptors have been recived
+	 * from the connected usb audio device, and that copy and memory mapping
+	 * have beed completed so that it can be used in abox usb f/w
+	 */
+
+	return 0;
+}
+
+static int exynos_usb_audio_conn(struct usb_device *udev, int is_conn)
+{
+
+	/* TODO: Notify abox usb f/w whether usb device is connected or not */
+	if (!is_conn) {
+		if (usb_audio->is_audio) {
+			usb_audio->is_audio = 0;
+			usb_audio->usb_audio_state = USB_AUDIO_REMOVING;
+		}
+	} else {
+		cancel_work_sync(&usb_audio->usb_work);
+		usb_audio->indeq_map_done = 0;
+		usb_audio->outdeq_map_done = 0;
+		usb_audio->fb_indeq_map_done = 0;
+		usb_audio->fb_outdeq_map_done = 0;
+		usb_audio->pcm_open_done = 0;
+		reinit_completion(&usb_audio->discon_done);
+		usb_audio->usb_audio_state = USB_AUDIO_CONNECT;
+		usb_audio_connection = 1;
+	}
+
+	return 0;
+}
+
+static int exynos_usb_audio_pcm(bool is_open, bool direction)
+{
+	if (!usb_audio->is_audio || !otg_connection)
+		return -1;
+
+	if (is_open)
+		usb_audio->pcm_open_done = 1;
+
+	/* TODO: Notify the abox usb f/w the pcm open/close status */
+
+	return 0;
+}
+
+static void exynos_usb_audio_work(struct work_struct *w)
+{
+	/* Don't unmap in USB_AUDIO_TIMEOUT_PROBE state */
+	if (usb_audio->usb_audio_state != USB_AUDIO_REMOVING)
+		return;
+
+	exynos_usb_audio_unmap_all();
+	usb_audio->usb_audio_state = USB_AUDIO_DISCONNECT;
+	usb_audio_connection = 0;
+	complete(&usb_audio->discon_done);
+}
+
+static int exynos_usb_scenario_ctl_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = AUDIO_MODE_NORMAL;
+	uinfo->value.integer.max = AUDIO_MODE_CALL_SCREEN;
+	return 0;
+}
+
+static int exynos_usb_scenario_ctl_get(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct exynos_usb_audio *usb = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = usb->user_scenario;
+	return 0;
+}
+
+static int exynos_usb_scenario_ctl_put(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct exynos_usb_audio *usb = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
+
+	if (usb->user_scenario !=
+	     ucontrol->value.integer.value[0]) {
+		usb->user_scenario = ucontrol->value.integer.value[0];
+		changed = 1;
+	}
+
+	return changed;
+}
+
+static int exynos_usb_add_ctls(struct snd_usb_audio *chip,
+				unsigned long private_value)
+{
+	struct snd_kcontrol_new knew = {
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.name = "USB Audio Mode",
+		.info = exynos_usb_scenario_ctl_info,
+		.get = exynos_usb_scenario_ctl_get,
+		.put = exynos_usb_scenario_ctl_put,
+	};
+
+	int err;
+
+	if (!chip)
+		return -ENODEV;
+
+	knew.private_value = private_value;
+	usb_audio->kctl = snd_ctl_new1(&knew, usb_audio);
+	if (!usb_audio->kctl)
+		return -ENOMEM;
+
+	err = snd_ctl_add(chip->card, usb_audio->kctl);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int exynos_usb_audio_init(struct device *dev, struct platform_device *pdev)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *np_abox;
+	struct platform_device *pdev_abox;
+	int ret = 0;
+
+	if (!usb_audio) {
+		usb_audio = kmalloc(sizeof(struct exynos_usb_audio), GFP_KERNEL);
+		if (!usb_audio)
+			return -ENOMEM;
+	}
+
+	np_abox = of_parse_phandle(np, "abox", 0);
+	if (!np_abox)
+		return -EPROBE_DEFER;
+
+	pdev_abox = of_find_device_by_node(np_abox);
+	if (!pdev_abox)
+		return -EPROBE_DEFER;
+
+	init_completion(&usb_audio->in_conn_stop);
+	init_completion(&usb_audio->out_conn_stop);
+	init_completion(&usb_audio->discon_done);
+	usb_audio->abox = pdev_abox;
+	usb_audio->hcd_pdev = pdev;
+	usb_audio->udev = NULL;
+	usb_audio->is_audio = 0;
+	usb_audio->is_first_probe = 1;
+	usb_audio->user_scenario = AUDIO_MODE_NORMAL;
+	usb_audio->usb_audio_state = USB_AUDIO_DISCONNECT;
+	usb_audio_connection = 0;
+
+	INIT_WORK(&usb_audio->usb_work, exynos_usb_audio_work);
+
+	/* interface function mapping */
+	ret = snd_vendor_set_ops(&exynos_usb_audio_ops);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(exynos_usb_audio_init);
+
+/* card */
+static int exynos_usb_audio_connect(struct usb_interface *intf)
+{
+	struct usb_interface_descriptor *altsd;
+	struct usb_host_interface *alts;
+	struct usb_device *udev = interface_to_usbdev(intf);
+	int timeout = 0;
+
+	alts = &intf->altsetting[0];
+	altsd = get_iface_desc(alts);
+
+	if ((altsd->bInterfaceClass == USB_CLASS_AUDIO ||
+		altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC) &&
+		altsd->bInterfaceSubClass == USB_SUBCLASS_MIDISTREAMING) {
+	} else {
+		if (usb_audio->usb_audio_state == USB_AUDIO_REMOVING) {
+			timeout = wait_for_completion_timeout(
+				&usb_audio->discon_done,
+				msecs_to_jiffies(DISCONNECT_TIMEOUT));
+
+			if ((usb_audio->usb_audio_state == USB_AUDIO_REMOVING)
+					&& !timeout) {
+				usb_audio->usb_audio_state =
+					USB_AUDIO_TIMEOUT_PROBE;
+			}
+		}
+
+		if ((usb_audio->usb_audio_state == USB_AUDIO_DISCONNECT)
+			|| (usb_audio->usb_audio_state == USB_AUDIO_TIMEOUT_PROBE)) {
+			exynos_usb_audio_set_device(udev);
+			exynos_usb_audio_hcd(udev);
+			exynos_usb_audio_conn(udev, 1);
+			exynos_usb_audio_desc(udev);
+		} else {
+			return -EPERM;
+		}
+	}
+
+	return 0;
+}
+
+static void exynos_usb_audio_disconn(struct usb_interface *intf)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+
+	exynos_usb_audio_conn(udev, 0);
+}
+
+/* clock */
+static int exynos_usb_audio_set_interface(struct usb_device *udev,
+		struct usb_host_interface *alts, int iface, int alt)
+{
+	unsigned char ep;
+	unsigned char numEndpoints;
+	int direction;
+	int i;
+	int ret = 0;
+
+	if (alts != NULL) {
+		numEndpoints = get_iface_desc(alts)->bNumEndpoints;
+		if (numEndpoints < 1)
+			return -22;
+		if (numEndpoints == 1)
+			ep = get_endpoint(alts, 0)->bEndpointAddress;
+		else {
+			for (i = 0; i < numEndpoints; i++) {
+				ep = get_endpoint(alts, i)->bmAttributes;
+				if (!(ep & 0x30)) {
+					ep = get_endpoint(alts, i)->bEndpointAddress;
+					break;
+				}
+			}
+		}
+		if (ep & USB_DIR_IN)
+			direction = SNDRV_PCM_STREAM_CAPTURE;
+		else
+			direction = SNDRV_PCM_STREAM_PLAYBACK;
+
+		ret = exynos_usb_audio_setintf(udev, iface, alt, direction);
+	}
+
+	return ret;
+}
+
+/* pcm */
+static int exynos_usb_audio_set_rate(int iface, int rate, int alt)
+{
+	int ret;
+
+	ret = exynos_usb_audio_setrate(iface, rate, alt);
+
+	return ret;
+}
+
+static int exynos_usb_audio_set_pcmbuf(struct usb_device *dev, int iface)
+{
+	int ret;
+
+	ret = exynos_usb_audio_pcmbuf(dev, iface);
+
+	return ret;
+}
+
+static int exynos_usb_audio_set_pcm_intf(struct usb_interface *intf,
+					int iface, int alt, int direction)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	int ret;
+
+	ret = exynos_usb_audio_setintf(udev, iface, alt, direction);
+
+	return ret;
+}
+
+static int exynos_usb_audio_pcm_control(struct usb_device *udev,
+			enum snd_vendor_pcm_open_close onoff, int direction)
+{
+	int ret = 0;
+
+	if (onoff == 1) {
+		ret = exynos_usb_audio_pcm(1, direction);
+	} else if (onoff == 0) {
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+			reinit_completion(&usb_audio->out_conn_stop);
+		else if (direction == SNDRV_PCM_STREAM_CAPTURE)
+			reinit_completion(&usb_audio->in_conn_stop);
+
+		if (!usb_audio->pcm_open_done)
+			return 0;
+
+		ret = exynos_usb_audio_pcm(0, direction);
+	}
+
+	return ret;
+}
+
+static int exynos_usb_audio_add_control(struct snd_usb_audio *chip)
+{
+	int ret;
+
+	if (chip != NULL)
+		ret = exynos_usb_add_ctls(chip, 0);
+	else
+		ret = usb_audio->user_scenario;
+
+	return ret;
+}
+
+static int exynos_usb_audio_set_pcm_binterval(const struct audioformat *fp,
+				 const struct audioformat *found,
+				 int *cur_attr, int *attr)
+{
+	if (usb_audio->user_scenario >= AUDIO_MODE_IN_CALL) {
+		if (fp->datainterval < found->datainterval) {
+			found = fp;
+			cur_attr = attr;
+		}
+	} else {
+		if (fp->datainterval > found->datainterval) {
+			found = fp;
+			cur_attr = attr;
+		}
+	}
+
+	return 0;
+}
+
+/* Set interface function */
+static struct snd_usb_audio_vendor_ops exynos_usb_audio_ops = {
+	/* card */
+	.connect = exynos_usb_audio_connect,
+	.disconnect = exynos_usb_audio_disconn,
+	/* clock */
+	.set_interface = exynos_usb_audio_set_interface,
+	/* pcm */
+	.set_rate = exynos_usb_audio_set_rate,
+	.set_pcm_buf = exynos_usb_audio_set_pcmbuf,
+	.set_pcm_intf = exynos_usb_audio_set_pcm_intf,
+	.set_pcm_connection = exynos_usb_audio_pcm_control,
+	.set_pcm_binterval = exynos_usb_audio_set_pcm_binterval,
+	.usb_add_ctls = exynos_usb_audio_add_control,
+};
+
+int exynos_usb_audio_exit(void)
+{
+	/* future use */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(exynos_usb_audio_exit);
+
+MODULE_AUTHOR("Jaehun Jung <jh0801.jung@samsung.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Exynos USB Audio offloading driver");
+
diff --git a/sound/usb/exynos_usb_audio.h b/sound/usb/exynos_usb_audio.h
new file mode 100644
index 0000000..13707744
--- /dev/null
+++ b/sound/usb/exynos_usb_audio.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*   USB Audio Driver for Exynos
+ *
+ *   Copyright (c) 2017 by Kyounghye Yun <k-hye.yun@samsung.com>
+ *
+ */
+
+#ifndef __LINUX_USB_EXYNOS_AUDIO_H
+#define __LINUX_USB_EXYNOS_AUDIO_H
+
+#include "../../../sound/usb/usbaudio.h"
+
+/* for KM */
+
+#define USB_AUDIO_MEM_BASE	0xC0000000
+
+#define USB_AUDIO_SAVE_RESTORE	(USB_AUDIO_MEM_BASE)
+#define USB_AUDIO_DEV_CTX	(USB_AUDIO_SAVE_RESTORE+PAGE_SIZE)
+#define USB_AUDIO_INPUT_CTX	(USB_AUDIO_DEV_CTX+PAGE_SIZE)
+#define USB_AUDIO_OUT_DEQ	(USB_AUDIO_INPUT_CTX+PAGE_SIZE)
+#define USB_AUDIO_IN_DEQ	(USB_AUDIO_OUT_DEQ+PAGE_SIZE)
+#define USB_AUDIO_FBOUT_DEQ	(USB_AUDIO_IN_DEQ+PAGE_SIZE)
+#define USB_AUDIO_FBIN_DEQ	(USB_AUDIO_FBOUT_DEQ+PAGE_SIZE)
+#define USB_AUDIO_ERST		(USB_AUDIO_FBIN_DEQ+PAGE_SIZE)
+#define USB_AUDIO_DESC		(USB_AUDIO_ERST+PAGE_SIZE)
+#define USB_AUDIO_PCM_OUTBUF	(USB_AUDIO_MEM_BASE+0x100000)
+#define USB_AUDIO_PCM_INBUF	(USB_AUDIO_MEM_BASE+0x800000)
+
+#if defined(CONFIG_SOC_S5E9815)
+#define USB_AUDIO_XHCI_BASE	0x12210000
+#define USB_URAM_BASE		0x122a0000
+#define USB_URAM_SIZE		(SZ_1K * 24)
+#elif defined(CONFIG_SOC_S5E9935)
+#define USB_AUDIO_XHCI_BASE	0x10B00000
+#define USB_URAM_BASE		0x02a00000
+#define USB_URAM_SIZE		(SZ_1K * 24)
+#else
+#error
+#endif
+
+#define USB_AUDIO_CONNECT		(1 << 0)
+#define USB_AUDIO_REMOVING		(1 << 1)
+#define USB_AUDIO_DISCONNECT		(1 << 2)
+#define USB_AUDIO_TIMEOUT_PROBE	(1 << 3)
+
+#define DISCONNECT_TIMEOUT	(500)
+
+#define AUDIO_MODE_NORMAL		0
+#define AUDIO_MODE_RINGTONE		1
+#define AUDIO_MODE_IN_CALL		2
+#define AUDIO_MODE_IN_COMMUNICATION	3
+#define AUDIO_MODE_CALL_SCREEN		4
+
+#define	CALL_INTERVAL_THRESHOLD		3
+
+#define USB_AUDIO_CONNECT		(1 << 0)
+#define USB_AUDIO_REMOVING		(1 << 1)
+#define USB_AUDIO_DISCONNECT		(1 << 2)
+#define USB_AUDIO_TIMEOUT_PROBE	(1 << 3)
+
+#define DISCONNECT_TIMEOUT	(500)
+
+struct host_data {
+	dma_addr_t out_data_dma;
+	dma_addr_t in_data_dma;
+	void *out_data_addr;
+	void *in_data_addr;
+};
+
+extern struct host_data xhci_data;
+
+struct exynos_usb_audio {
+	struct usb_device *udev;
+	struct platform_device *abox;
+	struct platform_device *hcd_pdev;
+	struct mutex    lock;
+	struct work_struct usb_work;
+	struct completion in_conn_stop;
+	struct completion out_conn_stop;
+	struct completion discon_done;
+
+	u64 out_buf_addr;
+	u64 in_buf_addr;
+	u64 pcm_offset;
+	u64 desc_addr;
+	u64 offset;
+
+	/* for hw_info */
+	u64 dcbaa_dma;
+	u64 in_ctx;
+	u64 out_ctx;
+	u64 erst_addr;
+
+	int speed;
+	/* 1: in, 0: out */
+	int set_ep;
+	int is_audio;
+	int is_first_probe;
+	u8 indeq_map_done;
+	u8 outdeq_map_done;
+	u8 fb_indeq_map_done;
+	u8 fb_outdeq_map_done;
+	u32 pcm_open_done;
+	u32 usb_audio_state;
+
+	struct snd_kcontrol *kctl;
+	u32 user_scenario;
+
+	void *pcm_buf;
+	u64 save_dma;
+
+	bool use_uram;
+};
+
+struct hcd_hw_info {
+	/* for XHCI */
+	int slot_id;
+	dma_addr_t erst_addr;
+	dma_addr_t dcbaa_dma;
+	dma_addr_t in_ctx;
+	dma_addr_t out_ctx;
+	dma_addr_t save_dma;
+	u64 cmd_ring;
+	/* Data Stream EP */
+	u64 old_out_deq;
+	u64 old_in_deq;
+	u64 out_deq;
+	u64 in_deq;
+	int in_ep;
+	int out_ep;
+	/* feedback ep */
+	int fb_in_ep;
+	int fb_out_ep;
+	u64 fb_old_out_deq;
+	u64 fb_old_in_deq;
+	u64 fb_out_deq;
+	u64 fb_in_deq;
+	/* Device Common Information */
+	int speed;
+	void *out_buf;
+	u64 out_dma;
+	void *in_buf;
+	u64 in_dma;
+	int use_uram;
+	int rawdesc_length;
+};
+
+int exynos_usb_audio_init(struct device *dev, struct platform_device *pdev);
+int exynos_usb_audio_exit(void);
+#endif /* __LINUX_USB_EXYNOS_AUDIO_H */
-- 
2.7.4

