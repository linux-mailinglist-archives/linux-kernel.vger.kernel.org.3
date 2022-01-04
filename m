Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C42C4847EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiADSc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbiADScx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:32:53 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B9C061761;
        Tue,  4 Jan 2022 10:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=lxT6nZC1HPw9SagH/7xCX+OmMsi0Jahj6Y8adGP53mw=; b=Q2
        p+Pi+ue0KRfl4d3C986afG8aCxjgzbTmuAmWt9iBqIluqE+RxCrnYlU5n+kMzvcE/RvJL86hdc8Rr
        m/ZeCUBiwm1ArXnRRrBkCMcn1rrkGDARjTi0HFgWjcf1DC/vkNaQf0BXa+ExhvdcqPs16NqfRanuB
        Pi2eyUZKcSBwr62yoH3QQOjDVqRgkzws/KqRAq1YGFu4ZdOasYIbgN7QY6D2BH+TF1jUXvJUL2tZy
        VzrpgxfWstyDE4rNLDsaSlqC9Iuu6FeR8wjVg9kSp6rAoFwiPwn04/BIjROkYP6rxwbKlZTglZqvX
        LiFFnaanK2H7vjmVSuHrS3DVGPpCta1A==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1n4oc5-0002Jc-0W; Tue, 04 Jan 2022 18:32:49 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: u_audio: fix calculations for small bInterval
Date:   Tue,  4 Jan 2022 18:32:42 +0000
Message-Id: <20220104183243.718258-1-john@metanate.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bInterval is 1, then p_interval is 8000 and p_interval_mil is 8E9,
which is too big for a 32-bit value.  While the storage is indeed
64-bit, this value is used as the divisor in do_div() which will
truncate it into a uint32_t leading to incorrect calculated values.

Switch back to keeping the base value in struct snd_uac_chip which fits
easily into an int, meaning that the division can be done in two steps
with the divisor fitting safely into a uint32_t on both steps.

Fixes: 6fec018a7e70 ("usb: gadget: u_audio.c: Adding Playback Pitch ctl for sync playback")
Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/u_audio.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index c46400be5464..4fb05f9576a6 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -76,8 +76,8 @@ struct snd_uac_chip {
 	struct snd_pcm *pcm;
 
 	/* pre-calculated values for playback iso completion */
-	unsigned long long p_interval_mil;
 	unsigned long long p_residue_mil;
+	unsigned int p_interval;
 	unsigned int p_framesize;
 };
 
@@ -194,21 +194,24 @@ static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
 		 * If there is a residue from this division, add it to the
 		 * residue accumulator.
 		 */
+		unsigned long long p_interval_mil = uac->p_interval * 1000000ULL;
+
 		pitched_rate_mil = (unsigned long long)
 				params->p_srate * prm->pitch;
 		div_result = pitched_rate_mil;
-		do_div(div_result, uac->p_interval_mil);
+		do_div(div_result, uac->p_interval);
+		do_div(div_result, 1000000);
 		frames = (unsigned int) div_result;
 
 		pr_debug("p_srate %d, pitch %d, interval_mil %llu, frames %d\n",
-				params->p_srate, prm->pitch, uac->p_interval_mil, frames);
+				params->p_srate, prm->pitch, p_interval_mil, frames);
 
 		p_pktsize = min_t(unsigned int,
 					uac->p_framesize * frames,
 					ep->maxpacket);
 
 		if (p_pktsize < ep->maxpacket) {
-			residue_frames_mil = pitched_rate_mil - frames * uac->p_interval_mil;
+			residue_frames_mil = pitched_rate_mil - frames * p_interval_mil;
 			p_pktsize_residue_mil = uac->p_framesize * residue_frames_mil;
 		} else
 			p_pktsize_residue_mil = 0;
@@ -222,11 +225,11 @@ static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
 		 * size and decrease the accumulator.
 		 */
 		div_result = uac->p_residue_mil;
-		do_div(div_result, uac->p_interval_mil);
+		do_div(div_result, uac->p_interval);
+		do_div(div_result, 1000000);
 		if ((unsigned int) div_result >= uac->p_framesize) {
 			req->length += uac->p_framesize;
-			uac->p_residue_mil -= uac->p_framesize *
-					   uac->p_interval_mil;
+			uac->p_residue_mil -= uac->p_framesize * p_interval_mil;
 			pr_debug("increased req length to %d\n", req->length);
 		}
 		pr_debug("remains uac->p_residue_mil %llu\n", uac->p_residue_mil);
@@ -591,7 +594,7 @@ int u_audio_start_playback(struct g_audio *audio_dev)
 	unsigned int factor;
 	const struct usb_endpoint_descriptor *ep_desc;
 	int req_len, i;
-	unsigned int p_interval, p_pktsize;
+	unsigned int p_pktsize;
 
 	ep = audio_dev->in_ep;
 	prm = &uac->p_prm;
@@ -612,11 +615,10 @@ int u_audio_start_playback(struct g_audio *audio_dev)
 	/* pre-compute some values for iso_complete() */
 	uac->p_framesize = params->p_ssize *
 			    num_channels(params->p_chmask);
-	p_interval = factor / (1 << (ep_desc->bInterval - 1));
-	uac->p_interval_mil = (unsigned long long) p_interval * 1000000;
+	uac->p_interval = factor / (1 << (ep_desc->bInterval - 1));
 	p_pktsize = min_t(unsigned int,
 				uac->p_framesize *
-					(params->p_srate / p_interval),
+					(params->p_srate / uac->p_interval),
 				ep->maxpacket);
 
 	req_len = p_pktsize;
-- 
2.34.1

