Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD74AAFB7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 14:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbiBFN6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 08:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbiBFN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 08:58:28 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6E5C0401CF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 05:58:22 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D4A9A40300
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644155897;
        bh=lowbJ9HbAqgBRMehsHM/qhZ+cS05q8+wNRQlqfDefTM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=o2MxFSVwYa6MfR7CycRimKSeVpmHjhOxn1ann4TKe8VgMgOmtEsqISRIj6XHdMP6p
         LFZjO82mO6cIOf46wTmJ0k/Zx0m7ehqADuhhAxgRoiKDztYfI1R0pEyNIVphlonCuh
         vXXfd7ZRBXAnXDEpqAKDeF6szbO/gzEGIOKDnM8rPl9jzs/nNOCqGM3tC7Lxwp2W4y
         3ROQHpTHyHLPGGKpE69zVHOboJLHgz6zgQMGlGWGbfaq9Dqs/4V9X7IXCxG0RisAp3
         kwPrwDepDK95tzaWVn3VqQQI3dNP2R0t7uh/lir+JbYQgMetD3SYEoCUsICaZN34s6
         9zz2hIqpFKIrg==
Received: by mail-wm1-f69.google.com with SMTP id a8-20020a7bc1c8000000b0037bc4c62e97so502934wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 05:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lowbJ9HbAqgBRMehsHM/qhZ+cS05q8+wNRQlqfDefTM=;
        b=Ps7jbBFI8VrZ2hpi94JnDlenk+vo5Kuf7g0pX8bzOQMzOjo5sBP0ULtcFqvszYY0tE
         jN2SKFzfEkBqSkfkwNc/idgQFrDWjK16pgVlY23qn9U8G6eetHdNRitfiugl7Gy5B1mA
         wYBqhiGoQElTn8ZJ/pd2Wi8uoeBkV71gHPC77t8U3Tc3AsM/SRKf5ZyJsgpezQIacZbO
         fa1O/wFX6SugxsVH7sj01S0fQB87nHkMabio2tX5/9oJYjW/FKdxh4jEAIwbffUUiLZ6
         KpBbc9Kp8evO4ZrQWsLhoaFe2g1If2N/fC+0BLH2OjCOTrYesmdLQByIDz/cj1tb3Ytb
         oTmQ==
X-Gm-Message-State: AOAM531iQiB0Gl+If6D7YXhv4qBNQm7WqAzncWcngT3FOfflBf6GElRm
        PglRDL0PjFvz9GFHXFdWFN3JANJc/pYN2rFQsp68FlRFj6TUyjIUfORRoYXTqhmKvc+g5TO1hOw
        ZyreQLZOUI6A4J6V38QMZGffaTfcKcaMp3nrjcbOS4g==
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr7316481wmi.95.1644155897619;
        Sun, 06 Feb 2022 05:58:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFbHkfXy9mwKBU3YQJK1xswUXUcJeL2qs8UreyNLnbIswkcL4WL2NExoBBoPLmzdhlDF7SCw==
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr7316471wmi.95.1644155897470;
        Sun, 06 Feb 2022 05:58:17 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e9sm8296888wrg.60.2022.02.06.05.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:58:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/8] dt-bindings: memory: lpddr3: deprecate manufacturer ID
Date:   Sun,  6 Feb 2022 14:58:04 +0100
Message-Id: <20220206135807.211767-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory manufacturer should be described in vendor part of
compatible, so there is no need to duplicate it in a separate property.
Similarly is done in LPDDR2 bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/memory-controllers/ddr/jedec,lpddr3.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index d6787b5190ee..3bcba15098ea 100644
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

