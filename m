Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DFE502783
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351809AbiDOJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245712AbiDOJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:44:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB8AC040;
        Fri, 15 Apr 2022 02:41:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso11438554pju.1;
        Fri, 15 Apr 2022 02:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Lt5Azs8UE62t7hvUqRmpYoBuvvMq0qHOp5jSW71Q4WI=;
        b=it9+AZgUreEGNbOCqj3mjB3EWh1Pv2by2M4d4we2/EWRVJsB18V3G3SWiaPRj/+IPZ
         9Pswfro3J0nLvxN2vTrSLTQSDb6HJ4Iqna9DljB1Thpw4CN6nmH7ClgiL/SlK7hDljqs
         D0KZRdVEi/8ssbEVZyPx42ntrWNTBLwfg8skrLztkgyoDUS9OmtryIcnVDmkUklSr7qh
         2y3CWXID/mY5ccp5nZa5uccv813RMJEiL5fUTTUBvvgtNB9MJn2KNsuke0GJxa9a3jb6
         X9kYWf04GUHRfxfkZejDcn5fvpfNRZvRMBjD7S9ANYKHEwRP2B4lT7BRcB9a/MuoUq3X
         MlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lt5Azs8UE62t7hvUqRmpYoBuvvMq0qHOp5jSW71Q4WI=;
        b=7IGjnyq6s0t7VnBqSHtlp5pIS5HmhfVZpVJBjKM6eYlTbUoc+wwgoEhevXAY47UCxw
         nzWNClztV/gly5V1o8zOGGrOjGm8NXH5EC4qcRYyVcLL6EM1Y7zNsC/idElQWZo4se2G
         6LhUuDmYVn1cVP5uGoE2B/BjYG6/ea2mRwXgOaJwtzA/QUlyX8JZAoJPKww7EfaRazII
         VvLd2av7gemWzkNXPJFkciyxIA/F2y9Bc397SS2Qg77WCsK8LDFypi1/HhInP/F7INrM
         Y2JW+afm02KXO5jmPVPsJ5V9PVZ3rXCh63ATXJs7kTjiEf57s1mS8v/AQre5PSjQlV7E
         nUug==
X-Gm-Message-State: AOAM530GWBhI/feGm/LGtzNyavY2OdhsYJ6OsNUAWreIl+poExCZGpRi
        14GE5/miGlHllUvIJqF0SfY=
X-Google-Smtp-Source: ABdhPJzIMuvlYSnmyMEevTCPhzSlyTu/WcAj1C9nr9Vs4FS75fbUHZGIYT3pGgEEf3pteAr1Qf5u8g==
X-Received: by 2002:a17:902:b70c:b0:156:16f0:cbfe with SMTP id d12-20020a170902b70c00b0015616f0cbfemr50796482pls.152.1650015719087;
        Fri, 15 Apr 2022 02:41:59 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id m13-20020a62a20d000000b004fe0ce6d7a1sm2278502pff.193.2022.04.15.02.41.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2022 02:41:58 -0700 (PDT)
From:   Wells Lu <wellslutw@gmail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, Wells Lu <wellslutw@gmail.com>
Subject: [PATCH] pinctrl: Fix an error in pin-function table of SP7021
Date:   Fri, 15 Apr 2022 17:41:28 +0800
Message-Id: <1650015688-19774-1-git-send-email-wellslutw@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first valid item of pin-function table should
start from the third item. The first two items,
due to historical and compatible reasons, should
be dummy items.

The two dummy items were removed accidentally in
initial submission. This fix adds them back.

Signed-off-by: Wells Lu <wellslutw@gmail.com>
---
 drivers/pinctrl/sunplus/sppctl_sp7021.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/sunplus/sppctl_sp7021.c b/drivers/pinctrl/sunplus/sppctl_sp7021.c
index 9748345..cd65776 100644
--- a/drivers/pinctrl/sunplus/sppctl_sp7021.c
+++ b/drivers/pinctrl/sunplus/sppctl_sp7021.c
@@ -419,7 +419,15 @@ static const struct sppctl_grp sp7021grps_prbp[] = {
 	EGRP("PROBE_PORT2", 2, pins_prp2),
 };
 
+/*
+ * Due to compatible reason, the first valid item should start at the third
+ * position of the array. Please keep the first two items of the table
+ * no use (dummy).
+ */
 const struct sppctl_func sppctl_list_funcs[] = {
+	FNCN("", pinmux_type_fpmx, 0x00, 0, 0),
+	FNCN("", pinmux_type_fpmx, 0x00, 0, 0),
+
 	FNCN("L2SW_CLK_OUT",        pinmux_type_fpmx, 0x00, 0, 7),
 	FNCN("L2SW_MAC_SMI_MDC",    pinmux_type_fpmx, 0x00, 8, 7),
 	FNCN("L2SW_LED_FLASH0",     pinmux_type_fpmx, 0x01, 0, 7),
-- 
2.7.4

