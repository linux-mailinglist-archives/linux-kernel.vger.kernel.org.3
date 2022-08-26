Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C975A241B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbiHZJUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbiHZJUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:20:34 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7267C22A6;
        Fri, 26 Aug 2022 02:20:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 202so883672pgc.8;
        Fri, 26 Aug 2022 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=XCs65AqKF8nYHmFctjAQYP7Kb099G/Og2TNUg8MNKII=;
        b=JGla83o4EgOfL5+TIw5GjgufqCFO2gy8TNbUDZGFMZ4nuo7eKlMlPnA7W40U7CO/cb
         azamcgWFAWxmbH/gHVcphRRBRIjT9+4IDmrjFSTMPGGAnB3lmQWNhlPcCtE/OXZIzrNH
         4g/170IeHv63xOVNtsgNT9ZIk0ye39WSyLdrv09KkcfEj6HOFMwttC/6gGhULWo08LbD
         aw3UQjhMk9CEkfeIhifRaZoXDQohXRy4svQ59jx1H1FUGHG6FKrB/Lclm03Zyj19t0RU
         o05oTTQr16YqfzH4kKsuzEwIRU0BdRB7HlCwK+yc0u5SmbLTc1V9K+a7KZM4MoqKtivP
         cwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XCs65AqKF8nYHmFctjAQYP7Kb099G/Og2TNUg8MNKII=;
        b=i9VJNpTpL2tMd43uD8qzCKXRKAOkiiAwyh3KnaQAvqMIZIoc4+AVH2wTochiBqLacR
         XA+VcLX7IfO9OopF9qirrpdYsGrNd1Nlr/oEyTiKTVRq/ZT8VAXodwLJM70QpGkFsEKX
         2+LVD1sBmQXf9B/o0yCED3Pw+zhX6yB+nXiJaOA2HvcdJBTl+FttnEiSGuRyONy7ooRX
         n14caVGZnhNgtv66MPmLbIjGO65dREQQg9Gqmg16f9+XDgikLdofnMOoQ2ReYQpYFH9k
         YA2Ib0sm1n77+waJxOT+FZoSgKP1b19RlHw4YtQOO/VHVvW0pEof+cRRbROuWkWbBK/2
         10NQ==
X-Gm-Message-State: ACgBeo06Qf22/x/YtpbyX7ixcV1yf9lHr0iwQGFQPe2LnhtsybREnsaE
        k9hdUGoVj9VdhzS+hO9fpi1Qskag6gU=
X-Google-Smtp-Source: AA6agR5jrsZxC3iHTVCO+cuXMEZUzntCr8rOW47hsOLq7CpxuTlfCqMhn+FvN77l0/HR4VazgkdgQQ==
X-Received: by 2002:a05:6a00:1a93:b0:536:5dca:a685 with SMTP id e19-20020a056a001a9300b005365dcaa685mr3046037pfv.13.1661505632382;
        Fri, 26 Aug 2022 02:20:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902d64b00b0016d88dc7745sm1025429plh.259.2022.08.26.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:20:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     linux@roeck-us.net
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xupanda <xu.panda@zte.com.cn>, Zeal Robot <zeal@zte.com.cn>
Subject: [PATCH linux-next v2] usb: typec: tcpm: tcpci: Remove the unneeded result variable
Date:   Fri, 26 Aug 2022 09:17:32 +0000
Message-Id: <20220826091731.254966-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: xupanda <xu.panda@zte.com.cn>

Return the value regmap_update_bits() directly instead of
storing it in another redundant variable.

Reported-by: Zeal Robot <zeal@zte.com.cn>
Signed-off-by: xupanda <xu.panda@zte.com.cn>

---
change for v2
 - remove those irrelevant sentences 
---

 drivers/usb/typec/tcpm/tcpci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index b2bfcebe218f..29047da826a9 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -328,11 +328,9 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(dev);
-	int ret;
 
-	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
+	return regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
 				 enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);
-	return ret;
 }
 
 static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
-- 
2.25.1

