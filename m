Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E96A4C8C50
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiCANNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiCANNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:13:10 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B37C12;
        Tue,  1 Mar 2022 05:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646140348;
  x=1677676348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SiBbFJCKuZ3OQnC8duTiCLF5hmEwEETvZMAIa1BnuPE=;
  b=PdN2ZCGHKG4diZ3dHtN989eFS+bOJ54N2JbpdqCWu8pIVR86BoY1yZE0
   AILomtcQx34OwxYtQfIA3eZ8HKE2YdvJHkS9l3TWgiRj0jt48XpBGooUW
   O0Y7o5vJtHgXKEQWlLZWEiUZI+W4w+UtM5PddHe1D3910TUtFOtjP2HDA
   5bmofDrgBvq9E1ibK5PEn645+X5/KfhtxouJFUP94yNoguESJzuJQxRUY
   w5pQA/Dvsd9PLozeenHFNUqRhg/k1fE77/fDYJE62kqmEqVSqm4dqihiq
   6RhC6ilgBoSUXQQjHf0FJVTfNUZHuzdSVMg01CFJe/sG/cxkU+JkUPCi/
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtc: pcf8563: clear RTC_FEATURE_ALARM if no irq
Date:   Tue, 1 Mar 2022 14:12:20 +0100
Message-ID: <20220301131220.4011810-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no IRQ hooked up, clear RTC_FEATURE_ALARM to make the core
ensure that userspace is made aware that alarms are not supported.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    Could there be some board which uses the RTC for wakeup using wakealarm but
    which doesn't have an IRQ?  Then this patch will stop it from working since
    wakealarm requires RTC_FEATURE_ALARM too.
    
    It's unclear how that needs to be addressed.  There seems to be a lot of
    variation in how different RTC drivers handle these flags.  Some call
    device_set_wakeup_capable(), either conditionally based on the irq or always,
    while others don't call it at all.  Some call dev_init_wakeup(), others don't.
    Some don't clear RTC_FEATURE_ALARM if wakeup-source is set, others don't check
    wakeup-source and only clear RTC_FEATURE_ALARM based on the irq.  Others never
    clear RTC_FEATURE_ALARM.

 drivers/rtc/rtc-pcf8563.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index c8bddfb94129..ade3a564bd33 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -580,6 +580,8 @@ static int pcf8563_probe(struct i2c_client *client,
 								client->irq);
 			return err;
 		}
+	} else {
+		clear_bit(RTC_FEATURE_ALARM, pcf8563->rtc->features);
 	}
 
 	err = devm_rtc_register_device(pcf8563->rtc);
-- 
2.34.1

