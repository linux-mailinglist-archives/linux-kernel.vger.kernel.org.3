Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A047D467D68
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382754AbhLCSjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382714AbhLCSip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:38:45 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034C1C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:35:21 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id v15so7995516ljc.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 10:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQnrspX0S8NnC4mxCmKPdkJ6I75373YtJdts4KCHDH8=;
        b=qYK9cCqqjz4Qv85bmedDRlhwPofmfrLO949h2gjaDftYpZEPsucz4ommT5hBAk6+9z
         P/55ZUobXmg6hhr0wiBP9Lv6hu9/eS5TCPMJdkUdVcuvn8ta0CTR+betnF8V5TlFu2id
         UjKfuqV7P7yEJgF3hYBxAsSHUeY+fJRuiUqu/NLbjk8Kj3D4HqARTAYnCz2+PHGnaKgH
         0ATTA5TiEVmka2z0SjtA1AorX+BpJVRgs/ii6vwd2Magx4EsF5aoRpskY3nSYEjcK0qq
         Q+W3Bu5xLPXwMBGIawjEPMfMU+pLWHCl3JhiSASuGe9A9ccrlF7Ujg2I4SL1Ss5KEquV
         AO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQnrspX0S8NnC4mxCmKPdkJ6I75373YtJdts4KCHDH8=;
        b=uFR0jzH+fET8b/s+1CxlOUMgvAenqBuKyxU2KWBd5DMceqAiY06BP4bqmDL/DJS2Zp
         J/rZKGYf9GpL5lI1/egVw9w+s10HA6MHC1DNCJFS2V7nAJKvFgDIiBT8dHNF0PPuyGCG
         YUJzCCdgr0GQMP2cauHnalQwodbZpHgqdYHBb0kP+C6RsOLU6tvXNHA5Tbys6DqtPfie
         Hkr8ZEsPGcetd35/8U5AENfdogoXvVmFq6eN1FHq6LM54/hIgHI647B+k9WfyRYaM0dR
         FFKxLnAljzsrrJ7QknXAkLScuRv0kMDvdVX6Jd8Ob3exW/wnOBNBgogVOj91tPz9naHX
         ivsA==
X-Gm-Message-State: AOAM530b2ToM3HVic4yG5rMJtlXUk4yKVEEJ16dWHIqeEvuRhoYlQnsK
        SYagWGMeenUUppQPWPV4otMeNw==
X-Google-Smtp-Source: ABdhPJwj4GY/waMrbwCZWa+p5cuBxz4LdUMdBeiNnkEryxqskHF71WC2CXIypDg2pYfKf9/x2sxgfw==
X-Received: by 2002:a2e:9787:: with SMTP id y7mr19557627lji.228.1638556519298;
        Fri, 03 Dec 2021 10:35:19 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id f13sm462261lfc.215.2021.12.03.10.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 10:35:18 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Masahiro Yamada <masahiroy@kernel.org>,
        David Virag <virag.david003@gmail.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Only show unique unit address warning for enabled nodes
Date:   Fri,  3 Dec 2021 20:35:17 +0200
Message-Id: <20211203183517.11390-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are valid cases when two nodes can have the same address. For
example, in Exynos SoCs there is USI IP-core, which might be configured
to provide UART, SPI or I2C block, all of which having the same base
register address. But only one can be enabled at a time. That looks like
this:

    usi@138200c0 {
        serial@13820000 {
            status = "okay";
        };

        i2c@13820000 {
            status = "disabled";
        };
    };

When running "make dt_binding_check", it reports next warning:

    Warning (unique_unit_address):
    /example-0/usi@138200c0/serial@13820000:
    duplicate unit-address (also used in node
    /example-0/usi@138200c0/i2c@13820000)

Disable "unique_unit_address" in DTC_FLAGS to suppress warnings like
that, but enable "unique_unit_address_if_enabled" warning, so that dtc
still reports a warning when two enabled nodes are having the same
address.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reported-by: Rob Herring <robh@kernel.org>
Suggested-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index c9abfbe3f0aa..41c555181b6f 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -65,7 +65,9 @@ DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
 override DTC_FLAGS := \
 	-Wno-avoid_unnecessary_addr_size \
 	-Wno-graph_child_address \
-	-Wno-interrupt_provider
+	-Wno-interrupt_provider \
+	-Wno-unique_unit_address \
+	-Wunique_unit_address_if_enabled
 
 # Disable undocumented compatible checks until warning free
 override DT_CHECKER_FLAGS ?=
-- 
2.30.2

