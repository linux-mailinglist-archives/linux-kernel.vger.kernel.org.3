Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6E14C47F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbiBYOzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiBYOzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:55:12 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92303227590
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:54:39 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id v18so6801122qvh.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtUJySmbIWUCXkZt6OYhMWHmPcZgwTz+ISBAU3SmGDQ=;
        b=XBeJBV/AW6aVcAIEUmMxOHtmJJN7cXdlOyt9jA1A+SxQhFAomT394g2penNl+l7GbZ
         PpPBvEeiwnLHMlif2iBNjv9DS5xXf89R++JUB9W/GWyFgQmJe9HHL5/5oXQ2ZEcNODeL
         zxvcRwUWGtQlhpu7nx+Gn62ZpV0GU+3XcJTPUYqsxdM1igSMmHWIS8ot0rD8QW0V0x8E
         TtYT0843fMm0a55pRiVBotTg2R+5GvDnRAjR+GB0OVP/5g2KUHuHibAcxH9mOw3XOyBg
         YQ3J4aeSNGohJwzflt6MidXQdlW3MZXTxUKgvefm6Oxead2rar6rAiGCDvdpDeXCoJqr
         +B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtUJySmbIWUCXkZt6OYhMWHmPcZgwTz+ISBAU3SmGDQ=;
        b=sTH9a0TgDCJk0WD2aCS6dsg6y3GD4UnCyP7QMYVkIEtgwU25UnQ28fwifFqAqmULaU
         W1tklyrJ6JFlboGAaG4UzVz0YcfU9kAAF/bZKlIuAMO/AgonuiFKcrzqTpXL24pEScV3
         RQEOCCLuEX4h4C/18gaqts7mPR1fxrKJSZp+JrBneFpQaC1K2DAO5+FSbEbkTwo5jEbe
         GWWLBT2+7YIDwGkInHgj1b+SPLB7zz5rlGvzlqCJnQPqOcASjijpDOeNEK1kWM3xxTRN
         1qHv7STitTI7BwAYjgQ34jmIpSsRBZ8y8QWYjHUVq6N8XLdr34gDOWNBaT3XFUOkSzB4
         BFaw==
X-Gm-Message-State: AOAM530tIyepWoOBS4/aONJgJUdAwnvllk4l8vBw2HNFEHL+Y09zVd7P
        z26+eYMteetow5jtODhKCig=
X-Google-Smtp-Source: ABdhPJzdjq6wQF+dln+duSIHpHfuXWwvm/2iQsbrmZi+C7AS5r4pVyrCpU26OtRm5/Tmk3Cdwx6ovA==
X-Received: by 2002:ad4:5cca:0:b0:42c:3a47:5bc with SMTP id iu10-20020ad45cca000000b0042c3a4705bcmr6205281qvb.69.1645800878646;
        Fri, 25 Feb 2022 06:54:38 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm1318292qkc.73.2022.02.25.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:54:38 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/8] soc: rockchip: set dwc3 clock for rk3566
Date:   Fri, 25 Feb 2022 09:54:26 -0500
Message-Id: <20220225145432.422130-4-pgwipeout@gmail.com>
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

The rk3566 dwc3 otg port clock is unavailable at boot, as it defaults to
the combophy as the clock source. As combophy0 doesn't exist on rk3566,
we need to set the clock source to the usb2 phy instead.

Add handling to the grf driver to handle this on boot.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/soc/rockchip/grf.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 494cf2b5bf7b..384461b70684 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -108,6 +108,20 @@ static const struct rockchip_grf_info rk3399_grf __initconst = {
 	.num_values = ARRAY_SIZE(rk3399_defaults),
 };
 
+#define RK3566_GRF_USB3OTG0_CON1	0x0104
+
+static const struct rockchip_grf_value rk3566_defaults[] __initconst = {
+	{ "usb3otg port switch", RK3566_GRF_USB3OTG0_CON1, HIWORD_UPDATE(0, 1, 12) },
+	{ "usb3otg clock switch", RK3566_GRF_USB3OTG0_CON1, HIWORD_UPDATE(1, 1, 7) },
+	{ "usb3otg disable usb3", RK3566_GRF_USB3OTG0_CON1, HIWORD_UPDATE(1, 1, 0) },
+};
+
+static const struct rockchip_grf_info rk3566_pipegrf __initconst = {
+	.values = rk3566_defaults,
+	.num_values = ARRAY_SIZE(rk3566_defaults),
+};
+
+
 static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
 	{
 		.compatible = "rockchip,rk3036-grf",
@@ -130,6 +144,9 @@ static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
 	}, {
 		.compatible = "rockchip,rk3399-grf",
 		.data = (void *)&rk3399_grf,
+	}, {
+		.compatible = "rockchip,rk3566-pipe-grf",
+		.data = (void *)&rk3566_pipegrf,
 	},
 	{ /* sentinel */ },
 };
-- 
2.25.1

