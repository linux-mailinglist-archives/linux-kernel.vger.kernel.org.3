Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53D0529EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245674AbiEQKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343511AbiEQKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:05:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF209FEE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:05:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l38-20020a05600c1d2600b00395b809dfbaso980882wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HyGdG5hdHtnAbHtcbhlYB3o/m/Iup0FsxrmZdcSyIhY=;
        b=hW0Lm6qeax17fQPafdhAi3j58GQnzrxokEbAfsmlPX52e8zERDq6JhEGfSUt7RP59x
         iYdwSVq7et8mPArZYNIahzZqP+k5MdWlI8RCzSRIbkw/TE3ZjMTb2cX9al9E9Beuu7aY
         fCtus6L/jGqXqa3A1b9RmnmLIdzhgPt5rV4n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HyGdG5hdHtnAbHtcbhlYB3o/m/Iup0FsxrmZdcSyIhY=;
        b=T3QPYzTzlL3dMciSIbMK+nDxuncHps+2+CUdfZUH0rBARd4G/nYylRPIn7o3mZJARE
         9/hg0nIdQza441nC7F8amAPfl/cgwKPRBZ5GXg78+Fxz2roEb7Qr4FzlPyuGNXcpsyO1
         HerHOpB+L9jR3aRzOgHnYW7KpI7xxsaD6Yq1HgPfpivp11HS45r05sMH5d5qm5aE/8XB
         W1rLO76C1JDgHOnxSBdyXdxfpnXpitDL/+DDL1RoMx2fSwHqyuC++B7Oiep3MoihquOi
         FZ8UraMv3eB3DD+I3JEJIB44gA+Do0VUsLsEE5Ihh4g7O97Cy4T/ZQpelpEq65HQ4TeX
         nB+w==
X-Gm-Message-State: AOAM530IKHutafmcr2bG8UsTQGipkWrydUFCkYLqN3oLioLMEnHr2Hvf
        0jIdIY/cMiNU9Ixm6GUQK98a0A==
X-Google-Smtp-Source: ABdhPJy/lII4hO4bT2sYwnq0DcH6vcVkDel6Xf6SwWAJ3naxf+4MmDGYnJxePcBcZ7c6pxuTKCJerQ==
X-Received: by 2002:a7b:cf36:0:b0:394:e58:b64b with SMTP id m22-20020a7bcf36000000b003940e58b64bmr31134145wmg.125.1652781949497;
        Tue, 17 May 2022 03:05:49 -0700 (PDT)
Received: from localhost.localdomain (mob-176-245-118-121.net.vodafone.it. [176.245.118.121])
        by smtp.gmail.com with ESMTPSA id s2-20020adfa282000000b0020e0b9487besm1528730wra.109.2022.05.17.03.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:05:48 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] net: fec: Avoid to allocate rx buffer using ATOMIC in ndo_open
Date:   Tue, 17 May 2022 12:05:44 +0200
Message-Id: <20220517100544.2326499-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
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

