Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2453FA30
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiFGJs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiFGJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:48:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3AAE7306
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:48:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso9217386wmn.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBY26428AsgO42bUNkI3Xmu9+XGt4S7I1D7qDZJnCuY=;
        b=WsqvRqj2DwkAk6bgPB5XF4je1x7cZf8A72CMRHydGqC1NtxVXxkb0CRGViR5GxWSkc
         +1oHBp0OYfI6DwqAc8Skbjj9PCDqUzZbZe2jlRY2kK+xGlg00SSR/VXCcHcaDwAbtTxV
         qx3rtcu9Xvpvz0G053GVqailSVaZ6IVkEIvdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBY26428AsgO42bUNkI3Xmu9+XGt4S7I1D7qDZJnCuY=;
        b=UrUd5BpzLvSbY7QOfXGEy613idvQ5FWKfqOWJD/MeOVxtIBNPrUbu35yPafGwZRGMu
         1twwDp8qW+SoWN6QI/uxgC7XdCZI5KOer0yMoEQcgLSMB74qhatVUXsOMBM1n4q+sQQe
         cTTB+mDd6Pk9QN8EZjJXYdQRKYDpTJzPwFbvkQLiDMYef70kmOTh8RyftpcnQt2fOD2O
         adhmiv+rHW1LhzGVq68oszNBZonbbjmC8N+48uoW7H+1LDGGDBZitoyRjsoQ3bBgJP4g
         5SAH6SPXpGmSfmDnquigm0oMJBLO6nIyH9dsqUE/yU8aTjH6fl9Joux92X8OW2TRQv4u
         rpAQ==
X-Gm-Message-State: AOAM5325qN/caDVUpgM3qc71GXXQh9FvzOaq+jEUqr8LFNjXQprLI0NV
        Svd8ixqPAQ1f/wmciWMgjN0YpWce+orANg==
X-Google-Smtp-Source: ABdhPJyLSyg7+64l6V8JYJEslH3fmo3qhX4wZk1ktAIXFo+0ieSm+xhmKrbFJcJxWwP4ibysrBJGoQ==
X-Received: by 2002:a05:600c:3caa:b0:394:8fb8:716 with SMTP id bg42-20020a05600c3caa00b003948fb80716mr56163311wmb.105.1654595291462;
        Tue, 07 Jun 2022 02:48:11 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (mob-5-90-137-51.net.vodafone.it. [5.90.137.51])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0039748be12dbsm23200547wms.47.2022.06.07.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:48:11 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 01/13] can: slcan: use the BIT() helper
Date:   Tue,  7 Jun 2022 11:47:40 +0200
Message-Id: <20220607094752.1029295-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
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

Use the BIT() helper instead of an explicit shift.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/slcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 64a3aee8a7da..b37d35c2a23a 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -413,7 +413,7 @@ static int slc_open(struct net_device *dev)
 	if (sl->tty == NULL)
 		return -ENODEV;
 
-	sl->flags &= (1 << SLF_INUSE);
+	sl->flags &= BIT(SLF_INUSE);
 	netif_start_queue(dev);
 	return 0;
 }
-- 
2.32.0

