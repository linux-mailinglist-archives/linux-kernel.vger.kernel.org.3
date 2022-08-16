Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797AA596272
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiHPS00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiHPS0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:26:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528E86C21
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:26:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p10so13608728wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1LGGHQ6p+mDphp3bmxn1t5fZUfaS0Whf3Mk8geT3R/0=;
        b=TiOXfR9UekVJZRu7evd3xJo1JSSbcUbx/ZgBAE+jckIRBaEzCO5PwmG3rqD5z5zN53
         0AUtBwvF39Nfxva12oH0R9WNAVRfcWT1zluLWip42kfP2Hl7UgGxAJ6crW2lEvSFh5BH
         nkX9NvPQ9x7JlYkKi6K9YqcEPT+ZrEhwFYF3Sh+XQk/v4JsMDMpF1KlZJMBZzl2JqKqY
         ScVfYOAfRcm+1+wC0uA049NWyCbH8DO4s6/azpjdBZmnMp7G1Er0FoZk4zWi70CfKRvD
         mCACPBrFGx1PgSbm7sBofXPHA98a4rFi0Ogtd/hFKf1Qc3YKLpdXqsljBHFCzwBR1hWI
         3shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1LGGHQ6p+mDphp3bmxn1t5fZUfaS0Whf3Mk8geT3R/0=;
        b=lOeirNRvc9Giiy/fDGVuIgoUGaqkUu05F+nzGSMtB5WJUTn8KtDTuEtZWTDch4TcqG
         8sQtknglE6tdrqhABHEgqjP8n1Gp0c/Ysw7zM72KMDZbEq1VmtDFsawxK3yw8gxRtwhy
         0haykd7BzNAl+C0vlT8tC/h9Q/caJtKalloDY8Ew9HNGF0Tgt1UZ72h9pGHLf1VzQhW1
         3zH4YECR5VV4V8UFiAW28hSVHlNxPuTBE5HQkW6GDRs2vq3izvTi6RRg0kU8IiiKQlsz
         n/UU6UpTUtM/z0bYLMQAYdVyzNvCHFNUAQ3bkPacR5R8Rt84IC/FktCjCbgl8wVicSni
         9v/g==
X-Gm-Message-State: ACgBeo1BAUDfEia7tX5G2perhG0/klHdZFXGPEOfZFqaUCf1p1+tWJ80
        QX3cxn99e4itEFJvf7EwTojovw==
X-Google-Smtp-Source: AA6agR40opo+7mClW53ltFMT6yiRmc3Yot2+VJrAVQqciuJ53cfMm+Ju4S49z0oFptPwsbaT26fANQ==
X-Received: by 2002:a5d:588d:0:b0:220:73d3:997e with SMTP id n13-20020a5d588d000000b0022073d3997emr11899733wrf.546.1660674360051;
        Tue, 16 Aug 2022 11:26:00 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003a603fbad5bsm4015482wmc.45.2022.08.16.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:25:59 -0700 (PDT)
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
Subject: [PATCH v2 4/6] riscv: dts: microchip: mpfs: remove ti,fifo-depth property
Date:   Tue, 16 Aug 2022 19:25:46 +0100
Message-Id: <20220816182547.3454843-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816182547.3454843-1-mail@conchuod.ie>
References: <20220816182547.3454843-1-mail@conchuod.ie>
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
undocument property on the icicle & polarberry devicetrees:

arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: ethernet@20112000: ethernet-phy@8: Unevaluated properties are not allowed ('ti,fifo-depth' was unexpected)
        From schema: Documentation/devicetree/bindings/net/cdns,macb.yaml

I know what you're thinking, the binding doesn't look to be the problem
and I agree. I am not sure why a TI vendor property was ever actually
added since it has no meaning... just get rid of it.

Fixes: bc47b2217f24 ("riscv: dts: microchip: add the sundance polarberry")
Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2022.08 or later of dt-schema is required.
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts | 2 --
 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 044982a11df5..ee548ab61a2a 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -84,12 +84,10 @@ &mac1 {
 
 	phy1: ethernet-phy@9 {
 		reg = <9>;
-		ti,fifo-depth = <0x1>;
 	};
 
 	phy0: ethernet-phy@8 {
 		reg = <8>;
-		ti,fifo-depth = <0x1>;
 	};
 };
 
diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
index 82c93c8f5c17..dc11bb8fc833 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
@@ -54,12 +54,10 @@ &mac1 {
 
 	phy1: ethernet-phy@5 {
 		reg = <5>;
-		ti,fifo-depth = <0x01>;
 	};
 
 	phy0: ethernet-phy@4 {
 		reg = <4>;
-		ti,fifo-depth = <0x01>;
 	};
 };
 
-- 
2.37.1

