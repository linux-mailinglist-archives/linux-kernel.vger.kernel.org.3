Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ECE4DC50D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiCQLy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiCQLyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:54:23 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829CE1E5335
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:53:06 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D0C363F1A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647517983;
        bh=GjViklxymlU9oUxXKXReSCbCv0V/xFiwY5UUrPDATe4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=vAAd6IWaOt4QUZcApT2vABV+/FwRZHLb8W1dNubntdygx93k1qlKGdEiMGYWP8ZGN
         +SagSRoEFc5KorD6SS0rcBumPdZcRXmKgjLxL5cF1oB32BHi+fLy8B2mTZroABNXn6
         zDlgRWJmECFgufwODrqaWjYk9YzQ7RnbUo4tTPQgoHXpP2EPd5Wb9foiLLMn3i1LJg
         7NrzjtxZ3dbBpELlI1E2EK5KjSyICJCFQuCWQ2xBUzw1AWzNdHDlHyAO/KLeD8AbsG
         /4UuJSYJCZi5nDm28kcEN3pNKXwqb6MDqayb040liHiYqqk1HUDKhvqYTICCYxnlnR
         j8a1VnaZMYsKQ==
Received: by mail-wr1-f70.google.com with SMTP id 8-20020adf8108000000b00203d97ba415so1474901wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjViklxymlU9oUxXKXReSCbCv0V/xFiwY5UUrPDATe4=;
        b=wQFbGK+knO1q/drr9v2rp/fG9raBF/XE7ZLv3gQF3Gg0AKXw7r0d6vxZukLc6sLHiA
         5fYcn52rJRmh2N2AZj99W/WNoEpjSDHy8uSm62aLvyNT7rvQohN4KMqqVTsO2UP75CD2
         cSEV8u31qXULUjtOWhPCSbDojG37IkX4bZ8/Nvevo+Nb8L16uB/KXp7QDRltkeKex0Tc
         rL0OjunUu33lArHWFuplWOsbLZo8xU7R5jNqYxG8mDo1TvHe26m1QP8q4NeGiP85FYVz
         v1eMY2a14LOu4fXBNfOmcPzUIeHQn7ViSpfPrmLIiiLe0Du7XPom5agfw6QvKB+IBBDZ
         yasg==
X-Gm-Message-State: AOAM532hDL5rpLHdOFyt9WGFwGxGkoBMRwIZn6RU4ywKf2w7IN9Ii1Gf
        /ls9oVoRunOHZgrzDYvEqCT14Y7QYpC7p3mGj8IyG2peANjRGfc768T0/ZwEPCxlLYXpzgNrKZ5
        MzzEfQqhSmSLzVrL9Uhx2jWnryD0/a0DZghBkhDj2Bg==
X-Received: by 2002:a05:6000:1a8b:b0:1f1:d8f4:4aa with SMTP id f11-20020a0560001a8b00b001f1d8f404aamr3854712wry.238.1647517983560;
        Thu, 17 Mar 2022 04:53:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/DM8yJ+E/5dtwBBWinZJdW8tjig7HKoZ0ZwEWjp3EJbHwbEfzlppwLm7ESNbDHke+EN+0lQ==
X-Received: by 2002:a05:6000:1a8b:b0:1f1:d8f4:4aa with SMTP id f11-20020a0560001a8b00b001f1d8f404aamr3854693wry.238.1647517983347;
        Thu, 17 Mar 2022 04:53:03 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d698c000000b001f1d8bb4618sm5397351wru.36.2022.03.17.04.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:53:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] MIPS: ingenic: correct unit node address
Date:   Thu, 17 Mar 2022 12:52:59 +0100
Message-Id: <20220317115259.448868-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unit node addresses should not have leading 0x:

  Warning (unit_address_format): /nemc@13410000/efuse@d0/eth-mac-addr@0x22: unit name should not have leading "0x"

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 3f9ea47a10cd..b998301f179c 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -510,7 +510,7 @@ efuse: efuse@d0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			eth0_addr: eth-mac-addr@0x22 {
+			eth0_addr: eth-mac-addr@22 {
 				reg = <0x22 0x6>;
 			};
 		};
-- 
2.32.0

