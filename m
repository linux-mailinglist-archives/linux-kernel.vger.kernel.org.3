Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EF74F0D9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 04:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376950AbiDDCyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 22:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiDDCyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 22:54:06 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD6B396A1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 19:52:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q200so6637190qke.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 19:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northvilleschools.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=otqIVowhU2obuVpjI9J66qJe/tdtEeQSkuJxEFFPVfw=;
        b=CYdW/tHTao9xYQkkEgM4OgPB4UeamwEomjOcg8DPUI8rOX8OH9QPHQ9pwOsr3PXen5
         uAoZiT0jzn3JqOp1nHTNaYsBpTOPvoeGiFQ++RJcdVPEPZ+91aHTB4CtoS2pak06daaJ
         QgPNxuNn6qntkYIpS2zkLnxKPNVhP17KX2nnmUurTGUxczde02cM9z25fwMRYZwLD1oP
         ntk07CnKq2q5ATZllrLXCxFu5CEvZYhg8VQmvD8MEXF5PkoOfskZcjV0CzNDfgW2EnGO
         B1EceoKeBOszPct6xmvGEa4PKtxV0iMuttAIPfThwMiBzcpNB9C9M7guISP9/8l55LjE
         ET0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=otqIVowhU2obuVpjI9J66qJe/tdtEeQSkuJxEFFPVfw=;
        b=gLnFJt4XDBzfkGDq1U+nJbZIFzq/Y3ifwU4CpicpAZd7Lnhfy2ek+C29sL3Zdgfaiy
         5XqPSPU7fKCV51RIFnkH3yZnQwMb46UI6SS1ZNjHv6CUgKmp/iV6QHRznY2LdgfeSISI
         fOFKHsi4CaNDXFYqPd2R97/f0a7iTyzJvze3XNYI3BvYwXjo8wjgF5+VZIb2twWsgvdO
         4xIbRbgWcUmHKaNb6K1yNjuTIpme4Bej99x3FuIWoewB7BVIV0/ds+guX7iMjH4i/S3E
         dnF95v50xVOZk10NiHLgUnGQF0XIrQP5VGX/qk8tPYUghEXvxfKsUpuCiMxXHwo8qpn1
         4cTw==
X-Gm-Message-State: AOAM533ZeVtJ/UHetnhwdE8K6T/r6ok0tE68LvUCV77de2Gx9kH0Tsgs
        0kDWQ4YRP9FSp8oa0jynPDWOzw==
X-Google-Smtp-Source: ABdhPJwFMLKJkNF7xvI5cuv4J44M713fbdKhh8CxD5KdS58mIW4cgGnX17hUpDsJgB+iM1RsQDVJmg==
X-Received: by 2002:a37:781:0:b0:67e:11a2:7d00 with SMTP id 123-20020a370781000000b0067e11a27d00mr12997820qkh.218.1649040729273;
        Sun, 03 Apr 2022 19:52:09 -0700 (PDT)
Received: from sckzor-linux (d4-50-247-168.col.wideopenwest.com. [50.4.168.247])
        by smtp.gmail.com with ESMTPSA id k13-20020a05622a03cd00b002e21621c243sm7872961qtx.39.2022.04.03.19.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 19:52:08 -0700 (PDT)
Date:   Sun, 3 Apr 2022 22:52:07 -0400
From:   Charlie Sands <sandsch@northvilleschools.net>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH V2] Fix unsafe memory access by memcmp
Message-ID: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
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

V2: Fixed checkpatch.pl warning and changed variable name as suggested
by Greg K. H. and improved error checking on the "copy_from_user" function as
suggested by Pavel Skripkin.

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 ++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 7df213856d66..4b4eec2bde96 100644
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
+		return 0;
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

