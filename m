Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971A351AF60
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiEDUjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378200AbiEDUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:38:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0991092
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:35:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c11so3513337wrn.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u32JFIRC//emCZL/Ld3yABcbdL+d3UQ5fDlVHIQccNo=;
        b=EqFAmxuYJmI2kg2xatXiw/7b//+XA/+XzJzcDLMsLcAOX1ovCEd1KFfehGAAlyE/4f
         xiEsAoP4ivzt5ag/BNffjzP+vfNzGXwAIK22vNZQHW+NcP7O09lV3mpCC7Y6loIiONrA
         TTsShcURvOoV0uUpDVoGQAxc1Bl2gAypo/gfEHlcSVj5tO79VuX+dc+7lB+A2Y42au5l
         H7WUi6m66kT551TvD/5W6zFWyscv1V1s17bypijpwcglt/NXM9J0zI3zkSpgFPF+rZVs
         ZbH1OXkxjFCSbAD6w2PvEQE0c1NTq4S6bPHM+Pn78i4aywVaF3Meg/7ZOF1rAk3WinHd
         YsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u32JFIRC//emCZL/Ld3yABcbdL+d3UQ5fDlVHIQccNo=;
        b=qpeePhYev92yhCPSkdV3GiA9ujMC/vxzo2qjoVg91WUIDvQbqCOjm1IYx7PRU7wFOU
         obV/tOodzsQwjcx1iuKorzIMVkuVc+QsMbWTnnh4lVrUUxClmnSRo8m+tV544wy01ULB
         JayMdL8pcxrD0itEeotzXLWbG0NdUbw47qz3Vudxv0unsr7eytWxDvIdbcr8Z1eSkJdi
         wT/AcnqPpx8gM5OAo8ZBi31jgQsO06Ngu2mVgQ6QE2CmFGYn1zY7yPIgcf/QXn/i3kIw
         EyuYuNSFBpnyD+Mln3HoXInUT8KB05k9KauKC2gHBNTbaeqqk1wBed6jJyIZaREIBMYZ
         dvTA==
X-Gm-Message-State: AOAM531uXkfrIUGT4cOGAEytCJqrAilEfc6R0RSnwZ/kSxCVzUoaMZWS
        PekHmkVAHmmutzNx2fQ7s/hMfQ==
X-Google-Smtp-Source: ABdhPJzdiW4qElFhKIrkosBG7ULnYOtaYvUC52RzTtbzq9l2iyrkPzwTsFVvo1mh5bSHLcpQlZiRLA==
X-Received: by 2002:adf:f6c1:0:b0:20a:c408:4aeb with SMTP id y1-20020adff6c1000000b0020ac4084aebmr17411494wrp.74.1651696514483;
        Wed, 04 May 2022 13:35:14 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id l20-20020adfc794000000b0020c5253d8dfsm13330101wrg.43.2022.05.04.13.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:35:13 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/8] riscv: dts: microchip: move sysctrlr out of soc bus
Date:   Wed,  4 May 2022 21:30:46 +0100
Message-Id: <20220504203051.1210355-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504203051.1210355-1-mail@conchuod.ie>
References: <20220504203051.1210355-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The MPFS system controller has no registers of its own, so move it out
of the soc node to avoid dtbs_check warnings:
arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dtb: soc: syscontroller: {'compatible': ['microchip,mpfs-sys-controller'], 'mboxes': [[15, 0]], 'status': ['okay']} should not be valid under {'type': 'object'}

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Suggested-by: Rob Herring <robh@kernel.org>
Fixes: 528a5b1f2556 ("riscv: dts: microchip: add new peripherals to icicle kit device tree")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 746c4d4e7686..bf21a2edd180 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -146,6 +146,11 @@ refclk: mssrefclk {
 		#clock-cells = <0>;
 	};
 
+	syscontroller: syscontroller {
+		compatible = "microchip,mpfs-sys-controller";
+		mboxes = <&mbox 0>;
+	};
+
 	soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -446,10 +451,5 @@ mbox: mailbox@37020000 {
 			#mbox-cells = <1>;
 			status = "disabled";
 		};
-
-		syscontroller: syscontroller {
-			compatible = "microchip,mpfs-sys-controller";
-			mboxes = <&mbox 0>;
-		};
 	};
 };
-- 
2.36.0

