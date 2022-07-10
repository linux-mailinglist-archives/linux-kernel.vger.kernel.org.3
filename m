Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779AE56CE1A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiGJIzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:55:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4176F2AD9;
        Sun, 10 Jul 2022 01:55:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l42so1430714wms.5;
        Sun, 10 Jul 2022 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCc/12kJgYRwCmgyCNs4BbEuU6ksyhzPFxsHQ2CRTfw=;
        b=dHwGhsaQw8Jneqf/dZmiEccZBSAsrkFwtsz57JMXeep7XK9A4JKt88PmzjRf+eFX/x
         tdwWA5pxR4m/LmIro1jemoTN3hVtQ4bji9vxY2zcsHA7+VRdye8VX+gAWEAdzQjGFlWQ
         jZqH3Q4ITEhMweb8hVeK6ygjthCgYDVPs91sA8TNzsI0sP7BrT5eVQJPoSb5+6NjnQD3
         c02ZS6/4PhwKrv+Xcg0dI/+fjT5/35i1vC04DDtfFMcyWFngfroYQYJfVm7JeJnqHc9I
         ZMc4/+IgSoJ3r0uFNhzoI064yBtuo2V/Qe79QWYbqnBH7zlzSTGK+biVAuKjC0I0JFF/
         vAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCc/12kJgYRwCmgyCNs4BbEuU6ksyhzPFxsHQ2CRTfw=;
        b=LasQUlARTQdrAeRiaLDIundLWSYtCSVre+oobBO/KjWcY7ts80vRw1O093EkmeLIXl
         AtWHUS4Ry/767HihBaupC+/CRI8JIPsTLLkwj+GEH48pdsDF+3L5pHetu2AwKXtNCmKY
         oqq7cUuRNSUFOdZDZUq6XSZYlV90/Ea7+4ZvZLIFgtkHZ7dIW0XHrAABxMhpQrUnr+eI
         wFghg9asU0/PUSIwSoSGhSC7DZG1APpNqbEH8pJtcn+od94GX1HwVQ/rNQXV2tEHUIkG
         RG/DbvaLTn9fNSoF23nPNp+VSD/I9CYTKuVuhJIHThjxjzIKuzYFT2w5S7J3wcqtiHEi
         Fkjw==
X-Gm-Message-State: AJIora80LlT79CDfdyH2mG/WPzGEhS/+TycDSIYVNfeEB7C5wyB9Isk7
        Ra6YVm0KXNKL6c60sy6oVwMfwYLq6IE=
X-Google-Smtp-Source: AGRyM1tsIZdYXokBVw/kf0KOxhRjd1hTQXU2iqSxN1qHS3NlVjVacwU5Xs7nWEfWx1PbdM3nLFByZQ==
X-Received: by 2002:a05:600c:3d8b:b0:3a0:466c:b08d with SMTP id bi11-20020a05600c3d8b00b003a0466cb08dmr9321498wmb.125.1657443342724;
        Sun, 10 Jul 2022 01:55:42 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f2e4000d7544521133919bb.dip0.t-ipconnect.de. [2003:cf:9f2e:4000:d754:4521:1339:19bb])
        by smtp.googlemail.com with ESMTPSA id p12-20020a5d48cc000000b0021d9d13bf6csm1707467wrs.97.2022.07.10.01.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 01:55:42 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add missing sensors for X570-I GAMING
Date:   Sun, 10 Jul 2022 10:55:38 +0200
Message-Id: <20220710085539.1682869-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
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

VRM and chipset temperature for ROG STRIX X570-I GAMING were missing
according to a user contribution to the LHM project [1].

[1] https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/pull/767

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 625c2baa35ec..0749cd023a32 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -366,9 +366,10 @@ static const struct ec_board_info board_info[] = {
 	},
 	{
 		.board_names = {"ROG STRIX X570-I GAMING"},
-		.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
-			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
-			SENSOR_IN_CPU_CORE,
+		.sensors = SENSOR_TEMP_CHIPSET | SENSOR_TEMP_VRM |
+			SENSOR_TEMP_T_SENSOR |
+			SENSOR_FAN_VRM_HS | SENSOR_FAN_CHIPSET |
+			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 		.family = family_amd_500_series,
 	},
-- 
2.35.1

