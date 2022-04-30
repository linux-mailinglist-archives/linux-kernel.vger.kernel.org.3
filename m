Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B841515D66
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382751AbiD3NQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382698AbiD3NQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:16:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C85B83016
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:13:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i5so14024256wrc.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l7Rc5OS3t5jH6ZKfP/hcCEMnf9UpuWYMdCo25UYCckg=;
        b=X9thXVlmcxmH1PE12wviFkCqeB+MZYit8NQzf7UG+cKxQdSXGYfNvp7epUsMhphPqw
         dgI0WpBh0Q16kC+ZyLeT3gTwo77RcBTLZdMSrV2LfXYUCnDCz9trJlWx4B6qkjb3UKcH
         /kwL7Y3RvEE71ZY7lCZrSxmxURm6ziJ/ptAjeQSh8WkExAGRC2DdTIw6RyuHUA0qIUQD
         aeDj/HfU6moCSAkfL+R0hj+IeFufhNBoyleaw0kmPvK2aA4eotgsq+ljwATz/XNDZBJO
         KyekhtyA4ptf7zq5UJYpNJUJHZB3KjExiMKo8fb/9Cidq4B5IFsDPeuwpSZ5mq6zs5zH
         vwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l7Rc5OS3t5jH6ZKfP/hcCEMnf9UpuWYMdCo25UYCckg=;
        b=cqt2u4Y0bTfK19MIXPqOBAnISTgMOhM0fAFIlJ/lLGQKgsELDzr2G8Ol6Udhy9bGwG
         LKUVk/SYaJJ9MU2NMW4Oxo9Fqt+55D7PlLTA8VIlRyJdVGL4OjlpfMKDvGDSiEZnYDgg
         JPxh2DEfY8f1s5uJvu2I1cR3lOGXUwKpyF4iKMsS1pJOyDkWCkSLzu3lb87tyBfRDU8Z
         Z3n++mVUXmX00+siR9FPPuIdwu31MEIkrmo9bmG0CSAkgmRQzirxMwT6QwWBIyphrL5q
         xRluIUgqMWC0GlbDukgrOFktKh2JHjRqqGh0KYwJJAaxpd2nrd32imvUgMbqliMqnqaQ
         K+Sw==
X-Gm-Message-State: AOAM5319zRk1Bmx+HSowWSAOH4slc20KB+qShvnD7UWhreMdDUxUgDVV
        BLM71wgbzNEnzg0fyxeQ6EzfKMy/DU5dODpE
X-Google-Smtp-Source: ABdhPJwfVdzniLJsxd2OkH7C13/Hxoma+jQxRAs+vM3HMP4eVaImC/GGXFNkSLzzDuWaaC2VqGfS6A==
X-Received: by 2002:adf:e942:0:b0:20a:c907:90d6 with SMTP id m2-20020adfe942000000b0020ac90790d6mr3047537wrn.163.1651324378647;
        Sat, 30 Apr 2022 06:12:58 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id p9-20020adfa209000000b0020c5253d8ebsm2004439wra.55.2022.04.30.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:12:58 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: [PATCH v2 5/8] riscv: dts: microchip: make the fabric dtsi board specific
Date:   Sat, 30 Apr 2022 14:09:20 +0100
Message-Id: <20220430130922.3504268-6-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220430130922.3504268-1-mail@conchuod.ie>
References: <20220430130922.3504268-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Currently mpfs-fabric.dtsi is included by mpfs.dtsi - which is fine
currently since there is only one board with this SoC upstream.

However if another board was added, it would include the fabric contents
of the Icicle Kit's reference design. To avoid this, rename
mpfs-fabric.dtsi to mpfs-icicle-kit-fabric.dtsi & include it in the dts
rather than mpfs.dtsi.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <mail@conchuod.ie>
---
 .../microchip/{mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} | 2 ++
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts               | 1 +
 arch/riscv/boot/dts/microchip/mpfs.dtsi                         | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)
 rename arch/riscv/boot/dts/microchip/{mpfs-fabric.dtsi => mpfs-icicle-kit-fabric.dtsi} (93%)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
similarity index 93%
rename from arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
rename to arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index ccaac3371cf9..7ee592e78c05 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -2,6 +2,8 @@
 /* Copyright (c) 2020-2021 Microchip Technology Inc */
 
 / {
+	compatible = "microchip,mpfs-icicle-reference-rtlv2203";
+
 	core_pwm0: pwm@41000000 {
 		compatible = "microchip,corepwm-rtl-v4";
 		reg = <0x0 0x41000000 0x0 0xF0>;
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 84b0015dfd47..739dfa52bed1 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include "mpfs.dtsi"
+#include "mpfs-icicle-kit-fabric.dtsi"
 
 /* Clock frequency (in Hz) of the rtcclk */
 #define RTCCLK_FREQ		1000000
diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index cc3386068c2d..695c4e2807f5 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -3,7 +3,6 @@
 
 /dts-v1/;
 #include "dt-bindings/clock/microchip,mpfs-clock.h"
-#include "mpfs-fabric.dtsi"
 
 / {
 	#address-cells = <2>;
-- 
2.36.0

