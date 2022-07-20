Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A0457C129
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiGTXw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiGTXwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:52:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BCE7479E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:52:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 17so252596pfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=a3OguH8eaWNUdzIKiVwF6MdPX3UiQkvOvo8rNj3ZjYg=;
        b=WvdqwtCwNeeRqNX+X1mDBFyXnPmoZx1aRXArXLVPC0SsHebz4WvwiLAs2JmIlCgUIx
         QmhJHQA9Wo+caj3BfnBPiYar8h6XRd1QtJB4ElX1hhSLu+5TmGo4gQL9XbitDK2y6tHx
         821z3QE5E+jz+53+UrrpfUWD2eCq3nU7doYOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=a3OguH8eaWNUdzIKiVwF6MdPX3UiQkvOvo8rNj3ZjYg=;
        b=oOECsanlV2U1EaKrgO7kWIKFUW0H1Tm/YCFQCm5NI97sRObi76/9kfh8atuYeIbQxJ
         gsZUGx4Ny/quoiucRGJrzPqVlOmpTtFbVvyJK/khRKe7RP5mdYYLDM3eSZ7q+5YVg8A3
         yGz5ZL6VEmOAIJrXgqk5Q+ae78L76zrtKDmErf27i2B2KpBgl5M5QKWLQEdRLCefX/OV
         ENhWbLj+yfWHfHXhSbUC6T9PEoJtIC9VNjeDog7Ojy0gEPrbC3nK0AvaJ2Ea9aWSAX1M
         FpVEGyaStnoabBN48Vf6Xan5wxjwaBW0SUKSBf9mneyvurjDCqjSyJdL9yHxOL8/KA3P
         jFnA==
X-Gm-Message-State: AJIora+wCJOyAGLG3oWWBXD50vsPJ2LB9g3XYkrSGmVicG+GRYmp0tvU
        icedUySVaFvzfYP10Z8cTv9Ajw==
X-Google-Smtp-Source: AGRyM1sEWKESkA5mCU6o6vOli/VHUODRBfFvQiNVVaGzkQRq/r+pW+mi68Ogrb1AXeJkEIPA90QYjg==
X-Received: by 2002:a05:6a00:2495:b0:52b:7a9:9c72 with SMTP id c21-20020a056a00249500b0052b07a99c72mr41243961pfv.46.1658361132693;
        Wed, 20 Jul 2022 16:52:12 -0700 (PDT)
Received: from ubuntu-22.localdomain ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0016d1e2a240dsm123715plg.202.2022.07.20.16.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:52:11 -0700 (PDT)
From:   William Zhang <william.zhang@broadcom.com>
To:     william.zhang@broadcom.com
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCMBCA
        ARM ARCHITECTURE)
Subject: [PATCH 1/9] dt-bindings: arm64: bcmbca: Merge BCM4908 into BCMBCA
Date:   Wed, 20 Jul 2022 16:52:07 -0700
Message-Id: <20220720235207.29064-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000403b2405e4454a0a"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000403b2405e4454a0a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Copy BCM4908 SoC device tree descriptions into BCMBCA binding
and delete the BCM4908 binding document.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

 .../bindings/arm/bcm/brcm,bcm4908.yaml        | 42 -------------------
 .../bindings/arm/bcm/brcm,bcmbca.yaml         | 21 ++++++++++
 2 files changed, 21 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml
deleted file mode 100644
index 9b745531ff04..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml
+++ /dev/null
@@ -1,42 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/arm/bcm/brcm,bcm4908.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Broadcom BCM4908 device tree bindings
-
-description:
-  Broadcom BCM4906 / BCM4908 / BCM49408 Wi-Fi/network SoCs with Brahma CPUs.
-
-maintainers:
-  - Rafał Miłecki <rafal@milecki.pl>
-
-properties:
-  $nodename:
-    const: '/'
-  compatible:
-    oneOf:
-      - description: BCM4906 based boards
-        items:
-          - enum:
-              - netgear,r8000p
-              - tplink,archer-c2300-v1
-          - const: brcm,bcm4906
-          - const: brcm,bcm4908
-
-      - description: BCM4908 based boards
-        items:
-          - enum:
-              - asus,gt-ac5300
-              - netgear,raxe500
-          - const: brcm,bcm4908
-
-      - description: BCM49408 based boards
-        items:
-          - const: brcm,bcm49408
-          - const: brcm,bcm4908
-
-additionalProperties: true
-
-...
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
index 324e59104360..6a64afa95918 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
@@ -15,6 +15,7 @@ maintainers:
   - William Zhang <william.zhang@broadcom.com>
   - Anand Gore <anand.gore@broadcom.com>
   - Kursad Oney <kursad.oney@broadcom.com>
+  - Rafał Miłecki <rafal@milecki.pl>
 
 properties:
   $nodename:
@@ -28,6 +29,26 @@ properties:
           - const: brcm,bcm47622
           - const: brcm,bcmbca
 
+      - description: BCM4906 based boards
+        items:
+          - enum:
+              - netgear,r8000p
+              - tplink,archer-c2300-v1
+          - const: brcm,bcm4906
+          - const: brcm,bcm4908
+
+      - description: BCM4908 based boards
+        items:
+          - enum:
+              - asus,gt-ac5300
+              - netgear,raxe500
+          - const: brcm,bcm4908
+
+      - description: BCM49408 based boards
+        items:
+          - const: brcm,bcm49408
+          - const: brcm,bcm4908
+
       - description: BCM4912 based boards
         items:
           - enum:
-- 
2.34.1


--000000000000403b2405e4454a0a
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILuQl3exfnHKnQis9jU3bmXz4CP4
DAqD1A/ETjRJpdp/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcyMDIzNTIxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBXVW+UY8h2eKe4pffJbxAv/kIJ17X/rIOUDlejYnm8rsg4
vlyKUxuJHwLqGY/PgKGjoE9yis+jsLrdMLNC/oguW78ZdD8eoMftWkv+VlwsYSo1XEY411l6uplr
tXkhIrh5aMZPkgx8Khgmz75brZ7Vp53estoMK8/3eQGGfDgC2ryjfo++TDjDURRit4dxr8tiZ3f8
ruDPjeiHsnsBk/hXJO2GpucK4jx0VnpmFJCTdRlJ0ej3Ehnek/9WdMV8quy97MOMS26NaVds0eoF
TknIA3GZ4o+/0A5tm2kp/Dl08cvzqmMayezLGLUMnCWMb5Ai5G2CQaA51E9j7olzm32x
--000000000000403b2405e4454a0a--
