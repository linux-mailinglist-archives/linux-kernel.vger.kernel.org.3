Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE044F608A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiDFNv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiDFNvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:51:11 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB4055E43B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:25:44 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i4so3685362qti.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northvilleschools.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=q6Ao2x264TUuXRgjmNEOpLHsRTrAHzD0yaNN8nRTx24=;
        b=njmvVKYihT1RCQkDsfwJcxDQ5hrQAokIdNT4iYCY7YdZYuQV/2QHaxoFav7vgscxgR
         GU7vm3TjVuKnRN9YGtfgKvLxmtcA22Ml7a7P2uYXFOlH/n4jSANiidycUu+UiDb+ifaT
         z2W/KwIuJ9XabHI/wP8RxrT7RJesCc3uzqO+ihfmZNpLkotMdDGP0YciD3yMxNqXe9TG
         rnCIF6mixuez4Ti3g2PkmGDRQQQLnJd/QPswDRig31mlOOmVIqTRbBzW4PAaXADLKBwM
         l85U11q13H2miX6uvXSNi1Z7717Qr+bnSyqDod7dPg1G0RZmiH2wDE6ZXZs6Hd/GME6Q
         MHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=q6Ao2x264TUuXRgjmNEOpLHsRTrAHzD0yaNN8nRTx24=;
        b=YrWDGBInX+5u75jhefmW9FqBvFR3ZEhmN+3Y6e4LMDn/2sxY6pPPl6rdygAi03xuAV
         wwSINy4vAxM3+fgm3fgrx4q+H1UcG5gt+SEEL3H0emtDy91H66XyCh7ox6McPbe6D02l
         S5WJ/LyEWY+Cun2MQoSzTwdv8W9iromMuhotyF7pwCZb2hudIWZ2huNW2cKf/PTZdAwW
         KpY5oMDj0KnQ8EhhBmKiUlh72zRJhtSlaq2zxa/7N7Y7P2CAHwm2Di2NKBgToIygmUa+
         umnBWQghrPEnozGsSpUIn+8aHjwbXUXlRU0l02gmf+oe7K701jaJPyJ58xmsI0fDQJGY
         Wxlg==
X-Gm-Message-State: AOAM530bsdsVNNzfSX9cyYYfC2OuRAoEnVnpUPjJhbGObASib4L46SHE
        KIp1GQi3fozLLDwMEACRETI9+g==
X-Google-Smtp-Source: ABdhPJxHViamNtf0QgejhKNAmZKKRWhl4+iap8uIfRlYuirDrIAVzWYkzo12oIxcVryHgb0okFUCBA==
X-Received: by 2002:a05:620a:17a4:b0:67d:bb92:f56d with SMTP id ay36-20020a05620a17a400b0067dbb92f56dmr5087900qkb.276.1649244343892;
        Wed, 06 Apr 2022 04:25:43 -0700 (PDT)
Received: from sckzor-linux (d4-50-247-168.col.wideopenwest.com. [50.4.168.247])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a044600b002e1b9be8e6fsm13119618qtx.36.2022.04.06.04.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 04:25:43 -0700 (PDT)
Date:   Wed, 6 Apr 2022 07:25:42 -0400
From:   Charlie Sands <sandsch@northvilleschools.net>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, straube.linux@gmail.com,
        dan.carpenter@oracle.com, fmdefrancesco@gmail.com
Subject: [PATCH V3] staging: r8188eu: Fix unsafe memory access by memcmp.
Message-ID: <Yk14tpZCOFCsvtup@sckzor-linux.localdomain>
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

This patch fixes sparse warnings about the memcmp function unsafely accessing 
userspace memory without first copying it to kernel space.

Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
---

V2: Fixed checkpatch.pl warning and changed variable name as suggested by Greg
K. H. and improved error checking on the "copy_from_user" function as suggested
by Pavel Skripkin.

V3: return -EFAULT from the function when there is a memory error while moving
it from user space to kernel space and fix incorrect subject from V2

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 ++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 7df213856d66..9f2182b8e451 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3233,23 +3233,28 @@ static int rtw_p2p_get(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	if (!memcmp(wrqu->data.pointer, "status", 6)) {
+	char wrqu_data[9];
+
+	if (copy_from_user(wrqu_data, wrqu->data.pointer, 9) != 0)
+		return -EFAULT;
+
+	if (!memcmp(wrqu_data, "status", 6)) {
 		rtw_p2p_get_status(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "role", 4)) {
+	} else if (!memcmp(wrqu_data, "role", 4)) {
 		rtw_p2p_get_role(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "peer_ifa", 8)) {
+	} else if (!memcmp(wrqu_data, "peer_ifa", 8)) {
 		rtw_p2p_get_peer_ifaddr(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "req_cm", 6)) {
+	} else if (!memcmp(wrqu_data, "req_cm", 6)) {
 		rtw_p2p_get_req_cm(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "peer_deva", 9)) {
+	} else if (!memcmp(wrqu_data, "peer_deva", 9)) {
 		/*	Get the P2P device address when receiving the provision discovery request frame. */
 		rtw_p2p_get_peer_devaddr(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "group_id", 8)) {
+	} else if (!memcmp(wrqu_data, "group_id", 8)) {
 		rtw_p2p_get_groupid(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "peer_deva_inv", 9)) {
+	} else if (!memcmp(wrqu_data, "peer_deva_inv", 9)) {
 		/*	Get the P2P device address when receiving the P2P Invitation request frame. */
 		rtw_p2p_get_peer_devaddr_by_invitation(dev, info, wrqu, extra);
-	} else if (!memcmp(wrqu->data.pointer, "op_ch", 5)) {
+	} else if (!memcmp(wrqu_data, "op_ch", 5)) {
 		rtw_p2p_get_op_ch(dev, info, wrqu, extra);
 	}
 	return 0;
-- 
2.35.1

