Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9774FA93E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242448AbiDIPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242409AbiDIPX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:23:29 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D43B3DF;
        Sat,  9 Apr 2022 08:21:22 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id hu11so9760055qvb.7;
        Sat, 09 Apr 2022 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cC35jZSMuibIlbDfx38vUrrgkq1N8fYAn9zrEEF/JE=;
        b=iRKCQqnjzJgB+zMSPLNUcVi3w7xZfYU4XFOCFdbHx9ZJbcgAXtmiMl1765xlDsSMFM
         7W6oTqvODYt7tqyJ7u7WGLGQnhCSgmBFKRsaVqanlqzRUml38wAsOxsPNelcpZlWftD/
         lJFwAXfEXYgHEIjyypUMHJ+O67J5lMMB8G2ONqA+mGQhFZe/wyso+wxRwseEHiEKM5lQ
         +EHSqF9A1t3usbtK2yemn4UR5+16nBVQoeLW3Q4x9xTH039VJe83Nvg/Mc7YFhD5VXHw
         Mm+q+hfzDxbo850ovcxJNCNBHXdWxyclmpGoJ60BJ3JadZqknRgQUPOkshgedYWTXQ3L
         ZJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cC35jZSMuibIlbDfx38vUrrgkq1N8fYAn9zrEEF/JE=;
        b=q4HLpgQ82tHz33B+mlU4KOo1mvF8+CPqO53MNG2sgRvjOILv1ZyoVBNNBiPoo7m54i
         R6WlaTuhpptdU5+aPdPl6pFXx+WAOsq3QyV6C5+cJmySG/NasrY4L8DOnJPpJIFzwMg8
         phupun5EumYOWG7qTVr3dsWuEHK4ZVFu+SBCvAC5vGO1ABcs8HI/YGSLb1yRoru6nbAE
         x/Ap93E0FBiez67pSJassL2k8mwimfen1pCHkATrwVMyR+lbL/uSxr0YdDYqDFn6WmFT
         g8KRA2HZHFSmYRAKACwiFQQkCLAHxU3ZCOXFcfLFL18H7WWOkOuZs5jOaFy1jB0iI1cQ
         5igg==
X-Gm-Message-State: AOAM533DLh3yi5zna0LTohLyi2QBlxLdkO943S3s6755vwRbww/E2C1f
        Ni6GaCxelYoQ2TjV00lRo+Q=
X-Google-Smtp-Source: ABdhPJxKeuEAwnxh2dOIZwzzkEhGTq6QJurUZWwxAy7CtPbPSue+U0zKtCm1RK04b4VUUu42u3Eibw==
X-Received: by 2002:a05:6214:c2a:b0:440:f702:2195 with SMTP id a10-20020a0562140c2a00b00440f7022195mr20338466qvd.37.1649517681090;
        Sat, 09 Apr 2022 08:21:21 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b00680af0db559sm16559516qkb.127.2022.04.09.08.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 08:21:20 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Peter Geis <pgwipeout@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: fix backwards compat with rockchip devices
Date:   Sat,  9 Apr 2022 11:21:15 -0400
Message-Id: <20220409152116.3834354-1-pgwipeout@gmail.com>
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

Commit 33fb697ec7e5 ("usb: dwc3: Get clocks individually") moved from
the clk_bulk api to individual clocks, following the snps,dwc3.yaml
dt-binding for clock names.
Unfortunately the rk3328 (and upcoming rk356x support) use the
rockchip,dwc3.yaml which has different clock names, which are common on
devices using the glue layer.
The rk3328 does not use a glue layer, but attaches directly to the dwc3
core driver.
The offending patch series failed to account for this, thus dwc3 was
broken on rk3328.

To retain backwards compatibility with rk3328 device trees we must also
check for the alternate clock names.

Fixes: 33fb697ec7e5 ("usb: dwc3: Get clocks individually")

Reported-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---

This patch is standalone to fix the backwards compatibility, and is
necessary no matter if we decide to retain the clock names in
rockchip,dwc3.yaml as is or align with snps,dwc3.yaml.

 drivers/usb/dwc3/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1170b800acdc..5bfd3e88af35 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1690,21 +1690,44 @@ static int dwc3_probe(struct platform_device *pdev)
 		/*
 		 * Clocks are optional, but new DT platforms should support all
 		 * clocks as required by the DT-binding.
+		 * Some devices have different clock names in legacy device trees,
+		 * check for them to retain backwards compatibility.
 		 */
 		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
 		if (IS_ERR(dwc->bus_clk))
 			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
 					     "could not get bus clock\n");
 
+		if (dwc->bus_clk == NULL) {
+			dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
+			if (IS_ERR(dwc->bus_clk))
+				return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+						     "could not get bus clock\n");
+		}
+
 		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
 		if (IS_ERR(dwc->ref_clk))
 			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
 					     "could not get ref clock\n");
 
+		if (dwc->ref_clk == NULL) {
+			dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
+			if (IS_ERR(dwc->ref_clk))
+				return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+						     "could not get ref clock\n");
+		}
+
 		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
 		if (IS_ERR(dwc->susp_clk))
 			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
 					     "could not get suspend clock\n");
+
+		if (dwc->susp_clk == NULL) {
+			dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
+			if (IS_ERR(dwc->susp_clk))
+				return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+						     "could not get suspend clock\n");
+		}
 	}
 
 	ret = reset_control_deassert(dwc->reset);
-- 
2.25.1

