Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85ED469082
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhLFGvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:51:15 -0500
Received: from cpanel.siel.si ([46.19.9.99]:43326 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237926AbhLFGvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZN2DajTm4fWPaTsefMyX/RjdOsvAcL54VACdDPakJ4o=; b=E40JMGM7cVMEoTmuiNcTandPhr
        zrwzoNVRE7q3+d98HT4096vKIX3NAU7SS+eVzZs67vHTvOavEHA09mec4GfWzl5EDgrgviToZr7X/
        +BGkShRjqBUVJ/90H3Jg33HKWfPtw8GEdUpATtrXjpyUilZEvnv/9E0WZZdtup9IxT3A2yQ1jm9v2
        PVSy+csWXSNaSNGe5I+QWimfbV6MX95d0GBgbpvjhPbYYmPgXOCGhlv1LKqL28gOMlkGCmYw3IwiV
        u7k7huB9VbX1+X6Sa+CVDYzThCw/ytUcSzCFegLEUCR+lpWiP5e7DwLWp57cEyuCy3LE1NQbcbt3t
        xndnWX4g==;
Received: from [89.212.21.243] (port=40020 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mu7me-00GJXR-G7; Mon, 06 Dec 2021 07:47:39 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     support.opensource@diasemi.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     andrej.picej@norik.com, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        cniedermaier@dh-electronics.com
Subject: [PATCH v5 2/5] mfd: da9061: make register CONFIG_I writable
Date:   Mon,  6 Dec 2021 07:47:29 +0100
Message-Id: <20211206064732.280375-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206064732.280375-1-andrej.picej@norik.com>
References: <20211206064732.280375-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the config register CONFIG_I writable to change the watchdog mode.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Chnages in v5:
 - new patch, make CONFIG_I writable also for da9061 version
---
 drivers/mfd/da9062-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 7041ba53efb4..20e5ce2a2354 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -453,6 +453,7 @@ static const struct regmap_range da9061_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
+	regmap_reg_range(DA9062AA_CONFIG_I, DA9062AA_CONFIG_I),
 	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
 };
 
-- 
2.25.1

