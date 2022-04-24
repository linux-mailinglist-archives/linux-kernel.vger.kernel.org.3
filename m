Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320E250CE4C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 03:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbiDXCBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiDXCBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:01:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF3236E00;
        Sat, 23 Apr 2022 18:58:05 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g3so9864234pgg.3;
        Sat, 23 Apr 2022 18:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yvCVUXuZoZuLVMw47+vPYc/UbkVpldMV9je33JT8RXY=;
        b=BaEnelyLCe6fQtpmxHKMl+7x6ulG+QbSfiACl/qx1EuaK0PIMz5VXI6XpMHLT164qI
         HfoyHxDJDHm836SwupKNX4N76ujwaEVRoslu6PsGmUfmdmAd3Jmm+6HS28o3NZzZBxeB
         GfDXaguExILpSsViHR7bmGMdgkP3v2VtdUpCj0kWxhcSvX5kOnHCKyu9/M+iI6jl7Yzn
         h8eVqPzyPN/bOThkDppJMuNw/hb8n2Q3YjjBr/AHWUPr7AHfun86YhPUYnivOcyU4byS
         9gf5klvrcBgV09YoOSAa0e0x8ZVr4O3t3TaYHkUre7ZJgtLR0ziLt1e5vAPOOqpfkESL
         Yfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yvCVUXuZoZuLVMw47+vPYc/UbkVpldMV9je33JT8RXY=;
        b=MQg9y1UzcOf9vz2vYTBExfBebSoF5x1hBb+Zmmn+mSOkeJWJjryWeTzAMZx9wj4KTw
         4WmMrUx2DQ1MJkGv2JnbGO2IhgBqWVXH0PbwQQ6/kodeAqBca82UwK8HxwbOa8Jg3MHX
         S1tGcbxQkOeUEPAVzEl8x4aLJj+V+q+waKvka82fbvzZd9NDuZ8a9yZrjzOWGQtEeo0N
         r1mtK0rz4WQB8GwmuMq7r8DS9ObaHPcgeVxBINEAskiqrSF8F4t+aIrbzuGqrQU/j99b
         owCJi9TfueYELImTrzYHF/EE3/+6rO41oyLVaM1w5axWd8KoMIX9BNWEw3jxjDxLvcQ4
         E0Ug==
X-Gm-Message-State: AOAM5307SBvZBpkJu8H/nlbE71zExvpXGQe9SJFmaNKJfZzAVjy7gDLG
        7BxPvhI0FtWK2Ae20aNOq4aX4ft64iyOZBWs
X-Google-Smtp-Source: ABdhPJzCv8OcdvS99ZXrpBWfpomrC4a0+uEtHndmRRaQ1sWwWOzJwnHEkuSAXSN/LVIUVPWKhAhg4Q==
X-Received: by 2002:a63:257:0:b0:3aa:a481:9159 with SMTP id 84-20020a630257000000b003aaa4819159mr9750819pgc.1.1650765485214;
        Sat, 23 Apr 2022 18:58:05 -0700 (PDT)
Received: from zeshkernups01.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090a734a00b001bf31f7520csm2061092pjs.1.2022.04.23.18.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 18:58:04 -0700 (PDT)
From:   Surong Pang <surong.pang@gmail.com>
To:     mathias.nyman@linux.intel.com
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        surong.pang@gmail.com, Orson.Zhai@unisoc.com, yunguo.wu@unisoc.com
Subject: [PATCH V2] usb/host: Let usb phy shutdown later
Date:   Sun, 24 Apr 2022 09:57:57 +0800
Message-Id: <20220424015757.21993-1-surong.pang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e05ec742-c3dc-df7c-c5d7-29358d0a7081@linux.intel.com>
References: <e05ec742-c3dc-df7c-c5d7-29358d0a7081@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 649ffd861b44..fe492ed99cb7 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -390,13 +390,13 @@ static int xhci_plat_remove(struct platform_device *dev)
 
 	usb_remove_hcd(shared_hcd);
 	xhci->shared_hcd = NULL;
-	usb_phy_shutdown(hcd->usb_phy);
 
 	usb_remove_hcd(hcd);
 	usb_put_hcd(shared_hcd);
 
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
+	usb_phy_shutdown(hcd->usb_phy);
 	usb_put_hcd(hcd);
 
 	pm_runtime_disable(&dev->dev);
-- 
2.17.1

