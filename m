Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075454EFAF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351120AbiDAUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243806AbiDAUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:14:39 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B6322FD90
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:12:49 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gh15so2856968qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northvilleschools.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=oZosTPYclzlc5poYKr58RA5wxMWJ95dZSkxQK8mQ7Lw=;
        b=jBwU+Eju1cxeknfoVOH9U665mT7GdgJWN3rqZEQvdXJI7xGpq2y0fCTxG/o0GtRnQl
         yHnaFIamVXVDs5C1aMm5Y3PYDukydkVUqVIB4uSDgYeDLAAIp4fkSfH7NBJusvIVEepJ
         GKB84vhcjm/s/VZGn37oJzlqfyrv4mHPTKWwzfTRTkLT35frUBctvmujuurNm9wK5K3O
         WEwkzL9JCDIOu6G6+oacKjv5YBo0ph2ZXZuQx+qEfVRFy8q816KS1SH+kkthZ0TdYhCH
         GOyEEj6Tq9o2caghZEHYmJLmz97XehYzY1Go2hx9AGezQW5K1itwkygtQFlz3IqJbpM6
         eWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oZosTPYclzlc5poYKr58RA5wxMWJ95dZSkxQK8mQ7Lw=;
        b=ZZSZLE1q25qE3XG04ojlEHIvtyY1tl5FQ2rBm+Adk3z6LMyQ/OiGjm4GwQ52mx6Rnp
         V2bKVQvvaoo2txDU/o23cbcz8kEv2pKWmx3bEH8ITqDnd17KRH/+nAaBlmmL0K95FbjQ
         bLWIMPKEPcevHB22YIzyrx0Dj+5zvOPNO5zwSUNz+DtEBe7bM7knud7tDJ1SVNIjEv/F
         nX72YVU3Hf/5ly6/cLj4hpoYK5MceJ9Ypv8M3DV0pXIo+xRT39uba207ANj80e4TJQIG
         UHO3XlzQbWOIemS2Zznp06xztQJFS+BMj5r48XLm6X8JCjwMovEDsu0zDVvgny6TJcqS
         Yfpg==
X-Gm-Message-State: AOAM530K5lAJj2E2WHQJzAg6CpcKeT0G7jlkdSzlBa+FyHyja+yacZoK
        c4TKk+yEbypkEhHHcnZTUMZ/4zTKkk7sTfBN
X-Google-Smtp-Source: ABdhPJxR3D2ziE1C1fU3A5e9Qo50x2v8BOfL9Sh2jN9dQDz+G6xk6+Vq9Q6sv113p7q3DFR1pdKGAQ==
X-Received: by 2002:a05:6214:cc9:b0:443:a483:3459 with SMTP id 9-20020a0562140cc900b00443a4833459mr6689045qvx.6.1648843968526;
        Fri, 01 Apr 2022 13:12:48 -0700 (PDT)
Received: from sckzor-linux (d4-50-247-168.col.wideopenwest.com. [50.4.168.247])
        by smtp.gmail.com with ESMTPSA id b82-20020ae9eb55000000b0067b314c0fedsm1857817qkg.42.2022.04.01.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:12:48 -0700 (PDT)
Date:   Fri, 1 Apr 2022 16:12:47 -0400
From:   Charlie Sands <sandsch@northvilleschools.net>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Fix unsafe memory access by memcmp.
Message-ID: <Ykdcv6Sm3oDE9IEp@sckzor-linux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes sparse warnings about the memcmp function unsafely
accessing userspace memory without first copying it to kernel space.

Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 7df213856d66..1cfac1b27eb7 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3233,23 +3233,27 @@ static int rtw_p2p_get(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	if (!memcmp(wrqu->data.pointer, "status", 6)) {
+	char wrqu_data_ptr[9];
+	if (copy_from_user(wrqu_data_ptr, wrqu->data.pointer, 9))
+		return 0;
+
+	if (!memcmp(wrqu_data_ptr, "status", 6)) {
 		rtw_p2p_get_status(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "role", 4)) {
+	} else if (!memcmp(wrqu_data_ptr, "role", 4)) {
 		rtw_p2p_get_role(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "peer_ifa", 8)) {
+	} else if (!memcmp(wrqu_data_ptr, "peer_ifa", 8)) {
 		rtw_p2p_get_peer_ifaddr(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "req_cm", 6)) {
+	} else if (!memcmp(wrqu_data_ptr, "req_cm", 6)) {
 		rtw_p2p_get_req_cm(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "peer_deva", 9)) {
+	} else if (!memcmp(wrqu_data_ptr, "peer_deva", 9)) {
 		/*	Get the P2P device address when receiving the provision discovery request frame. */
 		rtw_p2p_get_peer_devaddr(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "group_id", 8)) {
+	} else if (!memcmp(wrqu_data_ptr, "group_id", 8)) {
 		rtw_p2p_get_groupid(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "peer_deva_inv", 9)) {
+	} else if (!memcmp(wrqu_data_ptr, "peer_deva_inv", 9)) {
 		/*	Get the P2P device address when receiving the P2P Invitation request frame. */
 		rtw_p2p_get_peer_devaddr_by_invitation(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "op_ch", 5)) {
+	} else if (!memcmp(wrqu_data_ptr, "op_ch", 5)) {
 		rtw_p2p_get_op_ch(dev, info, wrqu, extra);
 	}
 	return 0;
-- 
2.35.1

