Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE5355ACBD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 23:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiFYV1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiFYV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 17:27:16 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3213E02
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 14:27:15 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b125so4451137qkg.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S8QPR7010o3+lSeTdoHVBPsXg7K50OfJRqwfALm+B8Y=;
        b=EuwnwbchhSMoZBWIKc/x9m5O2fkTFhYTIHK0kIussP9tG64+1y9Y0/2Dppi5Fo9EdV
         dmmp153kQiz+ZpNvC/LBYNdTA66I7BF5QTtRS2mI/pqKblP9W4DAgJPEMezWTJYOARSa
         7XeABi9J7KgqlehGMrX6LFZsEn0uPJNx8iXoum5k0FB95lUqdNbs1TgSeKAb9G52NUSP
         bEXy48i+uA1zupC2PHhnha1Z/dVjNJ9wUhuEaq2PWhpD8cDwc5kgK9e4fO8SLctnh+yN
         U7xR70Xp/FlOtslyLMFNTvUNILDZw7+kbs+YYAdPeBH5Hr9tuiwtrYO0nLJ6ri/rhIMo
         A5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S8QPR7010o3+lSeTdoHVBPsXg7K50OfJRqwfALm+B8Y=;
        b=rAuiVJpVeiDQ2JiMqMMw9Ux67Hm5TWQWSYJ8ClWj2PiR3x5m5xJyGF2gsfOhCtl3+H
         gwf3YOZTg5TnbqcGAtIC1LE2qMKE9Bc/bvT4AIjrC75AYoRdVTQG/wFHZRFnp2P0tYUV
         JAUqN02qwf+OCphMDIcs1/jd/CG3Axc2LKzBPy7ZO4H5+FLta84mBAFIoxPe6zSLl2sy
         WIdXZ7Bkjjm2ivrUS9t67C+aWEoIepoWrqpoPVv4CQW1+94p4yEvuWHLwE3qQthbY8O1
         v4eDuJN2cQcKlJOekGLREw8jtMInT06/HA9Rg6xugbphWbIphcvt1AX8K94wHaFV/vCk
         FQUg==
X-Gm-Message-State: AJIora+4oYGA0nqONan5xueMXCiukdDMnW/R7REYk3LTXG7j/pGdBL1C
        kPxph6uUDgZ3sSy1EnHeuruc3s+9taO80w==
X-Google-Smtp-Source: AGRyM1s4h1N3WWL57e5l+pcg+OjgEgNSB9UE+Z/gTHHHREPG/QUu8JCNL/rEMqQrEbQf4v2vzU9l4g==
X-Received: by 2002:a05:620a:24c7:b0:6a7:2d03:2de3 with SMTP id m7-20020a05620a24c700b006a72d032de3mr3996238qkn.134.1656192434519;
        Sat, 25 Jun 2022 14:27:14 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id m22-20020a05620a291600b006aef641865esm4834601qkp.128.2022.06.25.14.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 14:27:14 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] phy: rockchip-inno-usb2: Prevent incorrect error on probe
Date:   Sat, 25 Jun 2022 17:27:11 -0400
Message-Id: <20220625212711.558495-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a phy supply is designated but isn't available at probe time, an
EPROBE_DEFER is returned. Use dev_err_probe to prevent this from
incorrectly printing during boot.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 6e44069617df..706a2263b0b2 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1289,7 +1289,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 		phy = devm_phy_create(dev, child_np, &rockchip_usb2phy_ops);
 		if (IS_ERR(phy)) {
-			dev_err(dev, "failed to create phy\n");
+			dev_err_probe(dev, PTR_ERR(phy), "failed to create phy\n");
 			ret = PTR_ERR(phy);
 			goto put_child;
 		}
-- 
2.25.1

