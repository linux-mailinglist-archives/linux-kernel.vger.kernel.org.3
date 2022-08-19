Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF059A938
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbiHSXPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiHSXOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:14:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70878D6B86
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:14:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d16so1410785wrr.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qOyz6Sg85RbWT2/Ms96NRUeJwTK6SHK6KdVqomRoy/M=;
        b=b20LHdRRH8R/Q+oePil62xrPW3l+XqvP6OmHEeWw5bOMd1EMbcO5TLuIWroY5y4Ee4
         CtEA5P44vdN71F2XBMUzih8Oyi5MNTB6RCneepbuqNo+PvIRb28c3l0VYVyt+z2a3ArX
         MnCcFo1H7PxGuAjpRKHazx2atqDqRZV1JtUGrw7N3Q2HleE0QUrVKEJAnY3qwDKkLFC3
         M9vIok1W1mUEtYuyX4YpLrISDk1RfxX5dRP4o4ReB9RDkWygOCIS/hSJ6FJROZ9Yq5Eo
         5HBu79m9ltkIkSUT/q1W4UEGTGZiXchtMW9C+KujCeX4I44CfYxOaytpkD2uT91XGFvA
         xpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qOyz6Sg85RbWT2/Ms96NRUeJwTK6SHK6KdVqomRoy/M=;
        b=dd6RsfGqAHLJ4dSuUh0jRtbzXdApMwsYrKGrQIKvIv1/OaO754ya9lVnR9s1uFfNim
         +kyVUUIaLfMErAXFc4mdFzSXVQ5+WOLSIL/zwZXam0ShLQI0pC7s8U9fXQFTJJQFIjeQ
         YyrEzexSXUS3SH9x1ic2oCyYb+h6PpAU+cPwrmr+XzEwe/ywOTlGsNVEuX29P9enyYGr
         kYm2MqP2L58HmDcnUYk6sJQjAl/uFpZ/ofpGMdillY0/O7eUGS7Po4SoP4B26dHT9Dze
         DIR1wenUXFdTfRXc8VM1qre0iCaO5J1cE2WZIhwGhPKNQlfscAeyb3/16zOL+y+lMeiQ
         aoPw==
X-Gm-Message-State: ACgBeo3OqHRqTou1EcU7Gt2toxdoOPY8NZf1L+GrSNT8y221plFti4jl
        s1UitmrlYgLhPh2XYy35g+VIpA==
X-Google-Smtp-Source: AA6agR6vUaHN6BTvJT+nGrbl0qd+vCmNAcWX79JjfXB/fht2QO+oi5yTVfEecpWAaDUdcw+aY1zs+A==
X-Received: by 2002:a5d:64e2:0:b0:220:7dc6:1353 with SMTP id g2-20020a5d64e2000000b002207dc61353mr5381793wri.411.1660950871065;
        Fri, 19 Aug 2022 16:14:31 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d46d1000000b0020fff0ea0a3sm5198522wrs.116.2022.08.19.16.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:14:30 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 6/7] riscv: dts: microchip: mpfs: remove bogus card-detect-delay
Date:   Sat, 20 Aug 2022 00:14:15 +0100
Message-Id: <20220819231415.3860210-7-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819231415.3860210-1-mail@conchuod.ie>
References: <20220819231415.3860210-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Recent versions of dt-schema warn about a previously undetected
undocumented property:
arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: mmc@20008000: Unevaluated properties are not allowed ('card-detect-delay' was unexpected)
        From schema: Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml

There are no GPIOs connected to MSSIO6B4 pin K3 so adding the common
cd-debounce-delay-ms property makes no sense. The Cadence IP has a
register that sets the card detect delay as "DP * tclk". On MPFS, this
clock frequency is not configurable (it must be 200 MHz) & the FPGA
comes out of reset with this register already set.

Fixes: bc47b2217f24 ("riscv: dts: microchip: add the sundance polarberry")
Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2022.08 or later of dt-schema is required.
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts | 1 -
 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index ee548ab61a2a..f3f87ed2007f 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -100,7 +100,6 @@ &mmc {
 	disable-wp;
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
-	card-detect-delay = <200>;
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	sd-uhs-sdr12;
diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
index dc11bb8fc833..c87cc2d8fe29 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
@@ -70,7 +70,6 @@ &mmc {
 	disable-wp;
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
-	card-detect-delay = <200>;
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	sd-uhs-sdr12;
-- 
2.37.1

