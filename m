Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0124447BE65
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhLUKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:48:05 -0500
Received: from bosmailout01.eigbox.net ([66.96.184.1]:58687 "EHLO
        bosmailout01.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbhLUKsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:48:04 -0500
X-Greylist: delayed 1825 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 05:48:04 EST
Received: from bosmailscan04.eigbox.net ([10.20.15.4])
        by bosmailout01.eigbox.net with esmtp (Exim)
        id 1mzcDC-0006eL-4d; Tue, 21 Dec 2021 05:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ewhac.org;
         s=dkim; h=Sender:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:To:From:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EimLAUwkePQ+L+4urY/7QQSNoxw6K1rYTlIf2uEcgII=; b=nuD9TAtQVNpUE8sE8+luSzdmCP
        yFFCQ9K119CBWzAbZNtg1fohVA56+Lc92vewyCcBMASqYjxvXvsOpSCygPefye895P/33y4+tzj8H
        1df/0ZnKkIv6yA9oxm+VipQoxxQHaTr1IRKnsmd5A95ZX45mo5hfIIl/GsaPirkvHfVpjlYJ3eQAB
        oSBgcnPiiYPOZb24JHJKvztX067kPfKLtP/vvMlo67arkv3nPW3IV1NBOewoI9mEgrWUy+AKbRXb/
        FpFgq9FcGIPCCJT8vWcof0skUf2Ezbn7c8fdiU3G+LXTCSK13FzeauoF+QHencC2rmeOrSs7/Tbk5
        Q0ggIwyw==;
Received: from [10.115.3.33] (helo=bosimpout13)
        by bosmailscan04.eigbox.net with esmtp (Exim)
        id 1mzcDB-0002mx-Ss; Tue, 21 Dec 2021 05:17:37 -0500
Received: from bosauthsmtp10.yourhostingaccount.com ([10.20.18.10])
        by bosimpout13 with 
        id YyHa2600B0D2CUy01yHdXG; Tue, 21 Dec 2021 05:17:37 -0500
X-Authority-Analysis: v=2.3 cv=RNUo47q+ c=1 sm=1 tr=0
 a=Kpo39fPXdbgqDwiI3/AEUA==:117 a=lOZ7gjDonWBvovu+dU3iMA==:17
 a=IOMw9HtfNCkA:10 a=ltsmEuTAGloA:10 a=fmD_JHji_u0A:10 a=z5_pBHiqAAAA:8
 a=qn0TFzAFAAAA:8 a=pGLkceISAAAA:8 a=Pzg-1rgCefmo0o8-T2QA:9
 a=Ixuhb_GfD2BeaOSowo0a:22 a=HH7FIXwXL_sUf1zzYxQd:22 a=1ZDzRB_x0Jt2thgvHzGi:22
 a=bwAZncKOXFtojdMDTreG:22
Received: from [135.180.175.56] (port=57742 helo=exiguous.ewhac.net)
        by bosauthsmtp10.eigbox.net with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim)
        id 1mzcD8-00040G-H5; Tue, 21 Dec 2021 05:17:34 -0500
From:   "Leo L. Schwab" <ewhac@ewhac.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Leo L. Schwab" <ewhac@ewhac.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: spaceball - fix parsing of movement data packets
Date:   Tue, 21 Dec 2021 02:16:31 -0800
Message-Id: <20211221101630.1146385-1-ewhac@ewhac.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EN-UserInfo: a76222b247b80e113a63936ffdc903eb:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: ewhac@ewhac.org
Sender:  "Leo L. Schwab" <ewhac@ewhac.org>
X-EN-OrigIP: 135.180.175.56
X-EN-OrigHost: unknown
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spaceball.c module was not properly parsing the movement reports
coming from the device.  The code read axis data as signed 16-bit
little-endian values starting at offset 2.

In fact, axis data in Spaceball movement reports are signed 16-bit
big-endian values starting at offset 3.  This was determined first by
visually inspecting the data packets, and later verified by consulting:
http://spacemice.org/pdf/SpaceBall_2003-3003_Protocol.pdf

If this ever worked properly, it was in the time before Git...

Signed-off-by: Leo L. Schwab <ewhac@ewhac.org>
---
Changes in v2:
  - Coding style changes requested by <dmitry.torokhov@gmail.com>.

 drivers/input/joystick/spaceball.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
index 429411c6c0a8..10e09c86e067 100644
--- a/drivers/input/joystick/spaceball.c
+++ b/drivers/input/joystick/spaceball.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/input.h>
 #include <linux/serio.h>
+#include <asm/unaligned.h>
 
 #define DRIVER_DESC	"SpaceTec SpaceBall 2003/3003/4000 FLX driver"
 
@@ -74,10 +75,16 @@ static void spaceball_process_packet(struct spaceball* spaceball)
 	switch (spaceball->data[0]) {
 
 		case 'D':					/* Ball data */
+			/*
+			 * Skip first three bytes; read six axes worth of data.
+			 * Axis values are signed 16-bit big-endian.
+			 */
 			if (spaceball->idx != 15) return;
-			for (i = 0; i < 6; i++)
+			data += 3;
+			for (i = 0;  i < ARRAY_SIZE(spaceball_axes);  ++i) {
 				input_report_abs(dev, spaceball_axes[i],
-					(__s16)((data[2 * i + 3] << 8) | data[2 * i + 2]));
+					(__s16)get_unaligned_be16(&data[i * 2]));
+			}
 			break;
 
 		case 'K':					/* Button data */
-- 
2.34.1

