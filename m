Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239384DC523
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiCQL6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiCQL6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:58:31 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43A81E5A79
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:15 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 75B593F499
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518234;
        bh=VChXuM8K4QoDWKbjkubBo2C7YS9EHl+r3kLe9dbaCgo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=RIvnWzoKVJ+hbtq6+bzObfxgUdPhuE661YJauvJ9sKNPxRtrfDfPgJrvEyUJ7HOC0
         O1XpUNURmPZNZTOZ2gpFygWujmQU4j9xtmDsI3zRmGm0IIoQWY4TKA01HGd7aKU7Ed
         wsviopv5DETjEIZBIKjT+R9CejjvLu4+TBHAuLxbH0HHTE4nfq4sNX6zRMUDKdlGbT
         DXKs+JcZFEnM8sGtRCd2KVn1C2m3PUJJvWUl9Sp7DMi80msAWYyfpaCT2TvHLNlV/3
         4ZGA55vwQ2UTNtgDwcaVBkPBRVhUFBJBzAcKA1Oi1nHpFYQzpodkkTGsTG/u3JZWXi
         9qQ5oE2+9HXIg==
Received: by mail-wr1-f71.google.com with SMTP id j67-20020adf9149000000b00203e6b7d151so774987wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VChXuM8K4QoDWKbjkubBo2C7YS9EHl+r3kLe9dbaCgo=;
        b=P836qA2s3h89wRHK8XMF0sO6gpMzMb0AqEjL1/YMJszZ9kqe3onSojbephtKlZ/f0J
         himAjufFRapziGN3VXNTjeQN3RfBHXxQzx3ijSXsqooXAnJ+pM3stH5QzQoVjSi3HHmt
         mRQDM0aCJ0GBi44wRqeYSdqTnIzNprYfK0uq8uKlaN8ggDZgZfH1jfJbVe3KyP6z4KAH
         KPZSUVtQOd38lqWmdP6w2qsnRngqZuFaVsOaYvqHfCIHNV1PJxro9gGF2Dr/lJwOA/C/
         h5OB1MLq9Yg10GjUq/X8TlDnKjWHxpVoBuyhq3lNopP2k+N504P2ISUFdY7L+s4/QHFc
         qxZg==
X-Gm-Message-State: AOAM532QrTv8mj9Hacb9KSdMXdC/z/xb8AVljsnKltT3fxsritYQpERc
        UDW4F/L2Ks2nqMFX7gvWRY/ep3KGHnrS9/6nhPtV0YYmPw5oC3uJctnOLbw8/UsLzZSxhjojhJL
        AlzbT/qU7+B/u5Eo+ZphxLnFNVy6B6Z+VqKCkGIMQ7w==
X-Received: by 2002:a1c:7518:0:b0:381:c77:ceec with SMTP id o24-20020a1c7518000000b003810c77ceecmr3609284wmc.57.1647518234160;
        Thu, 17 Mar 2022 04:57:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsiX6nbj0kfQADgRjJIDqdkJ617e7CvGmtStpgdMKD/NEmWTzdx19H/0Ce1BkkWrE8nM6zWw==
X-Received: by 2002:a1c:7518:0:b0:381:c77:ceec with SMTP id o24-20020a1c7518000000b003810c77ceecmr3609267wmc.57.1647518233902;
        Thu, 17 Mar 2022 04:57:13 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 02/18] ARM: dts: ox820: align interrupt controller node name with dtschema
Date:   Thu, 17 Mar 2022 12:56:49 +0100
Message-Id: <20220317115705.450427-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes dtbs_check warnings like:

  gic@1000: $nodename:0: 'gic@1000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/ox820.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
index 90846a7655b4..dde4364892bf 100644
--- a/arch/arm/boot/dts/ox820.dtsi
+++ b/arch/arm/boot/dts/ox820.dtsi
@@ -287,7 +287,7 @@ local-timer@600 {
 				clocks = <&armclk>;
 			};
 
-			gic: gic@1000 {
+			gic: interrupt-controller@1000 {
 				compatible = "arm,arm11mp-gic";
 				interrupt-controller;
 				#interrupt-cells = <3>;
-- 
2.32.0

