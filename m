Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342074B8799
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiBPM1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:27:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiBPM1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:27:52 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C61A2A39F2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:27:39 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B4B6122246;
        Wed, 16 Feb 2022 13:27:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645014457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=papN3QpdwQf9C62sFFns3emevR7CyK/275hQyIq1OFw=;
        b=HZGhfzVUiwdbNjTjTmteQtLGOsPYIxGXfEf8tEaqnG59No1jAUn0Nh6ri5G4zMGCJYYSxs
        cq3dcxIRtkGUzbxKuJ3DU2JCgb1iv5rcXj5DMnJxJ/4WHsGuBtFzJQgkhtkDAxLsmfKWxE
        NrShh6+ditm/LvNL0ETD09Q6CkVmYxo=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Colin Foster <colin.foster@in-advantage.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Walle <michael@walle.cc>
Subject: [PATCH] pinctrl: ocelot: fix duplicate debugfs entry
Date:   Wed, 16 Feb 2022 13:27:27 +0100
Message-Id: <20220216122727.1005041-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

This driver can have up to two regmaps. If the second one is registered
its debugfs entry will have the same name as the first one and the
following error will be printed:

[    2.242568] debugfs: Directory 'e2004064.pinctrl' with parent 'regmap' already present!

Give the second regmap a name to avoid this.

Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-ocelot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index a859fbcb09af..35b213de1af8 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1890,6 +1890,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
 		.val_bits = 32,
 		.reg_stride = 4,
 		.max_register = 32,
+		.name = "pincfg",
 	};
 
 	base = devm_platform_ioremap_resource(pdev, 1);
-- 
2.30.2

