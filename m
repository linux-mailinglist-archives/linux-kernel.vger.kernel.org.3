Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7851676A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiEATaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353461AbiEATaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:30:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1C52CE0F
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:26:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v12so17186435wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6W8mGDi/93K2kk8QDtCgHIHZ3boVF3yAi62LdfvdHGI=;
        b=z705utCZ70PlQa67japtrig72flqPdJgJOKkrHueq5Iw2c9SpNq+cIMxweQe2GEYEj
         shYp2a2Iw26H01P8fTOtJpjxwucUqcqc1Jef2vnQ/IUDGH66DYW8hV8L8DsTo4IRCSqN
         +dQ36SXZfQPi27IUXhVP2tcM5rSRVQHH/IGu5dNPgSDs7wfObKs2tI8tFCvb2FoyFsgZ
         rrSxwxbA0x5dXLYnuma1fKl0fRvnfMsAOhXhIbBbzy77f49AdV3zRACrX/irUrC6HUQu
         KcoFfwSkiSwvp7kyK4S3z1Ks5zOhqreoRGja0SyJCxKjlDVZXbsvlPfMm0OZ9ZlBqpWD
         mezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6W8mGDi/93K2kk8QDtCgHIHZ3boVF3yAi62LdfvdHGI=;
        b=H+lIXUCFsIZ4Vg+7XF4izwncU8+2VeqIpFOTDbQboB2vMSpZeswtA20wu+l2KGExEH
         2aBoabVC/g+B2X9jO6KjDIX2A1HcHkXLeo1I0QXUy6Mh9vMinxLRfhrsfcOclfJJ9aJD
         AxJhhoKMb1EaB/0MPTtBun72g3LJRkxDDY7JWcgsSQHX+xsPe7EOXftw0b1+36m0VJKL
         g7PYjxSTkkry4ErQB6IngCJASw+sXlJU74HE+BinMsUPQxQqx8meHJHK7IfS/zRS2nMi
         81kQkhBNmGD0G2Pm6V0eTgS3tTAr64/an0+NtqhZlEAU9NKh6XpQGZZfE4LUGZme69rL
         wp6A==
X-Gm-Message-State: AOAM531zU0OpGuJ2oJqs9twwZZkyn2LN5e3hBkSh3sLyFNuJ19J5S6G/
        KVG88D/Y2czJ8ZJ1UQQJCJzoNQ==
X-Google-Smtp-Source: ABdhPJzktGGFVqcfOs/yVESY98mBaNz3iD17f8nMMsgMFe5Ky+S2e2dB9zIM3ZVQuf3drq+RAsChrg==
X-Received: by 2002:a05:6000:1848:b0:20c:5e07:f75f with SMTP id c8-20020a056000184800b0020c5e07f75fmr3031026wri.678.1651433193050;
        Sun, 01 May 2022 12:26:33 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id i14-20020adfa50e000000b0020c5253d8c6sm6448105wrb.18.2022.05.01.12.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:26:32 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 3/8] riscv: dts: microchip: remove soc vendor from filenames
Date:   Sun,  1 May 2022 20:25:54 +0100
Message-Id: <20220501192557.2631936-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220501192557.2631936-1-mail@conchuod.ie>
References: <20220501192557.2631936-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Having the SoC vendor both as the directory and in the filename adds
little. Remove microchip from the filenames so that the files will
resemble the other directories in riscv (and arm64). The new names
follow a soc-board.dts & soc{,-fabric}.dtsi pattern.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile                          | 2 +-
 .../microchip/{microchip-mpfs-fabric.dtsi => mpfs-fabric.dtsi}  | 0
 .../{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts}      | 2 +-
 .../riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-fabric.dtsi => mpfs-fabric.dtsi} (100%)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts} (98%)
 rename arch/riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} (99%)

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index 855c1502d912..af3a5059b350 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb
+dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
 obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
similarity index 100%
rename from arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
rename to arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
similarity index 98%
rename from arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
rename to arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index c71d6aa6137a..84b0015dfd47 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -3,7 +3,7 @@
 
 /dts-v1/;
 
-#include "microchip-mpfs.dtsi"
+#include "mpfs.dtsi"
 
 /* Clock frequency (in Hz) of the rtcclk */
 #define RTCCLK_FREQ		1000000
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
similarity index 99%
rename from arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
rename to arch/riscv/boot/dts/microchip/mpfs.dtsi
index bf21a2edd180..cc3386068c2d 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -3,7 +3,7 @@
 
 /dts-v1/;
 #include "dt-bindings/clock/microchip,mpfs-clock.h"
-#include "microchip-mpfs-fabric.dtsi"
+#include "mpfs-fabric.dtsi"
 
 / {
 	#address-cells = <2>;
-- 
2.36.0

