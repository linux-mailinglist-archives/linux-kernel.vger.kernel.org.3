Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D364FAB42
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiDJA7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiDJA71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:59:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FCAB1D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 17:57:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 2so12005866pjw.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iewQTcBhULh0Wlv/puXFU1ZAd6A0j76cf895Aowl2UU=;
        b=L/QeTnVVQn5jjd6snJlLFoNDo34diFEa7BHp0Oy6Cd8XrjkU2pIzp5UPnr7I8QcZjA
         SEA+jA204dyrIqws1t4y3z5Ovwb4L+G5JkyckHDKDzcIeIqOTnbEH238f//fHvKDhcFG
         KeL74z3++8KfMVnrSX+pzPMB/81fR2LP/4VOIVpNapMH/qFM9hVqQqaH3ttnzATPrW6K
         wS0h0sw4otD+tnuHvP1SijmCvMIWzejGS3bIsBi7FfZppv6Am+ZJZLbxojHqXX+UCIrd
         vm/+oMTEvgRsdrcXAEXEyaHzWltL7qmD9JKxUgaraKqTP6uli6B7nu8RQYejLmiyOPkn
         Hv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iewQTcBhULh0Wlv/puXFU1ZAd6A0j76cf895Aowl2UU=;
        b=WGsUxmHEeWU7n6BCvgcqPeY8/GEvgp3chfaaDCsxqdQJ9HLQa+Di2g56hBVNj3aFxN
         QdmquApQfZsFonXlpJUrJZVJZBk9EZap+8PU5/uCBUEMIqPZnOctH7yah8kC679OhtmY
         qYOR3TFz4zClX0laPl8imu0pMbY9VApzXACa/PaEF1i3kn40tA5fWW/HqSLduYCJLsY8
         FCJFnUePjWKUsyom8EZ11McDhYi1d3Ep4x8U9Y/zKKNBuCsekPR807BufvDBbZl0q5gd
         PKYBi3nRs3SUBLGBhUNN7hv0iknTv4fvwTP/N9prqkuf2RtXYQ+dHA4uD3a24zOE2bL6
         cWOg==
X-Gm-Message-State: AOAM531Cdz0Uszi2l/Yo3FKw9CY/Ekk+/btNFqmUh2hOx+tLniHydcFp
        K2cgAZg64yLgt7qwo43OVAA=
X-Google-Smtp-Source: ABdhPJxuIbEUR2rjIgM+QIPwPcWDxqVzGadLvv5PLEpQI792X8OmRHPI+iyWRlhk+5SZC9wabjGa9A==
X-Received: by 2002:a17:902:ce82:b0:156:bb3c:3297 with SMTP id f2-20020a170902ce8200b00156bb3c3297mr25408771plg.159.1649552237537;
        Sat, 09 Apr 2022 17:57:17 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:172c:26af:268e:6e9f])
        by smtp.gmail.com with ESMTPSA id l67-20020a633e46000000b003986e01e982sm25088215pga.67.2022.04.09.17.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 17:57:16 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/4] xtensa: iss: replace iss_net_set_mac with eth_mac_addr
Date:   Sat,  9 Apr 2022 17:56:30 -0700
Message-Id: <20220410005632.3925219-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410005632.3925219-1-jcmvbkbc@gmail.com>
References: <20220410005632.3925219-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iss_net_set_mac is just a copy of eth_mac_addr with pointless locking.
Drop this function and replace it with eth_mac_addr.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/network.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 409def002f55..e9454652551b 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -436,19 +436,6 @@ static void iss_net_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 }
 
-static int iss_net_set_mac(struct net_device *dev, void *addr)
-{
-	struct iss_net_private *lp = netdev_priv(dev);
-	struct sockaddr *hwaddr = addr;
-
-	if (!is_valid_ether_addr(hwaddr->sa_data))
-		return -EADDRNOTAVAIL;
-	spin_lock_bh(&lp->lock);
-	eth_hw_addr_set(dev, hwaddr->sa_data);
-	spin_unlock_bh(&lp->lock);
-	return 0;
-}
-
 static int iss_net_change_mtu(struct net_device *dev, int new_mtu)
 {
 	return -EINVAL;
@@ -474,7 +461,7 @@ static const struct net_device_ops iss_netdev_ops = {
 	.ndo_start_xmit		= iss_net_start_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= iss_net_change_mtu,
-	.ndo_set_mac_address	= iss_net_set_mac,
+	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_tx_timeout		= iss_net_tx_timeout,
 	.ndo_set_rx_mode	= iss_net_set_multicast_list,
 };
-- 
2.30.2

