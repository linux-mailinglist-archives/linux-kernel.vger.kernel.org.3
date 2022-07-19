Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9C5792A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiGSFs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiGSFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:48:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543D25596
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:48:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r186so12566302pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Zv1KPN9JiNDXsrpx/KpRv4jlVQ/XgtQ+la2iBvvbEo=;
        b=aPmyhgHbEj3yjha+RdH7+WmsgzNU6UK2PdYcjlAmGBwYMtEf1UUTaGFvA/5q3/uqf2
         TSB6Pb0KkVqQxl+mHM+p05+aB2P5iNDR4JPwth096jqb6fK+ei29DWXX6/m5v9EsqHiI
         4EJ/DM1d9n7Rq270JbzZLvMOQyJDkGEGWn0b9gPk0e8WV0U9tV5+yXOwjV8pN4Ua2ZPA
         ZX5FKnH5IeeNqaVG+9NH1B6+Sz/m4+M852tl3ArR+1lescplIrffsGg4Y9JW/C4xwctn
         gGtD4KLl+OQq9rj6VoPFcNUtmF+IrtEbwKLvDpQcEIUsvhbJOXyJwOzd5tEghk+vQCC2
         gGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Zv1KPN9JiNDXsrpx/KpRv4jlVQ/XgtQ+la2iBvvbEo=;
        b=rS11YV0Tq0OWeBpNmREMspuR8q5yNipEfyo8U/Gt07XweWQxmXZ4QKF843SHH2Ii9Z
         GWnYq54mK6o8x4VDwUwlywLRF3omlisDiotYFtmro+y6t/tWzZzbucdgiZdHZbU4iBLC
         O0/xIorSXz8Ttfzqs9aj3uJsXjhQddeFQQpHx38otDgpvL7SI5fkPEGshRfy62RCU8Yj
         c6Us7keJQW9rFcuOny+LtWl594h4hGsALE220idZ/XHv0qPN8phTOGAzuiCMRumedBYw
         KNTuLNBBuQPjdgL5jDH8kgg31s0xHfMC5K5vyp4KPkhH+SwK50AFIg8D0/3OBYwcWG6f
         XSSg==
X-Gm-Message-State: AJIora+8UGvATRDUK3/U2GzOUoh4LL5GkkKvYR8I5TOCVl8u9bAE+JWT
        aBMQBPkkMY0uE0vbTBUkfTv6sA==
X-Google-Smtp-Source: AGRyM1swatdkW28ipNZyiwyjPCdj/wjSf0JTm3UtSlnt0QiJb65SJO6lfU4nMttdr1PWPl6x72yPxg==
X-Received: by 2002:aa7:8887:0:b0:52b:17e8:fc7 with SMTP id z7-20020aa78887000000b0052b17e80fc7mr28107122pfe.35.1658209705381;
        Mon, 18 Jul 2022 22:48:25 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.93.102])
        by smtp.gmail.com with ESMTPSA id o186-20020a62cdc3000000b0050dc7628171sm10374129pfg.75.2022.07.18.22.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:48:24 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/2] dt-bindings: riscv: Add optional DT property riscv,timer-always-on
Date:   Tue, 19 Jul 2022 11:17:28 +0530
Message-Id: <20220719054729.2224766-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719054729.2224766-1-apatel@ventanamicro.com>
References: <20220719054729.2224766-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add an optional DT property riscv,timer-always-on which if present
in CPU DT node then CPU timer is always powered-on and never loses
context.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d632ac76532e..33832b8dfaab 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -78,6 +78,12 @@ properties:
       - rv64imac
       - rv64imafdc
 
+  riscv,timer-always-on:
+    type: boolean
+    description:
+      If present, the timer is powered through an always-on power
+      domain, therefore it never loses context.
+
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
 
-- 
2.34.1

