Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68FB5740B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiGNBBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGNBBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:01:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BCA1CB02
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:01:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r9so312359lfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWF1kWcT9wxBz0pCIKCeMgLRCPWsycB4mMPiKfgQZvo=;
        b=RsxtLdL6XVjF/9EvPZ/q0ijYIEgUeq6CSqaM6RM50MPare6FTYgLCNypHYoQMCksqS
         ajP6GHw7pWI0gRxfVZQ9jfxqnLNSCBnIU3olfZziYqOHS8ySWMxv7E3qr/5D1zI1uH00
         Q3aVHYaGEgpJnnqvk9FgJnibN2Pma6vkRwp18H+AJujauLWyH5a2qXqlEECFM/RIkYw6
         44z7lw1C5e0oz5dpQpsdb4wO08TmlZFymN+CuhtaLCSr5cZIoULXqM6AwKfuGe/leqQi
         qMTJieSfYKsy1+e5svV03ptxhzzD7hs8u9wZ3m9Vn8kDCKjXpjzN78aAprzDVvKHA7y4
         Agew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWF1kWcT9wxBz0pCIKCeMgLRCPWsycB4mMPiKfgQZvo=;
        b=1LUS4OutfcdWdxqTz96mzKUDOfEazJOTADXuDKeDR0hY2kLaQkNl6WQ0rrnPbzXVHu
         sGCcKiLArq+Wi1GaZl3PwzBU36Dzbo/oZ696rYB2mpKUGzN83RcGDkBJrQiB9bWU9uVC
         cjjiBAupTkaYB3iX1kvIw0nhqC1kOx7QArY6xyoKH2V1T1Zh1wY4PSOGxwDIWXso5jHT
         cXBcYzW308FC/rufJ5DCrgWUyQQMb4d1KA8a7rqYsf6vEuk3X+XR+tZvBnzAiW41qVGS
         6AV19yOxur7+R05LVe3RBVRXkUgzt3/lAjKwuQKp4VqlyhbXgGhYFEsmVoW0LC0ciTAB
         6CHA==
X-Gm-Message-State: AJIora8T47RZ0c93AejFWyop37Bi4/oXTnNe7MfnIv5XY2P1Z+cvfFkD
        WOqJUfONDmZ4pKYy8qAH/qZdvJMIge6OPg==
X-Google-Smtp-Source: AGRyM1suYNn2OTqVyN0AoIxFKs9vGbir5E6Hv14lYeggSk5ewWKh62mMJODbZHHO4oaig2eaC3PzXQ==
X-Received: by 2002:a05:6512:2296:b0:489:d318:8849 with SMTP id f22-20020a056512229600b00489d3188849mr3494930lfu.69.1657760504227;
        Wed, 13 Jul 2022 18:01:44 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512358e00b00489c59819ebsm58169lfr.66.2022.07.13.18.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 18:01:43 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
        mw@semihalf.com, jaz@semihalf.com, tn@semihalf.com
Subject: [net-next: PATCH] net: dsa: mv88e6xxx: fix speed setting for CPU/DSA ports
Date:   Thu, 14 Jul 2022 03:00:21 +0200
Message-Id: <20220714010021.1786616-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3c783b83bd0f ("net: dsa: mv88e6xxx: get rid of SPEED_MAX setting")
stopped relying on SPEED_MAX constant and hardcoded speed settings
for the switch ports and rely on phylink configuration.

It turned out, however, that when the relevant code is called,
the mac_capabilites of CPU/DSA port remain unset.
mv88e6xxx_setup_port() is called via mv88e6xxx_setup() in
dsa_tree_setup_switches(), which precedes setting the caps in
phylink_get_caps down in the chain of dsa_tree_setup_ports().

As a result the mac_capabilites are 0 and the default speed for CPU/DSA
port is 10M at the start. To fix that execute phylink_get_caps() callback
which fills port's mac_capabilities before they are processed.

Fixes: 3c783b83bd0f ("net: dsa: mv88e6xxx: get rid of SPEED_MAX setting")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 37b649501500..9fab76f256bb 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3293,7 +3293,12 @@ static int mv88e6xxx_setup_port(struct mv88e6xxx_chip *chip, int port)
 	 * port and all DSA ports to their maximum bandwidth and full duplex.
 	 */
 	if (dsa_is_cpu_port(ds, port) || dsa_is_dsa_port(ds, port)) {
-		unsigned long caps = dp->pl_config.mac_capabilities;
+		unsigned long caps;
+
+		if (ds->ops->phylink_get_caps)
+			ds->ops->phylink_get_caps(ds, port, &dp->pl_config);
+
+		caps = dp->pl_config.mac_capabilities;
 
 		if (chip->info->ops->port_max_speed_mode)
 			mode = chip->info->ops->port_max_speed_mode(port);
-- 
2.29.0

