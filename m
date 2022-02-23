Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922F24C0D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiBWHgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiBWHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:36:21 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789EE70CD0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:35:54 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2ED223FCA5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645601753;
        bh=aODgGfRuLmdS4tRHrVKVzJZACN4gsj7dyGKVHf/acuA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=aNuxzBWVwJtW8vFfzGbvIKwEXdI+6/7xe1/QPAmxNx9OGdP+zFG6LyAYDM5CEA62N
         FJMcePyOSkST1ZTStSWPnlK993zOorbQ5A9kvG6zEHv8PvOoHKnOdpGCSHc+8SKW94
         K5b8sZYPZFBRcFNdvORg1XUIjEXIAgq6mx74zIvSWEIKZn11bNKDNM1WzfhW3TWS7A
         +1O5pBx+NGJlihulmo0M5z4NFpe+RQ4+sVarKahFyqbsOxatnrNbsLhOFhHvbpaqgL
         UpNoMIAgO3MCQyyG9HLbRcFtyFUNDt7r5wKSQ1eR0WRdbCYfsvgOeE2uvfmeIAqmZ6
         nwJ0o916G/k0Q==
Received: by mail-ej1-f72.google.com with SMTP id nb1-20020a1709071c8100b006d03c250b6fso6627596ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aODgGfRuLmdS4tRHrVKVzJZACN4gsj7dyGKVHf/acuA=;
        b=gYwuINSz6t84S40q2FHJ4149J4M/MK/6nzABFBPioAyKAmChQEqWjsbpUq9+PTMbeh
         veQRfkKuxGBDyTjJhhf/hkcH+Bp0jVD9Q1mM7Dnb75KDQUCW0z0Hz1tYzhCjoV+efoSK
         Loykc/YJsIj2b76pSmrz8nVa8pMkddI9/vqZqoHhIC2YkqWIyfWKg3qfkCiIp2mygYBm
         ol0lEXXHNeMZX+05GMNZ9ZkmZuCNtJnHHRh00lYBHLfnS5dLoPC3ZBByBNPiKnJTwzjX
         dPcAdeleZmlWQ7D1f4lBlLmIk4Q6IOlrbV687qzA0jo4JpcpDEqmTz7iccNxrF+kQmml
         PlVA==
X-Gm-Message-State: AOAM533LkS6c9YzQgDNzaZzzaYlCNO+h3BoNzQ87mQifRBd3InIUb1OD
        m/Uz1ci3UkykkBWXoqqKlJEI5PbVpwicw61LnsmhTHOxSEf/IW0mtf6oeLL+QpbIWHD1OyLy+51
        Lf9oXTracqVQEU3SFe4Hnv+oeMLNqr7SMAaX8bfzNzQ==
X-Received: by 2002:a17:906:3bc7:b0:6cc:493e:31e4 with SMTP id v7-20020a1709063bc700b006cc493e31e4mr21625334ejf.549.1645601752352;
        Tue, 22 Feb 2022 23:35:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzugDAebkigYMSFqiHHTQ3C1J6Lrwp3y9xalxujMvR5h0cH2kx7GcK7Vzs36/2R2yC4qTpfYg==
X-Received: by 2002:a17:906:3bc7:b0:6cc:493e:31e4 with SMTP id v7-20020a1709063bc700b006cc493e31e4mr21625323ejf.549.1645601752129;
        Tue, 22 Feb 2022 23:35:52 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id u4sm7129842ejn.216.2022.02.22.23.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:35:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/2] dt-bindings: writing-schema: Install from PyPI repository
Date:   Wed, 23 Feb 2022 08:35:46 +0100
Message-Id: <20220223073547.8746-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Installing dtschema from github.com/devicetree-org is not needed anymore
because dtschema is now part of regular PyPI repository.  In certain
cases it might cause some troubles as it brings latest master version,
not the stable release:

    $ pip3 show dtschema
    Version: 2020.8.2.dev4+g341f3e3
    $ make dt_binding_check
    dtschema minimum version is v2020.8.1

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/writing-schema.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index ea21c72aeb37..4004dd9209a6 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -118,7 +118,7 @@ The DT schema project must be installed in order to validate the DT schema
 binding documents and validate DTS files using the DT schema. The DT schema
 project can be installed with pip::
 
-    pip3 install git+https://github.com/devicetree-org/dt-schema.git@master
+    pip3 install dtschema
 
 Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
 installed. Ensure they are in your PATH (~/.local/bin by default).
-- 
2.32.0

