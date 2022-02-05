Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E348F4AA881
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379753AbiBEMBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:01:06 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44390
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379718AbiBEMA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:00:56 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B92140038
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 12:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644062455;
        bh=OuVWT+OxqE323DEVUlu5DyHs7hHuGTLMdHDm6pwqNSI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=N5l1jinDQVSe5Mv4Q0cYSDbESGzbhgOeCLLdhGgAc24ufCnUP6OfEv3H55IHPrJqz
         N1U99ue0Q87NBTGDt9xKCCD9jsc5jaVltzy/deICM4M12jSCbWzq9h93SJhWYhF7CA
         2SwD48E6OYMF8xo9TdlnjzUMPLQpxDH/jY3eGHbwlMJKwKI+c4wnFgMpqZpDFq9nPb
         a4N42/xguDLyOfyfBn4jBl6LfrqmU3gJxIkZqT845cah0ONUu52t67g4cVzRq73bsJ
         oOfbVUfEE8U5/wbNo7dVaN4ZlT2UmqcZoxUcHUac+2YN8FH3jXkaMtCi0Q9Q8ncc8d
         XQJnH72L/QVlA==
Received: by mail-ed1-f72.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso4517191edk.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 04:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuVWT+OxqE323DEVUlu5DyHs7hHuGTLMdHDm6pwqNSI=;
        b=XPsxMarHPCUSTNuMWHTnfwkuRLvtCbd5dpNhgvACckfvmCwDUG3scQsJ4PVnpOUjeR
         nde0DYLzGeoXH0XhtofWmJC0uS0mJj3ZZ2fJHOSRvq/PKcgZMYYk6eCduS+JdRY8nNsO
         5BufgUVrvpq9Woghlhw5R1Xm9lVewbEhzAta8f1bIUowaPlYeXJzjahRil6vEUIKA4kQ
         hnS6XGuYC8sE5YAmMrgmTbdKJiZDLjw2R31RtxvN6Z8reTPrqEaWGUKA5x38oGmYmLFZ
         gSpBkhJtS2fQgvlaFqIQIaMSxAYlMGAYK/kdBfjnMkQkKu1ZwjCPbSdlujFkEq15Vuyp
         Kf3A==
X-Gm-Message-State: AOAM531CVkLihlIChR1V3vaLkDhKlvaSTVkmh6IvvN7pRr+Y8VmoY1YX
        c6z4U/ZgiME8GbfBSfaQsOndMFJytaJ7BB9M1nd5ZLzdDsqds6D3ssZqAy0M8D1RsuCTYhB1P4W
        Ryf4XxRjBmE9UP1W35oWJDFFtiW9AaGje6tfY68ffyg==
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr683863ejn.652.1644062455284;
        Sat, 05 Feb 2022 04:00:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1Mfepppy+jyN7m6yTpySmK5tZkCeWnsio2ctwMkbDoEsk7W8TQZsy4nTTRgAd/Wm47p/TjQ==
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr683853ejn.652.1644062455141;
        Sat, 05 Feb 2022 04:00:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m12sm1534185ejr.218.2022.02.05.04.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 04:00:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: memory: lpddr3: deprecated manufacturer ID
Date:   Sat,  5 Feb 2022 13:00:41 +0100
Message-Id: <20220205120043.8337-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
References: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory manufacturer should be described in vendor part of
compatible, so there is no need to duplicate it in separate property.
Similarly is done in LPDDR2 bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/memory-controllers/ddr/jedec,lpddr3.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index 0c8353c11767..138c57d8a375 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -40,7 +40,9 @@ properties:
   manufacturer-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
-      Manufacturer ID value read from Mode Register 5.
+      Manufacturer ID value read from Mode Register 5.  The property is
+      deprecated, manufacturer should be derived from the compatible.
+    deprecated: true
 
   revision-id:
     $ref: /schemas/types.yaml#/definitions/uint32-array
-- 
2.32.0

