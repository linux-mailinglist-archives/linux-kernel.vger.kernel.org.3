Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBEA53B7B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiFBLYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiFBLYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:24:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B777E23356B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:24:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s68so4495141pgs.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/UviAPw6MVTun+p1meC75VFrnzsHlfU+tXdnWRM4ero=;
        b=R0jGR2UNz89lSMNrXmYn+tG9AJzhiCUoStselCRkCR/NOXJfrPJjYaEv+1hjEK7ayj
         xxi8yhx18W7TUO++IRoOKPH1kv3Wphzv27c/4bnjB/NsPBe/t8Zy3AJZ1zs2YNXeJ/B6
         iyjVtD/QRJxEpHh2ksIpZYkGt4QOJUT8Ux1j3gNGPTnekRgEXrUCysEl1NNSsKI9Hf/L
         IRnIfKiEJExZLlfmkgCFTPLvq9uDiLWcETVqHtw/zWRhhMz84BzVY+ZF9khjo856lK9A
         csc3U0Zf+ZX3Z8594T4AdaeIMyRkoBKN1Ed2H2X4O2UuZsBuMWz9DTwH9At1/lLCXiaA
         rcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/UviAPw6MVTun+p1meC75VFrnzsHlfU+tXdnWRM4ero=;
        b=bJD4HOaATURyquHnQwJSL12Tgod8rWH/ymfjNZqSSVN6e6fEnsAUDqB5GCyAd/PBHr
         7+3x43uTXbipnD7yo2d9HHgwXcs88owiX7Prh5RSRMMbXfqjKxNOIchoN488UTxNsHXW
         CQ+oqGiDPmF9SMfUG414wWq4kq8avZIlzohmo6w6/2I8HhCs6UGYqrrmxG4Rr0FxuJwm
         1eBA/mtr3MYQnJm/WDexkKZDk5r3CBPSl0rFNGDfxLJha2xt/U1Bm+qdWbIpmogYZ9IU
         u4v3CMbVCB4JK1KUS2OFtykIGpVePv77ydnnOmqwAF2jmfoppkOF28xopcOSVliefwXd
         1hxQ==
X-Gm-Message-State: AOAM533D5DZ0CjRnBIsfXm3p7uhVVMu8xgPVJC8pfmoLU8dt216m0jO1
        PSMred8B2eYJE0xv68cAOX4=
X-Google-Smtp-Source: ABdhPJzty2L83Yb6F5pcpnNIYPmmPuhhuOwoP/lHnm+WllkboYqVQ5sSbX0lDdTrvwBAURr+82kwTw==
X-Received: by 2002:a63:d209:0:b0:3fb:b455:deb2 with SMTP id a9-20020a63d209000000b003fbb455deb2mr3870838pgg.323.1654169077266;
        Thu, 02 Jun 2022 04:24:37 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id t4-20020a170902b20400b001617ffc6d25sm3262140plr.19.2022.06.02.04.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 04:24:36 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: vexpress-config: Fix refcount leak in vexpress_syscfg_probe
Date:   Thu,  2 Jun 2022 15:24:26 +0400
Message-Id: <20220602112428.3002-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: a5a38765ac79 ("bus: vexpress-config: simplify config bus probing")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/bus/vexpress-config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index a58ac0c8e282..b368e2f01f8b 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -395,10 +395,13 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
 		struct device_node *bridge_np;
 
 		bridge_np = of_parse_phandle(node, "arm,vexpress,config-bridge", 0);
-		if (bridge_np != pdev->dev.parent->of_node)
+		if (bridge_np != pdev->dev.parent->of_node) {
+			of_node_put(bridge_np);
 			continue;
+		}
 
 		of_platform_populate(node, NULL, NULL, &pdev->dev);
+		of_node_put(bridge_np);
 	}
 
 	return 0;
-- 
2.25.1

