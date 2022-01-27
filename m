Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2BD49DBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbiA0Hwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:52:43 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36066
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbiA0Hwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:52:39 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 476D53F1D0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643269958;
        bh=qdfi4d+HIRszzf26gXi/pQU/uCw5YnQfSUk9vCmYV/U=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qovQ6rB8MkLVUT6Nyhw/eGBQdpE1fWj9NRKiVdlcY8XJFlGMfA9aNn1fnCWPlevEf
         Rg7t4/nPyrwFtALI2JmD52w0D7ELditIOGouxJ88q79oWJBemESbTPz8B1cDnzLerF
         OSCLAjLD9FTXwjEBfdBmwq4OhCYG5eyGldtuoC+RG0jKBD0EYQuPGMN8VmAXD8LAn7
         kjXd4fWjEgCaEBOiwuwKs3P247cnaK/sBDFalkVM7wT8NtP3sM5OaFVi2bXeinL1RU
         H+T+ArkZkzp3oH/zuPDM+EKGX8MFpuike7b4bDmcp/rNPDzORTRZUptcnK3drbrfUp
         kw37de0ahiFbQ==
Received: by mail-ed1-f70.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso986612edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdfi4d+HIRszzf26gXi/pQU/uCw5YnQfSUk9vCmYV/U=;
        b=74Yi7f7unBWKZXgK+C+HhV5kbdXd3dfzM8cytBhdobXzkdxEwL8N1DNaa4lt3XO4xm
         pi+1kCcR+8HKgVDQWdzeqX9NQDiEeb2F4U0i+UcJFa+va4RXabUS3MDoDCd0eL72OnVm
         XBLt9zYFqz41/WOBxaafdXTYbDPTakmImerzLz2rCqbBttqA+FyT62of48AqgKX1JB0d
         Y2+2tBQDBXvOMresKqPK2r/f9Zhf62XNqGA9ROxKLuYmVS2amBGgmEMXvSVk06S4VgS3
         h6C7GuMQSJJZl2K4wrF+e3+rDYPXSb5KPSlemX0veDOUtx9r0/7HtFlcrb8oKYa44Uq2
         eBhg==
X-Gm-Message-State: AOAM531SB9Z3UUAbeqj57hW6H2z8lDszouGK6UNsetFrr2Rq6m58/FrT
        A2I8Rucnr6ygJOH/ZcUO3pBYdOnA73GprCXPQoO+/mOLozb7CseK6+gpFCJAEKG0OAkpb5aHO5g
        mSalE254rTpTVQmUonv4Ac/xO5+ajY/JswnoWsm/VUA==
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr2539235edc.258.1643269956983;
        Wed, 26 Jan 2022 23:52:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXgM/NUB2nDHBifcFiSo9kBuXpOj4f7jGx7eR7EFTCWiVTMxtZDYwMkSwUrGK449uKeKU31A==
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr2539208edc.258.1643269956206;
        Wed, 26 Jan 2022 23:52:36 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bv2sm8305550ejb.154.2022.01.26.23.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 23:52:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        nick.hawkins@hpe.com, verdun@hpe.com
Subject: [PATCH] dt-bindings: vendor-prefixes: clarify HP prefix
Date:   Thu, 27 Jan 2022 08:52:29 +0100
Message-Id: <20220127075229.10299-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two independent companies: "HP Inc." and "Hewlett Packard
Enterprise". Clarify that "hp" prefix is about the first one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Cc: nick.hawkins@hpe.com
Cc: verdun@hpe.com

Optionally please squash it with a new patch adding "hpe" prefix.
See: https://lore.kernel.org/all/20220125194609.32314-1-nick.hawkins@hpe.com/
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0d8da47cda1a..05a059c8a011 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -518,7 +518,7 @@ patternProperties:
   "^hoperun,.*":
     description: Jiangsu HopeRun Software Co., Ltd.
   "^hp,.*":
-    description: Hewlett Packard
+    description: Hewlett Packard Inc.
   "^hsg,.*":
     description: HannStar Display Co.
   "^holtek,.*":
-- 
2.32.0

