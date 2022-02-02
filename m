Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207EC4A6FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiBBL16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:27:58 -0500
Received: from relay035.a.hostedemail.com ([64.99.140.35]:43331 "EHLO
        relay4.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiBBL1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:27:55 -0500
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 36D1D1204E3;
        Wed,  2 Feb 2022 11:27:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 31AAA2001F;
        Wed,  2 Feb 2022 11:27:54 +0000 (UTC)
Message-ID: <2132d97ca8d4dd5ac9426cc23af95e819079b02c.camel@perches.com>
Subject: [PATCH] usb: gadget: f_uac2: Neaten and reduce size of
 afunc_validate_opts
From:   Joe Perches <joe@perches.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Feb 2022 03:27:53 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 31AAA2001F
X-Spam-Status: No, score=0.10
X-Stat-Signature: gc3wm1fcagg5ghyrk6h9935b4g98p5ec
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+tg98Iz6SbLaGINvM6dRk6Lmq3iivjAtE=
X-HE-Tag: 1643801274-810819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repetition and reduce the object size a bit.

$ size drivers/usb/gadget/function/f_uac2.o* (x86-64 defconfig with gadget)
   text	   data	    bss	    dec	    hex	filename
  24515	   3136	     16	  27667	   6c13	drivers/usb/gadget/function/f_uac2.o.new
  24817	   3136	     16	  27969	   6d41	drivers/usb/gadget/function/f_uac2.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/usb/gadget/function/f_uac2.c | 91 +++++++++++++++---------------------
 1 file changed, 38 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index f2237bcdba7c0..1ee06d40059c1 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -973,59 +973,44 @@ static void setup_descriptor(struct f_uac2_opts *opts)
 static int afunc_validate_opts(struct g_audio *agdev, struct device *dev)
 {
 	struct f_uac2_opts *opts = g_audio_to_uac2_opts(agdev);
-
-	if (!opts->p_chmask && !opts->c_chmask) {
-		dev_err(dev, "Error: no playback and capture channels\n");
-		return -EINVAL;
-	} else if (opts->p_chmask & ~UAC2_CHANNEL_MASK) {
-		dev_err(dev, "Error: unsupported playback channels mask\n");
-		return -EINVAL;
-	} else if (opts->c_chmask & ~UAC2_CHANNEL_MASK) {
-		dev_err(dev, "Error: unsupported capture channels mask\n");
-		return -EINVAL;
-	} else if ((opts->p_ssize < 1) || (opts->p_ssize > 4)) {
-		dev_err(dev, "Error: incorrect playback sample size\n");
-		return -EINVAL;
-	} else if ((opts->c_ssize < 1) || (opts->c_ssize > 4)) {
-		dev_err(dev, "Error: incorrect capture sample size\n");
-		return -EINVAL;
-	} else if (!opts->p_srates[0]) {
-		dev_err(dev, "Error: incorrect playback sampling rate\n");
-		return -EINVAL;
-	} else if (!opts->c_srates[0]) {
-		dev_err(dev, "Error: incorrect capture sampling rate\n");
-		return -EINVAL;
-	}
-
-	if (opts->p_volume_max <= opts->p_volume_min) {
-		dev_err(dev, "Error: incorrect playback volume max/min\n");
-			return -EINVAL;
-	} else if (opts->c_volume_max <= opts->c_volume_min) {
-		dev_err(dev, "Error: incorrect capture volume max/min\n");
-			return -EINVAL;
-	} else if (opts->p_volume_res <= 0) {
-		dev_err(dev, "Error: negative/zero playback volume resolution\n");
-			return -EINVAL;
-	} else if (opts->c_volume_res <= 0) {
-		dev_err(dev, "Error: negative/zero capture volume resolution\n");
-			return -EINVAL;
-	}
-
-	if ((opts->p_volume_max - opts->p_volume_min) % opts->p_volume_res) {
-		dev_err(dev, "Error: incorrect playback volume resolution\n");
-			return -EINVAL;
-	} else if ((opts->c_volume_max - opts->c_volume_min) % opts->c_volume_res) {
-		dev_err(dev, "Error: incorrect capture volume resolution\n");
-			return -EINVAL;
-	}
-
-	if ((opts->p_hs_bint < 0) || (opts->p_hs_bint > 4)) {
-		dev_err(dev, "Error: incorrect playback HS/SS bInterval (1-4: fixed, 0: auto)\n");
-		return -EINVAL;
-	}
-
-	if ((opts->c_hs_bint < 0) || (opts->c_hs_bint > 4)) {
-		dev_err(dev, "Error: incorrect capture HS/SS bInterval (1-4: fixed, 0: auto)\n");
+	const char *msg = NULL;
+
+	if (!opts->p_chmask && !opts->c_chmask)
+		msg = "no playback and capture channels";
+	else if (opts->p_chmask & ~UAC2_CHANNEL_MASK)
+		msg = "unsupported playback channels mask";
+	else if (opts->c_chmask & ~UAC2_CHANNEL_MASK)
+		msg = "unsupported capture channels mask";
+	else if ((opts->p_ssize < 1) || (opts->p_ssize > 4))
+		msg = "incorrect playback sample size";
+	else if ((opts->c_ssize < 1) || (opts->c_ssize > 4))
+		msg = "incorrect capture sample size";
+	else if (!opts->p_srates[0])
+		msg = "incorrect playback sampling rate";
+	else if (!opts->c_srates[0])
+		msg = "incorrect capture sampling rate";
+
+	else if (opts->p_volume_max <= opts->p_volume_min)
+		msg = "incorrect playback volume max/min";
+	else if (opts->c_volume_max <= opts->c_volume_min)
+		msg = "incorrect capture volume max/min";
+	else if (opts->p_volume_res <= 0)
+		msg = "negative/zero playback volume resolution";
+	else if (opts->c_volume_res <= 0)
+		msg = "negative/zero capture volume resolution";
+
+	else if ((opts->p_volume_max - opts->p_volume_min) % opts->p_volume_res)
+		msg = "incorrect playback volume resolution";
+	else if ((opts->c_volume_max - opts->c_volume_min) % opts->c_volume_res)
+		msg = "incorrect capture volume resolution";
+
+	else if ((opts->p_hs_bint < 0) || (opts->p_hs_bint > 4))
+		msg = "incorrect playback HS/SS bInterval (1-4: fixed, 0: auto)";
+	else if ((opts->c_hs_bint < 0) || (opts->c_hs_bint > 4))
+		msg = "incorrect capture HS/SS bInterval (1-4: fixed, 0: auto)";
+
+	if (msg) {
+		dev_err(dev, "Error: %s\n", msg);
 		return -EINVAL;
 	}
 


