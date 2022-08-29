Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1BE5A4135
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiH2DFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH2DFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:05:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F026412749;
        Sun, 28 Aug 2022 20:05:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x26so6921187pfo.8;
        Sun, 28 Aug 2022 20:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=YGMycgUwRPz2tjC0IBocG1q3RSZtySFGaidz43cV5mI=;
        b=m/gLKyuUbF+icm8Yz9zwxD0N9vkmX3cs76hdop5mlBlaFzUWeGVyOLDH0oiVpHeuK1
         VydYgN15GzhWYkSGDqpg5Bhk4ARWqY1x9wiRWaM9ohQwELgakqYvVubm4hH8fLNHpZVz
         1glbhvau8PfbLE7oOds6vVD6MmMNKXmpTzZ8FNbytsXOyC+U/7Wu1irtdVmZr5m4uEe8
         1CulPuo/NP6SqiN/Q2fH7vlO2Vbg0LkzuganH4+ozfQ5mkboRYBRRdAPBRQJwIFLKN/J
         PCXhClXnbaycryphMDz5/pjhsMoWrX6efu2cZXugpaugmEj/y2RuK+TmdD9qQkdQefzT
         8MLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=YGMycgUwRPz2tjC0IBocG1q3RSZtySFGaidz43cV5mI=;
        b=rfuZIFl5i6RP3VNTjpDLOkWJfzHtGXzNskH5bmVDi7SjFdRvoeI5FFAVxynvKT0JO1
         90DNM1bsOz3A3hqy8LoUFW7eK6uVBI+f1U7gMKfUREbn+6+ErP19yO3p9aYAKkGGgqYi
         1IVK1R7mL+AFnqbXQ71qiLi+JPF+JVU1m6uptgxm2YuEybJ3r7OeoPtoGp72VoUHroL9
         mn63tdY4Lmw6wndKIhQ65YyaFUDn4IpuMq+Y7HKst1kzV8phI33UB3sv+HU8BnJSir2Z
         DqF9kD48QHiMDUyq6c0ghY87ZlDG5ZpMGV+G3GaD/vZycXt5ECU7J61seLyjJhpOFWOR
         TNCw==
X-Gm-Message-State: ACgBeo2RCVEmD0dZsXZ4CbQ4kCEXTEXtES6Jnfwp4u6IWH9O9asbTUFL
        UWHw7TFolCm6zqDoy0y9NSM=
X-Google-Smtp-Source: AA6agR7jOTRj0JjX9FzvbZ6qDZVc3TA4M8apOwMPYUKq51zSAfxHPThpv50qvuijD4qdyeGidXowsg==
X-Received: by 2002:a63:5749:0:b0:42b:4002:2f65 with SMTP id h9-20020a635749000000b0042b40022f65mr11881048pgm.340.1661742318529;
        Sun, 28 Aug 2022 20:05:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c23-20020a63ef57000000b0042988a04bfdsm1263680pgk.9.2022.08.28.20.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 20:05:17 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     linux@roeck-us.net
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xupanda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next v3] usb: typec: tcpm: tcpci: Remove the unneeded result variable
Date:   Mon, 29 Aug 2022 03:04:43 +0000
Message-Id: <20220829030442.264695-1-xu.panda@zte.com.cn>
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

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xupanda <xu.panda@zte.com.cn>

---
chang for v3
 - re-align continuation line alignment
---
 drivers/usb/typec/tcpm/tcpci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index b2bfcebe218f..cd243530264b 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -328,11 +328,9 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(dev);
-	int ret;
 
-	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
-				 enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);
-	return ret;
+	return regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
+			enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);
 }
 
 static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
-- 
2.25.1

