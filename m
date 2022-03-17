Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E214DD11B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiCQXW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiCQXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:22:51 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904551FD2D8;
        Thu, 17 Mar 2022 16:21:33 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso8301764oop.13;
        Thu, 17 Mar 2022 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cV2G53aQ8gy5xgFrzeVM67TOnDJP6UFgv7JOAg+ZKWQ=;
        b=M7g23SMXsoBSpy5meppRZhZ9iJd6A1uiBr9hvVMVpqk+LXXZx6qHDtr5tv8/j5pqXl
         18GJFWFYcUiH8MfsMi05vmvsjihNU6mF10W/KnfcwystkmUCBfcHc3Dzelei1Dv2kyI3
         9LhhVYktOShrLdOw4kqCJ/cOlOAkM1C1+kzA/Uw93daCZYZaHrpxIQq4LB4w1eLL2rSe
         vu/DLza6h8iMKOUrFA+LYcKYBfb8X/5zXDwDYP7ZRCUKjry2F8oeEzUxHHdBeW0Chje1
         GTEVVwGXVwXMuFP0sDOqDOaGErYFIDJ7ejZYdgkkwtUyBhwf94QX16auJz1djyhta7P4
         SsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cV2G53aQ8gy5xgFrzeVM67TOnDJP6UFgv7JOAg+ZKWQ=;
        b=qrrFrxh+EFYIMfStyOxYALZzeV65H7TaujNOcJX9wZoQmLQUs1jXUxImTH3BWHokUy
         CUAuWJ1JofSGG8x3FFomx5u8JQ8fv9efqqMk77ak7FrwDALBjyoRRLI4dBg++0vLMuVZ
         /5LVDKAfYOUqeXeaAsgXofIjnx9pHnx67PhYklWWfdrEyzEYOJOW5ZnmYI46Lw3EKzoH
         L+aNtD00Y9Zg+zbl1WlxLLhLPqTJY2rodQ8fKEneB1/9GgEKXwb174VjZYuG5SncQBny
         etJu2fx9D+sIFd1Gbojhje9kHCzQG8ypTTvsP7feIfWLF9pAqkaFp3n1Toj9lcTKx9Ha
         OXPw==
X-Gm-Message-State: AOAM533Hl0znHYDb8RncHgEuLYsXz3FYlc2t1/21FhTUy+TDoamZ3b4O
        S4cXLv/dWuEa+NyXZ0FNpeg6TYfbjJe+mA==
X-Google-Smtp-Source: ABdhPJxJ+l9rTlCJYd2wVYy2pwNS7uAh2Sp5Ne51ph7mT/7XNCauNvYRHmWpLePy55iAhu00t0gKlw==
X-Received: by 2002:a05:6870:c10b:b0:da:40b:9d92 with SMTP id f11-20020a056870c10b00b000da040b9d92mr2800341oad.31.1647559292787;
        Thu, 17 Mar 2022 16:21:32 -0700 (PDT)
Received: from fstone04p1.aus.stglabs.ibm.com ([129.41.86.15])
        by smtp.gmail.com with ESMTPSA id 2-20020a056870124200b000dd9ac0d61esm2869159oao.24.2022.03.17.16.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:21:32 -0700 (PDT)
From:   Brandon Wyman <bjwyman@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Brandon Wyman <bjwyman@gmail.com>
Subject: [PATCH] hwmon: (pmbus) Add Vin unit off handling
Date:   Thu, 17 Mar 2022 23:21:23 +0000
Message-Id: <20220317232123.2103592-1-bjwyman@gmail.com>
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

If there is an input undervoltage fault, reported in STATUS_INPUT
command response, there is quite likely a "Unit Off For Insufficient
Input Voltage" condition as well.

Add a constant for bit 3 of STATUS_INPUT. Update the Vin limit
attributes to include both bits in the mask for clearing faults.

If an input undervoltage fault occurs, causing a unit off for
insufficient input voltage, but the unit is off bit is not cleared, the
STATUS_WORD will not be updated to clear the input fault condition.
Including the unit is off bit (bit 3) allows for the input fault
condition to completely clear.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
---
 drivers/hwmon/pmbus/pmbus.h      | 1 +
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index e0aa8aa46d8c..ef3a8ecde4df 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -319,6 +319,7 @@ enum pmbus_fan_mode { percent = 0, rpm };
 /*
  * STATUS_VOUT, STATUS_INPUT
  */
+#define PB_VOLTAGE_VIN_OFF		BIT(3)
 #define PB_VOLTAGE_UV_FAULT		BIT(4)
 #define PB_VOLTAGE_UV_WARNING		BIT(5)
 #define PB_VOLTAGE_OV_WARNING		BIT(6)
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index ac2fbee1ba9c..a0d899dc81f0 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1373,7 +1373,7 @@ static const struct pmbus_limit_attr vin_limit_attrs[] = {
 		.reg = PMBUS_VIN_UV_FAULT_LIMIT,
 		.attr = "lcrit",
 		.alarm = "lcrit_alarm",
-		.sbit = PB_VOLTAGE_UV_FAULT,
+		.sbit = (PB_VOLTAGE_UV_FAULT | PB_VOLTAGE_VIN_OFF),
 	}, {
 		.reg = PMBUS_VIN_OV_WARN_LIMIT,
 		.attr = "max",
-- 
2.25.1

