Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29BB567744
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiGETFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiGETEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:04:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC3713D02
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:04:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk26so3800704wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNuyaztG7WG0XECyfRAu1NlFkLmq6WFnwK6RpenhzSk=;
        b=Npg6A1E1a10kmmFESMxKy1SqF84MP3WhpDB4JM9gAU7qd4MB9Z69GK51SXZQlRU/MY
         SqJUW7jJa/PhNKQUYxyGteJLYUQSdq306+RMob512BiSvFZ+AH5mge2FwXNwTkv2zQA/
         f9e/djtjCOhGwoZuoXcG/bT7/p4BnkgWVXmfwN2z26XoQvYoFXr2SKB72DgjcQ+7j2O7
         JZStLlzfaBTWs0X8Os5HHab5COQZBOUnoXALUWu70rLfSPBQksy1/7z9arApMPObnSdZ
         qvAqOHE8VzLUb+t3X0Y3tO7w4jVaC67k5ySYZTr1ZUMwozxNjK4cVf0QaVtKIliP5n1q
         xwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNuyaztG7WG0XECyfRAu1NlFkLmq6WFnwK6RpenhzSk=;
        b=NIsuUIWcpNiRTgP43zKOeneLjEw1//Szi8H0iUN1Gu3NmFY0en5Z1Ctj3/y6Roq/Sl
         +kv/Z8lKBp1BvsvuP3jgkWkzLaZGdbL7SOFrADBT9ydEZTyPr49w9JvOfZCT0+ZDFuh7
         8VeCCYp5XO8C9awfdKEz9vb1zGkXv6tiJ0fhjRZvFAlg1uINnqPuzelAsE6rCD23nB8n
         v0J6EiIxYohw7FN7aMWbOdcsTP1g5SuNj8D9E1Pyrcy4TXO0w/BvX4wSeRyv4PQebqY7
         gFCFEj70Cja3Yxfkz5QFSBxsMPlI5PbcPdaMJugkcplsh547Db7XIAhu2L0lZtAuh1Nm
         1EuQ==
X-Gm-Message-State: AJIora+gBf+WzZdUwWI+N5T6MXp6T/gDZ4FLg6+YyKsMxDS5q7SN2+OD
        W6bqFAyUa1v087V9REFU3cuEOs2Y1716wIVKV1k=
X-Google-Smtp-Source: AGRyM1sZnlUg7cRbAbZwdDLmnM+md2H39+NMEEpyyL3usCmFG/KO5nQimCQLm9NLNI9LS9XggnvjhA==
X-Received: by 2002:a5d:4b87:0:b0:21d:7019:80c6 with SMTP id b7-20020a5d4b87000000b0021d701980c6mr6132428wrt.234.1657047890925;
        Tue, 05 Jul 2022 12:04:50 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d5387000000b0021d5c52f4b4sm9912961wrv.34.2022.07.05.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:04:50 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Brice Goglin <Brice.Goglin@inria.fr>
Subject: [PATCH 2/5] riscv: dts: sifive: Add fu540 topology information
Date:   Tue,  5 Jul 2022 20:04:33 +0100
Message-Id: <20220705190435.1790466-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705190435.1790466-1-mail@conchuod.ie>
References: <20220705190435.1790466-1-mail@conchuod.ie>
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

The fu540 has no cpu-map node, so tools like hwloc cannot correctly
parse the topology. Add the node using the existing node labels.

Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
Link: https://github.com/open-mpi/hwloc/issues/536
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index e3172d0ffac4..24bba83bec77 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -133,6 +133,30 @@ cpu4_intc: interrupt-controller {
 				interrupt-controller;
 			};
 		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+
+				core4 {
+					cpu = <&cpu4>;
+				};
+			};
+		};
 	};
 	soc {
 		#address-cells = <2>;
-- 
2.37.0

