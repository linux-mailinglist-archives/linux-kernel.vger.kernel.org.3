Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E104B9D17
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiBQKZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:25:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbiBQKYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:24:38 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543A1279093;
        Thu, 17 Feb 2022 02:24:19 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4JzrXd5VH7z9sTX;
        Thu, 17 Feb 2022 11:24:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645093456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbvCasmUFqvTSL2/pps15VXLcbVxmyd1SHRFolaNqP8=;
        b=Cb+b5k/E/wvw4yuJsBjyZIkinG6PnTSn0HUPUoHFvYVAcoOXIGO6xHDXe9eLVQ4jEkwstt
        jWxwfLFfJl6pCieYQA+eG76s3r3y6WwSlVh04h5Tj99U1yJl/0NsZLZklZdO6XUfITqmcK
        Nhle+PTGB3Hcye3jSHIJoa+BuqpcZrxwCBoHo2MKwukB6tLtiC8IOiZA0sn3Bi6GVgalIj
        Krp6505oObvHIwV8tGNesFIUywxmSe0cCvnKRYMCPNnEsW9cVCfzKtQsknd0I8SND4pfkz
        6Zzqem7G4+0UPR207J7mZjpOUEfclDdGZ6/+Vcoy4lbq9aY93vYXWNYnxY0RIg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v1 1/1] hwmon: (pmbus) Add regulator supply into macro
Date:   Thu, 17 Feb 2022 11:23:49 +0100
Message-Id: <d3563864d03a3d3450cf00b3be05465dc506e161.1645092563.git.sylv@sylv.io>
In-Reply-To: <cover.1645092563.git.sylv@sylv.io>
References: <cover.1645092563.git.sylv@sylv.io>
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

Add optional regulator supply into PWBUS_REGULATOR macro. This makes it
possible to define a vin-supply in DT. Not defining a supply will only
cause the following debug output:

```
Looking up vin-supply property in node [...] failed
```

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/hwmon/pmbus/pmbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index e0aa8aa46d8c..38f049d68d32 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -464,6 +464,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
 #define PMBUS_REGULATOR(_name, _id)				\
 	[_id] = {						\
 		.name = (_name # _id),				\
+		.supply_name = "vin",				\
 		.id = (_id),					\
 		.of_match = of_match_ptr(_name # _id),		\
 		.regulators_node = of_match_ptr("regulators"),	\
-- 
2.34.1

