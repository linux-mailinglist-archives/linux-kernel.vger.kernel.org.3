Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16845569B42
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiGGHDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiGGHCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:02:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB2132053
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:02:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w185so13848543pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=uXfw6g9jIwDWYoKukXW5eZYsoS1Sn9T+wnlGs1ltZSM=;
        b=dc8IAVNgQKctWviVf51O6gUxvtBEvPlLJGOMDJZXiUwdevmB4fxrZLwFwBJl95jEDw
         UdPg14zzeBv2J6R9/RrkK65bDZqHRtsd/iMtbTR+EMx4OVRGOBufrwLynpB8S22GpoUx
         NHZUhBGBZyeVGamEndyzuj//N6D2ajDFlUXzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=uXfw6g9jIwDWYoKukXW5eZYsoS1Sn9T+wnlGs1ltZSM=;
        b=h4nDsk60dtRnAxU7LCSX/NVhUiMhilbV6BJg6FU2xAToHOCEi4AK+3FCVqjSmcYyfE
         z/FdA2Gr0V/sB3TdqSZy1fqm9GwaUA6kJiYvWp+uhHZCwe2tT1Lz39n8w94qq/2h3xhG
         uu1WwsskiBZXZiKmJXKqLv31GsGae/4dE7gUWkEDeJ1xywmFNRY6L82FgbDKDm2/LAXS
         NMMxbrLIKCcVKJlcIEw7wbpi6BppkZm4PGRSlZ3EnKJ1+0ThpSwq4a/26Ic2GRaoSOc+
         YcQR4rMXW74bRQqmRW1//8Tzh2cqncUe2JkeDtWVnsOBhjL6HLqdj5sgjCccQDXMMwTS
         UCxw==
X-Gm-Message-State: AJIora/Uo/iwEB31kba9o/Rr3AqulJ336/KoWfJh5yPoR/X5tvLDtf9Z
        961OkZ+Cvt4Na9dQ+6ouNq9UaQ==
X-Google-Smtp-Source: AGRyM1uB2PQUunHYqFYlK2cXI1ZzCx8ondZhO96zvrHgsuXkLzjJ1BheubUWCmwwCuFFk1JJpo1RfQ==
X-Received: by 2002:a17:90b:3a8e:b0:1ef:93e5:afbd with SMTP id om14-20020a17090b3a8e00b001ef93e5afbdmr3348950pjb.23.1657177336987;
        Thu, 07 Jul 2022 00:02:16 -0700 (PDT)
Received: from ubuntu-22.localdomain ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b001ec9b7efec2sm18291626pjs.5.2022.07.07.00.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:02:15 -0700 (PDT)
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
Subject: [PATCH v2 6/8] arm: bcmbca: Add BCMBCA sub platforms
Date:   Thu,  7 Jul 2022 00:00:36 -0700
Message-Id: <20220707070037.261532-7-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707070037.261532-1-william.zhang@broadcom.com>
References: <20220707070037.261532-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000084e37a05e331aac5"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000084e37a05e331aac5
Content-Transfer-Encoding: 8bit

Create new CORTEXA7, CORTEXA9 and BRAHMAB15 BCMBCA sub platform configs to
enable fine-grained selection for each type of ARMv7 SoC.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

(no changes since v1)

 arch/arm/mach-bcm/Kconfig | 45 +++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 25aa4ef4db07..0cd23e549cdd 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -201,25 +201,58 @@ config ARCH_BRCMSTB
 	  This enables support for Broadcom ARM-based set-top box chipsets,
 	  including the 7445 family of chips.
 
-config ARCH_BCMBCA
+menuconfig ARCH_BCMBCA
 	bool "Broadcom Broadband SoC"
 	depends on ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
-	select ARCH_HAS_RESET_CONTROLLER
+	help
+	  Say Y if you intend to run the kernel on a Broadcom Broadband ARM-based
+	  BCA chipset.
+
+	  This enables support for Broadcom BCA ARM-based broadband chipsets,
+	  including the DSL, PON and Wireless family of chips.
+
+comment "BCMBCA sub platforms"
+
+if ARCH_BCMBCA
+
+config ARCH_BCMBCA_CORTEXA7
+	bool "Cortex-A7 SoCs"
+	help
+	  Say Y if you intend to run the kernel on a Broadcom Broadband ARM A7
+	  based chipset.
+
+	  This enables support for Broadcom BCA ARM A7 broadband chipsets,
+	  including various DSL, PON and Wireless family of chips.
+
+config ARCH_BCMBCA_CORTEXA9
+	bool "Cortex-A9 SoCS"
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_GLOBAL_TIMER
 	select CACHE_L2X0
 	select HAVE_ARM_TWD if SMP
 	select HAVE_ARM_SCU if SMP
+	help
+	  Say Y if you intend to run the kernel on a Broadcom Broadband ARM A9
+	  based BCA chipset.
 
+	  This enables support for Broadcom BCA ARM A9 broadband chipset. Currently
+	  only DSL chip BCM63138.
+
+config ARCH_BCMBCA_BRAHMAB15
+	bool "Brahma-B15 SoCs"
+	select ARM_ERRATA_798181 if SMP
 	help
-	  Say Y if you intend to run the kernel on a Broadcom Broadband ARM-based
-	  BCA chipset.
+	  Say Y if you intend to run the kernel on a Broadcom Broadband ARM B15
+	  based BCA chipset.
 
-	  This enables support for Broadcom BCA ARM-based broadband chipsets,
-	  including the DSL, PON and Wireless family of chips.
+	  This enables support for Broadcom BCA ARM B15 broadband chipset. Currently
+	  only DSL chip BCM63148.
+
+endif
 
 endif
-- 
2.34.1


--00000000000084e37a05e331aac5
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFRhFP8sKzQHRIpHF6MMimETAi50
YBd8rC12S+vl3MvCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcwNzA3MDIxN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCJsMKvK2TA0VfWSejQbpNcyutWAWXXAPhVuTFL4JxQe23j
MHYRGGUmAnI/eloNR9TFGojeUpThoEQIKvoXDCKOddszuN8FJ/xMboUzrz2/r4xe1s5NRI5uQLkz
4DxItEXPpucfDZTZwOdVmDsBgeM251MQBohUVf1WvdOW4UUE21L0E0ZktG8qaaQEbjd/lhGczaAJ
MZEH/BhQQ7rBYJHaOCGmo+wwHEw+t1N9gM+XKkcc7GO6SALopfygRGXo45K3m2RbSqaxzdLGh10r
eiGI1IC19HdDYAw4E5MEF2EVExw5/OnwE/NNo7eLik380A3qdx0+rwJ/8f2ZKzfOcGEA
--00000000000084e37a05e331aac5--
