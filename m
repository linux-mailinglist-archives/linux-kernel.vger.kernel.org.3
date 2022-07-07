Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F69569B41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiGGHDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiGGHCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:02:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD21D3204B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:02:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x184so4183579pfx.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=OXuBgzWBg6rqhTHKRec3lrq5ZNp5TJ7Tdv7sGffBB5Q=;
        b=RJ9KDFxkt1uB1GUZyModTw+2e3QjvSrnOeVLV+69Hj6TwUF8MYQeDxgCowXBFBiSfr
         /cFZPsqZdSyKc+g1Vu7VcYCgRf/m30Kjvlov7wuowXJzMb0/GQuB7HXerk8MDGOKCpkn
         JsqVwWXlQEnE+lkQYKo8+sngyhXTPPRYcfXn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=OXuBgzWBg6rqhTHKRec3lrq5ZNp5TJ7Tdv7sGffBB5Q=;
        b=LBQ/T1R1URK9J/v+n6kXCfmgIv+C59CEW9qpVjN3BX7VTPN1F6CBtGUPsoPG392vtD
         8BvzCo3kxP5LdvyRhJ8UnZ0347CaKRj05WCziJkPehJRx8qFnnYhjH3qdGcZ5zVN8gaE
         FEBxcLJ5069Ex4EqhKsDW7JhpK42mUauyRJsR9iDMoybDoMcSJyPkb78GienJx6dAR5N
         i+Gk2nnxMauD/4QLOB6FWvaMAE5G3fomzAkPfwbDaC8I1hA9KCv5abmpBSLyi4X5GdQZ
         QXzChzB6yOZZ3EcuMbK73T/zZS/f8U8ORk7czngTR+5PcyTtFn9mWsGWRlzauRtY7jTY
         oR8A==
X-Gm-Message-State: AJIora9q6NvuyBnkt12X3+yUKrp3P61pGoffy1IgKpYznd1mBcPNOAie
        ob8ovT44Wti/NeVNJ6r5+zT98A==
X-Google-Smtp-Source: AGRyM1t2DE9ibu6bkz4BeglaLbRhyxxPWbT7flgw2V81ZowLY5UW/N5TUSFgfEP2l8FHl8rgF0VO9Q==
X-Received: by 2002:aa7:8e45:0:b0:528:9e96:744b with SMTP id d5-20020aa78e45000000b005289e96744bmr10946819pfr.19.1657177334287;
        Thu, 07 Jul 2022 00:02:14 -0700 (PDT)
Received: from ubuntu-22.localdomain ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b001ec9b7efec2sm18291626pjs.5.2022.07.07.00.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:02:12 -0700 (PDT)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] arm: bcmbca: Move BCM63138 ARCH_BCM_63XX to ARCH_BCMBCA
Date:   Thu,  7 Jul 2022 00:00:35 -0700
Message-Id: <20220707070037.261532-6-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707070037.261532-1-william.zhang@broadcom.com>
References: <20220707070037.261532-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005be8d005e331aab9"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005be8d005e331aab9
Content-Transfer-Encoding: 8bit

Remove ARCH_BCM_63XX Kconfig for BCM63138 and merge its selections to
ARCH_BCMBCA. Delete bcm63xx.c as it is no longer needed.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

(no changes since v1)

 arch/arm/mach-bcm/Kconfig   | 26 +++++++++-----------------
 arch/arm/mach-bcm/Makefile  |  7 +------
 arch/arm/mach-bcm/bcm63xx.c | 17 -----------------
 3 files changed, 10 insertions(+), 40 deletions(-)
 delete mode 100644 arch/arm/mach-bcm/bcm63xx.c

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index f73a056bf560..25aa4ef4db07 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -182,23 +182,6 @@ config ARCH_BCM_53573
 	  The base chip is BCM53573 and there are some packaging modifications
 	  like BCM47189 and BCM47452.
 
-config ARCH_BCM_63XX
-	bool "Broadcom BCM63xx DSL SoC"
-	depends on ARCH_MULTI_V7
-	select ARCH_HAS_RESET_CONTROLLER
-	select ARM_ERRATA_754322
-	select ARM_ERRATA_764369 if SMP
-	select ARM_GIC
-	select ARM_GLOBAL_TIMER
-	select CACHE_L2X0
-	select HAVE_ARM_ARCH_TIMER
-	select HAVE_ARM_TWD if SMP
-	select HAVE_ARM_SCU if SMP
-	help
-	  This enables support for systems based on Broadcom DSL SoCs.
-	  It currently supports the 'BCM63XX' ARM-based family, which includes
-	  the BCM63138 variant.
-
 config ARCH_BRCMSTB
 	bool "Broadcom BCM7XXX based boards"
 	depends on ARCH_MULTI_V7
@@ -224,10 +207,19 @@ config ARCH_BCMBCA
 	select ARM_AMBA
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_GLOBAL_TIMER
+	select CACHE_L2X0
+	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_SCU if SMP
+
 	help
 	  Say Y if you intend to run the kernel on a Broadcom Broadband ARM-based
 	  BCA chipset.
 
 	  This enables support for Broadcom BCA ARM-based broadband chipsets,
 	  including the DSL, PON and Wireless family of chips.
+
 endif
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 284ea2f8cbc2..25347d7049b8 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -50,12 +50,6 @@ ifeq ($(CONFIG_ARCH_BCM_5301X),y)
 obj-$(CONFIG_SMP)		+= platsmp.o
 endif
 
-# BCM63XXx
-ifeq ($(CONFIG_ARCH_BCM_63XX),y)
-obj-y				+= bcm63xx.o
-obj-$(CONFIG_SMP)		+= bcm63xx_smp.o bcm63xx_pmb.o
-endif
-
 ifeq ($(CONFIG_ARCH_BRCMSTB),y)
 CFLAGS_platsmp-brcmstb.o	+= -march=armv7-a
 obj-y				+= brcmstb.o
@@ -64,5 +58,6 @@ endif
 
 # BCMBCA
 ifeq ($(CONFIG_ARCH_BCMBCA),y)
+obj-$(CONFIG_SMP)		+= bcm63xx_smp.o bcm63xx_pmb.o
 obj-y				+= bcmbca.o
 endif
diff --git a/arch/arm/mach-bcm/bcm63xx.c b/arch/arm/mach-bcm/bcm63xx.c
deleted file mode 100644
index f855e361dfba..000000000000
--- a/arch/arm/mach-bcm/bcm63xx.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-// Copyright (C) 2014 Broadcom Corporation
-
-#include <linux/of_platform.h>
-
-#include <asm/mach/arch.h>
-
-static const char * const bcm63xx_dt_compat[] = {
-	"brcm,bcm63138",
-	NULL
-};
-
-DT_MACHINE_START(BCM63XXX_DT, "BCM63xx DSL SoC")
-	.dt_compat	= bcm63xx_dt_compat,
-	.l2c_aux_val	= 0,
-	.l2c_aux_mask	= ~0,
-MACHINE_END
-- 
2.34.1


--0000000000005be8d005e331aab9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TltlrAeBKRJ1M9O/DY5v7L1Yrs//7XIRg/d2ZPAOSGBQzFYjYTFWwNBiR1s1zP0m2y56DPbS5gwj
fqAN/I4PJHIvTh3zUgHXNKadYoYRiPHXfaTWO9UhzysOpQIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUohM5GmNlGWe5wpzDxzIy
+EgzbRswDQYJKoZIhvcNAQELBQADggEBACKu9JSQAYTlmC+JTniO/C/UcXGonATI/muBjWTxtkHc
abZtz0uwzzrRrpV+mbHLGVFFeRbXSLvcEzqHp8VomXifEZlfsE9LajSehzaqhd+np+tmUPz1RlI/
ibZ7vW+1VF18lfoL+wHs2H0fsG6JfoqZldEWYXASXnUrs0iTLgXxvwaQj69cSMuzfFm1X5kWqWCP
W0KkR8025J0L5L4yXfkSO6psD/k4VcTsMJHLN4RfMuaXIT6EM0cNO6h3GypyTuPf1N1X+F6WQPKb
1u+rvdML63P9fX7e7mwwGt5klRnf8aK2VU7mIdYCcrFHaKDTW3fkG6kIgrE1wWSgiZYL400xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw28eX6TfvsbNfu
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGlMIRYbXeg5EfYotflsrUztdzVw
Jzm5gWJDdQtxTi1mMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcwNzA3MDIxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBCTOuA84QOVS4z0fH3jZzW99CUNxyUwqrMTjrGvF7aGhNI
v+/3aqelZf17el79GeobV/auZ2CFQumbIJUJ+dVs8uzEO4aK5DqdsfYTp/QSMzVSHz0CdtdNzgwy
U7dnJUqFLzT493U5Zfpp2JfRmLoNU6pHamaAL7QCTptznORDyiVkDEfT55tYYJO4Rbj7dHYpfO2l
bIRN8y7JbIewod7GeSQm+zZ6OcHQR/bgyd0YiFOhY/SNN2gBjbRzuLo0VKX8b0m5V1MCDzZ9bcMa
9pPBnmBinFEMLQPOyTR8+fr2Qq7ggTmK9m2Fb4EXR8MGIoezA1oYChAyMn5vlrVHWBQL
--0000000000005be8d005e331aab9--
