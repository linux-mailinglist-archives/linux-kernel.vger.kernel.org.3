Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234914BD178
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbiBTUbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:31:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243959AbiBTUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:31:07 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C838522D7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:30:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a23so27908791eju.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=duxIQa38l5Vx3zHZUfG7pCHqZ11ClbH921hoe86DwF4=;
        b=nFgg1jcLmoGkjXe/yOB2v3smQ01rvtMIvZJssfGp537oqtgrI2qeupJqHr++hHinPf
         uzA4DQ5tXoN4PLkRRvYH5Kj1xa6f9uWRY02L66BSGxRysSE2m8r3GYBx0AnUffg6SV3I
         A7lrnSZQSuQ9NP59c5tZNfLx7ZAoSclot7i8jf31LlLvHf44rm4sw1C/0snqwrGvHBHv
         Q+rvSvwSFpq49rqhMvfuuGIb/xwinrY3Q8FQSCIR8ZzGUyTCLYFBHNwyo1vJ8afYWzyM
         +ptGIL85FFls03r75ByEQt4h4Q+vhH0KKTqT5HSfwid2NT4XQO1n1XmA9B9xX4XvG5NB
         RvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=duxIQa38l5Vx3zHZUfG7pCHqZ11ClbH921hoe86DwF4=;
        b=6ZHHDaIFSS2PfI2u/T4sHdNEimqfLUUWXkVowqJgW08Q2q0VxTCckCRx+ntIXIH2Bo
         C6xUmHK10MeTjvKBOKf+xRNXrv3gNQD56+YTdc74GB7HMWu4husY1x+CCME7LSfNUQZt
         ropUweQzpZtJFMpq6AddeDMLkQg50+xIs9W77tmWjF2vMvoH8PEaxFimII9fGr3kDOzL
         CqgxdcIlSXCiyPPYJqGvHeGyZMek5Qjn54KAAjw7ziSqBlZLJK+P7qFZWbZpdeF8Cm1E
         CIND2yXb0lVKSnlURQLnllbF0VZcuzfAnZpQqjJ1mTglZ+27JLTd7m4hyyvqn8g6MMWi
         BTGw==
X-Gm-Message-State: AOAM532ER0emkIapcZb44Iw4ZbviGJiU+tgTzr4HaU7kW5v2Rq977EFj
        NgXc4SJzMZkGsSjnuFTqfac=
X-Google-Smtp-Source: ABdhPJxD4menECLdNo3bqpMdiBcTjMPRE/sq2Rb0w0RTZm6w9cKCyMknqWyWde40kCYB+YiV1QW3kA==
X-Received: by 2002:a17:907:788c:b0:6ce:29d5:c075 with SMTP id ku12-20020a170907788c00b006ce29d5c075mr14028590ejc.407.1645389044574;
        Sun, 20 Feb 2022 12:30:44 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id r3sm4493631ejd.129.2022.02.20.12.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 12:30:44 -0800 (PST)
Date:   Sun, 20 Feb 2022 21:30:42 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: vt6656: Remove ftrace-like logging and
 unnecessary line breaks
Message-ID: <44f469737b788d1012943eb4e95997d40a947f04.1645386791.git.philipp.g.hortmann@gmail.com>
References: <cover.1645386791.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645386791.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warnings like:
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
CHECK: Lines should not end with a '('

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index a31947f2620d..4d29f8ebb393 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -58,8 +58,6 @@ static struct vnt_usb_send_context
 	struct vnt_usb_send_context *context = NULL;
 	int ii;
 
-	dev_dbg(&priv->usb->dev, "%s\n", __func__);
-
 	for (ii = 0; ii < priv->num_tx_context; ii++) {
 		if (!priv->tx_context[ii])
 			return NULL;
@@ -355,10 +353,8 @@ static bool vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer, struct sk_buff *skb)
 		ether_addr_copy(mic_hdr->addr2, hdr->addr2);
 		ether_addr_copy(mic_hdr->addr3, hdr->addr3);
 
-		mic_hdr->frame_control = cpu_to_le16(
-			le16_to_cpu(hdr->frame_control) & 0xc78f);
-		mic_hdr->seq_ctrl = cpu_to_le16(
-				le16_to_cpu(hdr->seq_ctrl) & 0xf);
+		mic_hdr->frame_control = cpu_to_le16(le16_to_cpu(hdr->frame_control) & 0xc78f);
+		mic_hdr->seq_ctrl = cpu_to_le16(le16_to_cpu(hdr->seq_ctrl) & 0xf);
 
 		if (ieee80211_has_a4(hdr->frame_control))
 			ether_addr_copy(mic_hdr->addr4, hdr->addr4);
-- 
2.25.1

