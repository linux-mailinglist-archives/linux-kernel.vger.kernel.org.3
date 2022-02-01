Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E254A5B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbiBALsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:48:39 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56558
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237463AbiBALsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:48:35 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B3E7D3F30F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643716111;
        bh=OuVWT+OxqE323DEVUlu5DyHs7hHuGTLMdHDm6pwqNSI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Fbs15aGFgyvnkbWUtMPMpCUoM8+qO2YRu8ZLKtjcYMAkFKmbOHtePRgZXkfPczobF
         8LtGVc8k3BokIJoM+7yVBwcLUsKyxwvjlx3n7tVJYMwrPYfrsu9Lj2LT48ECZcnaQ3
         EyL7V++sdNi1p5tLZMP65miqlwrhGiFOEv20cD95G22I05ISeQ+dptM+4M3L7z6UVD
         UFXF/YIfdI+V3albUpnGby2f6TQ2EwoZUtekPhlxVKvT3hobRkRk1TErcHM8BLGasW
         agtHMssixjPYn0519F0aBdSXBXd+yhVAy7YteKJOtPXexuYrFpCqgrPqy1qbXtfaRf
         uW3M4RY/QTepg==
Received: by mail-ed1-f71.google.com with SMTP id n7-20020a05640205c700b0040b7be76147so4044933edx.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 03:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuVWT+OxqE323DEVUlu5DyHs7hHuGTLMdHDm6pwqNSI=;
        b=8B0e4zdwReTqXLD7Hv/za7LaEXH8nQSmBpS6PGgH2a7Q3KYnT7E+lZ0tebXKhOKa/Q
         qgB0fcj9ujcUvUUU2J+lvqDrbIAgwG+IS9sSlpDrvwIami3GcY7vZn1nLeP9mRA8Bk0d
         4ekUFMWsnbwA+RiAPdR+0/sprXw4UV2SPsXbsQgxUadCPEmGH+qNzAp2p+QxP1eypfhd
         EdMhYwLFZdlRBjlJac37XHp7+c3Tjj57iyAhjRs572EdZ7Di1dByYvKPGO7ZnK5iOClq
         6LZiRnmCogDdUc3ydcoiCMzSN0xZCEt9MklweLd+XFG1WbOa9bvz2SrOjnH7PPUC8xI3
         q5gA==
X-Gm-Message-State: AOAM533E+/izHx1LQDgSYwuj0pG9t/Z1sQpI1XbZcSRt51zeYIoxR08d
        FiZ0lOQxgF8uByGXLgvGwgAhiLsTrexKBHmur8BxUD7DzFcf9Axf9yhWFDVVxpR861Lk70TTKmI
        otPmRU4zDWj2shHUCD+E3vCnEqlqb9B+R+FG3dJ4dGQ==
X-Received: by 2002:a17:907:d9f:: with SMTP id go31mr21604845ejc.282.1643716111075;
        Tue, 01 Feb 2022 03:48:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4hxffkdEDnSRNHd8A4Uy3TqYuAKbZF4KOrK7b4i45cPu6GWoai3jbLk/RRWS+LN17FX6K9Q==
X-Received: by 2002:a17:907:d9f:: with SMTP id go31mr21604841ejc.282.1643716110925;
        Tue, 01 Feb 2022 03:48:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bo19sm17954484edb.56.2022.02.01.03.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 03:48:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/6] dt-bindings: memory: lpddr3: deprecated manufacturer ID
Date:   Tue,  1 Feb 2022 12:47:47 +0100
Message-Id: <20220201114749.88500-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
References: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
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

