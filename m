Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214EA47FD71
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhL0Nfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:35:53 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54532
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234115AbhL0Nfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:35:52 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 810203FFDA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612151;
        bh=SHDOTqD45fkOcgdIZOrzabWTlwg9fQB3mqCZYwiASwc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SpldKGeptpdoJmZFia73TyCiINto51oXmcHlBj93Us3dXdizeXCsf4+pnlBDbCN07
         B+reX3gj1x8GFOGI6LjYtDJPA5Vu7CNitAhqGT9MaYi08Uk0mp0OxDd8XmCUOcViUJ
         aieaJDJf2Tval4TLXZnf4sfzw2cGPMXqOSpH3TCQ/6BqxYfoq4uQ9VyoquaE8KS0eR
         RglXElsZlTUahEFxuMOjrFjt0PnVRgWOBhbdq//0rDjl2ybbWw7rX32pdkMdRAzqHz
         Sgxj/N22veGUWFKEgvizNcMP8AQMZAjyyAi1K4liH8jpU4fo9mFRqbzi+ue+fTiN8A
         mU12ZOJX1VJ5g==
Received: by mail-lj1-f197.google.com with SMTP id a29-20020a2e7f1d000000b0022d7438b7e4so4931687ljd.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SHDOTqD45fkOcgdIZOrzabWTlwg9fQB3mqCZYwiASwc=;
        b=veca4xCerA2h9kPV6zQ1kfWjHN1odWfrB4rWrSP7muuWCZ203KEth890qNmq1Xg5X3
         BD7u5b8busXFgDHUa27IA/E3lhxibZWUDE406Xljy+Govo+5aBTiWUr8B3radTnaYOMz
         Chd/w2WNhoLG/lMNQ65LYe5gzTJlZ90C7fr4ZUMIIdFszGIVfz2Umg0UThuR/z9UqbBI
         XtUv+tGJNuC/8fT/RdYPX2yTp/3fcJ5mcXzf8BCzXeF5Aeqp4skoqhAmzPeWlyTMNdYo
         mz9tFSUKEWIpYxRXkw1e/S5kPMgUFYT3dkv2MbSRfqe+zGwBnbuWTSRqXVDaHhHQQi0m
         tl6A==
X-Gm-Message-State: AOAM530nEHq43tzo2U3oRKaBpUSDifAvQDVKohWGHPwhZcnkyHPfoytm
        0c2CRHI9ahpxttbTj01WQsXQXJYMh3WKtmcr02h37gQ0FGGu1+H5ELMpog30h9EdsooS+1Kt9Ve
        YWMQLeHo98Y3SHUbv3SFEWL9t6fHTwqKbVey9Qzi1+w==
X-Received: by 2002:ac2:51bc:: with SMTP id f28mr15038333lfk.222.1640612150083;
        Mon, 27 Dec 2021 05:35:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz74YnaGqeKHmwR3S7E74UQQMqDX12yIAKinwFN3GzO62zbbfUGRpdn19Zp2pmz0D3CIOT/OA==
X-Received: by 2002:ac2:51bc:: with SMTP id f28mr15038324lfk.222.1640612149924;
        Mon, 27 Dec 2021 05:35:49 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id h21sm829100lfu.253.2021.12.27.05.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:35:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 06/19] dt-bindings: altera: document Stratix 10 based board compatibles
Date:   Mon, 27 Dec 2021 14:35:32 +0100
Message-Id: <20211227133545.135049-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible for Stratix 10 based boards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index f4e07a21aaf5..5e2017c0a051 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -43,6 +43,12 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Stratix 10 boards
+        items:
+          - enum:
+              - altr,socfpga-stratix10-socdk
+          - const: altr,socfpga-stratix10
+
       - description: SoCFPGA VT
         items:
           - const: altr,socfpga-vt
-- 
2.32.0

