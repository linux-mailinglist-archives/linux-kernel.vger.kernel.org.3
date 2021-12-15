Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A5474F75
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhLOAqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbhLOAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:46:43 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D73C061574;
        Tue, 14 Dec 2021 16:46:42 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id k21so27324853ioh.4;
        Tue, 14 Dec 2021 16:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZeqp1FYJmD+knXrPe5OXFXwzSVkktTav5BzuULk6lM=;
        b=McaMoHZtB0R7eaaRVJjiBK77puPXXCMnkXxzz158P8zT/6hfq9kw0vjctqVga1vP1v
         zc1MK8vm793LD5a/XQ786JbtSoY0b4MFIAdJZoCrCaHWuUJNMrFRrv+U82ROIB5+9fgS
         JYUFsY1s2sgxrlLC8TzM4XqQeuPm29s6w/UAO7KJXUnGc2yHqV7iDrNSJ2sIDYB9UXjt
         CKFiL95ugoRUBx8SRamxYV/hsJEmOcRLoMt6WOFk60XfVl5+i9pKcSRq8aCclUCbNAFU
         0anU1ilFrD/RFBJqAVtI5S+amlJ7IZ88/bF4DQcPXNd1wzGo7L5GFabLQUnmueHWSBXR
         y4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZeqp1FYJmD+knXrPe5OXFXwzSVkktTav5BzuULk6lM=;
        b=rsr46kWcbo/7kGn/WfU4WdBu2FMPLYEWn2eXSaT3vZzHtxiB/Fua//1uTQ+xCkI17k
         H2C4UhSadUUz+Xhpt3o+in+LEpELO5uJfJG1UkI0wUaABDq1lf9L8QP9uSjqf/nIUcTH
         zaghdl8CF9GLN/jqDIJ3eAvaLX2zHnY/6fG7uBcMbB+LEhNVOjBFVS5TPb/k3A42erYv
         olt8O9ahE0EIi2Y3bl8FD2CYuYhe6xk4Me7aqe89HC4j/g1lvMhV9+KfsnFrplfMirED
         pkEDKR9I1OHdYbPyn0r/edQbczXR9oCqMbLx5AFZB1bhJmxZYoOh4N7moH9ZAVX1nWj+
         /3OQ==
X-Gm-Message-State: AOAM532uL8AzmTTHtSALTiJMKtTwidud51x8hPkVE0zDWzNBhD1/tuL/
        yScdiuFO+e+uoz2FvAqqtZI=
X-Google-Smtp-Source: ABdhPJxWw+JlvCdOA0QABauvmI+6V5wJiaujT/4F+Zmf0lwfeirbgSjiYolwktTReOWRSYFR+17Sdg==
X-Received: by 2002:a05:6602:164a:: with SMTP id y10mr5408745iow.123.1639529202186;
        Tue, 14 Dec 2021 16:46:42 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8256:b93c:84fb:458b])
        by smtp.gmail.com with ESMTPSA id y8sm218857iox.32.2021.12.14.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:46:41 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        michael@amarulasolutions.com, jagan@amarulasolutions.com,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/9] soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
Date:   Tue, 14 Dec 2021 18:46:19 -0600
Message-Id: <20211215004626.2241839-3-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215004626.2241839-1-aford173@gmail.com>
References: <20211215004626.2241839-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dispmix will be needed for the blkctl driver, so add it
to the gpcv2.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index a0eab9f41a71..3e59d479d001 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -843,6 +843,31 @@ static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
 		.pgc   = BIT(IMX8MN_PGC_GPUMIX),
 		.keep_clocks = true,
 	},
+
+	[IMX8MN_POWER_DOMAIN_DISPMIX] = {
+		.genpd = {
+			.name = "dispmix",
+		},
+			.bits  = {
+			.pxx = IMX8MN_DISPMIX_SW_Pxx_REQ,
+			.map = IMX8MN_DISPMIX_A53_DOMAIN,
+			.hskreq = IMX8MN_DISPMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MN_DISPMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MN_PGC_DISPMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MN_POWER_DOMAIN_MIPI] = {
+		.genpd = {
+			.name = "mipi",
+		},
+			.bits  = {
+			.pxx = IMX8MN_MIPI_SW_Pxx_REQ,
+			.map = IMX8MN_MIPI_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MN_PGC_MIPI),
+	},
 };
 
 static const struct regmap_range imx8mn_yes_ranges[] = {
-- 
2.32.0

