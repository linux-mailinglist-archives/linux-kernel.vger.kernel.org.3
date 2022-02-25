Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26FD4C47FA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbiBYOzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiBYOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:55:14 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6882272CB;
        Fri, 25 Feb 2022 06:54:42 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id t21so4650586qkg.6;
        Fri, 25 Feb 2022 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1aWUdNaxxdpw+lffSMBxQcG6QoqOdlZ2+Rp8zHx4iWQ=;
        b=CDm78T/7/AOeFBNhZ/Hsw/eFKprN/6WQC1KibaLR1X/6Xa+qSiMF2CebribEDB0grp
         68EPufCJj+DgWCEknXnwUwPQLa4q6JEVqXI70BaI/bf1dXhAWAK1z707JLmWprxe7nmo
         Gakgea52/WJ2+8AvgQt/FBNF8Fm7J5N0bGA7oGKsxuMgHJHGegvzedoXHXz5Z379tacq
         nM+9rHWpUNigxtY7K0/20QQTmWwvYaPSRQu2q1kY+ZAonZMKWIPFyuxL/zL1Lll4IJ35
         qmr6WwMC97V9KOvnR7eQkjCre7m4e06RQxD1PwOymh6AKiL70U4ma6grvazPYUaRt3CP
         kL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1aWUdNaxxdpw+lffSMBxQcG6QoqOdlZ2+Rp8zHx4iWQ=;
        b=N3ucis/P3oYcLfZxZpmvIY01RCUFy+IbDfqbhq1tVu8ZFdko4YJs3D7/H0t26EvIkC
         b/ZCHM8A4gDvei7+XjgW2saL/KMkqAKHAEF1ZgjFKXyCt0/01RsPgdPG4WQTl6qwNGrA
         IhO8nNwvE66tI+tzhbZf9JWLoji4UPtospCwqR1zBlGQhgPHdDRFTZbImEoeORkQoXE7
         P3X3CUhq7ae7HQRJy3iiJ2HqPb8q3dx5ZTbyAwcK4YCy/rXVArhslUDBaWLOqbbFpG8Y
         InxER5/JiWALpCiOsQ7/9uu6vSonR3+HBdQxjfjytO/22JSC/nHvT0P7SHNQpvQQU30z
         Xs7w==
X-Gm-Message-State: AOAM531Sk4fX6VxzpcFWiC7VEG7aGlSWiVP5HFjih+ZVoavpKKgAvtww
        iOmTxOMroAwZSHUiM6QhzbY55TiQAcNxbA==
X-Google-Smtp-Source: ABdhPJziU1O59hbevx/Nku3KuwwaXRY947GTXPKwNBjuKzU7SSBO7D/jEigjVZPZz+pHreartIQY+Q==
X-Received: by 2002:a37:9a94:0:b0:606:8349:e9e8 with SMTP id c142-20020a379a94000000b006068349e9e8mr4966818qke.66.1645800881655;
        Fri, 25 Feb 2022 06:54:41 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm1318292qkc.73.2022.02.25.06.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:54:41 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/8] usb: dwc3: add rk3568 dwc3 support
Date:   Fri, 25 Feb 2022 09:54:29 -0500
Message-Id: <20220225145432.422130-7-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225145432.422130-1-pgwipeout@gmail.com>
References: <20220225145432.422130-1-pgwipeout@gmail.com>
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

The rk3568 dwc3 controller is backwards compatible with the rk3399 dwc3
controller.
Add support for it to the dwc3-of-simple driver.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 9dc6295df6b1..1d52a261af55 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -49,7 +49,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	 * Some controllers need to toggle the usb3-otg reset before trying to
 	 * initialize the PHY, otherwise the PHY times out.
 	 */
-	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
+	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3") |
+	    of_device_is_compatible(np, "rockchip,rk3568-dwc3"))
 		simple->need_reset = true;
 
 	simple->resets = of_reset_control_array_get(np, false, true,
@@ -176,6 +177,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "hisilicon,hi3670-dwc3" },
 	{ .compatible = "intel,keembay-dwc3" },
 	{ .compatible = "rockchip,rk3399-dwc3" },
+	{ .compatible = "rockchip,rk3568-dwc3" },
 	{ .compatible = "sprd,sc9860-dwc3" },
 	{ /* Sentinel */ }
 };
-- 
2.25.1

