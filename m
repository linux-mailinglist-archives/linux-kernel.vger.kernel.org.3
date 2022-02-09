Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF894AF6C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbiBIQdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiBIQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:33:07 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF66C05CB87
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:33:10 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4249A223F6;
        Wed,  9 Feb 2022 17:33:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644424388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYb0ENCyRXUgcKmTLP8nEQL4yL3Qe7lBbJ2Pb+Opzlo=;
        b=prVn7lvZnIJqGf5WBUK86fnd8CVzCXHIitZvO1IDYALHUaPnm72yZkT8etQ4e+s27bg8wI
        5mm5cG5YnsZ3BPeL3cBjaMoSdBM2P2i+SKl0Vo5/SK3h6zHMBqviOFM/O2m8z+mFj81EqU
        0Sl1rwvZmyVUTv1YaQYq/L6N/BJunLA=
From:   Michael Walle <michael@walle.cc>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 5/7] soc: fsl: guts: use of_root instead of own reference
Date:   Wed,  9 Feb 2022 17:32:40 +0100
Message-Id: <20220209163242.430265-6-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209163242.430265-1-michael@walle.cc>
References: <20220209163242.430265-1-michael@walle.cc>
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

There is already a global of_root reference. Use that instead of getting
one on our own. We don't need to care about the reference count either
this way.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/soc/fsl/guts.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index f992064a7f58..13d07cc19f45 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -112,7 +112,7 @@ static const struct fsl_soc_die_attr *fsl_soc_die_match(
 
 static int fsl_guts_probe(struct platform_device *pdev)
 {
-	struct device_node *root, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct soc_device_attribute *soc_dev_attr;
 	static struct soc_device *soc_dev;
 	struct device *dev = &pdev->dev;
@@ -138,17 +138,13 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
-	root = of_find_node_by_path("/");
-	if (of_property_read_string(root, "model", &machine))
-		of_property_read_string_index(root, "compatible", 0, &machine);
+	if (of_property_read_string(of_root, "model", &machine))
+		of_property_read_string_index(of_root, "compatible", 0, &machine);
 	if (machine) {
 		soc_dev_attr->machine = devm_kstrdup(dev, machine, GFP_KERNEL);
-		if (!soc_dev_attr->machine) {
-			of_node_put(root);
+		if (!soc_dev_attr->machine)
 			return -ENOMEM;
-		}
 	}
-	of_node_put(root);
 
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
 	if (soc_die) {
-- 
2.30.2

