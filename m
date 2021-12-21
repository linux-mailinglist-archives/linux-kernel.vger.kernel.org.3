Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4547C006
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhLUMvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:51:45 -0500
Received: from mail-qv1-f45.google.com ([209.85.219.45]:36520 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbhLUMvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:51:43 -0500
Received: by mail-qv1-f45.google.com with SMTP id kc16so12309450qvb.3;
        Tue, 21 Dec 2021 04:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHBncKJ/xlQQ+CHewf+fDIZyImR+1QUXOkH9dtjvEd4=;
        b=kZNYWCy8AzzpYxfHtAwKhLPYX7p1iJ1eQQeMfGO6w1XFcygJWarvK+gHlRZxhZoLMH
         RI7mTV0RXQToGpCs3UEj7VgwzMDI2/IY8Ze3a+DcgE5r5SfRNyZ/35wyJ5N6zJ1ufHTc
         4W6hNImE/Yr715tL1AC5JGb4BVT51TPy2F82UkX1ZNGtYSQGa8KlvCInu1T4bTvAduRh
         CPvHY/4MDM/DdjFcVdzUncqfsHdA5QuqHP6IZHvvQTpFQqPEcuWMF3Acy1GsuVKZqtn4
         xCA/CfGl9XEIlIqCCloFV9fe/ZyGBRTIMVpTAZy0rx35K8MKnoh4qaffjLbiCflRiT+9
         b0GQ==
X-Gm-Message-State: AOAM532Q+sMqXWe6qWBG1ymCABOvugK99aitxX3HUWSDKAXUcV1LeOSs
        ORfg+csUtk6wsfdTzB1d1g==
X-Google-Smtp-Source: ABdhPJxS30a8Jzj7aAxnhi6th+9ajF2x7f0OHNZp4PLzHPjnEWQ9toXqnmaAHPCuaWfaTp+Y576otg==
X-Received: by 2002:a05:6214:27ee:: with SMTP id jt14mr2328206qvb.2.1640091102922;
        Tue, 21 Dec 2021 04:51:42 -0800 (PST)
Received: from xps15.. ([24.55.105.145])
        by smtp.googlemail.com with ESMTPSA id x190sm13023530qkb.115.2021.12.21.04.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:51:42 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: novatek,nt36672a: Fix unevaluated properties warning
Date:   Tue, 21 Dec 2021 08:51:26 -0400
Message-Id: <20211221125125.1194554-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support enabled, the novatek,nt36672a
binding has a new warning:

Documentation/devicetree/bindings/display/panel/novatek,nt36672a.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('vddi0-supply', '#address-cells', '#size-cells' were unexpected)

Based on dts files, 'vddi0-supply' does appear to be the correct name.
Drop '#address-cells' and '#size-cells' which aren't needed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/novatek,nt36672a.yaml   | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index ef4c0a24512d..563766d283f6 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -34,7 +34,7 @@ properties:
     description: phandle of gpio for reset line - This should be 8mA, gpio
       can be configured using mux, pinctrl, pinctrl-names (active high)
 
-  vddio-supply:
+  vddi0-supply:
     description: phandle of the regulator that provides the supply voltage
       Power IC supply
 
@@ -75,8 +75,6 @@ examples:
 
             reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
 
-            #address-cells = <1>;
-            #size-cells = <0>;
             port {
                 tianma_nt36672a_in_0: endpoint {
                     remote-endpoint = <&dsi0_out>;
-- 
2.32.0

