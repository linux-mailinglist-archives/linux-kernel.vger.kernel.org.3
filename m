Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1674757B8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiGTOsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiGTOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:48:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8A952442
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so1502015wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:mime-version:content-transfer-encoding:from:date:message-id
         :to:cc;
        bh=y0nOdBdH/FiY2jfQvMH95VKpuAO3BFQhEGGb8OIH85M=;
        b=yI2UwrXOi3+iAjbP6Ub6fisppNUVUrxVmdsq3fNJv+N1wsO60lcIG0WM+ItxOyv4Rp
         J0pUF3pyFpUzkdwL8Q0jOkNMphJOCg4N/hrIQy5AjQ37nU3pVu6iemD41WcW+fRHW+/s
         jaPCYzpz13OTcIxMzKeVd/YZ5rDKvd7lmW3y8O1oZP/SPBqo8z51egLC6Dnr0TQSsGGe
         liZNw/xHmAIH6C2eGologqz4OCE5zYmpsvArnvvfcrI1OuHxNqPkSPrL5KPsWRaGMvnk
         PQ6MCEAP3UGVGSIDP+NM9cKT1dXQPid6xBLrqZPa2VtgMYUXDNdLTEkvRiwZXpRNI66V
         uUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:mime-version:content-transfer-encoding
         :from:date:message-id:to:cc;
        bh=y0nOdBdH/FiY2jfQvMH95VKpuAO3BFQhEGGb8OIH85M=;
        b=ewfmQ7YnKV/isoQzIMg4zCIm6MrZVKVsigk7Ek8rCs89Nnx2T5J2gDCQ0lMatUjMJS
         K4QNXO92SkJUMjv+jOCqEG5j+DwNThKKUhTf4rNVKuVipnYpnTMOQH+Ttd29gQM/UHwG
         IIjJR3tfVtvzJQqjYTBKlDI4uyK3mnrxTTTnCLKscOodGnoVmIP+1Vj5HT8s5/0gGmfg
         08ZC7szmg7alIf8LJEINIrKDorRqHsfGzqf1gQavW2pkGaKyZkPA01Q+FmqTyD22fDXZ
         Z9nULUlqu+lD8fkY/13/gidzL7GPBs3EMItGrG1XhmVTzxNFT5jJhqDhzWUm25jP2/8w
         0DvQ==
X-Gm-Message-State: AJIora9KWc2o5DxLO4Z0EXb2XyCsLu+PDTvtp+0qYyBgxtDUJkR2xcpv
        w19I4Aa8R/b7bud8fA1qaOlhSgfaBYckGQ==
X-Google-Smtp-Source: AGRyM1ublPYAEei2qfPJouysredFf/CYLPH5v96mYBkQf2Q+0TkflmcBuDnsIT97NTApdhrn+fK1vw==
X-Received: by 2002:a05:600c:34d0:b0:3a1:a05c:b523 with SMTP id d16-20020a05600c34d000b003a1a05cb523mr4189886wmq.94.1658328518916;
        Wed, 20 Jul 2022 07:48:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb19:85e6:1900:c639:22f8:bed9:44dd])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003a31673515bsm3321121wmq.7.2022.07.20.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:48:38 -0700 (PDT)
Subject: [PATCH v1 0/6] Input: mt6779-keypad - double keys support
X-b4-tracking: eyJzZXJpZXMiOiB7InJldmlzaW9uIjogMSwgImNoYW5nZS1pZCI6ICIyMDIyMDcyMC1tdDgxODMta2
 V5cGFkLTIwYWE3NzEwNmZmMCIsICJoaXN0b3J5IjogeyJ2MSI6IFsiMjAyMjA3MjAtbXQ4MTgzLWtl
 eXBhZC12MS0wLTY4YzE5N2MxOWYyY0BiYXlsaWJyZS5jb20iLCAiMjAyMjA3MjAtbXQ4MTgzLWtleX
 BhZC12MS0wLWUyYmI0MjcwMTI3MUBiYXlsaWJyZS5jb20iLCAiMjAyMjA3MjAtbXQ4MTgzLWtleXBh
 ZC12MS0wLTc2OTM5ZmM0MTRhZkBiYXlsaWJyZS5jb20iXX19fQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date:   Wed, 20 Jul 2022 16:48:36 +0200
Message-Id: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.0-dev-54fef
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek keypad controller has multiple operating modes:
* single key detection (currently implemented)
* double key detection

With double key detection, each (row,column) is a group that can detect
two keys in the key matrix.
This minimizes the overall pin counts for cost reduction.
However, pressing multiple keys in the same group will not be
detected properly.

On some boards, like mt8183-pumpkin, double key detection is used.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

---
Fabien Parent (2):
      arm64: dts: mediatek: mt8183: add keyboard node
      arm64: dts: mediatek: mt8183-pumpkin: add keypad support

Mattijs Korpershoek (4):
      MAINTAINERS: input: add mattijs for mt6779-keypad
      dt-bindings: mediatek,mt6779-keypad: use unevaluatedProperties
      dt-bindings: mediatek,mt6779-keypad: add mediatek,double-keys
      Input: mt6779-keypad - support double keys matrix

 .../bindings/input/mediatek,mt6779-keypad.yaml      |  8 +++++++-
 MAINTAINERS                                         |  6 ++++++
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts     | 21 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi            |  9 +++++++++
 drivers/input/keyboard/mt6779-keypad.c              | 17 +++++++++++++++--
 5 files changed, 58 insertions(+), 3 deletions(-)
---
base-commit: 3b87ed7ea4d598c81a03317a92dfbd59102224fd
change-id: 20220720-mt8183-keypad-20aa77106ff0

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>
