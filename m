Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B614955CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377761AbiATVJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiATVJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:09:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C844C061574;
        Thu, 20 Jan 2022 13:09:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9E67B81E66;
        Thu, 20 Jan 2022 21:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEC3C340E0;
        Thu, 20 Jan 2022 21:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642712966;
        bh=gvKJNFWH+rntYZyayUFG04Y21zNp8GkFCMeuh1tSq1o=;
        h=Date:From:To:Cc:Subject:From;
        b=rTNcSXOaMkn7HtA/lElfF2YmeFt5wt3AfTQtPpIiBkZ6WE7Z30VhfKlE2ETkyEzkA
         mVI3CN7lWYa6DpY1+rv0szN+INL2Ts4o1mZjxmV03qpvoCoUE0CJhmMUth91es9r5F
         k7EwNDgqRSP6NzqgmoudknZ0BC/QbxEHIR/5bHcsaLQvgH9o8D+ubX7urAZrdV6Bh9
         T03m0TiN3BDnCe1UXk84KlftBFKVV8ZvJmDY8GAOxCejCRY98U/PYU5rQaCzwxQb3O
         OZGoQrOHXjlE4mKWLATHx66Sw5kbl1zE7t3UKhUgt7j8IGIHYPlLTEBhNadVOw4Wy9
         Hb+7Ee+WMA9Gw==
Date:   Thu, 20 Jan 2022 15:16:00 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] ALSA: usb-audio: scarlett2: Use struct_size()
 helper in scarlett2_usb()
Message-ID: <20220120211600.GA28841@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
sound/usb/mixer_scarlett_gen2.c:1064:28: warning: using sizeof on a flexible structure
sound/usb/mixer_scarlett_gen2.c:1065:29: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use correct format specifier %zu for type size_t argument.

 sound/usb/mixer_scarlett_gen2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 53ebabf42472..7ff8a4817c67 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1061,9 +1061,9 @@ static int scarlett2_usb(
 {
 	struct scarlett2_data *private = mixer->private_data;
 	struct usb_device *dev = mixer->chip->dev;
-	u16 req_buf_size = sizeof(struct scarlett2_usb_packet) + req_size;
-	u16 resp_buf_size = sizeof(struct scarlett2_usb_packet) + resp_size;
 	struct scarlett2_usb_packet *req, *resp = NULL;
+	size_t req_buf_size = struct_size(req, data, req_size);
+	size_t resp_buf_size = struct_size(resp, data, resp_size);
 	int err;
 
 	req = kmalloc(req_buf_size, GFP_KERNEL);
@@ -1111,7 +1111,7 @@ static int scarlett2_usb(
 		usb_audio_err(
 			mixer->chip,
 			"Scarlett Gen 2/3 USB response result cmd %x was %d "
-			"expected %d\n",
+			"expected %zu\n",
 			cmd, err, resp_buf_size);
 		err = -EINVAL;
 		goto unlock;
-- 
2.27.0

