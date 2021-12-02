Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312394660FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356752AbhLBJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356771AbhLBJ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638438823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kj9zMm+zAL1WWOfU9rtJ9ZDFeM3bY3eWl1NrUXuGVTA=;
        b=Itej58EsB93PwQBNF1gFktBtgPSNb9jTl45JoSThP5TopskdVB6pDv+Xe9HJr+M97l7Qcv
        BglQVScT5OBpnESiDGwIl/QQggD+wlXs5EHO1zfqm2K2wRQpsH540XF/e4967omxmZ23Fs
        frGpMUJY2CKvu/kGAnNDFwwQ+1qB1lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-KDLgE4XxOqm0rxKfmwXwHQ-1; Thu, 02 Dec 2021 04:53:40 -0500
X-MC-Unique: KDLgE4XxOqm0rxKfmwXwHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8192E100C667;
        Thu,  2 Dec 2021 09:53:39 +0000 (UTC)
Received: from xps-13.redhat.com (unknown [10.39.195.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1178319729;
        Thu,  2 Dec 2021 09:53:37 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/4] HID: sony: fix error path in probe
Date:   Thu,  2 Dec 2021 10:53:31 +0100
Message-Id: <20211202095334.14399-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
References: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the setup of the GHL fails, we are not calling hid_hw_stop().
This leads to the hidraw node not being released, meaning a crash
whenever somebody attempts to open the file.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-sony.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index c186af552129..60ec2b29d54d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -3037,19 +3037,23 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 */
 	if (!(hdev->claimed & HID_CLAIMED_INPUT)) {
 		hid_err(hdev, "failed to claim input\n");
-		hid_hw_stop(hdev);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err;
 	}
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
-		if (!hid_is_usb(hdev))
-			return -EINVAL;
+		if (!hid_is_usb(hdev)) {
+			ret = -EINVAL;
+			goto err;
+		}
 
 		usbdev = to_usb_device(sc->hdev->dev.parent->parent);
 
 		sc->ghl_urb = usb_alloc_urb(0, GFP_ATOMIC);
-		if (!sc->ghl_urb)
-			return -ENOMEM;
+		if (!sc->ghl_urb) {
+			ret = -ENOMEM;
+			goto err;
+		}
 
 		if (sc->quirks & GHL_GUITAR_PS3WIIU)
 			ret = ghl_init_urb(sc, usbdev, ghl_ps3wiiu_magic_data,
@@ -3059,7 +3063,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 							   ARRAY_SIZE(ghl_ps4_magic_data));
 		if (ret) {
 			hid_err(hdev, "error preparing URB\n");
-			return ret;
+			goto err;
 		}
 
 		timer_setup(&sc->ghl_poke_timer, ghl_magic_poke, 0);
@@ -3068,6 +3072,10 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	return ret;
+
+err:
+	hid_hw_stop(hdev);
+	return ret;
 }
 
 static void sony_remove(struct hid_device *hdev)
-- 
2.33.1

