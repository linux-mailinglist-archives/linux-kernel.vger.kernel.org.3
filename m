Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BCC4EC41D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbiC3MeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbiC3Mdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:33:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0210E6C944;
        Wed, 30 Mar 2022 05:19:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id c10so22726719ejs.13;
        Wed, 30 Mar 2022 05:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yb13D0MHL1q0I5GMitPig2+TSOgHDixtNwuPnXxvwfA=;
        b=dI7gx0ZI5YlOBk1wG2SDHXM04Peh5+DkcX7RDGRl9EwkN6RszSeZBTj6ZN7fE6Yxx4
         UMNH8SIDUrXlcSZ5IRBPixrf7W0oXWo8IB23yIYe7GCEAe10pIT7oL9xs8EVvXrPdtlY
         mpbuImX83TEuRXCPaxnag7HtMh7oj7XRVe5H57whU6AAGHsWPl47gXIvWgLspvf6bEGc
         naxxdvy0YYl9tYpUDNexlLoA2LCVWK68KOA33vQDD85RVDsQkgB9H80JSPhOtDl4WE8Z
         d7Wep1OhiBOzSHrVJQbI68jkXrqvJPLKdxuiB61MnNOUh7PnIM/HdK1ZjtPe8gmJxfWG
         SwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yb13D0MHL1q0I5GMitPig2+TSOgHDixtNwuPnXxvwfA=;
        b=eWHTDmPrTR4TJZC0xQcyMYvZqjH1t2/aTlPtMcDf+ZzLz6ryG33FoXZwvoCbNQT0zn
         4ylivb1htCxGZDzrvhZgB7Ib4K58nfEBnhMbZvAZoAWIliSX2+nwrJtoJQQhzDZWEomz
         XvBbEoEBjOHOXfLphzpp6pITmOH97RH7ctdQYMDdjobjX8yFzLqxIU/bFEtaPk7J88ca
         cfzW5qRWentC0C2F3geeSp7wTKEQsTIqTz1BsUqU3+YPB4dAOZ8+VhMPP923M5UEyDRv
         cBj+yVlkz/HgzOzer2ICO4UnY3wikAbvT3DZ6gRMs2wjSJDP9QOMjRXyOE0Pyew3nD2y
         Dyxw==
X-Gm-Message-State: AOAM530jasDNp2Hva6oexvgzPmO3QDgYmvlZr2OSYRwdI4YVwUuzXCsN
        AnmH2DIk+jwZmVEgpTzbQzo=
X-Google-Smtp-Source: ABdhPJz5HqJgfVLDw1fcgFbevMH0wU4OD3vKhI5tl/7Qy20DQc2ktAI+VZ2y8SpWOlN8Rd2RDGSLmw==
X-Received: by 2002:a17:907:2513:b0:6e1:2c10:2ada with SMTP id y19-20020a170907251300b006e12c102adamr10865184ejl.211.1648642772122;
        Wed, 30 Mar 2022 05:19:32 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906255500b006e08c4862ccsm7288778ejb.96.2022.03.30.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 05:19:31 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] ARM: dts: rockchip: rk322x: use generic node name for dma
Date:   Wed, 30 Mar 2022 14:19:23 +0200
Message-Id: <20220330121923.24240-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220330121923.24240-1-jbx6244@gmail.com>
References: <20220330121923.24240-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic, so fix this for the rk3228 dma node
and rename it to "dma-controller".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 2547f46fe..ffc16d6b9 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -503,7 +503,7 @@
 			<75000000>;
 	};
 
-	pdma: pdma@110f0000 {
+	pdma: dma-controller@110f0000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x110f0000 0x4000>;
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.20.1

