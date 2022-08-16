Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D92E596136
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiHPRdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiHPRdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:33:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689A4DF0E;
        Tue, 16 Aug 2022 10:33:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27GHXVA0085065;
        Tue, 16 Aug 2022 12:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660671211;
        bh=BSQEsZJimftFY0sfDV8OwynBg425lwnJNbxuDUrGP3g=;
        h=From:To:CC:Subject:Date;
        b=rX3YUndRI2x9e6/9sZZ3NVzrWbGNgFRjBY3Jqpgig2WJN37EykDnOR8PyrsV2szYU
         gogsNPFY1xPZAIeSX4FzzExcs0YFkqC5r9d0WV4ysOjdFu6ciNs5y/PfFD9q84lPP0
         KRyj9gdLknNA2epxwn8L/cdc3KPAEeCCDZVQi4d0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27GHXVnq116550
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Aug 2022 12:33:31 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 16
 Aug 2022 12:33:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 16 Aug 2022 12:33:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27GHXVnQ089225;
        Tue, 16 Aug 2022 12:33:31 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Linux RTC <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 1/2] rtc: k3: wait until the unlock field is not zero
Date:   Tue, 16 Aug 2022 12:33:11 -0500
Message-ID: <20220816173312.23243-1-bb@ti.com>
X-Mailer: git-send-email 2.17.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; h=from:subject; bh=uqG2rO48nlT80migsig0i8d0fyHBhC5zfTWKRk0iudo=; b=owEBbQGS/pANAwAKAcD4q9PiE9cMAcsmYgBi+9TXofEzTMSyOXDcVQEu8B3E+gOQfd4YcLa5FWMr bKRLL1KJATMEAAEKAB0WIQT86LDvkHWcjT+1Kb7A+KvT4hPXDAUCYvvU1wAKCRDA+KvT4hPXDLvaCA CrFm/ZcR3J9PEIWmC1bcwfgFZl4gTKsuR/x6yV9XtArOXeUVjD3T3GI+tMY30LAzAeyXkyaqEVN7W4 wvpKKMG3tmU/tKBdLmQj00cn6GjT8AKI0KlMngwQ99XSCAzCwTtNj9R7oFxWmw7+IC1u0H0L7512EK 7vCPMIktke1SMy7Gfg4dqEJoiF+wDVhRhS1Zlszw6kiGGcNdiUY2hy+bZUrXz06vzlYuElAzg0EO5X kd7k0BlJ3yngY5LjZCCFvr5xxsQdqYAPCDn3Ix/WOymOnYhKIRJbdY/hGLetdEMTq6HkscqXXT5aeF StoR89a7ErOMfnFGDOgHIPBGAQnGzX
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After writing the magic words to the KICK0 and KICK1 registers, we must
wait for a 1 in the unlock field of the general control register to
signify when the rtc device is in an unlocked state.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/rtc/rtc-ti-k3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ti-k3.c b/drivers/rtc/rtc-ti-k3.c
index 7a0f181d3fefe..fd26be7868d25 100644
--- a/drivers/rtc/rtc-ti-k3.c
+++ b/drivers/rtc/rtc-ti-k3.c
@@ -190,7 +190,7 @@ static int k3rtc_unlock_rtc(struct ti_k3_rtc *priv)
 
 	/* Skip fence since we are going to check the unlock bit as fence */
 	ret = regmap_field_read_poll_timeout(priv->r_fields[K3RTC_UNLOCK], ret,
-					     !ret, 2, priv->sync_timeout_us);
+					     ret, 2, priv->sync_timeout_us);
 
 	return ret;
 }
-- 
2.17.1

