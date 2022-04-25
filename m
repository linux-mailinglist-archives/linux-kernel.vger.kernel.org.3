Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B8650DD76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbiDYKEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241552AbiDYKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:03:42 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399ED627D;
        Mon, 25 Apr 2022 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1650880837;
  x=1682416837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2TQZYCx5ikLMtqq9rZGikO1te9HCqCd3K7Ahb1z4JPg=;
  b=o5TQ2lyp7C6NaGzOBeBg1iA8D4ROI/3VJWc3zFIQgocBLlkQBDpF4z6/
   ip4hT2Vhd1sXrXxHHhz5tInCs5MQrx8+BNf4SJTNO0scmA7J8PRM1HOCU
   3g3vIibDZ/jsI8dX4HcGP0/FA3k+TmIWq525N5RicAu6n3n+duwlVeXZO
   gevAaostmxdl1o0dSDlhFP62eN0q9DO7y1csIObasHOrQ0k5+XDLxzxt5
   b7i2H7e0f1hVExEb9zGOI0SU33HCLDjKRcgYg0ETLlFfplZh292VXzaUF
   xAlLN+I/E1updt88Gbc0elw41TiudGkTlNyp3RZBIQxga6J3TzC2S0mAg
   Q==;
From:   Camel Guo <camel.guo@axis.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     Camel Guo <camel.guo@axis.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: [PATCH] hwmon: (tmp401) Fix incorrect return value of tmp401_init_client
Date:   Mon, 25 Apr 2022 12:00:19 +0200
Message-ID: <20220425100019.562781-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ti,n-factor, ti,beta-compentation are not defined in devicetree,
of_property_read_u32|s32 returns -EINVAL. In this case,
tmp401_init_client should return 0 instead of simply pass ret to its
caller.

Fixes: c825ca044988 ("hwmon: (tmp401) Add support of three advanced features")
Signed-off-by: Camel Guo <camel.guo@axis.com>
---
 drivers/hwmon/tmp401.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index 8f49da997367..a58a2f31a07e 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -604,7 +604,7 @@ static int tmp401_init_client(struct tmp401_data *data)
 			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int tmp401_detect(struct i2c_client *client,
-- 
2.30.2

