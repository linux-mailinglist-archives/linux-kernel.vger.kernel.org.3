Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1548539678
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347130AbiEaSqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbiEaSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:46:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8375EA9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:46:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y187so1860380pgd.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=y7O7DMpobfoxFOoF0X6ZEf+S0WD2dkc4Cx0VPwZzwHo=;
        b=ck34rn6yOsbCES55S47lpz7qi03ww82/yk+5+iavYVbdfnhwIUIc5HknwKX/ZShA/+
         OKN2ZqsKwZC7sBKWqCWVRkROPERsrUNK9lju3njkfOXmYhPcrGN8uvN2snISVoae013p
         d9rnIUaYzGZIar/xaM0Cnf7ENj4GgxhzxMQH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=y7O7DMpobfoxFOoF0X6ZEf+S0WD2dkc4Cx0VPwZzwHo=;
        b=tuhOUY4XznVPPoHWGp5YAqiQx14hBMyLw8Eu9ULrFK+K+dUo+AtU7fAuf3MUBWD6in
         NYmPSepgDTxNUZPMiCmddh19T9bhkp6bUFQefJD0w8qTz6uDju/2pHZe26CxG3SZ3cgO
         mEEFzBKjpXOTR3JtgW6X9hEmQ1UxLQMPLhbEvL43VgZBlUrmW1r9YrjXGz7sTBfFajDu
         l0gz5ZMrDql2Fwv9LgvCiqkNF/pTCZ+ov2gO763qVH+xUxbwGQ7VYj+WmBw6qWe2FOtn
         IgnayAIDfDtjUwhMxnv+iTKl14KdJgydEmF+cSZhRYl+GaT1ECs8W+5YuK8bhkWzJgiB
         GD9g==
X-Gm-Message-State: AOAM530BlJxlSwgdqZONhZsqm3dezojvJz8HghENKmsfvJAcVK/9rxiG
        +nV6ZL+9UHLJGCV7R9TynMogNw==
X-Google-Smtp-Source: ABdhPJy1Ab4yNc7YiFz/QVL5LwHQ3MFb0ztE2TYdBo7D03wZy7vEzqYRk1IFkx4AxA8eGsGpJLeFSQ==
X-Received: by 2002:a05:6a00:23ce:b0:518:4115:170c with SMTP id g14-20020a056a0023ce00b005184115170cmr60552988pfc.76.1654022781032;
        Tue, 31 May 2022 11:46:21 -0700 (PDT)
Received: from linuxpc-ThinkServer-TS140.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm11358272pll.145.2022.05.31.11.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:46:19 -0700 (PDT)
From:   Anand Gore <anand.gore@broadcom.com>
To:     Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, florian.fainelli@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: bcmbca: add bcm6858 soc support
Date:   Tue, 31 May 2022 11:46:12 -0700
Message-Id: <20220531184615.2836433-1-anand.gore@broadcom.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005645d505e0533075"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005645d505e0533075
Content-Transfer-Encoding: 8bit


The initial support includes a bare-bone dts
for quad core ARM v8  with a brcm6345 uart.

Changes in v2:
- Fix psci and GIC entries in dts
- Remove extra empty lines
- Simplify subject line

Anand Gore (3):
  ARM64: dts: add dts files for bcmbca SoC bcm6858
  dt-bindings: arm64: add BCM6858 soc
  MAINTAINERS: add bcm6858 to bcmbca arch entry

 .../bindings/arm/bcm/brcm,bcmbca.yaml         |   7 +
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   3 +-
 .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     | 121 ++++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm96858.dts     |  30 +++++
 5 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts

-- 
2.25.1


--0000000000005645d505e0533075
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
dD3eNkKBkknQBWvFfBHcITIVdVccQg5YcIwowkVZhhA3NG0BXGI4l/3o+wjrl2BGO/t969dabQ5x
/SxGBTK8Vyn6NG7U0Lrjb0VtnrFXgEdxFvJuEQIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdhbmFuZC5nb3JlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUH4HXhI4xxNPqnv0yfNL6is0cLFYwDQYJ
KoZIhvcNAQELBQADggEBAAU15tMIqa2yrLdoPoNXMk6scL+6XJK/EVe0Lq0Uyq0SV8wpFV09ujno
nLmSFYTz1RjmiKr1eu/pwyTImqMUj1JAXZ2zgE0rFS5SvchJsSlB8Nv3WeTaf5Lha5ZmRTaB0U/E
eo7SFjA240UWLCGqXM69XCc5PHk6mWLNTsyDTgK2kLUKP1RVFswACNsI284fxiwA0qSCu2WnOEKE
LiytE/NBFgzVtBcryeBtcMnhZgMo0PQYRl4O+58O1O703CD1jiO4/ikP+hUTdxWQiiWAzpE89YCH
S0Pc2d2yC8RWARAiArr1jXHWA4+snG+TS3A1YVSPRZpboS5AXMutIIQ5YZQxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxzcZR0ocq9f8sVOu8wDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIECeBVSMlciWCUTN2CYqbD0njvIprRDt3LKgUpTZ
xxZ4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDUzMTE4NDYy
MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQBdLtZDBP3hxLMZG8gCg4I2nctGtd9nw+5Hav12BLnptKj4E3hXj2xqnkZ0
OzgrhlzStS69gv8btQZsOnaaugCZQjVAwm7iWx2PnStI8oGm8oeiLdZE+opNtT5vEl13ridaD0+5
jp1B0S/L/602TMBFWncV8iIUG1oKaL5KPTcLDvwIZ7tjPWzSqSmtQAS0jYhK11cumdbU4Q35ouQz
YSn0xk5GsqKjmKkSu7XY5Tn8rHeariMXmdFmj0VHg0uTiqMKLzx9xgaA79Zc6WxQbJ/ZgxGdWMxB
4zjqSBfGV7eipWsJ30jb6pmH5NAtUZnjD6beHNk0gHgmemb0OMC+mFkH
--0000000000005645d505e0533075--
