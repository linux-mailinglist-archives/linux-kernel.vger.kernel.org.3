Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3A597779
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbiHQUGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiHQUGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:06:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62A45A88F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:06:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so1552461wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=maIqyDhug0EL/mXAyR5nYeGttmLcfb6O/BjdQzpTa5E=;
        b=SvB7YEP3eBYgrsleZ9iJFkse/4XFgJLUFnZphTSo/h+JulyMrKVTZD8RO5Kg+xC5CU
         DeM3YEJ/7AJzDEuYTEFUS4u64EqaNwRPh8LLxU7fOu+knhpXuF1UoqLMf2vDzColvBcG
         l7EmjVeU4ldGrhztpHd+yPyzkjgGuYQURy1EZIMtGAO8cM/JJPCeB+60hrOrBaNrDsS6
         AaVH3j6cDsNPNUKbsndY9MAU8mfFXMKGQOiukc6NDpw2gXBhTGUTW9yoLzJt/azZ3xzA
         7hI0vRlX+AqEl3fe97FyADdLJ4s6F+sjgTgO0k8BTw9+Ru5FXr9VeuJ35AY6NZA3XKo3
         rDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=maIqyDhug0EL/mXAyR5nYeGttmLcfb6O/BjdQzpTa5E=;
        b=VP2Jbrm+jrm7jcJ37q+nOMeYHXGj9iqblkB6BbfmBTq8KHPSwh9jtxY7SK8wOde2D7
         2RqZYo+e5CSf/uQYabbBOFpvKgpExDlQalJ/dSWBPi6QdQLdWXNrhxXijmwZzw8BeEgu
         SxXr70MFHrsMMoGqii4VGib5psYLTWP+5tahhKaY8qZE2vm9TgrjCXBYaUwRIqbUAIRn
         Nnpt7/lJkEl8EdONY7VWkSmmR6fk603dXfn4qBaH2Tauqs+9j8/PyPGtS0EsxDYcUC7X
         No1d75PpsSG+rv54UYq7XhsQYW2jq+QjtlYN9j035BVCBTYp90+V8eNVSAkMEtYa3LYK
         Ooyw==
X-Gm-Message-State: ACgBeo2UlDWfUvReuvD7en1bzDklwb54wIOsOkP3+V4GE0JCXv+vYep6
        e2qo9fewnX68/+PFnILgm7qV2A==
X-Google-Smtp-Source: AA6agR69vG8ENkmh+Uqgy8Kv6cQH+ISkT39e9E6kBR+5DdZP6du68vAeHlgf+tU+DqK4XBGR6h4HRw==
X-Received: by 2002:a05:600c:3b0c:b0:3a6:aa0:5966 with SMTP id m12-20020a05600c3b0c00b003a60aa05966mr3076942wms.183.1660766762106;
        Wed, 17 Aug 2022 13:06:02 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i133-20020a1c3b8b000000b003a531c7aa66sm3400883wma.1.2022.08.17.13.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:06:01 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        Rob Herring <robh@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 1/4] hw/riscv: virt: fix uart node name
Date:   Wed, 17 Aug 2022 21:05:26 +0100
Message-Id: <20220817200531.988850-8-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817200531.988850-1-mail@conchuod.ie>
References: <20220817200531.988850-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

"uart" is not a node name that complies with the dt-schema.
Change the node name to "serial" to ix warnings seen during
dt-validate on a dtbdump of the virt machine such as:
/stuff/qemu/qemu.dtb: uart@10000000: $nodename:0: 'uart@10000000' does not match '^serial(@.*)?$'
        From schema: /stuff/linux/Documentation/devicetree/bindings/serial/8250.yaml

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
Fixes: 04331d0b56 ("RISC-V VirtIO Machine")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bc424dd2f5..6c61a406c4 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -917,7 +917,7 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
     char *name;
     MachineState *mc = MACHINE(s);
 
-    name = g_strdup_printf("/soc/uart@%lx", (long)memmap[VIRT_UART0].base);
+    name = g_strdup_printf("/soc/serial@%lx", (long)memmap[VIRT_UART0].base);
     qemu_fdt_add_subnode(mc->fdt, name);
     qemu_fdt_setprop_string(mc->fdt, name, "compatible", "ns16550a");
     qemu_fdt_setprop_cells(mc->fdt, name, "reg",
-- 
2.37.1

