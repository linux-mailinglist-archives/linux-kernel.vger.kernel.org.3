Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87355825CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiG0LoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiG0LoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:44:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FAD49B78
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:43:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x7so1996367pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CPQHjznoZ6b2glx4mv5BleZiD6F9CrQGa2QjZHjYAk=;
        b=FRPQ5DEeON6hr+ON1ZUCBRqVaD6UKtMN7FWnG+TiJ551KlCqDdy0r3uLcwH2HL6QJH
         l7WDhuWl9MkfjaS0XSPgW9n1unZhtd6+ZfZIrtE0tIBXUKu/nxEI8OzSdaFZhd36YBw+
         wbWNIjvHFN6IOiBHmHuSoXwZjtEnI3g6Aquz2voLi7ZqtjwNt9yj4UpVrKUpMt9LYOLV
         YFedqPoHh7qK8JDHl3M9tTn+9SS3ruir8rwhVtM13Btz83igBcjWQzRMQYfrDzbONY4O
         MQyTStOXmK5oUhHGLHrZVgYo3MU7fQNWgfu66fsCss8DYRVxISd/TFoUlrgTkqMwzjIR
         fSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CPQHjznoZ6b2glx4mv5BleZiD6F9CrQGa2QjZHjYAk=;
        b=5p9OHcxuFFeCQBAi5S/df8WvCkYti4MSnaVWHQhSPWKzm4urCDu3+kBl6jbbNQgQ0h
         yMnBapXGDzOItDEZ7uSZcFRWuwkwFfktuM/LuSiaSgFN/QQH6R9W3ZlQJiouFjDPfAef
         wAei+Z8ui7scFlw3roV9tZzigZG3WcPR1L+YomHotKKBZATdYY3l7XT0cOUOMNxagxrk
         ra+LHeuVFEDDpODYN7mCyb6EXUYVeM5PSRRlz+Fn0sDqJ3H6ABIY3e1eXz/11ORH+Cjt
         BSXDv5oYRz9a8+dYDie2OIT55RfpxoMEx9vQyMLneVmNZsynKUFhm4toD8232eIEBg43
         c9sw==
X-Gm-Message-State: AJIora9bbZ2/LsToVPfmtCOzcpK/Nf6djRj/hMWQSxJSnKIStgS9lNf6
        Vi/76eZTW0zaoR4WJaTruNc4jg==
X-Google-Smtp-Source: AGRyM1vnaKRmTMYomS9eDouKLzyJu05leK/dJlguPo3uyJqQ85jD8Cdr1zYUFAC0wnfYAIhPgdEy4w==
X-Received: by 2002:a17:90a:9bc4:b0:1f2:389a:7faa with SMTP id b4-20020a17090a9bc400b001f2389a7faamr4282213pjw.72.1658922238405;
        Wed, 27 Jul 2022 04:43:58 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.87.63])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902d4c800b0016be9fa6807sm13486685plg.284.2022.07.27.04.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 04:43:57 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property riscv,timer-can-wake-cpu
Date:   Wed, 27 Jul 2022 17:13:01 +0530
Message-Id: <20220727114302.302201-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727114302.302201-1-apatel@ventanamicro.com>
References: <20220727114302.302201-1-apatel@ventanamicro.com>
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

We add an optional DT property riscv,timer-can-wake-cpu which if present
in CPU DT node then CPU timer is always powered-on and never loses context.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d632ac76532e..b60b64b4113a 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -78,6 +78,12 @@ properties:
       - rv64imac
       - rv64imafdc
 
+  riscv,timer-can-wake-cpu:
+    type: boolean
+    description:
+      If present, the timer interrupt can wake up the CPU from
+      suspend/idle state.
+
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
 
-- 
2.34.1

