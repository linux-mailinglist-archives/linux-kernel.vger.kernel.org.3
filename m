Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EB8585AEA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiG3PG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiG3PGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:06:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5498218B18
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:06:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fy29so13051345ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sejWbLeM9dLSZeXoLlKAxwvz+W4OQgS27PLKjp2WElc=;
        b=Dg8eYtEP8xa36wVC0j7UO8wpulsxqYYjhCozlz0ZsIZRpnEQB59p5V2gLz8TbIOBEK
         IdVl0CQLoRcc/u4WbgrqyOkUpcf2nG11Vw9eXSSd+EU3vWH01HLdXbX4D8GFZHYLcXew
         zz9KPHDs6JNoe6/rpK3QgcH4DzNSwU5wj4pyMePQ1NHB0/J5OjjVtnGLKukImTPxp9/n
         aSdG7PCgDvTE0z9WGoi0i185T1zV8otqjCCRniGkbhgxKEl0TY8ayRqwFW9sK1Whb3cz
         /Mnf4Hno2SN/ZMHSXJsQIEES+YhARe5FdJLqZkYLTNBwgHYnraesjyOG061AuJrMe5sM
         MAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sejWbLeM9dLSZeXoLlKAxwvz+W4OQgS27PLKjp2WElc=;
        b=0T/OhgaaDYAQK6PgDF4wFxK/t6KC5NJMfug5LcDwYKUJyMKIFR8u5DcgxdiwxfsGib
         7KlW9xyroOQuWT1JbeyeN2lQ+qGm9AasQZU9ctunybHPoeQWACCfrgDSOlkpP42IoCw1
         QVAubgc2XbWEQzwzWmog4XWJMnEuQcvLaPzdReYe//ZVODd/qgI8P/5iAK2XFeiQgRiD
         jIuBc9GoD57PR/OzZBRPKF2Kucpb5LWmg0lOtzm+A8KfiqnIq3JglXBfIR798LSHaTWN
         G9sT6OtVi/PPgUm8ETArm35+iZb2XxfCO+8rzCpyGD3eJ+VwZvO847iH9VWGYuPQJPgB
         Me7A==
X-Gm-Message-State: AJIora/tc8eNWRT+5Q0Y2GN5B0oIAXUZxCxW0OvEYmrkRGJHsD9+YrGh
        WkprM2j967WLndNrpXsczdc=
X-Google-Smtp-Source: AGRyM1s6//hRZj4v+5sYEEZF7BnuYxuJXMFMGRqLogTNRRpsK61Oul/eOQEHnfTRRzAsWzzOOM6jYA==
X-Received: by 2002:a17:907:6d04:b0:72e:e204:a70b with SMTP id sa4-20020a1709076d0400b0072ee204a70bmr6366453ejc.432.1659193608830;
        Sat, 30 Jul 2022 08:06:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb9e.dynamic.kabel-deutschland.de. [95.90.187.158])
        by smtp.gmail.com with ESMTPSA id sy13-20020a1709076f0d00b00722d5b26ecesm3013989ejc.205.2022.07.30.08.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 08:06:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: convert dump_chip_info() to use netdev_dbg()
Date:   Sat, 30 Jul 2022 17:06:36 +0200
Message-Id: <20220730150637.3550-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220730150637.3550-1-straube.linux@gmail.com>
References: <20220730150637.3550-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should not spam the kernel log if they work properly. Convert
the dump_chip_info() function to use netdev_dbg() instead of pr_info()
so that developers can still enable it if they want to see this
information.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 5b8f1a912bbb..012828a05e6c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -526,8 +526,9 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _size_byte, u8 *pbuf)
 	Hal_EfuseReadEFuse88E(Adapter, 0, _size_byte, pbuf);
 }
 
-static void dump_chip_info(struct HAL_VERSION chip_vers)
+static void dump_chip_info(struct adapter *adapter, struct HAL_VERSION chip_vers)
 {
+	struct net_device *netdev = adapter->pnetdev;
 	uint cnt = 0;
 	char buf[128];
 
@@ -560,9 +561,9 @@ static void dump_chip_info(struct HAL_VERSION chip_vers)
 
 	cnt += sprintf((buf + cnt), "1T1R_");
 
-	cnt += sprintf((buf + cnt), "RomVer(%d)\n", 0);
+	cnt += sprintf((buf + cnt), "RomVer(%d)", 0);
 
-	pr_info("%s", buf);
+	netdev_dbg(netdev, "%s\n", buf);
 }
 
 void rtl8188e_read_chip_version(struct adapter *padapter)
@@ -581,7 +582,7 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 	ChipVersion.VendorType = ((value32 & VENDOR_ID) ? CHIP_VENDOR_UMC : CHIP_VENDOR_TSMC);
 	ChipVersion.CUTVersion = (value32 & CHIP_VER_RTL_MASK) >> CHIP_VER_RTL_SHIFT; /*  IC version (CUT) */
 
-	dump_chip_info(ChipVersion);
+	dump_chip_info(padapter, ChipVersion);
 
 	pHalData->VersionID = ChipVersion;
 }
-- 
2.37.1

