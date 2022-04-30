Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA1515D60
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382695AbiD3NQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbiD3NQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:16:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6339C82D23
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:12:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t6so14065643wra.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vCDZDxNF7ZpqCxnRxrYAOyYCsp207pYkROFjiHem+g=;
        b=XvSKxvLpEQjAkw8/ypM8c3YYtSSYtdpoJSa1Ww30x9aLc74D0KOsMl+k30OnNyQ9K1
         vQD+hhGLkeWvpJUbcaH1pWIvAovINFPJY3/oTaPq/yJ16EmdeD/w4K0fBJeTsui55YYy
         inTHM0Bp8+7apN2m/AVJQQ8YGOXdG9NCDv8PVXdmkkxiovBgh5aBJpsKqnUAyQrsDbMq
         uz3YiOSKYBrlQIJesPeuoA0FxDQS+mVow1cs86E4Pz3dfqoDIT1SQnfxHv6gr9szD1fh
         DbgJG6BR0cd5EAV/Cee2G6xGOWVv10cgoLrRaGoii9oiyrJAFz4NTz24zAa5rQcCcn+8
         6g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vCDZDxNF7ZpqCxnRxrYAOyYCsp207pYkROFjiHem+g=;
        b=XE9YQeJsOD9/9trrUwRtXpkw1qRyhdbvg65RWBHfmQ+4NGT4s+SZBuaD2DiR45LWhS
         FmxMe0zxNyM1mQLL5b4ESeYGXFptkBJi3BXHSWZgAMJ/zFIAfD0x8wJI5xAGwzSiqiUO
         r7KFskUHXH5zweqcMnb4CVibLPuwkrh15Pr2L06PxQ1N2JqbyY0+imZ/ZgFmfav8U/R9
         ZkFKw3K8ZrIU+jPK/nUwNMazxCBtUhbEU7iMsm9jZOD8xlt1hjr0mt7qaES79g3J4Gls
         TCfzjWQTKEk9CZLnSpCnbrn9WreqY5x+xKYgZ0zsWXeihrRxwx/jXcjx6HMGLXLhGHDg
         x94g==
X-Gm-Message-State: AOAM530dUv0ZaCexhBXov2CwS+9mWtZ1mMgk0pgcRbH4FMrl5T0svX+b
        LXlki2aXfszmaFH9ONzHOdQ2bw==
X-Google-Smtp-Source: ABdhPJyhk6sNyn6PYT8mUPpuoHYBQRyblDmpRGPqmY7TVB139oqJYZ2QO/EfyGQOU0BmMjp+TJTM8Q==
X-Received: by 2002:a5d:40cf:0:b0:20a:e0cf:2a47 with SMTP id b15-20020a5d40cf000000b0020ae0cf2a47mr2989078wrq.575.1651324373826;
        Sat, 30 Apr 2022 06:12:53 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id p9-20020adfa209000000b0020c5253d8ebsm2004439wra.55.2022.04.30.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:12:53 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: [PATCH v2 1/8] riscv: dts: microchip: remove icicle memory clocks
Date:   Sat, 30 Apr 2022 14:09:16 +0100
Message-Id: <20220430130922.3504268-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220430130922.3504268-1-mail@conchuod.ie>
References: <20220430130922.3504268-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The clock properties in the icicle kit's memory entries cause dtbs_check
errors:
arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dtb: /: memory@80000000: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'

Get rid of the clocks to avoid the errors.

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
Fixes: 5b28df37d311 ("riscv: dts: microchip: update peripherals in icicle kit device tree")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <mail@conchuod.ie>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 3392153dd0f1..c71d6aa6137a 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -32,14 +32,12 @@ cpus {
 	ddrc_cache_lo: memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x2e000000>;
-		clocks = <&clkcfg CLK_DDRC>;
 		status = "okay";
 	};
 
 	ddrc_cache_hi: memory@1000000000 {
 		device_type = "memory";
 		reg = <0x10 0x0 0x0 0x40000000>;
-		clocks = <&clkcfg CLK_DDRC>;
 		status = "okay";
 	};
 };
-- 
2.36.0

