Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FAB497A43
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbiAXIYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:24:12 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42940
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242184AbiAXIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:24:02 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 404563FFD9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643012638;
        bh=6MJYb8WcqWhjeyozgAW+GAp1i5m+HDM/agR5Nt4YXgk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=mmjmnK13bRSdTiAGO0O8qiGw27BWceV2GD5hkBJ3VFLfboTGPD1MA2emIZjs6Yfof
         mMROc6vlzi4Ncpos2XhK+pI3YNZNKZPVqI8lLceIMPysvD/HCB8+PaVIFaBqA1RUHs
         Hl55hElJwylkrQvaVcJreEer2Ysscrfqo1dpVqpL7GeKxGaY/wUNLMf4QGXXYpYex7
         xM9qFMY7DItjPTIgauHmdyNW4z6h+am5v/aqKtRoFiae/2qOkuE4UXxASEFJyjbR02
         8PFhD9G231HfcAoPg57uD5xVgodHWRiorKgJqXOzIPKZj8h+e6nZpGo5YwJsIshGED
         E58dbU3TrIEVA==
Received: by mail-wm1-f72.google.com with SMTP id z2-20020a05600c220200b0034d2eb95f27so10366068wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MJYb8WcqWhjeyozgAW+GAp1i5m+HDM/agR5Nt4YXgk=;
        b=UO8mXKgE3ZrD51LvAi6N4ohf2F9Pal+Bk+GtagwRZgNgLuDr7CP83GEB50IFqpYYXL
         poP4cF48r2pDSTVPhf8TFzSWCBp04OVPLau25a6dAFrDzH8vJ0GnUD/bmN0/c2ZP8xsY
         +e7bJbXIUy0I/pBrcv+Ijho6XFYn/rRfHAY82L1pS4sbo85CXIEvD8ZJD7zMtV/Na0c/
         WDyW28wi1R18dtKSftqQ2nXNtnfdM9txCxJ1UcouTHBiNurnC4+JT6qzh+WgIMqm52Z+
         bpLAPoFLKiBxhoJVnaBSZryiIyQ8HmemIHQCCRj8WIhBb1xcPEvCLXQUWrexILXivTLb
         9GuA==
X-Gm-Message-State: AOAM530PIyZZ97Y8Df42nvauriONY36pt7J3LH72WdlrBmg0iixFJ92g
        pkkTebOsFs/Fa4wxcXefHd1L5h9VD5SEBIuNN3AKwcsZ9EunMknCCKbyOKPkjYAX4swr8YdF9cf
        Dsul+b6ZY1fW7sQVmiLWxNyx+SLrB7I8wl1c9QjjHUQ==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr13030941wry.98.1643012636548;
        Mon, 24 Jan 2022 00:23:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGKdmyKgG7q+F9YXGqPhXojRHXYyPuTj4cdnyu4gQtA6b0oE0q4HED2u/bDAahosOh4nheLQ==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr13030924wry.98.1643012636413;
        Mon, 24 Jan 2022 00:23:56 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m64sm7148550wmm.31.2022.01.24.00.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:23:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v6 3/4] mfd: dt-bindings: google,cros-ec: fix indentation in example
Date:   Mon, 24 Jan 2022 09:23:46 +0100
Message-Id: <20220124082347.32747-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct level of indentation in the example.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 525ab18005b3..4caadf73fc4a 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -203,7 +203,7 @@ examples:
             spi-max-frequency = <5000000>;
 
             proximity {
-                    compatible = "google,cros-ec-mkbp-proximity";
+                compatible = "google,cros-ec-mkbp-proximity";
             };
 
             cbas {
-- 
2.32.0

