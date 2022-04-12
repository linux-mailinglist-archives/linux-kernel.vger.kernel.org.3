Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7144FE144
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354707AbiDLM41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355242AbiDLMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:53:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4204DF6A;
        Tue, 12 Apr 2022 05:25:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b15so17371227pfm.5;
        Tue, 12 Apr 2022 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=33bKbKDNXAx3ppOPWZ4HVLiAbWGiHxY2Mxqx6kKUUjc=;
        b=Uk8ggJ2OS0JkLBPm8p9999h8xf6fanlr6yaF1MHsctGgvCL+nUTWR57jYjdU8W3KLo
         thpNjNrkq6k3/C2AqoXqGHtdbhL07ntH4o2jspWqz9ctAkoGHLsqz8S6qjYamQMfuE9C
         C6vuU2r+ZUiew5O5Qah6wwZupIt9NN2Qtiyid1BH5oTZ+sL8YOn199jMxus2Bsjvna1t
         U8isN3WQ95nAnf4JlxcLkWdCMR5jHns2sqByP5M/QK8tG1g9GzEUCdmuUbtgDjFmWL+m
         98CmW59ozWwfJD+Mj3gcSPxzaJAz7/hDiNrL7yEIL+VH2HbMomYoEWMOGG+HuSu0UUZJ
         30fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=33bKbKDNXAx3ppOPWZ4HVLiAbWGiHxY2Mxqx6kKUUjc=;
        b=axqB5YwDcd83Augn9tPxh7M1cLinKjtw4dtrgW4HWNoPMEjUy3FiyVSpGrk7VNkPeo
         9BYi6WnfuZtcnbsauus+83q99ZzbCGoQGhAdpOB6xd+rW1zeVg16EgKGDaujNxSR0ie/
         AQ9jHLEN8DFJGzTtF1jt3XxDGGxzAUeLN6igS9pzqyWhiPx1v2o+QmaVnYWfrXw/sxVx
         ffRdmz2l5MX1UEXIpwUNnx/vrTSp1DAm87NhgkPG2g1E6NK7DD3hJC2AYj/vRETMzFF/
         hb4S3wOQfSBGbB5bhLJQwJApDezaPNZKF/u3D6HiZZB3pZlb3Wg99nFTzFFatrBUro86
         7rIA==
X-Gm-Message-State: AOAM531qdgbjXfutW9pH3yFzAQw0MF4t+xRWWUhZdNrvlHrKCy0Cyl5D
        lIs/VmVfNBs0bHDqdgsvFF8=
X-Google-Smtp-Source: ABdhPJycdPSZCbu4EHe5zFWxs7bVf9Z8wj+a4S2NpyQ6vGtHFc/5+yrhOdtwaM19rmz4m1S8g0UlRg==
X-Received: by 2002:a63:c1b:0:b0:39d:93f7:4b7b with SMTP id b27-20020a630c1b000000b0039d93f74b7bmr2723057pgl.595.1649766331348;
        Tue, 12 Apr 2022 05:25:31 -0700 (PDT)
Received: from zeshkernups01.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a16-20020a637050000000b00385f92b13d1sm2788915pgn.43.2022.04.12.05.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 05:25:30 -0700 (PDT)
From:   Surong Pang <surong.pang@gmail.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 1/1] usb/host: Let usb phy shutdown later
Date:   Tue, 12 Apr 2022 20:25:24 +0800
Message-Id: <20220412122524.26966-1-surong.pang@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Surong Pang <surong.pang@unisoc.com>

Let usb phy shutdown later in xhci_plat_remove function.
Some phy driver doesn't divide 3.0/2.0 very clear.
If calls usb_phy_shutdown earlier than usb_remove_hcd(hcd),
It will case 10s cmd timeout issue.

Call usb phy shutdown later has better compatibility.

Signed-off-by: Surong Pang <surong.pang@unisoc.com>
---
 drivers/usb/host/xhci-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 649ffd861b44..dc73a81cbe9b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -390,7 +390,6 @@ static int xhci_plat_remove(struct platform_device *dev)
 
 	usb_remove_hcd(shared_hcd);
 	xhci->shared_hcd = NULL;
-	usb_phy_shutdown(hcd->usb_phy);
 
 	usb_remove_hcd(hcd);
 	usb_put_hcd(shared_hcd);
@@ -398,6 +397,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
 	usb_put_hcd(hcd);
+	usb_phy_shutdown(hcd->usb_phy);
 
 	pm_runtime_disable(&dev->dev);
 	pm_runtime_put_noidle(&dev->dev);
-- 
2.17.1

