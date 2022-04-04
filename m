Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD84F126F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347730AbiDDJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiDDJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:59:21 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E723BFB7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:57:25 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 28F2D22247;
        Mon,  4 Apr 2022 11:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649066243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iX2fFx8/rq7F3Adog43qeOMbLlUuhbcJulHHCOYHYsg=;
        b=NNkJqr8+5zPdPhCam/JqBEDXjHgmuDyTC4HQuzE8W1AFUWCkpHKmXvPT5CrDnlCAiRJlLz
        lKmkzJsGVRQbhbivf/bArfrBeax3BmkJDf7FdMBGNh0nEzRukk32OAfTxo3fL0FSTzVM8y
        8ROz2rfs3NU6TZo2Z9EcRzwh9KMQKwY=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RESEND v2 1/7] soc: fsl: guts: machine variable might be unset
Date:   Mon,  4 Apr 2022 11:56:03 +0200
Message-Id: <20220404095609.3932782-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404095609.3932782-1-michael@walle.cc>
References: <20220404095609.3932782-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both the model and the compatible properties are missing, then
machine will not be set. Initialize it with NULL.

Fixes: 34c1c21e94ac ("soc: fsl: fix section mismatch build warnings")
Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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

