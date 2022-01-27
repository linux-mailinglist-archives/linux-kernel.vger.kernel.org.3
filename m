Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BBD49E7C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243962AbiA0Qlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbiA0Qll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:41:41 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0245AC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:41:41 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3A5AC223EA;
        Thu, 27 Jan 2022 17:41:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643301699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmcB32lZNLU8U2UJrhiSMThjgIDzKuhDycLLnDyMg7c=;
        b=Hj28wdCxF0vZgsjKzdionFrUFzJyrw8fIZkK4K2w2bRf+1LOOvuz9NXFaATAfous6xXqwd
        EE+tujNwm658TZ+2Zp/CBHTH1/QHqzmZTat/sdWSqA72fDkN7V0y6mQQ+YDS8F7/7ckq9o
        +dImi0lP8LPxI+Kb99Gmtr5Ts+Z31og=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>
Subject: [PATCH v1 1/7] soc: fsl: guts: machine variable might be unset
Date:   Thu, 27 Jan 2022 17:41:19 +0100
Message-Id: <20220127164125.3651285-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127164125.3651285-1-michael@walle.cc>
References: <20220127164125.3651285-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both the model and the compatible properties are missing, then
machine will not be set. Initialize it with NULL.

Fixes: 34c1c21e94ac ("soc: fsl: fix section mismatch build warnings")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/soc/fsl/guts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 5ed2fc1c53a0..be18d46c7b0f 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -140,7 +140,7 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	struct device_node *root, *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	const struct fsl_soc_die_attr *soc_die;
-	const char *machine;
+	const char *machine = NULL;
 	u32 svr;
 
 	/* Initialize guts */
-- 
2.30.2

