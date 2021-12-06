Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838B246A328
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbhLFRoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:44:03 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43844 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbhLFRoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:44:01 -0500
Received: by mail-oi1-f177.google.com with SMTP id o4so22757937oia.10;
        Mon, 06 Dec 2021 09:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koRW6az6+degourkxOP1GokVvT7gydbgTTyBLpfrkw0=;
        b=uSeOMMwmlU2nw6t3DV+q+kSyQ+dq1BXy7RFMUBqOnchg+GvLc5OSX0paAM86u+r+cz
         pB/9srRFBjn/w2ZHOVGwIoegWIKDjRSqcATtb/zg+QJG/37BiEa2Ki0P/a6xO6k1LUP6
         iEmB/+49apN+iBvHrwJSsjQ9/zkaJ5dbTh+W0erLG4vTz+Q0T8e0DwV8ppi68EdzSfPV
         B7feBgBEdM2Er08B+nnksjsRhLnUb0GDCSjLB3m/SOI0u062UEgdoWm8la3PjIj3pJf6
         Q8cARVVrDazKa5fw4kW6JkRBVehd//JyIt3lqqiaS9Yx/V6teqzKCsyK4LSIjwS4GD7X
         AOJA==
X-Gm-Message-State: AOAM5323zMr/KcHOkPaao5s06Es5Ds71Dg8sBouT2NwH0Wpa3KlwilLN
        QVFK8u9YGJT5KWKjP/s94g==
X-Google-Smtp-Source: ABdhPJz/jMkga0NqEh2zCLWJPjrBKT2u/B/vshshAuxBAhhj1IcGRKBDlhoencuokUNhK5KLxJR9ug==
X-Received: by 2002:aca:3945:: with SMTP id g66mr47oia.2.1638812430317;
        Mon, 06 Dec 2021 09:40:30 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id k8sm1748347oon.2.2021.12.06.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:40:29 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tero Kristo <t-kristo@ti.com>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: ti,rti-wdt: Fix assigned-clock-parents
Date:   Mon,  6 Dec 2021 11:40:28 -0600
Message-Id: <20211206174028.2294330-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support implemented, the ti,rti-wdt example
has the following warning:

/home/rob/proj/git/linux-dt/.build-arm64/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.example.dt.yaml: watchdog@2200000: Unevaluated properties are not allowed ('assigned-clock-parents' was unexpected)

The problem is the schema has a typo in 'assigned-clocks-parents'. As
it is not required to list assigned clocks in bindings, just drop the
property definitions to fix this.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
index 054584d7543a..2f33635876ff 100644
--- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
@@ -34,12 +34,6 @@ properties:
   power-domains:
     maxItems: 1
 
-  assigned-clocks:
-    maxItems: 1
-
-  assigned-clocks-parents:
-    maxItems: 1
-
 required:
   - compatible
   - reg
-- 
2.32.0

