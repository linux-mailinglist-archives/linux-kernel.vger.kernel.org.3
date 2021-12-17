Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA658479276
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbhLQRIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:08:22 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:37394 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239156AbhLQRIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:08:22 -0500
Received: by mail-ot1-f54.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so3675206otg.4;
        Fri, 17 Dec 2021 09:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8zplcAKJ5wrZOx8xUb88onbH++jPgJbSoL/b/D08i/I=;
        b=QKIj4fytIkupz2rjtTx9O/pPkymr444nfF7hfvZMyBON8bOV/uD2EZO1w/Umbu5IPz
         3CeAyFwaIJyOLVmQTR4kCaKxC8dJh4UX+3bCrlqZWShDi0snrJWLw8VTisVj3QHRSCKr
         q4omZJDjRqpSgWa7WxJs0+CbYGHhGmz7zbgnhAOlyL6wjTtfuNkgJ3cNPaF4mGaCmdvC
         vs876XuJTREMuXkbc3amcDDevBU4XGeoCf1x/yHClIuThlQHhl2ccvxpwKGw5q0VYR6D
         o/lDYEjA1AlXH41Iim29Z0dyz7IRTAkDNb0C6eah76bTMwq8kVDWFhfRm3EbqfPAPnJg
         6mJA==
X-Gm-Message-State: AOAM532o9GMw8BMa7bxeW0ZwbHyHhXUwIMA66PAnoa2PshqbRIUvh89V
        T0AnsQcAD+w5r7whyIaglA==
X-Google-Smtp-Source: ABdhPJyLemJ0/AHJnJ3qunkWa4KphC3zw59AMVzw53YU994eayPkNy6e8b8Vrqi9AOoTgch+1OKToQ==
X-Received: by 2002:a9d:60f:: with SMTP id 15mr2717678otn.266.1639760901503;
        Fri, 17 Dec 2021 09:08:21 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id n26sm1614683ooq.36.2021.12.17.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:08:21 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm,cci-400: Drop the PL330 from example
Date:   Fri, 17 Dec 2021 11:08:03 -0600
Message-Id: <20211217170803.3147777-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PL330 was commented out because its binding wasn't converted to a
schema. With the binding converted, the example now needs several updates.
However, while it's possible that the PL330 has a 'cci-control-port', there
aren't any platforms upstream which do. So rather than allowing
'cci-control-port' in the PL330 binding, let's just drop the example.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/arm,cci-400.yaml | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,cci-400.yaml b/Documentation/devicetree/bindings/arm/arm,cci-400.yaml
index 4682f991a5c8..f8530a50863a 100644
--- a/Documentation/devicetree/bindings/arm/arm,cci-400.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,cci-400.yaml
@@ -166,16 +166,6 @@ examples:
               };
           };
 
-          dma0: dma@3000000 {
-              /* compatible = "arm,pl330", "arm,primecell"; */
-              cci-control-port = <&cci_control0>;
-              reg = <0x0 0x3000000 0x0 0x1000>;
-              interrupts = <10>;
-              #dma-cells = <1>;
-              #dma-channels = <8>;
-              #dma-requests = <32>;
-          };
-
           cci@2c090000 {
               compatible = "arm,cci-400";
               #address-cells = <1>;
-- 
2.32.0

