Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46C74D35D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiCIQgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiCIQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:03 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A64B1AB1;
        Wed,  9 Mar 2022 08:23:19 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5E1AD1BF210;
        Wed,  9 Mar 2022 16:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646842996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkEkDTI4tmdKd0a5g97aV1gCfKtgE0kgXH2OsM8PUbk=;
        b=lt5/zNeevA1SELacA+piVtBOZkIgnA4bl+MJRkj/xLnqI2nne9xT/28s3IfAy+HVgT9DYh
        MNdBDIIzfoxK90bLXS7d8YpFlev9L++3TUvuxpC2TgFcPQtssPvLmD7OYoZV717TRD6w58
        tgaXY8FzCluR6Vnu2TrqwntuXezM9IUDRd/ptC2/JsOlwxzdPgxESWRzvOL8imKTqOq+ip
        owwZZetjEW4h1mfMF24EIa7fji2o9Yi4Js3jYvN/A3jYosJ+z/jt7DH22+a0rrvlCXtRjx
        +47jiHOt8KnDj950TKqfOHrab3slu31B432LSPU2KmTHcdczeaWvvma9r/u28Q==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/29] rtc: ds1307: switch to RTC_FEATURE_UPDATE_INTERRUPT
Date:   Wed,  9 Mar 2022 17:22:34 +0100
Message-Id: <20220309162301.61679-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using uie_unsupported and clear RTC_FEATURE_UPDATE_INTERRUPT instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 336cb9aa5e33..d51565bcc189 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1955,7 +1955,7 @@ static int ds1307_probe(struct i2c_client *client,
 		dev_info(ds1307->dev,
 			 "'wakeup-source' is set, request for an IRQ is disabled!\n");
 		/* We cannot support UIE mode if we do not have an IRQ line */
-		ds1307->rtc->uie_unsupported = 1;
+		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, ds1307->rtc->features);
 	}
 
 	if (want_irq) {
-- 
2.35.1

