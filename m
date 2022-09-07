Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE225B044D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiIGMvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIGMvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:51:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209D375CE9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:51:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bp20so19751824wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=K10uAJSt1u89AHdHDm3QcGmANMSoQ/8HY7X6zX3XZWE=;
        b=zebyzyv5uKr+UqsozuiNEURIYqvNSEMx/k5mlK+LX3bAhdI2PaQP2VCIgM9lmXtdeo
         JkMS58BTcZhx+QgoTSa9bOMHDIujGKqs6m3ZQKBtUJDMNicEjA07WZN/Qh0PJA9TYhpd
         3fcOrWd2LJJY/CeIk+4iQRL3yQ4nz7ws8FLReQL++JjQuPsCoS83B8l6ZERbys591+XP
         NC6/iLKXCGyqblLuTPfA/r/cjJFcoavZ/Gj6P1w4ROG8A8ZzO2dl3COIE1A/XUjRwMGD
         wZuy80hJFk+2Pq1ZHJc7wbkRe7TCJY9uN933qBYe0FGW8IxV/hOy93L43ghqQBxlx1sU
         mo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=K10uAJSt1u89AHdHDm3QcGmANMSoQ/8HY7X6zX3XZWE=;
        b=xz1yH5oxJAw+8YessOiH6/Ow4+NYZKKtFABpVS4K061HbWEsXu1JbSFgq7Jx3m4poO
         0vOZqTTAvdO4e8tmhipGTdguzY6NQcNwE2HjpeBgm9ZNd401ubLsVhoaZ2Eiqy/5vzF+
         TBOYA4/RqU1QubVv+xNHAskdF1NeQVPiKhYlmdNX+ObLd3su6rIEaUaTTRmhskARP1QO
         rW/4k+OReazrL6chQRzPa9iYfqx8cY9TaKAbScJnyg8Sb7Ae7qeGO8rbB7ESZqBr2aRJ
         EAFQX5rjhRt9JNrGGoPCplLE/AdqivnH3luX9CuRvWjyg97ob8/F03eUlhvzziIbrLtv
         KPig==
X-Gm-Message-State: ACgBeo0BLno275sshmm2IA04CuTuRE6/j+PTCRezJgpHwF8ko/ycrgid
        VLmzGU4CMif6saua22h4KWTFow==
X-Google-Smtp-Source: AA6agR6xJNUBhe9XopgqmLTZOld7yTF3ZPNZlh6fC1ETvTmQOaZ4LXyB4dTCOss9jZ/lXbavFtgZQw==
X-Received: by 2002:a5d:588b:0:b0:227:1c28:f470 with SMTP id n11-20020a5d588b000000b002271c28f470mr2105741wrf.331.1662555079421;
        Wed, 07 Sep 2022 05:51:19 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm11480001wrc.41.2022.09.07.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 05:51:19 -0700 (PDT)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     edumazet@google.com, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jasowang@redhat.com, mst@redhat.com, pabeni@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v3 1/6] udp: allow header check for dodgy GSO_UDP_L4 packets.
Date:   Wed,  7 Sep 2022 15:50:43 +0300
Message-Id: <20220907125048.396126-2-andrew@daynix.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907125048.396126-1-andrew@daynix.com>
References: <20220907125048.396126-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Packets from TAP devices with USO offload converts
to GSO_UDP_L4 & GSO_DODGY sk buffers.
Added changes allow skipping segmentation for DODGY/ROBUST packets.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 net/ipv4/udp_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6d1a4bec2614..8e002419b4d5 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -387,7 +387,7 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 		goto out;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 && !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
 		return __udp_gso_segment(skb, features, false);
 
 	mss = skb_shinfo(skb)->gso_size;
-- 
2.37.2

