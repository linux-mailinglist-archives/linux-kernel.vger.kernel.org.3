Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D870D52B245
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiERGUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiERGUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:20:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6FE6C0F4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:20:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so2554500wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NY8GpNn3ouqYPF3eic3S/ZQvlCNUF5XAtgPk9wl+rm0=;
        b=b8c46vdYjeWBbn0XMdRJguDoxnmC5sZgPyGV4+/mX8+WOLitHXwcKu1OKRIVtijzxg
         DWaVcdVj1CJHc8VV888C2pNoxc4NXxYGoPFfYTWN072HzrAxgt7K5EKXhBe8U0WX49tj
         DDyUxOo1q2sARKc/5wxojJqa0NVRmJ4RgLgyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NY8GpNn3ouqYPF3eic3S/ZQvlCNUF5XAtgPk9wl+rm0=;
        b=kzL+M9dybepRRd5qStFXu0el8sXcKDyl0E63GAPnDMrF1EbPiG4xGGxcpRCRcEUeFI
         GUOg7qLgMaviOrv4VnMfqk2e5mQwydJI5e3SD/bR256enk6MWABAqvN70cN5fnhab8Om
         wO/g0V+KE5G5MJokfLObxfAbRkaUdsu+WU0jud9OhRbq4FvB9IjwH6OwSrVreiY5t4cp
         e3oBl6d9gMhAbpL6pEESnggZ1sS9tzHWHtbENpOYKyZh/l/lJ4DiocLf25RfZ6qfA5Y1
         uCQOQzh2kiYpdrRXexoyeN+pLdtIrdnrSlLAvoeyWYiNicUFjgsoBc5QjSBR3D25ohCZ
         1/4g==
X-Gm-Message-State: AOAM5307lmbm8pRddDav/O1cdH8kcH1mEXzi6W/PHAb9Fs/7gl2EYhT/
        dyiD9k4xN+kGsMLc4bV/mSpsPg==
X-Google-Smtp-Source: ABdhPJwOzfUZghq0VDBdWhiOnXKgqnB9u9p8Iq0u1TSE0tbyeZdUma+QuQzT+kW4AWR+SvRpVDySPw==
X-Received: by 2002:a05:600c:3d8b:b0:397:87e:c8df with SMTP id bi11-20020a05600c3d8b00b00397087ec8dfmr11998118wmb.187.1652854810094;
        Tue, 17 May 2022 23:20:10 -0700 (PDT)
Received: from localhost.localdomain (mob-37-180-41-238.net.vodafone.it. [37.180.41.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a05600c00d700b003942a244f42sm4105169wmm.27.2022.05.17.23.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:20:09 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: fec: Avoid allocating rx buffer using ATOMIC in ndo_open
Date:   Wed, 18 May 2022 08:20:07 +0200
Message-Id: <20220518062007.10056-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make ndo_open less sensitive to memory pressure.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Change:
	- Adjust the commit message addressing the comments in RFC version
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9f33ec838b52..09eb6ea9a584 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3076,7 +3076,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	rxq = fep->rx_queue[queue];
 	bdp = rxq->bd.base;
 	for (i = 0; i < rxq->bd.ring_size; i++) {
-		skb = netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE);
+		skb = __netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE, GFP_KERNEL);
 		if (!skb)
 			goto err_alloc;
 
-- 
2.25.1

