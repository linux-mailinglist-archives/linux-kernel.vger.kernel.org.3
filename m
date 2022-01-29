Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA964A2F54
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbiA2MYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:24:04 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54088
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241697AbiA2MYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:24:03 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E96C3F32C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643459042;
        bh=Xin2bUCV5GBX+4IaAK+yFj1wjm1SLWxA3e09mShlOR4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=upfxwh5gSrgAt6Iow7u6hc274z6e9RAsI0wWWfj3AZ3D2/5xyxVKl8qjuUBxGhnVX
         NYzCZ0q9hftiCmT1cY2zPUM3fWoyDsFvy2TGvjszqyr8zaM6ru8cN/PHrBOpPp5y6S
         8eiY7WqYCJGr3bsQrYKdxqX72WSj07CXUDGJsrn9eoQRpe//wSVDNwk3u6u54JewvT
         LQgLSXV+2S+no9rDT18Vlq+WkvtArUfavwl3U5K4K8z8Q4DXpT+0skvNcmIzxC9wNT
         hO2yi4bG74+E34IIM41tJUBF9/ycK4HY/1y4C+mHHjb6xjvIpXEUHOcclYysSAFx2j
         3jv5qxnqMwroQ==
Received: by mail-wm1-f69.google.com with SMTP id q127-20020a1ca785000000b00352a4860babso478993wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 04:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xin2bUCV5GBX+4IaAK+yFj1wjm1SLWxA3e09mShlOR4=;
        b=4XGuNiltxUg0Xrd3om41AKLBLltpeE9tDpckwyFE20Q2nuX3aXSDH8KFrACbL/hQ8N
         XZYfHYSI6jEAzgb8ZlSprkK86Z3cNf8voCQ42vkdKCCSv8CJNORfG3f1xxBZxmrZNcXM
         v+uzI5RsHpsmCDZ/OKf7yILEuTE6kjKclakaCCecwSu1pOTHK0hGkyRVWpYkUDs2PEJk
         3JbAlniDQFEgUaRxos47KH8I5MU0siOL1X5XoaPAC4ggBCE0TTclGWoxSoweElZtBsFf
         lbcQTGQFBF9nQoZ2XAXGvFRlS83E7e3B5I5MnVom0v/9LZ/V7G1keRn/O5IDlwm/L+Iw
         hHYA==
X-Gm-Message-State: AOAM530O17HflkrXobcmDgCX/ak/a9yLTDrHJ2orcNwqIjNidEiiuama
        WtpfkX+2d3vg+5gAn9dF/iMfKFuZXX261Nabp0EfsrIVomg6Uf9zEeS/esCBq6JHIKxhzoDZpUe
        EMVSDeU5w+QXmhIv9CLFG27G4LNvgqROc3IQJiURmPw==
X-Received: by 2002:a05:600c:20a:: with SMTP id 10mr20148995wmi.19.1643459040703;
        Sat, 29 Jan 2022 04:24:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzX2X5P3axlQ5WI/mG6GqvwXYyv9cpxowJ11N6MeS+DE60iDMwN+meIUmiOJBb6d5n8wE5K5A==
X-Received: by 2002:a05:600c:20a:: with SMTP id 10mr20148982wmi.19.1643459040514;
        Sat, 29 Jan 2022 04:24:00 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z13sm7901534wrm.90.2022.01.29.04.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 04:23:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] ASoC: dt-bindings: samsung,aries-wm8994: require sound-dai property
Date:   Sat, 29 Jan 2022 13:23:52 +0100
Message-Id: <20220129122357.45545-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu and codec nodes must provide sound-dai property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/sound/samsung,aries-wm8994.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
index 4ffa275b3c49..97f83eeaf091 100644
--- a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
@@ -30,6 +30,8 @@ properties:
         description: |
           phandles to the I2S controller and bluetooth codec,
           in that order
+    required:
+      - sound-dai
 
   codec:
     type: object
@@ -37,6 +39,8 @@ properties:
       sound-dai:
         maxItems: 1
         description: phandle to the WM8994 CODEC
+    required:
+      - sound-dai
 
   samsung,audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-- 
2.32.0

