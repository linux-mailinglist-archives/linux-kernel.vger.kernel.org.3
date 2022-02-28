Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E284C6EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiB1N6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbiB1N5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:57:50 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B817D013
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:57:12 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id v18so12498064qvh.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtUJySmbIWUCXkZt6OYhMWHmPcZgwTz+ISBAU3SmGDQ=;
        b=f7mHaST5NAc+ZIDJY57ZHA0oq8TrhOyfZVssHBsJGecvBXPY/L1UQruS1pWOe1uZLR
         Wo9UrmY8B7uPAUk1siaDc8QWiwA0jZ4Lo4WXIICX+fW++jbriE10QO833oWDWj2VwLY4
         zoUZZ8mlJhqSuwf4E4q8+220BxsKfgZP2Z6fII+erqmLb6iYYwJ2AqmorFubvIP/ZOQ0
         7/Cz9afCjP5oCdXMd+DL1/YujlaMltAfzn2o2Rzg7U0KdAT3WtnK+OHopVVXhXGSZwVm
         euMv1yatBtzNxI9JDnjjtJw8Rzj1IJS9utJLiSCsmqH/D7WSq1W8xJcYqSQb3EZAg/xK
         ABCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtUJySmbIWUCXkZt6OYhMWHmPcZgwTz+ISBAU3SmGDQ=;
        b=R6TpWeTEmau+lrdgJRFV7N4hwa9qYBpfMB9Z6O25SvvpuEeIUvM37yPSlYtUA7wYNF
         79wioAt/cNzmERGC/GFV+MtLO85mrg0fvTQezPrKaZbkiR1PaX3G1nkzGQYElcK27+Tn
         cnfXVCAw0JRuTGcBBIWwtCOVmBCcCMaQ4XET8APCGW6jFf01GuPnEmmuoxCBWJrF7KtU
         rirvmdJby7zg+ksPlFGz+YKuykmiSsibgGW6ivlxd6AHwB0MYAQ6B1V9BpW+YkdJUUsK
         sUw+0RdSYL51WbIRwhDsXlOaSZRZYjP5dB2vNSlZLA7RYP4Wlp/67qQ5xB9HDKl53Mgf
         8hwg==
X-Gm-Message-State: AOAM531gQKO/LDNGEqnN3B3lCz7vJWDS7338gBFvdMwd4Duti4A0rasU
        wsvGAkGvIwIXAqLXaXp7t6hMvpmNojU52g==
X-Google-Smtp-Source: ABdhPJwPALj6XKu9+umS4mMfyI8C8p5m+jZ9VT//cuyLwFrVCc5AoMqTn2unAhe0zVjk9nrBQJb5kg==
X-Received: by 2002:a05:6214:212e:b0:42c:4226:282e with SMTP id r14-20020a056214212e00b0042c4226282emr14089597qvc.111.1646056631293;
        Mon, 28 Feb 2022 05:57:11 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm4932244qka.80.2022.02.28.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:57:11 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/8] soc: rockchip: set dwc3 clock for rk3566
Date:   Mon, 28 Feb 2022 08:56:55 -0500
Message-Id: <20220228135700.1089526-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228135700.1089526-1-pgwipeout@gmail.com>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
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

